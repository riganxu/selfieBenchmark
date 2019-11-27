function selfie_plot(dir_ext)
method_list = dir(dir_ext);
model_num = size(method_list,1) - 2;
model_name = cell(model_num,1);
for i = 3:size(method_list,1)
    model_name{i-2} = method_list(i).name;
end

propose = cell(model_num,1);
recall = cell(model_num,1);
name_list = cell(model_num,1);
ap_list = zeros(model_num,1);
for j = 1:model_num
    load(sprintf('%s/%s/selfie_pr_info_%s.mat',dir_ext, model_name{j}, model_name{j}));
    propose{j} = pr_cruve(:,2);
    recall{j} = pr_cruve(:,1);
    ap = VOCap(propose{j},recall{j});
    ap_list(j) = ap;
    ap = num2str(ap);
    if length(ap) < 5
        name_list{j} = [legend_name '-' ap];
    else
        name_list{j} = [legend_name '-' ap(1:5)];
    end       
end
[~,index] = sort(ap_list,'descend');
propose = propose(index);
recall = recall(index);
name_list = name_list(index);

figure1 = figure('PaperSize',[20.98 29.68],'Color',[1 1 1], 'rend','painters','pos',[1 1 600 400]);
axes1 = axes('Parent',figure1,...
    'LineWidth',2,...
    'FontSize',10,...
    'FontName','Times New Roman',...
    'FontWeight','bold');
box(axes1,'on');
hold on;

LineColor = colormap(hsv(model_num));
for i=1:model_num
    plot(propose{i},recall{i},...
        'MarkerEdgeColor',LineColor(i,:),...
        'MarkerFaceColor',LineColor(i,:),...
        'LineWidth',3,...
        'Color',LineColor(i,:))
    grid on;
    hold on;
end
legend1 = legend(name_list,'show');
set(legend1,'Location','SouthWest');

xlim([0,1]);
ylim([0,1]);
xlabel('Recall');
ylabel('Precision');

if ~exist('./Selfie/figure','dir')
    mkdir('./Selfie/figure');
end

savename = './Selfie/figure/selfie_pr_cruve.pdf';
saveTightFigure(gcf,savename);
clear gcf;
hold off;