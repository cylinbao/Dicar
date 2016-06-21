function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above symbols to modify the response to help main

% Last Modified by GUIDE v2.5 21-Jun-2016 09:09:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;
addpath './libsvm/unix';
addpath './libsvm/window';
load 'classifier/nuSVModel_n.mat';
load 'labels.mat'
handles.svm_model = svm_model;
handles.labels = labels;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Open.
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
[fname, fpath, ] = uigetfile({'*.png;*.PNG', 'PNG'});
im = imread(strcat(fpath, fname));
imshow(im);
set(handles.Symbols, 'string', '');
set(handles.Formula, 'string', '');
set(handles.Result, 'string', '');
handles.im = im;
guidata(hObject, handles);


% --- Executes on button press in Segment.
function Segment_Callback(hObject, eventdata, handles)
% hObject    handle to Segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
im = handles.im;
S = image_segmentation(im);

% Plot Bounding Box
hold on;
for k = 1:length(S)
    rectangle('Position', S(k).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 2);
end
hold off;

handles.S = S;
guidata(hObject, handles);


% --- Executes on button press in Recognize.
function Recognize_Callback(hObject, eventdata, handles)
% hObject    handle to Recognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
S = handles.S;
svm_model = handles.svm_model;
labels = handles.labels;
nS = [];
symbols = [];
for i = 1:length(S)
    img = S(i).Image;
    imsize = size(img);
    if (imsize(1) > imsize(2))
        pad = [0, round((imsize(1) - imsize(2)) / 2)];
    else
        pad = [round((imsize(2) - imsize(1)) / 2), 0];
    end
    img = padarray(img, pad);
    img = double(imresize(img,[40 40]));
% 	imshow(img);
	[number, prob] = classify(reshape(img',1,1600));
	label = labels{number,1};
    tnS = struct('BoundingBox', S(i).BoundingBox, 'number', number, 'label', label);
	nS = [nS; tnS];
    symbols = strcat(symbols, label);
end
set(handles.Symbols, 'string', symbols);
% Remove '='
if (strcmp(nS(end).label, '='))
    nS(end) = [];
elseif(strcmp(nS(end).label, '-') && strcmp(nS(end - 1).label, '-'))
    nS(end) = [];
    nS(end) = [];
end
handles.nS = nS;
guidata(hObject, handles);



% --- Executes on button press in Interpret.
function Interpret_Callback(hObject, eventdata, handles)
% hObject    handle to Interpret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
nS = handles.nS;
try
    formula = formula_interpret(nS);
catch
    warning('Problem at interpreter, set formula to empty');
    formula = '';
end
set(handles.Formula, 'string', formula);
handles.formula = formula;
guidata(hObject, handles);



function Symbols_Callback(hObject, eventdata, handles)
% hObject    handle to Symbols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Symbols as symbols
%        str2double(get(hObject,'String')) returns contents of Symbols as a double


% --- Executes during object creation, after setting all properties.
function Symbols_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Symbols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Formula_Callback(hObject, eventdata, handles)
% hObject    handle to Formula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Formula as text
%        str2double(get(hObject,'String')) returns contents of Formula as a double


% --- Executes during object creation, after setting all properties.
function Formula_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Formula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Result_Callback(hObject, eventdata, handles)
% hObject    handle to Result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Result as text
%        str2double(get(hObject,'String')) returns contents of Result as a double


% --- Executes during object creation, after setting all properties.
function Result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Evaluate.
function Evaluate_Callback(hObject, eventdata, handles)
% hObject    handle to Evaluate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
formula = handles.formula;
syms m n;

try
    result = eval(formula);
catch
    warning('Problem at evaluation, set result to 0');
    result = 0;
end

if (isnumeric(result))
    set(handles.Result, 'string', num2str(result));
else
    set(handles.Result, 'string', char(result));
end
guidata(hObject, handles);


% --- Executes on button press in All.
function All_Callback(hObject, eventdata, handles)
% hObject    handle to All (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Open_Callback(hObject, eventdata, handles);
Segment_Callback(hObject, eventdata, handles);
Recognize_Callback(hObject, eventdata, handles);
Interpret_Callback(hObject, eventdata, handles);
Evaluate_Callback(hObject, eventdata, handles);
