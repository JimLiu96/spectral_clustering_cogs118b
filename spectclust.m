%% refs
%%[1]	Shi, J., and J. Malik (1997) "Normalized Cuts and Image Segmentation",
%%	in Proc. of IEEE Conf. on Comp. Vision and Pattern Recognition, 
%%	Puerto Rico.

%%[2]	Kannan, R., S. Vempala, and A. Vetta (2000) "On Clusterings - Good, Bad %%	and Spectral", Tech. Report, CS Dept., Yale University.

%% This code is from ref [3] 
%%[3]	Ng, A. Y., M. I. Jordan, and Y. Weiss (2001) "On Spectral Clustering:
%% 	Analysis and an algorithm", in Advances in Neural Information Processing%%	Systems 14.


%%[4]	Weiss, Y. (1999) "Segmentation using eigenvectors: a unifying view", 
%%	Tech. Rep., CS. Dept., UC Berkeley.


%%%%%%%%% For question 9 uncomment this code to make your own random data of the same form
%r1=5;
%r2=10;
%set1= rand(1,20)*2*pi;
%set2= rand(1,30)*2*pi;
%d1=[r1*cos(set1); r1*sin(set1)]
%d2=[r2*cos(set2); r2*sin(set2)]
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% For question 9 comment out the next 3 lines
load 'HW3.mat'
d1=allpts(1:20,:)';
d2=allpts(21:50,:)';
%%%%%%%%%%%%%%%%%%%%

% subplot(2,3,1)
plot(d1(1,:),d1(2,:),'rx');
hold on
plot(d2(1,:),d2(2,:),'rx');

cluster1=d1';
cluster2=d2';

allpts=[cluster1;cluster2]
goto=length(allpts);
%%

%% compute A (step 1)
%%%%  experiment with sigsq in question 8
sigsq=.9;
Aisq=allpts(:,1).^2+allpts(:,2).^2;
Dotprod=allpts*allpts'
distmat=-repmat(Aisq',goto,1)-repmat(Aisq,1,goto)+2*Dotprod;
Afast=exp(distmat/(2*sigsq));
A = Afast-diag(diag(Afast));
subplot(2,3,2)
imagesc(A); colorbar;


%% step 2
D = diag(sum(A'))
L=D^(-.5)*A*D^(-.5)
subplot(2,3,3)
imagesc(L); colorbar;


%% step 3 
[X,di]=eig(L)
[Xsort,Dsort]=eigsort(X,di)
Xuse=Xsort(:,1:2)
subplot(2,3,4)
imagesc(Xuse); colorbar;


%% normalize X to get Y (step 4)
Xsq = Xuse.*Xuse;
divmat=repmat(sqrt(sum(Xsq')'),1,2)
Y=Xuse./divmat
subplot(2,3,5)
imagesc(Y); colorbar;

%% step 5/6
[c,Dsum,z] = kmeans(Y,2)

kk=c;
c1=find(kk==1);
c2=find(kk==2);

subplot(2,3,6)
plot(allpts(c1,1),allpts(c1,2),'co')
hold on;
plot(allpts(c2,1),allpts(c2,2),'mo')
title('with spectral clustering');


%% for comparison run kmeans on original data
[cc,Dsum2,z2] = kmeans(allpts,2)
subplot(2,3,1)

kk=cc;
c1=find(kk==1);
c2=find(kk==2);

plot(allpts(c1,1),allpts(c1,2),'co')
plot(allpts(c2,1),allpts(c2,2),'mo')
title('with k-means');

