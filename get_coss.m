function [coss] = get_coss(file)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    csi_trace = read_bf_file(file);
    m = size(csi_trace, 1);  % �ó�һ��dat�ļ��İ�������
    dataSet = zeros(m, 3) ;  % ���� һ���������� �������ľ���                
    coss = [];

    for k=1:50
        t = get_scaled_csi(csi_trace{k}) ;                              
        t = db(abs(squeeze(t).')) ;
        dataSet(k,:) = mean(t) ;  %  ����������⣺  ��30������ȡ��ƽ��ֵ
        coss = [coss;mean(t)];
    end
end

