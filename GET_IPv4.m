function [IPaddress] = GET_IPv4()
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
address = java.net.InetAddress.getLocalHost;
IPaddress = char(address.getHostAddress);
end

