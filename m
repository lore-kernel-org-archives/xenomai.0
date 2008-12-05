Message-ID: <000b01c956eb$c9128ff0$0f01a8c0@domain.hid>
From: "Daniele Pagani" <danielepagani@domain.hid>
Date: Fri, 5 Dec 2008 16:11:42 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0008_01C956F4.29B8DDC0"
Subject: Re: [Xenomai-help] Blackfin BF537 userspace - kernelspace strategy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01C956F4.29B8DDC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Dear sirs,

I'm using uClinux with Xenomai on BF537 and it works fine.

But, I need to understand the best strategy to use about Linux/Xenomai =
and userspace/kernelspace.

I'm using sport driver for audio input/ouput and my application does =
audio alghoritms on these buffers (I'm working fine with 16x2 sample =
@48khz that is something like 2ms of audio latency time).

The driver is developed in Linux environment (without real time), using =
2d-dma buffering and dma_copy in function read/write.

Then, I develop, in userspace, application using Xenomai native library =
with function such as:
rt_task_create
rt_task_start

and inside the real time task I'm using read/write function according to =
the char device driver sport. The priority of the task is set to 99.

Anyway, when I'm using this configuration, sometimes a calling to a =
webserver (that is running on the same machine) could cause an error on =
the audio output, so I think that something is not in real time =
environment.

So the question is, what I need to do?

1) write real time driver (very difficult now for me)

2) write userspace application with real time interrupt and dma =
management? If yes, I don't understand if in Xenomai context I can set =
the Blackfin register from a userspace application or if in Xenomai =
context has no sense to speak about user/kernel space.=20

Sorry for my confusion.

Best regards,
Daniele.



------=_NextPart_000_0008_01C956F4.29B8DDC0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16414" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Dear sirs,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm using uClinux with Xenomai on BF537 =
and it=20
works fine.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>But, I need to understand the best =
strategy to use=20
about Linux/Xenomai and userspace/kernelspace.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm using sport driver for audio =
input/ouput and my=20
application does audio alghoritms on these buffers (I'm working fine =
with 16x2=20
sample @48khz that is something like 2ms of audio=20
latency&nbsp;time).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The driver is developed in Linux =
environment=20
(without real time), using 2d-dma buffering and dma_copy in function=20
read/write.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Then, I develop, in userspace, =
application using=20
Xenomai native library with function such as:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>rt_task_create</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>rt_task_start</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>and inside the real time task I'm using =
read/write=20
function according to the char device driver sport. The priority of the =
task is=20
set to 99.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Anyway, when I'm using this =
configuration,=20
sometimes a calling to a webserver (that is running on the same machine) =
could=20
cause an error on the audio output, so I think that something is not in =
real=20
time environment.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So the question is, what I need to =
do?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>1) write real time driver (very =
difficult now for=20
me)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>2) write userspace application with =
real time=20
interrupt and dma&nbsp;management? If yes, I don't understand if in =
Xenomai=20
context I can set the Blackfin register from a userspace application or =
if in=20
Xenomai context has no sense to speak about user/kernel space. =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Sorry for my confusion.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Best regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Daniele.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV>
<DIV><BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_0008_01C956F4.29B8DDC0--


