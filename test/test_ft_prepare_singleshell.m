function test_ft_prepare_singleshell

% TEST test_ft_prepare_singleshell
% TEST ft_headmodel_singleshell ft_prepare_headmodel ft_prepare_singleshell

% function to test ft_headmodel_singleshell. this function is called
% by ft_prepare_headmodel

% the function should work either on an input (segmented) mri, or it
% should have a description of the geometry in the input, or it should
% have a hdmfile (string) that specifies which file to read

success = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get the data which is needed

% read in the segmented mri
cd('/home/common/matlab/fieldtrip/data/ftp/tutorial/beamformer');
load segmentedmri
mri = segmentedmri; clear segmentedmri;

% specify the file for the headshape
hdmfile  = '/home/common/matlab/fieldtrip/data/Subject01.shape';

% read in the headshape
shape = ft_read_headshape(hdmfile);

%%%%%%%%%%%%%%%%%%%%%
% do the computations

% with an MRI in the input
cfg         = [];
cfg.method  = 'singleshell';
vol1        = ft_prepare_headmodel(cfg, mri);
% the following needs to be done to be able to make the comparison
% vol1 = rmfield(vol1, 'unit');

cfg         = [];
vol1b       = ft_prepare_singleshell(cfg, mri);
% the following needs to be done to be able to make the comparison
% vol1b = rmfield(vol1b,'unit');

success     = success && isequal(vol1, vol1b);
if ~success
  error('ft_prepare_singleshell and ft_prepare_headmodel gave different outputs');
end

% with a filename in the input
cfg         = [];
cfg.method  = 'singleshell';
cfg.hdmfile = hdmfile;
vol2        = ft_prepare_headmodel(cfg);
% the following needs to be done to be able to make the comparison
% vol2        = rmfield(vol2, 'unit');

cfg         = [];
cfg.headshape = hdmfile;
vol2b       = ft_prepare_singleshell(cfg);

success     = success && isequal(vol2, vol2b);
if ~success
  error('ft_prepare_singleshell and ft_prepare_headmodel gave different outputs');
end

% with a point cloud in the input
cfg         = [];
cfg.method  = 'singleshell';
cfg.geom    = shape;
vol3        = ft_prepare_headmodel(cfg);
% the following needs to be done to be able to make the comparison
% vol3        = rmfield(vol3, 'unit');

cfg         = [];
cfg.headshape = shape;
vol3b       = ft_prepare_singleshell(cfg);
success     = success && isequal(vol3, vol3b);
if ~success
  error('ft_prepare_singleshell and ft_prepare_headmodel gave different outputs');
end
