%------------------------------sound capture-------------------------------
%Ashok Sharma Paudel, Deepesh Lekhak, Keshav Bashayal, Sushma shrestha
%--------------------------------------------------------------------------

function varargout = Sound_capture(varargin)
% SOUND_CAPTURE M-file for Sound_capture.fig
%      SOUND_CAPTURE, by itself, creates a new SOUND_CAPTURE or raises the existing
%      singleton*.
%
%      H = SOUND_CAPTURE returns the handle to a new SOUND_CAPTURE or the handle to
%      the existing singleton*.
%
%      SOUND_CAPTURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOUND_CAPTURE.M with the given input arguments.
%
%      SOUND_CAPTURE('Property','Value',...) creates a new SOUND_CAPTURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sound_capture_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sound_capture_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sound_capture

% Last Modified by GUIDE v2.5 01-May-2013 22:51:30

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sound_capture_OpeningFcn, ...
                   'gui_OutputFcn',  @Sound_capture_OutputFcn, ...
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


% --- Executes just before Sound_capture is made visible.
function Sound_capture_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sound_capture (see VARARGIN)

% Choose default command line output for Sound_capture
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sound_capture wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global a;
global p;


% --- Outputs from this function are returned to the command line.
function varargout = Sound_capture_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
    fid=fopen('rec.txt','w');
    aaa=1;
    fprintf(fid,'%d',aaa);


% --- Executes on button press in Record.
function Record_Callback(hObject, eventdata, handles)
% hObject    handle to Record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    global a;

   a.r= audiorecorder(22050, 16, 1);
   
   record(a.r);     % speak into microphone...
   
    % Store the img data in the handles struct 
   %handles.path=path;
   %guidata(hObject, handles);  % Save handles so all call backs have the updated data
    fid=fopen('rec.txt','w');
    aaa=0;
    fwrite(fid,aaa);

      
      
      


% --- Executes on button press in Plot.
function Plot_Callback(hObject, eventdata, handles )
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global a;
    global p;
  % Add the img data to the handle
    
    %guidata(hObject, handles);
    %%  listen to complete recording
    mySpeech = getaudiodata(a.r, 'int16'); % get data as int16 array
    axes(handles.axes1);
    plot(mySpeech);
    
 
       play(a.r);
    
    
   

% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   global a;
   global p;% Add the img data to the handle
    stop(a.r);
   


% --- Executes on button press in Train.
function Train_Callback(hObject, eventdata, handles)
% hObject    handle to Train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%h=gcf();
        global a;
        global p;
   
    

             fid=fopen('rec.txt','r');
   
    aaa=fscanf(fid,'%d');
    if aaa==1
        errordlg('Please record Your voice bofore proceeding further','Error');
        
    else
        prompt = {'Enter your name'};
        dlg_title = 'Input';
        num_lines = 1;
        def = {'Your name'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        answer=char(cell2mat(answer));

        p.path=answer;

        name=['sounds/',p.path,'.wav'];
        d=getaudiodata(a.r);
        wavwrite(d,22050,16,name);


       

        delete(handles.figure1);
        figure(train);
    end
    

% --- Executes on button press in Test.
function Test_Callback(hObject, eventdata, handles)
% hObject    handle to Test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global a

    fid=fopen('rec.txt','r');

    aaa=fscanf(fid,'%d');
    if aaa==1
    errordlg('Please record Your voice bofore proceeding further','Error');
    else    
    delete(handles.figure1);

    figure(Identification);
    end


% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d=['ASHOK SHARMA POUDEL(066BEX405), DEEPESH LEKHAK(066BEX414) , KESHAV BASHYAL(066BEX418) , SUSHMA SHRESTHA(066BEX444)'];
h = helpdlg(d,'About Us');

% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on button press in veri.
function veri_Callback(hObject, eventdata, handles)
% hObject    handle to veri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p;
 
  fid=fopen('rec.txt','r');
   
    aaa=fscanf(fid,'%d');
    if aaa==1
        errordlg('Please record Your voice bofore proceeding further','Error');
        
    else
        prompt = {'Enter your name'};
        dlg_title = 'Input';
        num_lines = 1;
        def = {'Your name'};
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        answer=char(cell2mat(answer));
      
         
        p.ans=answer;
         delete(handles.figure1);
        figure(verification);
    end

