function ldmFigS3C(data,rot,fly,sf_1,sf_2,sb_1,sb_2,flip)

% sort out data
ind=data{5};
times=data{1};
ca=data{2};
yaw=data{3};
pitch=data{4};
flip_ind = data{8};
numFlies=max(ind);
numTrials=size(ca,1);

% added this section to flip R neurons to left
% flip right axon to left
if flip
    yaw(flip_ind,:) = -yaw(flip_ind,:);
end

% which behavior is being analyzed?
switch rot
    case 'yaw'
        rot=yaw;
        color = 'blue';
    case 'pitch'
        rot=pitch;
        color = 'red';
    case 'turn'
        rot=abs(yaw);
end

rot = rot(ind==fly,:);
ca = ca(ind==fly,:);

%%
figure
hold on
fps = round(length(times)/range(times));
sf_1 = sf_1;
sf_2 = sf_2;
scale_rot = (sb_2/fps) * sf_2;
scale_ca = sb_1 * sf_1;

sb_rot = line([10,10],[0 scale_rot],'Color',color)
sb_ca = line([5,5],[0 scale_ca],'Color','black')
for ii = 1:min([size(rot,1),8])
hPlt = plot(times+60,[ca(ii,:)*sf_1-(ii - 0.5);rot(ii,:)*sf_2-ii]');
hPlt(1).Color = [0 0 0];
hPlt(2).Color = color;
end
xlim([0 180])
xticks(0:60:180)
pbaspect([1 2 1])
shg