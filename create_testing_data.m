function score = create_testing_data(data)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    ac = data==-Inf;
    data(ac)=0;
    
    [coeff,score,latent] = pca(data);
end

