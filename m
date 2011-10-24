References: 
Message-ID: <1319490255.1417.YahooMailNeo@domain.hid>
Date: Mon, 24 Oct 2011 14:04:15 -0700 (PDT)
From: Tom Z <tomz30@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="1498488837-480329272-1319490255=:1417"
Subject: Re: [Xenomai-help] address spaces of real-time task and standard
	linux process
Reply-To: Tom Z <tomz30@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: "\"xenomai@xenomai.org\"" <xenomai@xenomai.org>

--1498488837-480329272-1319490255=:1417
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for Thomas' answer.=0A=0AThe previous code I showed was truncated fo=
r simplicity. The actual code is a little more complicated.=A0=0A=0AI am wr=
iting a C++ program on Robotic Operating System (www.ROS.org) on Ubuntu 10.=
10 patched with Xenomai 2.5.6. This program processes video captured from a=
 USB camera. It has 3 major functions:=0A=0Aint main (int argc, char ** arg=
v): Initializes the whole program, create a message pipe for communication =
between the standard Linux process and a real-time (Xenomai) task.=0A=0Avoi=
d imageCb (const sensor_msgs::ImageConstPtr& msg): A callback function runn=
ing in the *standard Linux Process*. It is called whenever an image frame i=
s available, and it sends a message to the real-time task mentioned above.=
=0A=0Avoid rtImageProcessing (void * arg): This is the real-time (Xenomai) =
task that is supposed to process images.=0A=0AThe above functions are as fo=
llows: (For simplicity, I omitted some unimportant codes)=0A=0A1) int main =
(int argc, char ** argv){=0A=A02)=A0=0A=A03) =A0 =A0 rt_print_auto_init(1);=
=0A=A04) =A0 =A0 mlockall(MCL_CURRENT|MCL_FUTURE);=0A=A05) =A0 =A0 //Create=
 a message pipe for the real-time task=0A=A06) =A0 =A0 rt_pipe_create(&pipe=
_desc, NULL, PIPE_MINOR, 0);=0A=A07) =A0 =A0 //Initialize the real-time tas=
k=0A=A08) =A0 =A0 rt_task_create(&task_desc, "RealTimeImageProcessing", 409=
6, 99, T_FPU|T_CPU(0));=0A=A09) =A0 =A0 rt_task_start(&task_desc, &rtImageP=
rocessing, NULL);=0A10)=A0=0A11) =A0 =A0 //Create a message pipe for the st=
andard Linux process=0A12) =A0 =A0 char devname[32];=A0=0A13) =A0 =A0 sprin=
tf(devname, "/dev/rtp%d", PIPE_MINOR);=A0=0A14) =A0 =A0 pipe_fd =3D open(de=
vname, O_RDWR);=0A15)=A0=0A16)=A0=0A17) =A0 =A0 //Setup the callback functi=
on=0A18) =A0 =A0 //....=0A19)=A0=0A20) =A0 =A0 pause(); //Waiting=0A21)=A0=
=0A22) =A0 =A0 //Clean up the tasks & pipes=0A23) }=0A24)=A0=0A25)=A0=0A26)=
 void imageCb(const sensor_msgs::ImageConstPtr& msg){=0A27)=A0=0A28) =A0 =
=A0 int len =3D sizeof(sensor_msgs::ImageConstPtr *);=0A29) =A0 =A0 int ptr=
_as_int =3D (int)&msg;=0A30) =A0 =A0 //Write the address of msg to the pipe=
, so rtImageProcessing() gets msg's address, and interprets this address as=
 a pointer to msg.=0A31) =A0 =A0 write(pipe_fd, (const void*)&ptr_as_int, l=
en);=A0=0A32) }=0A33) //sensor_msgs::ImageConstPtr is a class defined in RO=
S libraries, and it looks like this:=0A34) //typedef boost::shared_ptr< ::s=
ensor_msgs::Image const> ImageConstPtr;=0A35) //where ::sensor_msgs::Image =
is a class for an image in ROS. Not sure if it matters how ::sensor_msgs::I=
mage is defined, so the definition is omitted for simplicity=0A36)=A0=0A37)=
 void rtImageProcessing (void * arg){=0A38) =A0 =A0 char read_buf[8];=0A39)=
 =A0 =A0 int ptr_as_int;=0A40) =A0 =A0 int len =3D sizeof(sensor_msgs::Imag=
eConstPtr *);=0A41) =A0 =A0 sensor_msgs::ImageConstPtr * p_msg;=0A42)=A0=0A=
43) =A0 =A0 while (1) {=0A44) =A0 =A0 =A0 =A0 rt_pipe_read(&pipe_desc, (voi=
d *)read_buf, len, TM_INFINITE);=0A45) =A0 =A0 =A0 =A0 ptr_as_int =3D *((in=
t*)read_buf);=0A46) =A0 =A0 =A0 =A0 p_msg =3D (sensor_msgs::ImageConstPtr *=
)ptr_as_int;=0A47) =A0 =A0 =A0 =A0=A0=0A48) =A0 =A0 =A0 =A0 cv_bridge::CvIm=
agePtr cv_ptr;=0A49) =A0 =A0 =A0 =A0 cv_ptr =3D cv_bridge::toCvCopy(*p_msg,=
 enc::BGR8);=0A50) =A0 =A0 =A0 =A0 //... More image processing codes go her=
e =A0=A0=0A51) =A0 }=0A52) }=0A=0A=0AIn=A0rtImageProcessing() I can use (*p=
_msg) as a pointer to msg to access some basic info of msg, e.g., (*p_msg)-=
>height. But the program has a segment fault when executing Line 49). I hav=
e made sure that the codes after Line 49) can, if running in the standard L=
inux process w/ msg as an argument (that is, do not use a real-time task fo=
r image processing), run correctly, so it is not the poor design of image p=
rocessing codes that cause this problem. I suspect that the problem comes f=
rom the accessing of a smart pointer across different processes, but I am n=
ot sure, and I am still struggling with this problem...=0A=0A=0AAny ideas o=
r suggestions will be highly appreciated.=0ATomZ=0A=0A=0A=0AOn Mon, Oct 24,=
 2011 at 11:25 AM, Thomas Lockhart <Thomas.Lockhart@domain.hid> wrote:=0A=
=0A=A0 =A0 On 10/23/2011 01:25 PM, haitaozhumail-disc@domain.hid wrote:=0A=
=0A=A0 =A0 =A0 =A0 Hi All,=0A=0A=A0 =A0 =A0 =A0 Do a standard Linux process=
 and a real-time task (spawned by the=0A=A0 =A0 =A0 =A0 standard Linux proc=
ess with rt_task_create and rt_task_start ) share the=0A=A0 =A0 =A0 =A0 sam=
e address space? More specifically, I have a C++ program like this:=A0=0A=
=0A=A0 =A0 ...=0A=0A=A0 =A0 =A0 =A0 Can the function demo() correctly acces=
s the object created in main()?=0A=A0 =A0 =A0 =A0 What if pA is a smart poi=
nter defined in Boost library?=A0=0A=0A=A0 =A0 Yes, yes, and yes (though I =
didn't look at the actual code, the address space is shared).=0A=0A=A0 =A0 =
For things like smart pointers, just make sure that someone is keeping a re=
ference to the object so the reference count does not go to zero.=0A=0A=A0 =
=A0 hth=0A=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- Tom=A0
--1498488837-480329272-1319490255=:1417
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div style=3D"font-fa=
mily: 'times new roman', 'new york', times, serif; font-size: 12pt; "><meta=
 http-equiv=3D"x-dns-prefetch-control" content=3D"off"></div><div id=3D"yiv=
617584859"><div><div style=3D"background-color: rgb(255, 255, 255); font-fa=
mily: 'times new roman', 'new york', times, serif; "><div id=3D"yiv61758485=
9yui_3_2_0_15_131947690534840" style=3D"color: rgb(0, 0, 0); font-size: 12p=
t; font-family: times, serif; ">Thanks for Thomas' answer.</div><div id=3D"=
yiv617584859yui_3_2_0_15_131947690534840" style=3D"color: rgb(0, 0, 0); fon=
t-size: 12pt; font-family: times, serif; "><br></div><div id=3D"yiv61758485=
9yui_3_2_0_15_131947690534840" style=3D"color: rgb(0, 0, 0); font-size: 12p=
t; font-family: times, serif; ">The previous code I showed was truncated fo=
r simplicity. The actual code is a little more complicated.&nbsp;</div><div
 id=3D"yiv617584859yui_3_2_0_15_131947690534840" style=3D"color: rgb(0, 0, =
0); font-size: 12pt; font-family: times, serif; "><br></div><div id=3D"yiv6=
17584859yui_3_2_0_15_131947690534840" style=3D"color: rgb(0, 0, 0); font-fa=
mily: times, serif; "><span class=3D"Apple-style-span" style=3D"font-family=
: times, serif; font-size: 12pt; ">I am writing a C++ program on Robotic Op=
erating System=0A (www.ROS.org) on Ubuntu 10.10 patched with Xenomai 2.5.6.=
 </span><font class=3D"Apple-style-span" face=3D"sans-serif"><span class=3D=
"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">This progr=
am processes video captured from a USB camera. It has 3 major functions:</s=
pan></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=
=3D"yui_3_2_0_14_131947716813670" style=3D"color: rgb(0, 0, 0); "><font cla=
ss=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-span=
" style=3D"font-size: 14px; line-height: 19px;"><br></span></font></div><di=
v id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131=
947716813670" style=3D"color: rgb(0, 0, 0); "><span class=3D"Apple-style-sp=
an" style=3D"font-family: sans-serif; font-size: 14px; line-height: 19px; "=
>int main (int argc, char ** argv): Initializes the whole program, create a=
 message pipe for communication between the standard Linux process and a re=
al-time (Xenomai) task.</span><font
 class=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-=
span" style=3D"font-size: 14px; line-height: 19px;"><br></span></font></div=
><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14=
_131947716813670" style=3D"color: rgb(0, 0, 0); "><span class=3D"Apple-styl=
e-span" style=3D"font-family: sans-serif; font-size: 14px; line-height: 19p=
x; ">void imageCb (const sensor_msgs::ImageConstPtr&amp; msg): A callback f=
unction running in the *standard Linux Process*. It is called whenever an i=
mage frame is available, and it sends a message to the real-time task menti=
oned above.</span><br></div><div id=3D"yiv617584859yui_3_2_0_15_13194769053=
4840" class=3D"yui_3_2_0_14_131947716813670" style=3D"color: rgb(0, 0, 0); =
"><span class=3D"Apple-style-span" style=3D"font-family: sans-serif; font-s=
ize: 14px; line-height: 19px; ">void rtImageProcessing (void * arg): This i=
s the real-time (Xenomai) task that is supposed to process images.</span></=
div><div
 id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_1319=
47716813670" style=3D"color: rgb(0, 0, 0); "><font class=3D"Apple-style-spa=
n" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size:=
 14px; line-height: 19px; "><br></span></font></div><div id=3D"yiv617584859=
yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670" style=
=3D"color: rgb(0, 0, 0); "><font class=3D"Apple-style-span" face=3D"sans-se=
rif"><span class=3D"Apple-style-span" style=3D"font-size: 14px; line-height=
: 19px;">The above functions are as follows: (For simplicity, I omitted som=
e unimportant codes)</span></font></div><div id=3D"yiv617584859yui_3_2_0_15=
_131947690534840" class=3D"yui_3_2_0_14_131947716813670" style=3D"color: rg=
b(0, 0, 0); "><font class=3D"Apple-style-span" face=3D"sans-serif"><span cl=
ass=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;"><br>=
</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840"
 class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" fa=
ce=3D"sans-serif"><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" clas=
s=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" face=3D=
"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14px; lin=
e-height: 19px;">1) int main (int argc, char ** argv){</span></font></div><=
div id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_1=
31947716813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span =
class=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">&n=
bsp;2)&nbsp;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_1319476=
90534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style=
-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-s=
ize: 14px; line-height: 19px;">&nbsp;3) &nbsp; &nbsp; rt_print_auto_init(1)=
;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840"
 class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" fa=
ce=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14px=
; line-height: 19px;">&nbsp;4) &nbsp; &nbsp; mlockall(MCL_CURRENT|MCL_FUTUR=
E);</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840"=
 class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" fa=
ce=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14px=
; line-height: 19px;">&nbsp;5) &nbsp; &nbsp; //Create a message pipe for th=
e real-time task</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131=
947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-s=
tyle-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"fo=
nt-size: 14px; line-height: 19px;">&nbsp;6) &nbsp; &nbsp; rt_pipe_create(&a=
mp;pipe_desc, NULL, PIPE_MINOR, 0);</span></font></div><div id=3D"yiv617584=
859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><fo=
nt class=3D"Apple-style-span"
 face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 1=
4px; line-height: 19px;">&nbsp;7) &nbsp; &nbsp; //Initialize the real-time =
task</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840=
" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" f=
ace=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14p=
x; line-height: 19px;">&nbsp;8) &nbsp; &nbsp; rt_task_create(&amp;task_desc=
, "RealTimeImageProcessing", 4096, 99, T_FPU|T_CPU(0));</span></font></div>=
<div class=3D"yui_3_2_0_14_131947716813670" id=3D"yiv617584859yui_3_2_0_15_=
131947690534840"><font class=3D"Apple-style-span" face=3D"sans-serif"><span=
 class=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">&=
nbsp;9) &nbsp; &nbsp; rt_task_start(&amp;task_desc, &amp;rtImageProcessing,=
 NULL);</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534=
840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span=
" face=3D"sans-serif"><span
 class=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">1=
0)&nbsp;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13194769053=
4840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-spa=
n" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size:=
 14px; line-height: 19px;">11) &nbsp; &nbsp; //Create a message pipe for th=
e standard Linux process</span></font></div><div id=3D"yiv617584859yui_3_2_=
0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D=
"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-span" sty=
le=3D"font-size: 14px; line-height: 19px;">12) &nbsp; &nbsp; char devname[3=
2];&nbsp;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_1319476905=
34840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-sp=
an" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size=
: 14px; line-height: 19px;">13) &nbsp; &nbsp; sprintf(devname, "/dev/rtp%d"=
,
 PIPE_MINOR);&nbsp;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_=
131947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Appl=
e-style-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D=
"font-size: 14px; line-height: 19px;">14) &nbsp; &nbsp; pipe_fd =3D open(de=
vname, O_RDWR);</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_1319=
47690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-st=
yle-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"fon=
t-size: 14px; line-height: 19px;">15)&nbsp;</span></font></div><div id=3D"y=
iv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813=
670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Ap=
ple-style-span" style=3D"font-size: 14px; line-height: 19px;">16)&nbsp;</sp=
an></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=
=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" face=3D"=
sans-serif"><span
 class=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">1=
7) &nbsp; &nbsp; //Setup the callback function</span></font></div><div id=
=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_1319477=
16813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span class=
=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">18) &nb=
sp; &nbsp; //....</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13=
1947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-=
style-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"f=
ont-size: 14px; line-height: 19px;">19)&nbsp;</span></font></div><div id=3D=
"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_1319477168=
13670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"=
Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">20) &nbsp; =
&nbsp; pause(); //Waiting</span></font></div><div id=3D"yiv617584859yui_3_2=
_0_15_131947690534840"
 class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" fa=
ce=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14px=
; line-height: 19px;">21)&nbsp;</span></font></div><div id=3D"yiv617584859y=
ui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><font c=
lass=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-sp=
an" style=3D"font-size: 14px; line-height: 19px;">22) &nbsp; &nbsp; //Clean=
 up the tasks &amp; pipes</span></font></div><div id=3D"yiv617584859yui_3_2=
_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=
=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-span" =
style=3D"font-size: 14px; line-height: 19px;">23) }</span></font></div><div=
 id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_1319=
47716813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span cla=
ss=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">24)&n=
bsp;</span></font></div><div
 id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_1319=
47716813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span cla=
ss=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">25)&n=
bsp;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840=
" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" f=
ace=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14p=
x; line-height: 19px;">26) void imageCb(const sensor_msgs::ImageConstPtr&am=
p; msg){</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13194769053=
4840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-spa=
n" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size:=
 14px; line-height: 19px;">27)&nbsp;</span></font></div><div id=3D"yiv61758=
4859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><f=
ont class=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-sty=
le-span" style=3D"font-size: 14px;
 line-height: 19px;">28) &nbsp; &nbsp; int len =3D sizeof(sensor_msgs::Imag=
eConstPtr *);</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947=
690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-styl=
e-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-=
size: 14px; line-height: 19px;">29) &nbsp; &nbsp; int ptr_as_int =3D (int)&=
amp;msg;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13194769053=
4840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-spa=
n" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size:=
 14px; line-height: 19px;">30) &nbsp; &nbsp; //Write the address of msg to =
the pipe, so rtImageProcessing() gets msg's address, and interprets this ad=
dress as a pointer to msg.</span></font></div><div id=3D"yiv617584859yui_3_=
2_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=
=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-span" =
style=3D"font-size: 14px;
 line-height: 19px;">31) &nbsp; &nbsp; write(pipe_fd, (const void*)&amp;ptr=
_as_int, len);&nbsp;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15=
_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"App=
le-style-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=
=3D"font-size: 14px; line-height: 19px;">32) }</span></font></div><div id=
=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_1319477=
16813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span class=
=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">33) //s=
ensor_msgs::ImageConstPtr is a class defined in ROS libraries, and it looks=
 like this:</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13194769=
0534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-=
span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-si=
ze: 14px; line-height: 19px;">34) //typedef boost::shared_ptr&lt; ::sensor_=
msgs::Image const&gt;
 ImageConstPtr;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_1319=
47690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-st=
yle-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"fon=
t-size: 14px; line-height: 19px;">35) //where ::sensor_msgs::Image is a cla=
ss for an image in ROS. Not sure if it matters how ::sensor_msgs::Image is =
defined, so the definition is omitted for simplicity</span></font></div><di=
v id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131=
947716813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span cl=
ass=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">36)&=
nbsp;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13194769053484=
0" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" =
face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14=
px; line-height: 19px;">37) void rtImageProcessing (void * arg){</span></fo=
nt></div><div
 id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_1319=
47716813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span cla=
ss=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">38) &=
nbsp; &nbsp; char read_buf[8];</span></font></div><div id=3D"yiv617584859yu=
i_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><font cl=
ass=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-spa=
n" style=3D"font-size: 14px; line-height: 19px;">39) &nbsp; &nbsp; int ptr_=
as_int;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534=
840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span=
" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: =
14px; line-height: 19px;">40) &nbsp; &nbsp; int len =3D sizeof(sensor_msgs:=
:ImageConstPtr *);</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_1=
31947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple=
-style-span" face=3D"sans-serif"><span
 class=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">4=
1) &nbsp; &nbsp; sensor_msgs::ImageConstPtr * p_msg;</span></font></div><di=
v id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131=
947716813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span cl=
ass=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">42)&=
nbsp;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13194769053484=
0" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" =
face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14=
px; line-height: 19px;">43) &nbsp; &nbsp; while (1) {</span></font></div><d=
iv id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_13=
1947716813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span c=
lass=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">44)=
 &nbsp; &nbsp; &nbsp; &nbsp; rt_pipe_read(&amp;pipe_desc, (void *)read_buf,=
 len,
 TM_INFINITE);</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13194=
7690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-sty=
le-span" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font=
-size: 14px; line-height: 19px;">45) &nbsp; &nbsp; &nbsp; &nbsp; ptr_as_int=
 =3D *((int*)read_buf);</span></font></div><div id=3D"yiv617584859yui_3_2_0=
_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"=
Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-span" styl=
e=3D"font-size: 14px; line-height: 19px;">46) &nbsp; &nbsp; &nbsp; &nbsp; p=
_msg =3D (sensor_msgs::ImageConstPtr *)ptr_as_int;</span></font></div><div =
id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_13194=
7716813670"><font class=3D"Apple-style-span" face=3D"sans-serif"><span clas=
s=3D"Apple-style-span" style=3D"font-size: 14px; line-height: 19px;">47) &n=
bsp; &nbsp; &nbsp; &nbsp;&nbsp;</span></font></div><div id=3D"yiv617584859y=
ui_3_2_0_15_131947690534840"
 class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-span" fa=
ce=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size: 14px=
; line-height: 19px;">48) &nbsp; &nbsp; &nbsp; &nbsp; cv_bridge::CvImagePtr=
 cv_ptr;</span></font></div><div id=3D"yiv617584859yui_3_2_0_15_13194769053=
4840" class=3D"yui_3_2_0_14_131947716813670"><font class=3D"Apple-style-spa=
n" face=3D"sans-serif"><span class=3D"Apple-style-span" style=3D"font-size:=
 14px; line-height: 19px;">49) &nbsp; &nbsp; &nbsp; &nbsp; cv_ptr =3D cv_br=
idge::toCvCopy(*p_msg, enc::BGR8);</span></font></div><div id=3D"yiv6175848=
59yui_3_2_0_15_131947690534840" class=3D"yui_3_2_0_14_131947716813670"><fon=
t class=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style=
-span" style=3D"font-size: 14px; line-height: 19px;">50) &nbsp; &nbsp; &nbs=
p; &nbsp; //... More image processing codes go here &nbsp;&nbsp;</span></fo=
nt></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_=
3_2_0_14_131947716813670"><font
 class=3D"Apple-style-span" face=3D"sans-serif"><span class=3D"Apple-style-=
span" style=3D"font-size: 14px; line-height: 19px;">51) &nbsp; }</span></fo=
nt></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" class=3D"yui_=
3_2_0_14_131947716813670"><font class=3D"Apple-style-span" face=3D"sans-ser=
if"><span class=3D"Apple-style-span" style=3D"font-size: 14px; line-height:=
 19px;">52) }</span></font></div><div style=3D"color: rgb(0, 0, 0); font-si=
ze: 14px; line-height: 19px; "><br></div></font></div><div id=3D"yiv6175848=
59yui_3_2_0_15_131947690534840" style=3D"color: rgb(0, 0, 0); font-size: 12=
pt; font-family: times, serif; "><br></div><div id=3D"yiv617584859yui_3_2_0=
_15_131947690534840" style=3D"color: rgb(0, 0, 0); font-family: times, seri=
f; font-size: 12pt; " class=3D"yui_3_2_0_14_131947716813676">In&nbsp;<span =
class=3D"Apple-style-span" style=3D"font-family: sans-serif; font-size: 14p=
x; line-height: 19px; ">rtImageProcessing() I can use (*p_msg) as a pointer=
 to msg to access some basic
 info of msg, e.g., (*p_msg)-&gt;height. But the program has a segment faul=
t when executing Line 49). I have made sure that the codes after Line 49) c=
an, if running in the standard Linux process w/ msg as an argument (that is=
, do not use a real-time task for image processing), run correctly, so it i=
s not the poor design of image processing codes that cause this problem. I =
suspect that the problem comes from the accessing of a smart pointer across=
 different processes, but I am not sure, and I am still struggling with thi=
s problem...</span></div><div id=3D"yiv617584859yui_3_2_0_15_13194769053484=
0" style=3D"color: rgb(0, 0, 0); font-family: times, serif; font-size: 12pt=
; " class=3D"yui_3_2_0_14_131947716813676"><span class=3D"Apple-style-span"=
 style=3D"font-family: sans-serif; font-size: 14px; line-height: 19px; "><b=
r></span></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" style=
=3D"color: rgb(0, 0, 0); font-family: times, serif; font-size: 12pt; "
 class=3D"yui_3_2_0_14_131947716813676"><span class=3D"Apple-style-span" st=
yle=3D"font-family: sans-serif; font-size: 14px; line-height: 19px; "><br><=
/span></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" style=3D"c=
olor: rgb(0, 0, 0); font-family: times, serif; font-size: 12pt; " class=3D"=
yui_3_2_0_14_131947716813676"><span class=3D"Apple-style-span" style=3D"fon=
t-family: sans-serif; font-size: 14px; line-height: 19px; ">Any ideas or su=
ggestions will be highly appreciated.</span></div><div id=3D"yiv617584859yu=
i_3_2_0_15_131947690534840" style=3D"color: rgb(0, 0, 0); font-family: time=
s, serif; font-size: 12pt; " class=3D"yui_3_2_0_14_131947716813676"><span c=
lass=3D"Apple-style-span" style=3D"font-family: sans-serif; font-size: 14px=
; line-height: 19px; ">TomZ</span></div><div id=3D"yiv617584859yui_3_2_0_15=
_131947690534840" style=3D"color: rgb(0, 0, 0); font-family: times, serif; =
font-size: 12pt; " class=3D"yui_3_2_0_14_131947716813676"><span class=3D"Ap=
ple-style-span"
 style=3D"font-family: sans-serif; font-size: 14px; line-height: 19px; "><b=
r></span></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" style=
=3D"color: rgb(0, 0, 0); font-family: times, serif; font-size: 12pt; " clas=
s=3D"yui_3_2_0_14_131947716813676"><span class=3D"Apple-style-span" style=
=3D"font-family: sans-serif; font-size: 14px; line-height: 19px; "><br></sp=
an></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840" style=3D"colo=
r: rgb(0, 0, 0); font-family: times, serif; font-size: 12pt; " class=3D"yui=
_3_2_0_14_131947716813676"><br></div><div id=3D"yiv617584859yui_3_2_0_15_13=
1947690534840" style=3D"color: rgb(0, 0, 0); font-family: 'times new roman'=
, 'new york', times, serif; font-size: 12pt; "><div id=3D"yiv617584859yui_3=
_2_0_15_131947690534840"><font class=3D"yiv617584859Apple-style-span" face=
=3D"'times new roman', 'new york', times, serif">On Mon, Oct 24, 2011 at 11=
:25 AM, Thomas Lockhart &lt;Thomas.Lockhart@domain.hid&gt; wrote:</font><=
/div><div
 id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font class=3D"yiv61758485=
9Apple-style-span" face=3D"'times new roman', 'new york', times, serif"><br=
></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font cl=
ass=3D"yiv617584859Apple-style-span" face=3D"'times new roman',=0A 'new yor=
k', times, serif">&nbsp; &nbsp; On 10/23/2011 01:25 PM, haitaozhumail-disc@=
yahoo.com wrote:</font></div><div id=3D"yiv617584859yui_3_2_0_15_1319476905=
34840"><font class=3D"yiv617584859Apple-style-span" face=3D"'times new roma=
n', 'new york', times, serif"><br></font></div><div id=3D"yiv617584859yui_3=
_2_0_15_131947690534840"><font class=3D"yiv617584859Apple-style-span" face=
=3D"'times new roman', 'new york', times, serif">&nbsp; &nbsp; &nbsp; &nbsp=
; Hi All,</font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840">=
<font class=3D"yiv617584859Apple-style-span" face=3D"'times new roman', 'ne=
w york', times, serif"><br></font></div><div id=3D"yiv617584859yui_3_2_0_15=
_131947690534840"><font class=3D"yiv617584859Apple-style-span" face=3D"'tim=
es new roman', 'new york', times, serif">&nbsp; &nbsp; &nbsp; &nbsp; Do a s=
tandard Linux process and a real-time task (spawned by the</font></div><div=
 id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font
 class=3D"yiv617584859Apple-style-span" face=3D"'times new roman', 'new yor=
k', times, serif">&nbsp; &nbsp; &nbsp; &nbsp; standard Linux process with=
=0A rt_task_create and rt_task_start ) share the</font></div><div id=3D"yiv=
617584859yui_3_2_0_15_131947690534840"><font class=3D"yiv617584859Apple-sty=
le-span" face=3D"'times new roman', 'new york', times, serif">&nbsp; &nbsp;=
 &nbsp; &nbsp; same address space? More specifically, I have a C++ program =
like this:&nbsp;</font></div><div id=3D"yiv617584859yui_3_2_0_15_1319476905=
34840"><font class=3D"yiv617584859Apple-style-span" face=3D"'times new roma=
n', 'new york', times, serif"><br></font></div><div id=3D"yiv617584859yui_3=
_2_0_15_131947690534840"><font class=3D"yiv617584859Apple-style-span" face=
=3D"'times new roman', 'new york', times, serif">&nbsp; &nbsp; ...</font></=
div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font class=3D"yiv=
617584859Apple-style-span" face=3D"'times new roman', 'new york', times, se=
rif"><br></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840">=
<font class=3D"yiv617584859Apple-style-span" face=3D"'times new roman', 'ne=
w york', times,
 serif">&nbsp; &nbsp; &nbsp; &nbsp; Can the function demo() correctly acces=
s the object created in main()?</font></div><div id=3D"yiv617584859yui_3_2_=
0_15_131947690534840"><font class=3D"yiv617584859Apple-style-span" face=3D"=
'times new roman', 'new york', times, serif">&nbsp; &nbsp; &nbsp; &nbsp; Wh=
at if pA is a smart pointer defined in Boost library?&nbsp;</font></div><di=
v id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font class=3D"yiv6175848=
59Apple-style-span" face=3D"'times new roman', 'new york', times, serif"><b=
r></font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font c=
lass=3D"yiv617584859Apple-style-span" face=3D"'times new roman', 'new york'=
, times, serif">&nbsp; &nbsp; Yes, yes, and yes (though I didn't look at th=
e actual code, the address space is shared).</font></div><div id=3D"yiv6175=
84859yui_3_2_0_15_131947690534840"><font class=3D"yiv617584859Apple-style-s=
pan" face=3D"'times new roman', 'new york', times, serif"><br></font></div>=
<div
 id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font class=3D"yiv61758485=
9Apple-style-span" face=3D"'times new roman', 'new york', times, serif">&nb=
sp; &nbsp; For things like smart pointers, just make sure that someone is k=
eeping a reference to the object so=0A the reference count does not go to z=
ero.</font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font=
 class=3D"yiv617584859Apple-style-span" face=3D"'times new roman', 'new yor=
k', times, serif"><br></font></div><div id=3D"yiv617584859yui_3_2_0_15_1319=
47690534840"><font class=3D"yiv617584859Apple-style-span" face=3D"'times ne=
w roman', 'new york', times, serif">&nbsp; &nbsp; hth</font></div><div id=
=3D"yiv617584859yui_3_2_0_15_131947690534840"><font class=3D"yiv617584859Ap=
ple-style-span" face=3D"'times new roman', 'new york', times, serif"><br></=
font></div><div id=3D"yiv617584859yui_3_2_0_15_131947690534840"><font class=
=3D"yiv617584859Apple-style-span" face=3D"'times new roman', 'new york', ti=
mes, serif" id=3D"yiv617584859yui_3_2_0_15_131947690534863">&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;- Tom&nbsp;</f=
ont></div></div></div></div></div><div style=3D"font-family: 'times new rom=
an', 'new york', times, serif; font-size: 12pt; "><meta
 http-equiv=3D"x-dns-prefetch-control" content=3D"on"></div></div></body></=
html>
--1498488837-480329272-1319490255=:1417--

