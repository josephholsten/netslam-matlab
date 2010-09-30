classdef SlamGraph
  % Represents a graph of local clusters of landmark observations, which
  % are treated as a single high-dimensional observation for purposes of
  % graph optimization.
  
  properties
    nodes % Array of nodes in the graph
    edges % Array of edges in the graph
    model % Dynamic model
    configuration % Configuration settings
  end
  
  methods
    
    function obj = SlamGraph(configuration)
      if nargin > 0
        obj.configuration = configuration;
        obj.model = SlamModel(configuration);
        obj.nodes = [];
        obj.edges = [];
      end
    end
    
  end
end