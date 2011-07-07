Message-ID: <SNT127-W46C0FFB2ED99A4AA6D15DAD1410@domain.hid>
Content-Type: multipart/alternative;
	boundary="_7c0ffbf9-2322-4bbf-b9e1-df9f9f5fdc27_"
From: Tony Vinto <tonyvintox@domain.hid>
Date: Thu, 7 Jul 2011 10:11:05 -0400
MIME-Version: 1.0
Subject: [Xenomai-help] Newbee questions - concerning the native API
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

--_7c0ffbf9-2322-4bbf-b9e1-df9f9f5fdc27_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=2C

I apologize if I am asking questions that have been handled many times befo=
re but at mu skill level searching the list of archives and for a similar t=
opic seems overly daunting to me.  ( Is there an application that can globa=
lly search the archives without me having to manually download each and ind=
ividually un-gzipping them and then searching for keywords in each? )

I am six months into Linux programming and only a few days into Xenomai...
( I have read the API document once=2C and am in the second reading of the =
Native API Tour revC.)

Anyway my questions...

For sake of discussion these refer to the example code "trivial-periodic.c"=
=2C but are really general questions.


1) Is the proceedure "demo(void *arg)" the real time part and the "main()" =
section standard linux?  That is=2C is "demo()" preempt-able or will it run=
 forever without preemption?  if the latter=2C I presume that it is the cod=
ers responsibility to build in a means for the procedure to return to sleep=
 when it has completed it's job.   ( as in the example=2C the "rt_task_wait=
_period(NULL)" call. )


2) My application will run in user space and will access a device on an SPI=
 bus.  I will be using a user mode SPI driver and making IOCTL calls to exc=
hange data with my device.
If I do all of my work in a real time proceedure ( like demo() in the examp=
le code ) will the IOCTL calls also be in the real time domain?  That is ar=
e they protected from preemption?


3) The API tour says "message pipes" are for exchange of data between RT us=
er mode and regular user mode. Intertasksynchronous message passing=2C Mess=
age queues=2C and Memory heaps are for kernel mode to user mode communicati=
on... or for RT user mode to RT user mode communication.

Am I "over reading" this?  ...or can I use any of these techniques for RT-U=
ser mode to regular user mode data exchange?



Thanks for the help!
Tony
 		 	   		  =

--_7c0ffbf9-2322-4bbf-b9e1-df9f9f5fdc27_
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
--></style>
</head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
Hi=2C<br><br>I apologize if I am asking questions that have been handled ma=
ny times before but at mu skill level searching the list of archives and fo=
r a similar topic seems overly daunting to me.&nbsp=3B ( Is there an applic=
ation that can globally search the archives without me having to manually d=
ownload each and individually un-gzipping them and then searching for keywo=
rds in each? )<br><br>I am six months into Linux programming and only a few=
 days into Xenomai...<br>( I have read the API document once=2C and am in t=
he second reading of the Native API Tour revC.)<br><br>Anyway my questions.=
..<br><br>For sake of discussion these refer to the example code "trivial-p=
eriodic.c"=2C but are really general questions.<br><br><br>1) Is the procee=
dure "demo(void *arg)" the real time part and the "main()" section standard=
 linux?&nbsp=3B That is=2C is "demo()" preempt-able or will it run forever =
without preemption?&nbsp=3B if the latter=2C I presume that it is the coder=
s responsibility to build in a means for the procedure to return to sleep w=
hen it has completed it's job.&nbsp=3B&nbsp=3B ( as in the example=2C the "=
rt_task_wait_period(NULL)" call. )<br><br><br>2) My application will run in=
 user space and will access a device on an SPI bus.&nbsp=3B I will be using=
 a user mode SPI driver and making IOCTL calls to exchange data with my dev=
ice.<br>If I do all of my work in a real time proceedure ( like demo() in t=
he example code ) will the IOCTL calls also be in the real time domain?&nbs=
p=3B That is are they protected from preemption?<br><br><br>3) The API tour=
 says "message pipes" are for exchange of data between RT user mode and reg=
ular user mode. Intertasksynchronous message passing=2C Message queues=2C a=
nd Memory heaps are for kernel mode to user mode communication... or for RT=
 user mode to RT user mode communication.<br><br>Am I "over reading" this?&=
nbsp=3B ...or can I use any of these techniques for RT-User mode to regular=
 user mode data exchange?<br><br><br><br>Thanks for the help!<br>Tony<br> 	=
	 	   		  </div></body>
</html>=

--_7c0ffbf9-2322-4bbf-b9e1-df9f9f5fdc27_--

