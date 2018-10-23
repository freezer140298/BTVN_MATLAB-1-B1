function varargout = BT1(varargin)
% BT1 MATLAB code for BT1.fig
%      BT1, by itself, creates a new BT1 or raises the existing
%      singleton*.
%
%      H = BT1 returns the handle to a new BT1 or the handle to
%      the existing singleton*.
%
%      BT1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BT1.M with the given input arguments.
%
%      BT1('Property','Value',...) creates a new BT1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BT1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BT1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BT1

% Last Modified by GUIDE v2.5 22-Oct-2018 09:29:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BT1_OpeningFcn, ...
                   'gui_OutputFcn',  @BT1_OutputFcn, ...
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


% --- Executes just before BT1 is made visible.
function BT1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BT1 (see VARARGIN)

% Choose default command line output for BT1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BT1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BT1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in drawUpdateBtn.
function drawUpdateBtn_Callback(hObject, eventdata, handles)
% hObject    handle to drawUpdateBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if any(ismember(fields(handles),'isImported'))
    if handles.isImported == true
        xData = handles.x;
        yData = handles.y;
        
        zStr = get(handles.zEdit,'String');

        if isempty(zStr)
            msgbox('Expression is not empty');
            return;
        end
        
        
        zStr = strcat('@(x,y)',zStr);
        z = str2func(zStr);
       
        
        [xData,yData] = meshgrid(xData,yData);
        zData = z(xData,yData);
       
        % Save z to GUI
        handles.z = zData;
        guidata(hObject,handles);
        
        switch(handles.popUpFlag)
            case 1
                plot3(xData,yData,zData);
            case 2
                mesh(xData,yData,zData);
            case 3
                surf(xData,yData,zData);
            case 4
                contour(xData,yData,zData,5);
            case 5
                contour3(xData,yData,zData,5);
            case 6
                waterfall(xData,yData,zData);
        end
        
        xlabel('x');
        ylabel('y');
        zlabel('z');
        
        xEditStr = get(handles.xEdit,'String');
        yEditStr = get(handles.yEdit,'String');
        
        if ~isempty(xEditStr) || ~isempty(yEditStr)
            xlimStr = strcat('xlim([',{xEditStr},'])');
            ylimStr = strcat('ylim([',{yEditStr},'])');
            eval(xlimStr{1});
            eval(ylimStr{1});
        end
        
        handles.isDrawed = true;
        guidata(hObject,handles);
    end
else
    msgbox('Need to import Excel file first!');   
end
function zEdit_Callback(hObject, eventdata, handles)
% hObject    handle to zEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zEdit as text
%        str2double(get(hObject,'String')) returns contents of zEdit as a double


% --- Executes during object creation, after setting all properties.
function zEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xEdit_Callback(hObject, eventdata, handles)
% hObject    handle to xEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xEdit as text
%        str2double(get(hObject,'String')) returns contents of xEdit as a double


% --- Executes during object creation, after setting all properties.
function xEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yEdit_Callback(hObject, eventdata, handles)
% hObject    handle to yEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yEdit as text
%        str2double(get(hObject,'String')) returns contents of yEdit as a double


% --- Executes during object creation, after setting all properties.
function yEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% Determine the selected data set
str = get(hObject,'String');
val = get(hObject,'Value');

% Set current data to the selected data set
switch(str{val})
    case 'plot3'
        flag = 1;
    case 'mesh'
        flag = 2;
    case 'surf'
        flag = 3;
    case 'contour'
        flag = 4;
    case 'contour3'
        flag = 5;
    case 'waterfall'
        flag = 6;
end

handles.popUpFlag = flag;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.popUpFlag = 1;
guidata(hObject,handles);


% --- Executes on button press in exportBtn.
function exportBtn_Callback(hObject, eventdata, handles)
% hObject    handle to exportBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
excelFileNameStr = get(handles.excelEdit,'String');

if isempty(excelFileNameStr) 
    msgbox('Filename is not empty');
    return;
end

if ~exist(excelFileNameStr,'file')
    msgbox('File does not exist');
    return;
end

if ~any(ismember(fields(handles),'isDrawed'))
    msgbox('Need to draw first');
    return;
end

x = handles.x;
y = handles.y;

% Make x,y matrix
xy = [x y];

z = handles.z;
xlswrite(excelFileNameStr,xy,'Sheet1','A1');
xlswrite(excelFileNameStr,z,'Sheet2','A1');
msgbox('Export completed');

% --- Executes on button press in importBtn.
function importBtn_Callback(hObject, eventdata, handles)
% hObject    handle to importBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

excelFileNameStr = get(handles.excelEdit,'String');

if isempty(excelFileNameStr)
    handles.isImported = false;
    guidata(hObject,handles);
    msgbox('Filename is not empty');
else
    if exist(excelFileNameStr,'file')
        data = xlsread(excelFileNameStr);
        x = data(:,1);
        y = data(:,2);
        %z = data(:,3);
        handles.excelFileNameStr = excelFileNameStr;
        handles.x = x;
        handles.y = y;
        %handles.z = z;
        
        handles.isImported = 1;
        
        guidata(hObject,handles);
        
        msgbox('File imported');
    else
        handles.isImported = false;
        
        guidata(hObject,handles);
        msgbox('File does not exist');
    end
end

function excelEdit_Callback(hObject, eventdata, handles)
% hObject    handle to excelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of excelEdit as text
%        str2double(get(hObject,'String')) returns contents of excelEdit as a double


% --- Executes during object creation, after setting all properties.
function excelEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to excelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
