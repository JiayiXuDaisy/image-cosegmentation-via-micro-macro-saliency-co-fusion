op=strcat(pwd,'/');
cd('./grabcut/GrabCut/')
run('./compile_gc.m'); %ʹ��mex����c�ļ�
cd(op);
cd('./vlf2/vlfeat-0.9.17/toolbox/')

run('./vl_compile.m');
run('./vl_setup.m');
cd(op);
cd('./mdaisy-v1.0/');
mex -compatibleArrayDims mex_compute_all_descriptors.cpp
mex -compatibleArrayDims mex_compute_descriptor.cpp
cd(op)