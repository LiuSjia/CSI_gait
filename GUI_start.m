function varargout = GUI_start(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_start_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_start_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_start is made visible.
function GUI_start_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for GUI_start
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_start_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global Flag_1 container_csi Flag_collect coss isYun num_collect
Flag_collect = 0;
num_collect = 100;
isYun = 1;
while Flag_1
%% Build a TCP Server and wait for connection
%% ����TCP���������ȴ�����
    port = 8090;
    t = tcpip('0.0.0.0', port, 'NetworkRole', 'server');
    t.InputBufferSize = 1024;
    t.Timeout = 15;
    fprintf('Waiting for connection on port %d\n',port);
    fopen(t);
    fprintf('Accept connection from %s\n',t.RemoteHost);

%% Set plot parameters  �趨��ͼ����
    axis([1,30,-10,30]);
    t1=0;
    m1=zeros(30,1);
%%  Starting in R2014b, the EraseMode property has been removed from all graphics objects. 
%%  https://mathworks.com/help/matlab/graphics_transition/how-do-i-replace-the-erasemode-property.html
    [~, DATESTR] = version();
    if datenum(DATESTR) > datenum('February 11, 2014')
       % p = plot(gui_handles.axes1,t1,m1,'MarkerSize',5);
       p = plot(handles.axes1,t1,m1);
    else
        %p = plot(gui_handles.axes1,t1,m1,'EraseMode','Xor','MarkerSize',5);
        p = plot(handles.axes1,t1,m1,'EraseMode','Xor','MarkerSize',5);
    end

   % xlabel('Subcarrier index');
  %  ylabel('SNR (dB)');

%% Initialize variables
    csi_entry = [];                 % ��¼
    index = -1;                     % The index of the plots which need shadowing
    broken_perm = 0;                % Flag marking whether we've encountered a broken CSI yet
    triangle = [1 3 6];             % What perm should sum to for 1,2,3 antennas

%% Process all entries in socket    �����׽����е�������Ŀ
    % Need 3 bytes -- 2 byte size field and 1 byte code
    while Flag_1
        % Read size and code from the received packets
        s = warning('error', 'instrument:fread:unsuccessfulRead');
        try
            field_len = fread(t, 1, 'uint16');  
            % t���ļ����    1 ���Ƕ����Ԫ�ظ���   'uint16'�� ��ʽ
            % ��ȡ �������ļ�
        catch
            warning(s);
            disp('Timeout, please restart the client and connect again.');
            break;
        end

        code = fread(t,1);    
        % If unhandled code, skip (seek over) the record and continue
        if (code == 187) % get beamforming or phy data
            bytes = fread(t, field_len-1, 'uint8');
            bytes = uint8(bytes);
            if (length(bytes) ~= field_len-1)
                fclose(t);
                return;
            end
        else if field_len <= t.InputBufferSize  % skip all other info
                fread(t, field_len-1, 'uint8');
                continue;
            else
                continue;
            end
        end

        if (code == 187) % (tips: 187 = hex2dec('bb')) Beamforming matrix -- output a record
            csi_entry = read_bfee(bytes);
        
            perm = csi_entry.perm;  % �������ߵ��ź����е����������3��RF��
            Nrx = csi_entry.Nrx;    % ���ߵ�����
            
            if Nrx > 1 % No permuting needed for only 1 antenna
                if sum(perm) ~= triangle(Nrx) % matrix does not contain default values
                    if broken_perm == 0
                        broken_perm = 1;
                        fprintf('WARN ONCE: Found CSI (%s) with Nrx=%d and invalid perm=[%s]\n', filename, Nrx, int2str(perm));
                    end
                else
                    csi_entry.csi(:,perm(1:Nrx),:) = csi_entry.csi(:,1:Nrx,:);
                end
            end
        end
    
        index = mod(index+1, 10);
        
        csi = get_scaled_csi(csi_entry);%CSI data
	%You can use the CSI data here.
        
        
	%This plot will show graphics about recent 10 csi packets
        set(p(index*3 + 1),'XData', [1:30], 'YData', db(abs(squeeze(csi(1,1,:)).')), 'color', 'b', 'linestyle', '-');
        
        if Nrx > 1
            set(p(index*3 + 2),'XData', [1:30], 'YData', db(abs(squeeze(csi(1,2,:)).')), 'color', 'g', 'linestyle', '-');
        end
        
        if Nrx > 2
            set(p(index*3 + 3),'XData', [1:30], 'YData', db(abs(squeeze(csi(1,3,:)).')), 'color', 'r', 'linestyle', '-');
            container_csi = db(abs(squeeze(csi).'));
            if Flag_collect & num_collect
                % disp(size(container_csi))
                coss = [coss;container_csi];
                num_collect = num_collect - 1;
            end
        end
        
        axis([1,30,-10,40]);
        drawnow;
 
        csi_entry = [];
    end
%% Close file
    fclose(t);
    delete(t);
    isYun = 0;
end



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% ����ID 
    id_yet = get(handles.listbox1, 'string');
    id_count = length(id_yet);
    id_add = num2str(id_count + 1);
    set(handles.listbox1, 'string', sort([id_yet; id_add]));
    mkdir(strcat('data/user', id_add));



function pushbutton2_Callback(hObject, eventdata, handles)
% ��������--����̬��csi����
    global isYun Flag_collect coss num_collect
    if isYun
        % �ж��Ƿ����tcp
    end
    sp=actxserver('SAPI.SpVoice');
    sp.Speak('�뿪ʼ����');
    As = get(handles.listbox1,'value');
    filepath = strcat('data/user', As,'/',As,'.mat');
    Flag_collect = 1;
    while num_collect

    end
    save(filepath,'coss');
    Flag_collect = 0;
    coss = [];

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
    % ��λ��ť
    global collect_con coss
    coss = [];
    collect_con = [];

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% ʶ��ť
    global Flag_collect coss num_collect
    sp=actxserver('SAPI.SpVoice');
    sp.Speak('�뿪ʼ����');

    Flag_collect = 1;
    while num_collect
    
    end
    plot(handles.axes3,coss);
    Flag_collect = 0;
  
% svm
    n = get(handles.listbox1, 'string');
    svm_trainer = svm_training(create_training_data(n));
    score = create_testing_data(coss);
    coss =[];
    classify_label = svm_classifying(svm_trainer,score);
% ��ʾ
    set(handles.text14,'String',classify_label);
    

% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
    % ����ע�� --��yc��������
    %global vid vid_res n_bands;
    %[vid, vid_res, n_bands] = open_camera();
    %hImage = image(zeros(vid_res(2),vid_res(1),n_bands));
    %preview(vid, hImage); 

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
    global Flag_1
    Flag_1 = 1;

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
    global Flag_1
    Flag_1 = 0;


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('recognition.fig');