From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Tue, 10 May 2011 14:38:26 +0200
Message-ID: <509DA52866E38F47878413CF102D751F709E6632A7@domain.hid>
References: <509DA52866E38F47878413CF102D751F709E6632A2@domain.hid>
In-Reply-To: <509DA52866E38F47878413CF102D751F709E6632A2@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_509DA52866E38F47878413CF102D751F709E6632A7poseidonnexus_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Is Xenomai Fully Functional for me(newbie) on
 Linux 2.6.37.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>
Cc: Antonio Gambin <antonio.gambin@domain.hid>

--_000_509DA52866E38F47878413CF102D751F709E6632A7poseidonnexus_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Gilles,
After browing through  Xenomai Help Server(Gna), I found my problem is very=
 close to the one of the users by name BONOS Antonis, who requested for  he=
lp  on an issue"Installation problem" yesterday!!!
As I followed the pdf http://embedded.communities.intel.com/servlet/JiveSer=
vlet/download/4435-1248/xeno_intel.pdf, BONOS Antonis also followed it.

Looking forward for your help!!!

Best Regards,
Samba.


________________________________
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On=
 Behalf Of Sambasiva Rao Manchili
Sent: Tuesday, 10. May, 2011 14:03
To: Xenomai-help@domain.hid
Cc: Antonio Gambin
Subject: [Xenomai-help] Is Xenomai Fully Functional for me(newbie) on Linux=
 2.6.37.6

Hi,
Oflate we are thinking to port our applications(libraries having tasks)  fr=
om VxWorks to Linux.  During the feasibility stduy we have come across Xeno=
mai.

We upgraded the Linux Kernel to 2.6.37 from 2.6.18 on CenOS.

For configuration of Real Time Kernel we followed the steps from
1. <http://www.xenomai.org/index.php/FAQs>
2. <Attached PDF >
3. <http://www.xenomai.org/index.php/Configuring_x86_kernels>


After building Kernel installing and Booting.  We see as follows.

root@domain.hid<mailto:root@domain.hid>:~> uname -a
Linux zrhws128 2.6.37.6_xenomai-2.5.6-ipipe #12 PREEMPT Tue May 10 13:03:37=
 CEST 2011 x86_64 x86_64 x86_64 GNU/Linux
I tried both SMP and UP mode of building Kernel.

root@domain.hid<mailto:root@domain.hid>:~> dmesg | grep Xenomai
[    1.293710] I-pipe: Domain Xenomai registered.
[    1.293714] Xenomai: hal/x86_64 started.
[    1.293727] Xenomai: scheduling class idle registered.
[    1.293728] Xenomai: scheduling class rt registered.
[    1.295065] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[    1.295146] Xenomai: starting native API services.
[    1.295148] Xenomai: starting POSIX services.
[    1.295170] Xenomai: starting RTDM services.
[    1.295176] Xenomai: starting VxWorks services.


BUT, when I run
root@domain.hid<mailto:root@domain.hid>:~> /usr/xenomai/bin/latency -t0 -p200 -=
f -T50
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)
Can you please help me. What is wrong ?

We also just ported one of our library(was running on VxWorks like Client a=
nd Server program) to  Linux2.6.37-xenoami2.5.6.

In this programe we used semMCreate, taskSpawn etc. VxWorks calls. So after=
 changing the compilation environment by include right headers from Xenomai=
, all the compilation problems solved without changing much of our code exc=
ept right includes and some changes in build environment.
+ We crated main function() where we call global function Server()  (earlie=
r on VxWorks, we call Server()  from VxWorks Shell by spawning task)

root@domain.hid<mailto:root@domain.hid>> =
./catsrv
Xenomai: vxworks skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_vxworks?)
If you need any more information, I would be glad to provide.  Looking forw=
ard for valuable guidance at your very earliest convenience.


Thanks in advance,
Samba.

Nexus Telecom is exhibiting at TMForum Management World 2011
May 23-26, Dublin, Ireland

Please visit us at Booth No. 39

http://www.tmforum.org/ManagementWorld2011/9414/home.html


________________________________
This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.

--_000_509DA52866E38F47878413CF102D751F709E6632A7poseidonnexus_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"GENERATOR" content=3D"MSHTML 8.00.6001.19046">
</head>
<body>
<div dir=3D"ltr" align=3D"left"><font color=3D"#0000ff" size=3D"2" face=3D"=
Arial"><span class=3D"035102912-10052011">Hi Gilles,</span></font></div>
<div dir=3D"ltr" align=3D"left"><font color=3D"#0000ff" size=3D"2" face=3D"=
Arial"><span class=3D"035102912-10052011">After browing through&nbsp; Xenom=
ai Help Server(Gna), I found my problem is very close to the one of the use=
rs by name BONOS Antonis, who requested for &nbsp;help&nbsp;
 on an issue&quot;Installation problem&quot; yesterday!!!</span></font></di=
v>
<div dir=3D"ltr" align=3D"left"><font size=3D"2" face=3D"Arial"><span class=
=3D"035102912-10052011"><font color=3D"#0000ff">As I followed the pdf
</font><a href=3D"http://embedded.communities.intel.com/servlet/JiveServlet=
/download/4435-1248/xeno_intel.pdf">http://embedded.communities.intel.com/s=
ervlet/JiveServlet/download/4435-1248/xeno_intel.pdf</a><font color=3D"#000=
0ff">, BONOS Antonis also followed it.</font></span></font></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"035102912-10052011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"035102912-10052011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial">Looking forward for your help!!!<=
/font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"035102912-10052011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"035102912-10052011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial">Best Regards,</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"035102912-10052011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial">Samba.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span class=3D"035102912-10052011"><font co=
lor=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>&nbsp;</div>
<div dir=3D"ltr" align=3D"left"><span class=3D"035102912-10052011">&nbsp;</=
span></div>
<div dir=3D"ltr" align=3D"left">
<hr tabindex=3D"-1">
</div>
<div dir=3D"ltr" align=3D"left"><font size=3D"2" face=3D"Tahoma"><b>From:</=
b> xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
<b>On Behalf Of </b>Sambasiva Rao Manchili<br>
<b>Sent:</b> Tuesday, 10. May, 2011 14:03<br>
<b>To:</b> Xenomai-help@domain.hid<br>
<b>Cc:</b> Antonio Gambin<br>
<b>Subject:</b> [Xenomai-help] Is Xenomai Fully Functional for me(newbie) o=
n Linux 2.6.37.6<br>
</font><br>
</div>
<div></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">Hi,=
</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">Ofl=
ate we are thinking to port our applications(libraries having tasks)&nbsp;&=
nbsp;from VxWorks to Linux.&nbsp; During the feasibility stduy we have come=
 across Xenomai.</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011"></s=
pan></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">We =
upgraded the Linux Kernel to 2.6.37 from 2.6.18 on CenOS.&nbsp;
</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011"></s=
pan></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">For=
 configuration of Real Time Kernel we followed the steps from&nbsp;
</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">1. =
&lt;<a href=3D"http://www.xenomai.org/index.php/FAQs"><font size=3D"3" face=
=3D"Times New Roman">http://www.xenomai.org/index.php/FAQs</font></a>&gt;</=
span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">2. =
&lt;Attached PDF &gt;</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">3. =
&lt;<a href=3D"http://www.xenomai.org/index.php/Configuring_x86_kernels"><f=
ont size=3D"3" face=3D"Times New Roman">http://www.xenomai.org/index.php/Co=
nfiguring_x86_kernels</font></a>&gt;</span></font></div>
<div><font size=3D"2" face=3D"Arial"></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">Aft=
er building Kernel installing and Booting.&nbsp; We see as follows.</span><=
/font></div>
<div><font size=3D"2" face=3D"Arial"></font>&nbsp;</div>
<div><a href=3D"mailto:root@domain.hid"><font size=3D"2" face=3D"Arial">root@=
zrhws128</font></a><font size=3D"2" face=3D"Arial">:~&gt; uname -a<br>
Linux zrhws128 2.6.37.6_xenomai-2.5.6-ipipe #12 PREEMPT Tue May 10 13:03:37=
 CEST 2011 x86_64 x86_64 x86_64 GNU/Linux</font><br>
<span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"></font><=
/span></div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial">I t=
ried both SMP and UP mode of building Kernel.</font></span></div>
<div><font size=3D"2" face=3D"Arial"></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"><a href=3D"mailto:root@domain.hid">root@=
zrhws128</a>:~&gt; dmesg | grep Xenomai<br>
[&nbsp;&nbsp;&nbsp; 1.293710] I-pipe: Domain Xenomai registered.<br>
[&nbsp;&nbsp;&nbsp; 1.293714] Xenomai: hal/x86_64 started.<br>
[&nbsp;&nbsp;&nbsp; 1.293727] Xenomai: scheduling class idle registered.<br=
>
[&nbsp;&nbsp;&nbsp; 1.293728] Xenomai: scheduling class rt registered.<br>
[&nbsp;&nbsp;&nbsp; 1.295065] Xenomai: real-time nucleus v2.5.6 (Wormhole W=
izards) loaded.<br>
[&nbsp;&nbsp;&nbsp; 1.295146] Xenomai: starting native API services.<br>
[&nbsp;&nbsp;&nbsp; 1.295148] Xenomai: starting POSIX services.<br>
[&nbsp;&nbsp;&nbsp; 1.295170] Xenomai: starting RTDM services.<br>
[&nbsp;&nbsp;&nbsp; 1.295176] Xenomai: starting VxWorks services.<br>
</font></div>
<div><font size=3D"2" face=3D"Arial"></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"></font>&nbsp;</div>
<div><span class=3D"069591011-10052011"><font color=3D"#ff0000" size=3D"2" =
face=3D"Arial">BUT,
</font></span><span class=3D"069591011-10052011"><font color=3D"#ff0000" si=
ze=3D"2" face=3D"Arial">when I run
</font></span></div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"><a =
href=3D"mailto:root@domain.hid"><font color=3D"#ff0000">root@domain.hid</font><=
/a><font color=3D"#ff0000">:~&gt; /usr/xenomai/bin/latency -t0 -p200 -f -T5=
0<br>
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
(modprobe xeno_native?)<br>
</font></font></span><span class=3D"069591011-10052011"><font size=3D"2" fa=
ce=3D"Arial"></font></span></div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial">Can=
 you please help me. What is wrong ?</font></span></div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"></f=
ont></span>&nbsp;</div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial">We =
also just ported one of our library(was running on VxWorks like Client and =
Server program) to&nbsp; Linux2.6.37-xenoami2.5.6.
</font></span></div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"></f=
ont></span>&nbsp;</div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial">In =
this programe we used semMCreate, taskSpawn etc. VxWorks calls. So after ch=
anging the compilation environment by include right headers from Xenomai, a=
ll the compilation problems solved without
 changing much of our code except right includes and some changes in build =
environment.</font></span></div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial">&#4=
3; We crated main function() where we call global function Server()&nbsp; (=
earlier on VxWorks, we call Server()&nbsp; from VxWorks Shell by spawning t=
ask)</font></span></div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"></f=
ont></span>&nbsp;</div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"><a =
href=3D"mailto:root@domain.hid"><font color=3D"#ff0000">ro=
ot@domain.hid</font></a><font color=3D"#ff0000">&gt; ./cat=
srv<br>
Xenomai: vxworks skin or CONFIG_XENO_OPT_PERVASIVE disabled.<br>
(modprobe xeno_vxworks?)<br>
</font></font></span></div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"><fo=
nt color=3D"#ff0000"><font color=3D"#000000">If you need any more informati=
on, I would be glad to provide.&nbsp; Looking forward for valuable guidance=
 at your very earliest convenience.</font></div>
</font></font></span>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"></f=
ont></span>&nbsp;</div>
<div><span class=3D"069591011-10052011"><font size=3D"2" face=3D"Arial"></f=
ont></span><font size=3D"2" face=3D"Arial">&nbsp;</div>
</font>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">Tha=
nks in advance,</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"069591011-10052011">Sam=
ba.</span></font></div>
<br>
<font face=3D"Arial" color=3D"Blue" size=3D"2">Nexus Telecom is exhibiting =
at TMForum Management World 2011<br>
May 23-26, Dublin, Ireland<br>
<br>
Please visit us at Booth No. 39<br>
<br>
http://www.tmforum.org/ManagementWorld2011/9414/home.html<br>
<br>
</font><br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1">This email and any attachmen=
t may contain confidential information which is intended for use only by th=
e addressee(s) named above. If you received this email by mistake, please n=
otify the sender immediately, and delete
 the email from your system. You are prohibited from copying, disseminating=
 or otherwise using the email or any attachment.<br>
</font>
</body>
</html>

--_000_509DA52866E38F47878413CF102D751F709E6632A7poseidonnexus_--


