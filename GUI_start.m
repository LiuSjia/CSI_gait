function varargout = GUI_start(varargin)
<<<<<<< HEAD

||||||| merged common ancestors
%GUI_START MATLAB code file for GUI_start.fig
%      GUI_START, by itself, creates a new GUI_START or raises the existing
%      singleton*.
%
%      H = GUI_START returns the handle to a new GUI_START or the handle to
%      the existing singleton*.
%
%      GUI_START('Property','Value',...) creates a new GUI_START using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI_start_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI_START('CALLBACK') and GUI_START('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI_START.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_start

% Last Modified by GUIDE v2.5 25-May-2018 01:37:49

% Begin initialization code - DO NOT EDIT
=======
%GUI_START MATLAB code file for GUI_start.fig
%      GUI_START, by itself, creates a new GUI_START or raises the existing
%      singleton*.
%
%      H = GUI_START returns the handle to a new GUI_START or the handle to
%      the existing singleton*.
%
%      GUI_START('Property','Value',...) creates a new GUI_START using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI_start_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI_START('CALLBACK') and GUI_START('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI_START.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_start

% Last Modified by GUIDE v2.5 25-May-2018 23:19:02

% Begin initialization code - DO NOT EDIT
>>>>>>> 444a777ca56b63a0e3f985cacc4c48a83041f456
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

% UIWAIT makes GUI_start wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_start_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% 启动和网卡的连接 并绘制出图像。
read_bf_socket(handles)



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes_camera_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes_camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  开启摄像头
global vid vid_res n_bands;
if vid == -1 %摄像头尚未开启
    [vid, vid_res, n_bands] = open_camera();
end
axes(handles.axes_camera);
hImage=image(zeros(vid_res(2),vid_res(1),n_bands));
preview(vid, hImage);   %打开预览画面


% --- Executes during object creation, after setting all properties.
function axes_camera_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_camera

global vid vid_res n_bands;
[vid, vid_res, n_bands] = open_camera();
axes(handles.axes_camera);
hImage = image(zeros(vid_res(2),vid_res(1),n_bands));
preview(vid, hImage);   %打开预览画面
