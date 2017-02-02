function clusterScatterPlot(idx, center)
%CLUSTERSCATTERPLOT Summary of this function goes here
%   Detailed explanation goes here


% TODO: plot all points; color points which belongs to each cluster in a
% different way; plot centers
in = repmat([1,2,3],size(idx,1),1);
%c = C(:);

figure, hold on
scatter3(idx(:,2), idx(:,3), idx(:,4), 36, in, 'Marker','.');
%scatter3(center(:,2), center(:,3), center(:,4), 100, in, 'Marker','o', 'LineWidth',3)
hold off
view(3), axis vis3d, box on, rotate3d on
xlabel('x'), ylabel('y'), zlabel('z')

end