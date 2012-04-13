Message-ID: <DUB114-W7121A0DDCD5D2E2B7CD801AF3B0@domain.hid>
Content-Type: multipart/alternative;
	boundary="_f3d9f8c0-7050-4719-abce-64fbd49ddaee_"
From: Fabio Visona <fabioviso@domain.hid>
Date: Fri, 13 Apr 2012 16:49:13 +0200
MIME-Version: 1.0
Subject: [Xenomai-help] rt_event_wait makes linux crash if executed while
 debugging with gdbserver
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

--_f3d9f8c0-7050-4719-abce-64fbd49ddaee_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C
=20
I am trying to debug a Xenomai task through gdbserver over ethernet=2C with=
:
=20
gdbserver host:12345 --attach 240
=20
where 240 is the PID of the Xenomai real-time task I want to debug.
=20
After connecting with the gdb client=2C running continuosly is fine=2C but =
if I put a breakpoint and afterwards make the software execute an rt_event_=
wait call=2C the system crashes (gdb client stuck=2C no more ethernet conne=
ction=2C no panic message on the debug console serial port).
=20
By going step by step with the debugger=2C the exact point of the problem c=
an be isolated:
=20
int rt_event_wait(RT_EVENT *event=2C
                         unsigned long mask=2C
                         unsigned long *mask_r=2C int mode=2C RTIME timeout=
)
{
     int ret=3B

    ret =3D XENOMAI_SKINCALL5(__native_muxid=2C
         __native_event_wait=2C
         event=2C &mask=2C mode=2C XN_RELATIVE=2C &timeout)=3B
    if (ret)
     return ret=3B
  =20
    *mask_r =3D mask=3B
=20
  return 0=3B
}
=20
with mode =3D EV_ANY=2C timeout is 10000 - 100000 ns about.
=20
Showing the assembly code of the XENOMAI_SKINCALL5 macro:
=20
 0x64fc4e <rt_event_wait+42>:  R3 =3D 0x0 (X)=3B  /*  R3=3D0x0(  0) */
 0x64fc50 <rt_event_wait+44>:  R7.L =3D 0x22b=3B  /* (555) R7=3D0x0x27022b(=
2556459) */
 0x64fc54 <rt_event_wait+48>:  JUMP.S 0x0x64fc60 <rt_event_wait+60>=3B
 0x64fc56 <rt_event_wait+50>:  R0 =3D P1=3B
 0x64fc58 <rt_event_wait+52>:  R1 =3D -0x55 (X)=3B  /*  R1=3D0x0xffffffab(-=
85) */
 0x64fc5c <rt_event_wait+56>:  CC =3D R0 =3D=3D R1=3B
 0x64fc5e <rt_event_wait+58>:  IF !CC JUMP 0x0x64fc9e <rt_event_wait+122>=
=3B
 0x64fc60 <rt_event_wait+60>:  [FP + -0x848] =3D R3=3B
 0x64fc64 <rt_event_wait+64>:  R1 =3D R6=3B
 0x64fc66 <rt_event_wait+66>:  R2 =3D P4=3B
 0x64fc68 <rt_event_wait+68>:  R0 =3D [P5]=3B
 0x64fc6a <rt_event_wait+70>:  R0 =3D R0 | R7=3B
 0x64fc6c <rt_event_wait+72>:  P0 =3D R0=3B
 0x64fc6e <rt_event_wait+74>:  R0 =3D P3=3B
 0x64fc70 <rt_event_wait+76>:  EXCPT 0x0=3B      <<<<<<<<<<<<<<<<<<<<<<<<<<=
<<<<<<<<<<<<<<<<<<<<<<<<
 0x64fc72 <rt_event_wait+78>:  P1 =3D R0=3B
 0x64fc74 <rt_event_wait+80>:  R0 =3D [FP + -0x848]=3B
=20
Execution crashes at EXCPT 0x0=2C which should be a system call=2C accordin=
g to Xenomai sources (syscall.h).
=20
Xenomai version is 2.5.3=2C Linux 2.6.34.7=2C running on a Blackfin BF518 p=
rocessor.
=20
Note that everything works fine running the application without debugger.
=20
Any hint?
Thank you very much in advance.

  		 	   		  =

--_f3d9f8c0-7050-4719-abce-64fbd49ddaee_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
Hello=2C<BR>
&nbsp=3B<BR>
I am trying to debug a Xenomai task through gdbserver over ethernet=2C with=
:<BR>
&nbsp=3B<BR>
gdbserver host:12345 --attach 240<BR>
&nbsp=3B<BR>
where 240 is the PID of the Xenomai real-time task I want to debug.<BR>
&nbsp=3B<BR>
After connecting with the gdb client=2C running continuosly is fine=2C but =
if I put a breakpoint and afterwards make the software execute an rt_event_=
wait call=2C the system crashes (gdb client stuck=2C no more ethernet conne=
ction=2C no panic message on the debug console serial port).<BR>
&nbsp=3B<BR>
By going step by step with the debugger=2C the exact point of the problem c=
an be isolated:<BR>
&nbsp=3B<BR>
int rt_event_wait(RT_EVENT *event=2C<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B unsigned long mask=2C<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B unsigned long *mask_r=2C int mode=2C RTIME timeout)<BR>{<BR>&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B int ret=3B<BR><BR>&nbsp=3B&nbsp=3B&nbsp=3B ret =3D XE=
NOMAI_SKINCALL5(__native_muxid=2C<BR>&nbsp=3B&nbsp=3B&nbsp=3B &nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B__native_event_wait=2C<BR>&nbsp=3B&nbsp=3B&nbsp=
=3B &nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3Bevent=2C &amp=3Bmask=2C mode=2C=
 XN_RELATIVE=2C &amp=3Btimeout)=3B<BR>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3Bif (r=
et)<BR>&nbsp=3B &nbsp=3B&nbsp=3B&nbsp=3Breturn ret=3B<BR>&nbsp=3B&nbsp=3B&n=
bsp=3B<BR>&nbsp=3B &nbsp=3B&nbsp=3B*mask_r =3D mask=3B<BR>&nbsp=3B<BR>&nbsp=
=3B&nbsp=3Breturn 0=3B<BR>}<BR>
&nbsp=3B<BR>
with mode =3D EV_ANY=2C timeout is 10000 - 100000 ns about.<BR>
&nbsp=3B<BR>
Showing the assembly code of the XENOMAI_SKINCALL5 macro:<BR>
&nbsp=3B<BR>
&nbsp=3B0x64fc4e&nbsp=3B&lt=3Brt_event_wait+42&gt=3B:&nbsp=3B&nbsp=3BR3 =3D=
 0x0 (X)=3B&nbsp=3B&nbsp=3B/*&nbsp=3B&nbsp=3BR3=3D0x0(&nbsp=3B 0) */<BR>&nb=
sp=3B0x64fc50&nbsp=3B&lt=3Brt_event_wait+44&gt=3B:&nbsp=3B&nbsp=3BR7.L =3D =
0x22b=3B&nbsp=3B&nbsp=3B/* (555)&nbsp=3BR7=3D0x0x27022b(2556459) */<BR>&nbs=
p=3B0x64fc54&nbsp=3B&lt=3Brt_event_wait+48&gt=3B:&nbsp=3B&nbsp=3BJUMP.S 0x0=
x64fc60 &lt=3Brt_event_wait+60&gt=3B=3B<BR>&nbsp=3B0x64fc56&nbsp=3B&lt=3Brt=
_event_wait+50&gt=3B:&nbsp=3B&nbsp=3BR0 =3D P1=3B<BR>&nbsp=3B0x64fc58&nbsp=
=3B&lt=3Brt_event_wait+52&gt=3B:&nbsp=3B&nbsp=3BR1 =3D -0x55 (X)=3B&nbsp=3B=
&nbsp=3B/*&nbsp=3B&nbsp=3BR1=3D0x0xffffffab(-85) */<BR>&nbsp=3B0x64fc5c&nbs=
p=3B&lt=3Brt_event_wait+56&gt=3B:&nbsp=3B&nbsp=3BCC =3D R0 =3D=3D R1=3B<BR>=
&nbsp=3B0x64fc5e&nbsp=3B&lt=3Brt_event_wait+58&gt=3B:&nbsp=3B&nbsp=3BIF !CC=
 JUMP 0x0x64fc9e &lt=3Brt_event_wait+122&gt=3B=3B<BR>&nbsp=3B0x64fc60&nbsp=
=3B&lt=3Brt_event_wait+60&gt=3B:&nbsp=3B&nbsp=3B[FP + -0x848] =3D R3=3B<BR>=
&nbsp=3B0x64fc64&nbsp=3B&lt=3Brt_event_wait+64&gt=3B:&nbsp=3B&nbsp=3BR1 =3D=
 R6=3B<BR>&nbsp=3B0x64fc66&nbsp=3B&lt=3Brt_event_wait+66&gt=3B:&nbsp=3B&nbs=
p=3BR2 =3D P4=3B<BR>&nbsp=3B0x64fc68&nbsp=3B&lt=3Brt_event_wait+68&gt=3B:&n=
bsp=3B&nbsp=3BR0 =3D [P5]=3B<BR>&nbsp=3B0x64fc6a&nbsp=3B&lt=3Brt_event_wait=
+70&gt=3B:&nbsp=3B&nbsp=3BR0 =3D R0 | R7=3B<BR>&nbsp=3B0x64fc6c&nbsp=3B&lt=
=3Brt_event_wait+72&gt=3B:&nbsp=3B&nbsp=3BP0 =3D R0=3B<BR>&nbsp=3B0x64fc6e&=
nbsp=3B&lt=3Brt_event_wait+74&gt=3B:&nbsp=3B&nbsp=3BR0 =3D P3=3B<BR>&nbsp=
=3B0x64fc70&nbsp=3B&lt=3Brt_event_wait+76&gt=3B:&nbsp=3B&nbsp=3BEXCPT 0x0=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B &lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&=
lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=
=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B=
&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=
=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B&lt=3B<BR>&nbsp=3B0x64fc72&nbsp=3B&l=
t=3Brt_event_wait+78&gt=3B:&nbsp=3B&nbsp=3BP1 =3D R0=3B<BR>&nbsp=3B0x64fc74=
&nbsp=3B&lt=3Brt_event_wait+80&gt=3B:&nbsp=3B&nbsp=3BR0 =3D [FP + -0x848]=
=3B<BR>
&nbsp=3B<BR>
Execution crashes at EXCPT 0x0=2C which should be a system call=2C accordin=
g to Xenomai sources (syscall.h).<BR>
&nbsp=3B<BR>
Xenomai version is 2.5.3=2C Linux 2.6.34.7=2C running on a Blackfin BF518 p=
rocessor.<BR>
&nbsp=3B<BR>
Note that everything works fine running the application without debugger.<B=
R>
&nbsp=3B<BR>
Any hint?<BR>
Thank you very much in advance.<BR>
<BR>&nbsp=3B<BR> 		 	   		  </div></body>
</html>=

--_f3d9f8c0-7050-4719-abce-64fbd49ddaee_--

