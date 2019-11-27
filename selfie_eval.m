clc;
clear;
close all;

%Please specify your pred result.
pred_file = 'sample.txt';

%Please specify your algorithm name.
legend_name = 'sample';

load('Selfie/gt_bbx/selfie_gt_bbx.mat');

if ~exist(sprintf('%s',pred_file),'file')
    fprintf('Can not find the prediction file  %s \n',pred_file);
else
    fid1 = fopen(sprintf('%s',pred_file),'r');
    tmp = textscan(fid1,'%s','Delimiter','\n');
    tmp = tmp{1};
    fclose(fid1);
  
    try
        bbx_num = tmp{2,1};
        bbx_num = str2num(bbx_num);
        bbx = zeros(bbx_num,5);
        if bbx_num ==0
            disp('No face');
            return;
        end
        for k = 1:bbx_num
            raw_info = str2num(tmp{k+2,1});
            bbx(k,1) = raw_info(1);
            bbx(k,2) = raw_info(2);
            bbx(k,3) = raw_info(3);
            bbx(k,4) = raw_info(4);
            bbx(k,5) = raw_info(5);
        end
        [~, s_index] = sort(bbx(:,5),'descend');
        bbx_list = bbx(s_index,:);
    catch
        fprintf('Invalid format  %s\n',pred_file);
    end   
end
%norm pred info
score_list = bbx_list(:,5);%
max_score = realmin('single');
min_score = realmax('single');
max_score = max(max_score,max(score_list));
min_score = min(min_score,min(score_list));
%disp('Norm perdiction!');
norm_score_list = (score_list - min_score)/(max_score - min_score);
bbx_list(:,5) = norm_score_list;
norm_bbx_list = bbx_list;


selfie_evaluation(norm_bbx_list,gt_bbx,legend_name);

dir_selfie = 'Selfie/baseline';
selfie_plot(dir_selfie);
