function varargout = Faces(varargin)
% FACES MATLAB code for Faces.fig
%      FACES, by itself, creates a new FACES or raises the existing
%      singleton*.
%
%      H = FACES returns the handle to a new FACES or the handle to
%      the existing singleton*.
%
%      FACES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACES.M with the given input arguments.
%
%      FACES('Property','Value',...) creates a new FACES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Faces_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Faces_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Faces

% Last Modified by GUIDE v2.5 07-Jan-2014 13:42:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Faces_OpeningFcn, ...
    'gui_OutputFcn',  @Faces_OutputFcn, ...
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


% --- Executes just before Faces is made visible.
function Faces_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Faces (see VARARGIN)
% Choose default command line output for Faces
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Faces wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Faces_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbuttonOpen.
function pushbuttonOpen_Callback(~, ~, handles)
% hObject    handle to pushbuttonOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
[file_name, file_path] = uigetfile ('*.jpg');
if file_path ~= 0
    im = imread ([file_path, file_name]);
    imshow(im, 'Parent', handles.axes1)
    set(handles.text1,'String',file_name)
end

% --- Executes on button press in pushbuttonGabor.
function pushbuttonGabor_Callback(~, ~, handles)
% hObject    handle to pushbuttonGabor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global net im IMGDB
img = imresize(im,[27 18]);
if (numel(size(img)) > 2)
    img = rgb2gray(img);
end
[~,index] = max(sim(net,im2vec(img)));
imshow(IMGDB{1,index*10}, 'Parent', handles.axes2)
set(handles.text2,'String',IMGDB{1,index*10})


% --- Executes on button press in pushbuttonEigen.
function pushbuttonEigen_Callback(~, ~, handles)
% hObject    handle to pushbuttonEigen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im V w cv
if (numel(size(im)) > 2)
    img = rgb2gray(im);
end
img = reshape(imresize(img,[27 18]), 27*18, 1);
v = cell2mat(w(2,:));
p=img-uint8(mean(v,2));       % Subtract the mean
s=single(p)'*V;
z=[];
for index=1:size(v,2)
    z=[z,norm(cv(index,:)-s,2)];
end
[~,index]=min(z);
imshow(w{1,index}, 'Parent', handles.axes2)
set(handles.text2,'String',w{1,index})