function [ vid, vid_res, n_bands ] = open_camera(~)
%��������ͷ
try
    vid=videoinput('winvideo',1,'YUY2_640x480');
    % save('globalvariables.mat','vid', '-mat');
    set(vid,'TriggerRepeat',Inf);
    set(vid,'FramesPerTrigger',1);
    set(vid,'FrameGrabInterval',2);
    set(vid,'ReturnedColorSpace','rgb'); %'rgb'������Ϊ��ɫ��ͼ��
    vid_res=get(vid,'VideoResolution');
    n_bands=get(vid,'NumberOfBands');
catch
    msgbox('����ͷ����ʧ��','����','error');
    vid = -1;
end

end


