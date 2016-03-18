% conditions can be set by using the following flags:
% 'all': all data
% 'sweep': sweep data
% 'grid': grid data
% 'fixed': head fixed data
% 'free': head free data
% 'task': task data

% 'oneeye': use only left eye

k = dir([pwd '/data/*.mat']);
files = {k.name}';

for fileIdx = 1:1
    
    exp_var.trainStr = files{fileIdx};
    exp_var.testStr = files{fileIdx};
    exp_var.fullExpStr = strcat(exp_var.trainStr,'_on_',exp_var.testStr,'.mat');
    
%     segments = {'free_oneeye'}; %,'task','free_oneeye','task_oneeye'};
    segments = {'free','task','free_oneeye','task_oneeye'};
    N = length(segments);
    
    errMean = zeros(N,N);
    errStd = zeros(N,N);
    errDistErr = cell(N,N);
    
    errDistVec = [];
    errDistLen = [];
    
    k = 1;
    
    filename = [pwd '/data/oneeye/output_' exp_var.fullExpStr];
    if ~(exist(filename, 'file') == 2)
        for i = 1:length(segments)
            for j = 1:length(segments)
                
                % Define experiment for all on all
                exp_var.trainCond = segments{i};
                exp_var.testCond = segments{j};
                exp_var.expStr = strcat(exp_var.trainStr,'_',exp_var.trainCond,'_on_',...
                    exp_var.testStr,'_',exp_var.testCond);
                [errors, calType] = exp_wrap(exp_var);
                
                if (calType == 0)
                    errMean(i,j) = 0;
                    errStd(i,j) = 0;
                    errDistErr{i,j} = 0;
                else
                    errMean(i,j) = errors.meanErr;
                    errStd(i,j) = errors.stddevErr;
                    errDistErr{i,j} = errors.distErr/10;
                end

                errDistVec = [errDistVec; errDistErr{i,j}];
                errDistLen = [errDistLen, k*ones(1,length(errDistErr{i,j}))];
                
                disp(['iter: ' num2str(k)]);
                k = k + 1;
            end
        end
        makefigs_group(exp_var.expStr,errDistVec,errDistLen,errMean);
        save(filename)
    else
        disp(filename);
        disp('file already processed');
    end
end


