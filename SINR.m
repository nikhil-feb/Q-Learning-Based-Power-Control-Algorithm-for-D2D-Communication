function [BI, DI]=SINR(P,dtx,dty,drx,dry,cx,cy)
load main_allo_testdata.mat;

    d_d2d_bs=distance_fn(dtx,dty,0,0);
    pl=15.3+37.6.*log10(d_d2d_bs/1000);
    int_d2d_bs=P+17+4-pl;
    int_d2d_bs2=10.^(int_d2d_bs/10);
    tot_int_bs=sum(int_d2d_bs2);
    d_bnc=distance_fn(cx,cy,0,0);
    pl=15.3+37.6.*log10(d_bnc/1000);
    sig_pow_bs=P+17+4-pl;
    sig_pow_bs2=10.^(sig_pow_bs/10);
    noise_power=10^((-116+30)/10);
    BI=sig_pow_bs2/(noise_power+tot_int_bs);
    d_d2d=zeros(length(drx),length(dtx));
    pr_d2d=zeros(length(drx),length(dtx));
    pr_d2d_2=zeros(length(drx),length(dtx));
    d_dnc=zeros(1,length(drx));
    pr_dnc=zeros(1, length(drx));
    pr_dnc2=zeros(1, length(drx));
    int_d2d=zeros(1, length(drx));
    sig_pow_d2d=zeros(1, length(drx));
    DI=zeros(1, length(drx));
    for i=1:length(dtx)
        for j=1:length(dtx)
           d_d2d(i,j)=distance_fn(drx(i),dry(i),dtx(j),dty(j));
           pr_d2d(i,j)=(P(i)+30)+8+(28+40*log10(d_d2d(i,j)/1000));
           pr_d2d_2(i,j)=10^(pr_d2d(i,j)/10);
        end
        d_dnc(i)=distance_fn(drx(i),dry(i),cx,cy);
        pr_dnc(i)=(23+30)+8+(28+40*log10(d_dnc(i)/1000));
        pr_dnc2(i)=10^(pr_dnc(i)/10);
        int_d2d(i)=sum(pr_d2d_2(i,:))-pr_d2d_2(i,i)+pr_dnc2(i);
        sig_pow_d2d(i)=pr_d2d_2(i,i);
        DI(i)=sig_pow_d2d(i)/(noise_power+int_d2d(i));
    end
end
% distance function
function[d]=distance_fn(x1,y1,x2,y2)
d=sqrt((x2-x1).^2+(y2-y1).^2);
end