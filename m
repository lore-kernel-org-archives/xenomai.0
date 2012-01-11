MIME-Version: 1.0
Date: Wed, 11 Jan 2012 23:49:25 +0100
Message-ID: <CA+fRa6cOs0iz37X8VKFPawXLDV4cDb5=u21FgS7JSP3dSmc+FQ@mail.gmail.com>
From: Daniele <danielegottfried@domain.hid>
Content-Type: multipart/alternative; boundary=f46d0444ec5f83d5e104b648718d
Subject: [Xenomai-help] troubles with library inclusion
Reply-To: daniele.gottfried@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--f46d0444ec5f83d5e104b648718d
Content-Type: text/plain; charset=ISO-8859-1

Hello,

We are trying to use xenomai with analogy library

[xenomai 2.6.0, kernel 2.6.38.8]

Compiling the program  we got the following error:


"undefined reference to
a4l_open<http://www.xenomai.org/documentation/trunk/html/api/group__descriptor1__lib.html#ga810401871fe8005ee0157c6910f94466>
"

The compiler detects correctly the function prototypes but it can't found
their complete definition.

taking care of our MakeFile we also have read this:

https://mail.gna.org/public/xenomai-help/2011-07/msg00036.html

but we noticed that our makefile already contains this instructions for our
skin, native.

How could we get rid of this?

Thanks in advance
Best regards

--f46d0444ec5f83d5e104b648718d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,taho=
ma,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left=
;background-color:rgb(255,255,255)">Hello,</span><br style=3D"color:rgb(51,=
51,51);font-family:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;=
font-size:11px;line-height:14px;text-align:left;background-color:rgb(255,25=
5,255)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(51,51,51);font-f=
amily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11p=
x;line-height:14px;text-align:left;background-color:rgb(255,255,255)">We ar=
e trying to use xenomai with analogy library=A0</span><br style=3D"color:rg=
b(51,51,51);font-family:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-s=
erif;font-size:11px;line-height:14px;text-align:left;background-color:rgb(2=
55,255,255)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(51,51,51);font-f=
amily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11p=
x;line-height:14px;text-align:left;background-color:rgb(255,255,255)">[xeno=
mai 2.6.0, kernel 2.6.38.8]</span><br style=3D"color:rgb(51,51,51);font-fam=
ily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11px;=
line-height:14px;text-align:left;background-color:rgb(255,255,255)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(51,51,51);font-f=
amily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11p=
x;line-height:14px;text-align:left;background-color:rgb(255,255,255)">Compi=
ling the program =A0we got the following error:</span><br style=3D"color:rg=
b(51,51,51);font-family:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-s=
erif;font-size:11px;line-height:14px;text-align:left;background-color:rgb(2=
55,255,255)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><br style=3D"color:rgb(51,51,51);font-fam=
ily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11px;=
line-height:14px;text-align:left;background-color:rgb(255,255,255)">
<span style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,taho=
ma,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left=
;background-color:rgb(255,255,255)">&quot;undefined reference to=A0</span><=
a class=3D"el" href=3D"http://www.xenomai.org/documentation/trunk/html/api/=
group__descriptor1__lib.html#ga810401871fe8005ee0157c6910f94466" style=3D"c=
olor:rgb(70,101,162);font-weight:bold;text-decoration:none;font-family:&#39=
;Lucida Grande&#39;,Verdana,Geneva,Arial,sans-serif;font-size:12px;backgrou=
nd-color:rgb(249,250,252)">a4l_open</a>&quot;<br style=3D"color:rgb(51,51,5=
1);font-family:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font=
-size:11px;line-height:14px;text-align:left;background-color:rgb(255,255,25=
5)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(51,51,51);font-f=
amily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11p=
x;line-height:14px;text-align:left;background-color:rgb(255,255,255)">The c=
ompiler detects correctly the function prototypes but it can&#39;t found th=
eir complete definition.</span><br style=3D"color:rgb(51,51,51);font-family=
:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11px;lin=
e-height:14px;text-align:left;background-color:rgb(255,255,255)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(51,51,51);font-f=
amily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11p=
x;line-height:14px;text-align:left;background-color:rgb(255,255,255)">takin=
g care of our MakeFile we also have read this:</span><br style=3D"color:rgb=
(51,51,51);font-family:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-se=
rif;font-size:11px;line-height:14px;text-align:left;background-color:rgb(25=
5,255,255)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><a href=3D"https://mail.gna.org/public/xe=
nomai-help/2011-07/msg00036.html" target=3D"_blank" rel=3D"nofollow nofollo=
w" style=3D"color:rgb(59,89,152);text-decoration:none;font-family:&#39;luci=
da grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11px;line-height:1=
4px;text-align:left;background-color:rgb(255,255,255)">https://mail.gna.org=
/public/xenomai-help/2011-07/msg00036.html</a><br style=3D"color:rgb(51,51,=
51);font-family:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;fon=
t-size:11px;line-height:14px;text-align:left;background-color:rgb(255,255,2=
55)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(51,51,51);font-f=
amily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11p=
x;line-height:14px;text-align:left;background-color:rgb(255,255,255)">but w=
e noticed that our makefile already contains this instructions for our skin=
, native.</span><br style=3D"color:rgb(51,51,51);font-family:&#39;lucida gr=
ande&#39;,tahoma,verdana,arial,sans-serif;font-size:11px;line-height:14px;t=
ext-align:left;background-color:rgb(255,255,255)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(51,51,51);font-f=
amily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11p=
x;line-height:14px;text-align:left;background-color:rgb(255,255,255)">How c=
ould we get rid of this?</span><br style=3D"color:rgb(51,51,51);font-family=
:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11px;lin=
e-height:14px;text-align:left;background-color:rgb(255,255,255)">
<br style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,tahoma=
,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left;b=
ackground-color:rgb(255,255,255)"><span style=3D"color:rgb(51,51,51);font-f=
amily:&#39;lucida grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11p=
x;line-height:14px;text-align:left;background-color:rgb(255,255,255)">Thank=
s in advance</span><br style=3D"color:rgb(51,51,51);font-family:&#39;lucida=
 grande&#39;,tahoma,verdana,arial,sans-serif;font-size:11px;line-height:14p=
x;text-align:left;background-color:rgb(255,255,255)">
<span style=3D"color:rgb(51,51,51);font-family:&#39;lucida grande&#39;,taho=
ma,verdana,arial,sans-serif;font-size:11px;line-height:14px;text-align:left=
;background-color:rgb(255,255,255)">Best regards</span>

--f46d0444ec5f83d5e104b648718d--

