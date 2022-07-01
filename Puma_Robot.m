function varargout = Puma_Robot(varargin)
% PUMA_ROBOT MATLAB code for Puma_Robot.fig
%      PUMA_ROBOT, by itself, creates a new PUMA_ROBOT or raises the existing
%      singleton*.
%
%      H = PUMA_ROBOT returns the handle to a new PUMA_ROBOT or the handle to
%      the existing singleton*.
%
%      PUMA_ROBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PUMA_ROBOT.M with the given input arguments.
%
%      PUMA_ROBOT('Property','Value',...) creates a new PUMA_ROBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Puma_Robot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Puma_Robot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Puma_Robot

% Last Modified by GUIDE v2.5 07-Dec-2020 23:28:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Puma_Robot_OpeningFcn, ...
                   'gui_OutputFcn',  @Puma_Robot_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before Puma_Robot is made visible.
function Puma_Robot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Puma_Robot (see VARARGIN)

% Choose default command line output for Puma_Robot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Puma_Robot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Puma_Robot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function px_Callback(hObject, eventdata, handles)
% hObject    handle to px (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of px as text
%        str2double(get(hObject,'String')) returns contents of px as a double


% --- Executes during object creation, after setting all properties.
function px_CreateFcn(hObject, eventdata, handles)
% hObject    handle to px (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function py_Callback(hObject, eventdata, handles)
% hObject    handle to py (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of py as text
%        str2double(get(hObject,'String')) returns contents of py as a double


% --- Executes during object creation, after setting all properties.
function py_CreateFcn(hObject, eventdata, handles)
% hObject    handle to py (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pz_Callback(hObject, eventdata, handles)
% hObject    handle to pz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pz as text
%        str2double(get(hObject,'String')) returns contents of pz as a double


% --- Executes during object creation, after setting all properties.
function pz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in inverse.
function inverse_Callback(hObject, eventdata, handles)
% hObject    handle to inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Px = str2double(get(handles.px,'string'));
Py = str2double(get(handles.py,'string'));
Pz = str2double(get(handles.pz,'string'));

d3=10;
d4=9;
a3=9;
a2=6;

%************L=Link([Th d a alpha])*************
L(1)=Link([0 0 0  0]);
L(2)=Link([0 0  0 -pi/2]);
L(3)=Link([0 d3  a2  0]);
L(4)=Link([0 d4 a3  -pi/2]);
L(5)=Link([0 0  0  pi/2]);
L(6)=Link([0 0 0  -pi/2]);

Robot=SerialLink(L);
Robot.name='Puma';

T=[1 0 0 Px ;
   0 1 0 Py ;
   0 0 1 Pz ; 
   0 0 0 1] ;

J=Robot.ikine(T,[0 0 0 0 0 0 ],[1 1 1 0 0 0 ])*180/pi;

a = floor(J(1));
b = floor(J(2));
c = floor(J(3));
d = floor(J(4));
e = floor(J(5));
f = floor(J(6));

set(handles.th1,'string',a);
set(handles.th2,'string',b);
set(handles.th3,'string',c);
set(handles.th4,'string',d);
set(handles.th5,'string',e);
set(handles.th6,'string',f);

Robot.plot(J*pi/180);





function th1_Callback(hObject, eventdata, handles)
% hObject    handle to th1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th1 as text
%        str2double(get(hObject,'String')) returns contents of th1 as a double


% --- Executes during object creation, after setting all properties.
function th1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function th2_Callback(hObject, eventdata, handles)
% hObject    handle to th2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th2 as text
%        str2double(get(hObject,'String')) returns contents of th2 as a double


% --- Executes during object creation, after setting all properties.
function th2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function th3_Callback(hObject, eventdata, handles)
% hObject    handle to th3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th3 as text
%        str2double(get(hObject,'String')) returns contents of th3 as a double


% --- Executes during object creation, after setting all properties.
function th3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function th4_Callback(hObject, eventdata, handles)
% hObject    handle to th4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th4 as text
%        str2double(get(hObject,'String')) returns contents of th4 as a double


% --- Executes during object creation, after setting all properties.
function th4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function th5_Callback(hObject, eventdata, handles)
% hObject    handle to th5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th5 as text
%        str2double(get(hObject,'String')) returns contents of th5 as a double


% --- Executes during object creation, after setting all properties.
function th5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function th6_Callback(hObject, eventdata, handles)
% hObject    handle to th6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th6 as text
%        str2double(get(hObject,'String')) returns contents of th6 as a double


% --- Executes during object creation, after setting all properties.
function th6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in direct.
function direct_Callback(hObject, eventdata, handles)
% hObject    handle to direct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1 = str2double(get(handles.th1,'string'))*pi/180;
theta2 = str2double(get(handles.th2,'string'))*pi/180;
theta3 = str2double(get(handles.th3,'string'))*pi/180;
theta4 = str2double(get(handles.th4,'string'))*pi/180;
theta5 = str2double(get(handles.th5,'string'))*pi/180;
theta6 = str2double(get(handles.th6,'string'))*pi/180;

d3=10;
d4=9;
a3=9;
a2=6;
%************L=Link([Th d a alpha])*************
L(1)=Link([0 0 0  0]);
L(2)=Link([0 0  0 -pi/2]);
L(3)=Link([0 d3  a2  0]);
L(4)=Link([0 d4 a3  -pi/2]);
L(5)=Link([0 0  0  pi/2]);
L(6)=Link([0 0 0  -pi/2]);
Robot=SerialLink(L);
Robot.name='Puma';
Robot.plot([theta1 ,theta2 ,theta3 ,theta4 ,theta5, theta6]);
T=Robot.fkine([theta1 ,theta2 ,theta3 ,theta4 ,theta5, theta6]);

x = floor(T(1,4));
y = floor(T(2,4));
z=  floor(T(3,4));

set(handles.px,'string',x);
set(handles.py,'string',y);
set(handles.pz,'string',z);
