function [crange_q] = match_crange(img_base,img_q,crange_base)

img_common = and(sum(img_base,3)>0,sum(img_q,3)>0);

%crange161EF = crangeList.FRT000161EF;
crange_base_R = crange_base(1,:); crange_base_R_mean = mean(crange_base_R); crange_base_R_width = crange_base_R(2)-crange_base_R(1);
crange_base_G = crange_base(2,:); crange_base_G_mean = mean(crange_base_G); crange_base_G_width = crange_base_G(2)-crange_base_G(1);
crange_base_B = crange_base(3,:); crange_base_B_mean = mean(crange_base_B); crange_base_B_width = crange_base_B(2)-crange_base_B(1);

R_base = img_base(:,:,1);
G_base = img_base(:,:,2);
B_base = img_base(:,:,3);

R_base_common = R_base(img_common); R_base_common_mean = mean(R_base_common); R_base_common_std = std(R_base_common);
G_base_common = G_base(img_common); G_base_common_mean = mean(G_base_common); G_base_common_std = std(G_base_common);
B_base_common = B_base(img_common); B_base_common_mean = mean(B_base_common); B_base_common_std = std(B_base_common);

R_q = img_q(:,:,1);
G_q = img_q(:,:,2);
B_q = img_q(:,:,3);

R_q_common = R_q(img_common); R_q_common_mean = mean(R_q_common); R_q_common_std = std(R_q_common);
G_q_common = G_q(img_common); G_q_common_mean = mean(G_q_common); G_q_common_std = std(G_q_common);
B_q_common = B_q(img_common); B_q_common_mean = mean(B_q_common); B_q_common_std = std(B_q_common);

crange_q_R_mean = crange_base_R_mean + (R_q_common_mean - R_base_common_mean);
crange_q_G_mean = crange_base_G_mean + (G_q_common_mean - G_base_common_mean);
crange_q_B_mean = crange_base_B_mean + (B_q_common_mean - B_base_common_mean);

crange_q_R_width = crange_base_R_width * (R_q_common_std./R_base_common_std);
crange_q_G_width = crange_base_G_width * (G_q_common_std./G_base_common_std);
crange_q_B_width = crange_base_B_width * (B_q_common_std./B_base_common_std);

crange_q_R = [crange_q_R_mean - crange_q_R_width/2, crange_q_R_mean + crange_q_R_width/2];
crange_q_G = [crange_q_G_mean - crange_q_G_width/2, crange_q_G_mean + crange_q_G_width/2];
crange_q_B = [crange_q_B_mean - crange_q_B_width/2, crange_q_B_mean + crange_q_B_width/2];

crange_q = cat(1,crange_q_R,crange_q_G,crange_q_B);

end