classdef SlamModel < handle
  % Dynamic motion and observation model
  
  properties
    config
    state
    covariance
    landmarks
    num_landmarks
    main_figure
    H % observation jacobian
    A % state transition jacobian
    Q % process noise
    is_packed
  end
  
  properties (Dependent = true)
    C
  end
  
  methods
    
    function obj = SlamModel(config, x, P)
      if nargin > 0
        obj.config = config;
        obj.state = x;
        obj.covariance = P;
      else
        obj.config = Configuration();
        obj.state = [0 0 0 1 0 0 0 0 0 0 0 0 0]';
        obj.covariance = sparse(eye(13));
      end
      obj.landmarks = [];
      obj.num_landmarks = 0;
      obj.is_packed = false;
    end
    
    function C = get.C(model)
      [p,q,v,w] = model.unpack_camera_state();
      R = q2R(q);
      C = [R', -R*p; zeros(1,3), 1];
    end
    
    
    function pack_state(model, p, q, v, w)
      % PACK_STATE pack the state into the state vector
      % p: camera position (3x1)
      % q: camera orientation quaternion (4x1)
      % v: linear camera velocity (3x1)
      % w: angular camera velocity quaternion (4x1)
      if ~model.is_packed
        model.is_packed = true;
      else
        err = MException('AEModel:AlreadyPacked', ...
                'This model is already packed, we cannot pack it again');
        throw(err);
      end
      model.pack_camera_state(p, q, v, w);
      model.pack_landmarks();
    end
    
    function pack_camera_state(model, p, q, v, w)
      % PACK_CAMERA_STATE pack the camera state into the state vector
      % p: camera position (3x1)
      % q: camera orientation quaternion (4x1)
      % v: linear camera velocity (3x1)
      % w: angular camera velocity quaternion (4x1)
      state = model.state;
      state(1:3) = p;
      state(4:7) = q;
      state(8:10) = v;
      state(11:13) = w;
      model.state = state;
    end
    
    function pack_landmarks(model)
      state = model.state;
      j = 14;
      n = 7;
      for i = 1:size(model.landmarks)
        state(j:j+n-1) = model.landmarks(i).ahp;
        j = j + n;
      end
      model.state = state;
    end
    
    function [p,q,v,w] = unpack_state(model)
      % UNPACK_STATE take variables out of state vector
      % p: camera position (3x1)
      % q: camera orientation quaternion (4x1)
      % v: linear camera velocity (3x1)
      % w: angular camera velocity quaternion (4x1)
      if model.is_packed
        model.is_packed = false;
      else
        err = MException('AEModel:AlreadyUnpacked', ...
                'This model is already unpacked, we cannot unpack it again');
        throw(err);
      end
      [p q v w] = model.unpack_camera_state();
      model.unpack_landmarks();
    end
    
    function unpack_landmarks(model)
      j = 14;
      n = 7;
      state = model.state;
      for i = 1:size(model.landmarks,2)
        model.landmarks(i).ahp = state(j:j+n-1);
        j = j + n;
      end
    end
    
    function [p,q,v,w] = unpack_camera_state(model)
      % UNPACK_CAMERA_STATE take camera variables out of state vector
      % p: camera position (3x1)
      % q: camera orientation quaternion (4x1)
      % v: linear camera velocity (3x1)
      % w: angular camera velocity quaternion (4x1)
      state = model.state;
      p = state(1:3);
      q = state(4:7);
      v = state(8:10);
      w = state(11:13);
    end
    
    function throw_away_bad_landmarks(model)
      % THROW_AWAY_BAD_LANDMARKS Tosses out landmarks which haven't been observed in a while.
      
      i = 1;
      while i < model.num_landmarks
        landmark = model.landmarks(i);
        if landmark.should_be_removed()
          model.throw_away_landmark(i);
        else
          i = i + 1;
        end
      end
    end
    
    function throw_away_landmark(model, index)
      % THROW_AWAY_LANDMARK Remove the landmark at the given index
      display('Throwing away landmark');
      i = index;
      if ~model.is_packed
        % err = MException('AEModel:IsUnpacked', ...
        %         'This model is unpacked, so we cannot remove a landmark at the moment.');
        % throw(err);
      end
      if i == 1
        model.landmarks = model.landmarks(i+1:end);
      else
        model.landmarks = [model.landmarks(1:i-1) model.landmarks(i+1:end)];
      end        
      model.num_landmarks = model.num_landmarks - 1;
      base = 14+(i-1)*7; % belongs to us; all your
      % remove the variables related to the landmark
      model.state = [model.state(1:base-1); model.state(base+7:end)];
      % removes the 7 columns corresponding to the landmark
      model.covariance = [model.covariance(:,1:base-1), model.covariance(:,base+7:end)];
      % remove the 7 rows corresponding to the landmark
      model.covariance = [model.covariance(1:base-1,:); model.covariance(base+7:end,:)];
    end
    
  end
  
end

