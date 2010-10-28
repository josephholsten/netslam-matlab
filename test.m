function test

close all;
clear all;

addpath([pwd, '/jacobians']);
addpath([pwd, '/fast-matlab-src']);

runtests tests;

end