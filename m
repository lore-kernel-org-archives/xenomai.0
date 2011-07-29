From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Fri, 29 Jul 2011 09:56:33 +0200
Message-ID: <509DA52866E38F47878413CF102D751FD42077949E@poseidon.nexus-ag.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_509DA52866E38F47878413CF102D751FD42077949Eposeidonnexus_"
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai VxWorks Skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Antonio Gambin <antonio.gambin@domain.hid>

--_000_509DA52866E38F47878413CF102D751FD42077949Eposeidonnexus_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hallo  Xenomai Experts,
We used Xenomai to quickly port our VxWorks code to Linux. Changes that we =
need to do for successful compilation and linking were minimal because of X=
enomai.Most of our tasks spawned are running with help of Xenomai on Linux =
2.6.37.

Once we had problem of task being crashed(Thread Segfault) with one of our =
tasks spawned by a process and after two weeks of debugging and re-verifyin=
g every thing found that "stacksize parameter" in the  taskSpawn  function =
that was normally running in VxWorks was not enough in the Xenomai Linux en=
vironment.  After increasint the stack size segmentation fault of taskSpawn=
 was solved.

Now again I see SIGABORT in another task. I increase the stack size from 32=
k to 8MB but still crashes. I am thinking now here in this case increasing =
stacksize value is not right.  Do you have any hints for such problem ?

Thanks in advance.
Samba.



(gdb) where
#0  0xffffe424 in __kernel_vsyscall ()
#1  0x4b0a1df0 in raise () from /lib/libc.so.6
#2  0x4b0a3701 in abort () from /lib/libc.so.6
#3  0x4b0da3ab in __libc_message () from /lib/libc.so.6
#4  0x4b0e33fd in _int_malloc () from /lib/libc.so.6
#5  0x4b0e4cca in calloc () from /lib/libc.so.6
#6  0x4b06af0a in _dl_allocate_tls () from /lib/ld-linux.so.2
#7  0x4b1e0f5d in pthread_create@domain.hid<mailto:pthread_create@domain.hid.=
1> () from /lib/libpthread.so.0
#8  0xb79ae4d2 in __real_pthread_create () from /usr/xenomai/lib/libvxworks=
.so.1
#9  0xb79ad338 in taskInit () from /usr/xenomai/lib/libvxworks.so.1
#10 0xb79ad49e in taskSpawn () from /usr/xenomai/lib/libvxworks.so.1
#11 0xb7ff3ccb in create_forth_task (entry=3D0xb4902098, priority=3D143, sp=
ecial_stack_size=3D0) at tesarm.c:1774
#12 0xb7ff58d7 in load_interpreter (toffset=3D1, filetab_index=3D0 '\000', =
single=3D0 '\000') at tesarm.c:851
#13 0xb7ff5bdf in reply_from_file_loader (msg_ptr=3D0xb44fcf14) at tesarm.c=
:1400
#14 0xb7ff3465 in handle_ta_request () at tesataLnx.c:126
#15 test_admin_task () at tesataLnx.c:400
#16 0xb79accbe in wind_task_trampoline () from /usr/xenomai/lib/libvxworks.=
so.1
#17 0x4b1e0832 in start_thread () from /lib/libpthread.so.0
#18 0x4b14b45e in clone () from /lib/libc.so.6

Sambasiva Rao Manchili
Software Development Engineer
________________________________

NEXUS TELECOM AG
Network and Service Investigation
Feldbachstrasse 80
8634 Hombrechtikon
Switzerland

Direct/mobile: +41 78 750 6808
Main: +41 44 355 6611
Email: sambasiva.manchili@domain.hid <mailto:sambasiva.manchili@domain.hid=
telecom.com>
Website: www.nexustelecom.com<http://www.nexustelecom.com/>

  [cid:335065507@domain.hid]


________________________________
This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.

--_000_509DA52866E38F47878413CF102D751FD42077949Eposeidonnexus_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"GENERATOR" content=3D"MSHTML 8.00.6001.19088">
</head>
<body>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011">Hal=
lo&nbsp; Xenomai Experts,</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011">We =
used Xenomai to quickly port our VxWorks code to Linux. Changes that we nee=
d to do for successful compilation and linking were minimal because of Xeno=
mai.</span></font><font size=3D"2" face=3D"Arial"><span class=3D"399284707-=
29072011">Most
 of our tasks spawned are running with help of Xenomai on Linux 2.6.37. </s=
pan></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011"></s=
pan></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011">Onc=
e we had problem of task being crashed(Thread Segfault) with one of our tas=
ks spawned by a process and after two weeks of debugging and re-verifying e=
very thing found that &quot;stacksize parameter&quot;
 in the &nbsp;taskSpawn&nbsp; function that was normally running in VxWorks=
 was not enough in the Xenomai Linux environment.&nbsp; After increasint th=
e stack size segmentation fault of taskSpawn was solved.</span></font></div=
>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011"></s=
pan></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011">Now=
 again I see SIGABORT in another task. I increase the stack size from 32k t=
o 8MB but still crashes. I am thinking now here in this case increasing sta=
cksize value is not right.&nbsp; Do you have
 any hints for such problem ?</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011"></s=
pan></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011">Tha=
nks in advance.</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011">Sam=
ba.</span></font></div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011"></s=
pan></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"><span class=3D"399284707-29072011"></s=
pan></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial"></font>&nbsp;</div>
<div><font size=3D"2" face=3D"Arial">(gdb) where<br>
#0&nbsp; 0xffffe424 in __kernel_vsyscall ()<br>
#1&nbsp; 0x4b0a1df0 in raise () from /lib/libc.so.6<br>
#2&nbsp; 0x4b0a3701 in abort () from /lib/libc.so.6<br>
#3&nbsp; 0x4b0da3ab in __libc_message () from /lib/libc.so.6<br>
#4&nbsp; 0x4b0e33fd in _int_malloc () from /lib/libc.so.6<br>
#5&nbsp; 0x4b0e4cca in calloc () from /lib/libc.so.6<br>
#6&nbsp; 0x4b06af0a in _dl_allocate_tls () from /lib/ld-linux.so.2<br>
#7&nbsp; 0x4b1e0f5d in <a href=3D"mailto:pthread_create@domain.hid">pthread=
_create@domain.hid</a> () from /lib/libpthread.so.0<br>
#8&nbsp; 0xb79ae4d2 in __real_pthread_create () from /usr/xenomai/lib/libvx=
works.so.1<br>
#9&nbsp; 0xb79ad338 in taskInit () from /usr/xenomai/lib/libvxworks.so.1<br=
>
#10 0xb79ad49e in taskSpawn () from /usr/xenomai/lib/libvxworks.so.1<br>
#11 0xb7ff3ccb in create_forth_task (entry=3D0xb4902098, priority=3D143, sp=
ecial_stack_size=3D0) at tesarm.c:1774<br>
#12 0xb7ff58d7 in load_interpreter (toffset=3D1, filetab_index=3D0 '\000', =
single=3D0 '\000') at tesarm.c:851<br>
#13 0xb7ff5bdf in reply_from_file_loader (msg_ptr=3D0xb44fcf14) at tesarm.c=
:1400<br>
#14 0xb7ff3465 in handle_ta_request () at tesataLnx.c:126<br>
#15 test_admin_task () at tesataLnx.c:400<br>
#16 0xb79accbe in wind_task_trampoline () from /usr/xenomai/lib/libvxworks.=
so.1<br>
#17 0x4b1e0832 in start_thread () from /lib/libpthread.so.0<br>
#18 0x4b14b45e in clone () from /lib/libc.so.6<br>
</div>
</font>
<div>&nbsp;</div>
<div align=3D"left"><font face=3D"Verdana"><font size=3D"2"><strong>Sambasi=
va Rao Manchili<br>
</strong>Software Development Engineer <br>
________________________________<br>
&nbsp;<br>
</font><font color=3D"#007bc0" size=3D"3"><b>NEXUS TELECOM AG</b></font></f=
ont> <font color=3D"#000000" size=3D"2" face=3D"Verdana, Arial, Helvetica, =
sans-serif">
<br>
Network and Service Investigation<br>
</div>
</font><font color=3D"#000000" size=3D"2" face=3D"Verdana, Arial, Helvetica=
, sans-serif">
<div align=3D"left"><span class=3D"335065507-19072011"><font size=3D"2" fac=
e=3D"Arial">Feldbachstrasse 80</font></span></div>
<div align=3D"left"><span class=3D"335065507-19072011">8634 Hombrechtikon</=
span></div>
<div align=3D"left">Switzerland<br>
<br>
Direct/mobile: &#43;41 78 750 6808<br>
Main: &#43;41 44 355 6611<br>
Email: <a title=3D"mailto:sambasiva.manchili@domain.hid" href=3D"mail=
to:sambasiva.manchili@domain.hid">
<font title=3D"mailto:sambasiva.manchili@domain.hid" color=3D"#000000=
" size=3D"2" face=3D"Verdana, Arial, Helvetica, sans-serif">sambasiva.manch=
ili@domain.hid
</font></a><br>
Website: <a title=3D"http://www.nexustelecom.com/" href=3D"http://www.nexus=
telecom.com/">
<font title=3D"http://www.nexustelecom.com/" color=3D"#000000" size=3D"2" f=
ace=3D"Verdana, Arial, Helvetica, sans-serif">www.nexustelecom.com</font></=
a><br>
<br>
&nbsp;<span style=3D"FONT-FAMILY: Verdana; mso-bidi-font-family: Arial">
<?xml:namespace prefix=20
=3D o ns =3D "urn:schemas-microsoft-com:office:office" />
<o:p><img border=3D"0" hspace=3D"0" alt=3D"" align=3D"baseline" src=3D"cid:=
335065507@domain.hid"></o:p></span></font></div>
<div>&nbsp;</div>
<br>
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

--_000_509DA52866E38F47878413CF102D751FD42077949Eposeidonnexus_--


