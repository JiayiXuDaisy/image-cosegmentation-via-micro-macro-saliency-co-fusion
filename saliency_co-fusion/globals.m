% SETUP PARAMETERS
feat_dim = 406;
param = struct;
param.gamma = 1 / sqrt(feat_dim); 
param.lambda = 1;
param.num_parts=50;
param.tt = 1;
param.color=0;% 0 if color feature not to be used; 1 if color feature to be used.
base_dir = pwd;
tmp_dir = [base_dir '/tmp/'];


