function selfie_evaluation(norm_bbx_list,gt_bbx,legend_name)

if ~exist(sprintf('./Selfie/baseline/%s',legend_name),'dir')
    mkdir(sprintf('./Selfie/baseline/%s',legend_name));
end

IoU_thresh = 0.5;
thresh_num = 1000;
count_face = 0;

pred_info = norm_bbx_list;
pred_recall = zeros(size(pred_info,1),1);
recall_list = zeros(size(gt_bbx,1),1);    

proposal_list = zeros(size(pred_info,1),1);
proposal_list = proposal_list + 1;         
pred_info(:,3) = pred_info(:,1) + pred_info(:,3); 
pred_info(:,4) = pred_info(:,2) + pred_info(:,4);

gt_bbx_tmp = gt_bbx;
gt_bbx(:,1) = round((gt_bbx_tmp(:,1) - gt_bbx_tmp(:,3)/2)*2048);
gt_bbx(:,2) = round((gt_bbx_tmp(:,2) - gt_bbx_tmp(:,4)/2)*1152);
gt_bbx(:,3) = round((gt_bbx_tmp(:,1) + gt_bbx_tmp(:,3)/2)*2048);
gt_bbx(:,4) = round((gt_bbx_tmp(:,2) + gt_bbx_tmp(:,4)/2)*1152);

for h = 1:size(pred_info,1)             
    overlap_list = boxoverlap(gt_bbx, pred_info(h,1:4));
    [max_overlap, idx] = max(overlap_list);
    if max_overlap >= IoU_thresh        
            recall_list(idx) = 1;
    end    
    r_keep_index = find(recall_list == 1);
    pred_recall(h) = length(r_keep_index);
end


img_pr_info = zeros(thresh_num,2); 
for t = 1:thresh_num
    thresh = 1-t/thresh_num;
    r_index = find(pred_info(:,5)>=thresh,1,'last');
    if (isempty(r_index))  
        img_pr_info(t,2) = 0;
        img_pr_info(t,1) = 0;
    else
        p_index = find(proposal_list(1:r_index) == 1);
        img_pr_info(t,1) = length(p_index);
        img_pr_info(t,2) = pred_recall(r_index);
    end
end

pr_cruve = zeros(thresh_num,2);
for i = 1:thresh_num
    pr_cruve(i,1) = img_pr_info(i,2)/img_pr_info(i,1);
    pr_cruve(i,2) = img_pr_info(i,2)/856;
    if i == thresh_num
        count_face = img_pr_info(i,2);
    end
end
disp('All detected£º')
disp(size(pred_info,1));
disp('Correctly detected£º')
disp(count_face);

save(sprintf('Selfie/baseline/%s/selfie_pr_info_%s.mat',legend_name,legend_name),'pr_cruve','legend_name','-v7.3');


