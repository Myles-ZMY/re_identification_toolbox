function setupCnn(varargin)
%SETUPCNN Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;
booleanValFcn = @(x) assert(isboolean(x), 'The value must be boolean.');
addParameter(p, 'UseGpu', true, booleanValFcn)
addParameter(p, 'Verbose', false, booleanValFcn)
addParameter(p, 'DownloadLibs', false, booleanValFcn)
addParameter(p, 'VlfeatLibDir', 'vlfeat/toolbox')
addParameter(p, 'MatConvNetLibDir', 'matconvnet/matlab')

parse(p, varargin{:});

useGpu = p.Results.UseGpu;


run vlfeat/toolbox/vl_setup;
run matconvnet/matlab/vl_setupnn;
addpath matconvnet/examples;

if (gpuDeviceCount == 0 && useGpu == true)
    warning('The UseGpu parameters appear to be set to true. However, no CUDA-enabled GPUs are installed on this device. Setting UseGpu to false.');
    useGpu = false;
end

if useGpu
    try
        vl_nnconv(gpuArray(single(1)),gpuArray(single(1)),[]);
    catch
        warning('VL_NNCONV() does not seem to be compiled. Trying to compile it now.');
        vl_compilenn('enableGpu', useGpu, 'verbose', opts.verbose);
    end
else
    try
        vl_nnconv(single(1),single(1),[]);
    catch
        warning('GPU support does not seem to be compiled in MatConvNet. Trying to compile it now.');
        vl_compilenn('enableGpu', useGpu, 'verbose', opts.verbose);
    end
end

end