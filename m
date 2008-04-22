Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A4CA.B7381520"
Date: Tue, 22 Apr 2008 18:46:34 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: [Xenomai-help] Xenomai serial port c++ code and / or xeno--
	(xenomm-0.0.1) install problem
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

------_=_NextPart_001_01C8A4CA.B7381520
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,

I recently installed Xenomai on a PC/104 and began writing a C++ program =
that makes use of the serial port.  I tried using the Xenomai Serial =
port example program cross-link.c and I was successful in getting that =
to run. I edited cross-link.c to read only from a device running at =
115200 on the serial port.  I have found the standard /dev/ttyS0 serial =
port to be useless for my application since I get overrun errors on my =
system. =20

My C++ program reads byte at a time from a serial port, processes the =
byte, then repeats until a checksummed packet is received.  I have two =
specific questions as to how to get the serial port to work under =
Xenomai with c++

The way I understand port reading is as follows:

1) Open device using read_fd =3D rt_dev_open( READ_FILE, 0 ) and set it =
up
    err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_SET_CONFIG, &read_config);
2) It is necessary to create an RT_TASK analogous to a thread to service =
the serial port task
    err =3D rt_task_create(&read_task, "read_task", 0, 51, 0);
3) for each byte read, activate the read task with rt_task_start
    err =3D rt_task_start(&read_task,&read_task_proc,NULL);
    4) Within the Real Time read_task_proc, request one byte at a time =
within the rt_task_process using
        err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, =
&rx_event);
        read =3D rt_dev_read(read_fd, buffer, 1);
5)  read from the buffer into the user application in non-real time mode

6)  close when done

The problem I am having with this method is that=20
int 	rt_task_start (RT_TASK *task, void(*fun)(void *cookie), void =
*cookie)
won't accept a pointer to an object method and requires a pointer to an =
instance to map into the void(*fun)(void *cookie), void *cookie section.

With Pthreads, I instantiate a threaded main loop within an object as =
follows:
void * serial::thunk(void * param)
{
	serial *instance =3D (serial *) param;
	instance->read_task_proc();

}

Is there a similar way to do this with rt_tasks?  In particular, if a =
c++ based serial read example were available for byte-at-a-time, that =
would be very useful.

Also, xenomm-0.0.1 failed under ./configure with "checking value of =
TM_UNSET in native/timer.h"-- any ideas on how to get xenomm (xeno--) =
working?  Is it useful?

Thank you,

Joshua Karch


------_=_NextPart_001_01C8A4CA.B7381520
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>Xenomai serial port c++ code and / or xeno-- (xenomm-0.0.1) =
install problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
I recently installed Xenomai on a PC/104 and began writing a C++ program =
that makes use of the serial port.&nbsp; I tried using the Xenomai =
Serial port example program cross-link.c and I was successful in getting =
that to run. I edited cross-link.c to read only from a device running at =
115200 on the serial port.&nbsp; I have found the standard /dev/ttyS0 =
serial port to be useless for my application since I get overrun errors =
on my system.&nbsp;<BR>
<BR>
My C++ program reads byte at a time from a serial port, processes the =
byte, then repeats until a checksummed packet is received.&nbsp; I have =
two specific questions as to how to get the serial port to work under =
Xenomai with c++<BR>
<BR>
The way I understand port reading is as follows:<BR>
<BR>
1) Open device using read_fd =3D rt_dev_open( READ_FILE, 0 ) and set it =
up<BR>
&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_SET_CONFIG, =
&amp;read_config);<BR>
2) It is necessary to create an RT_TASK analogous to a thread to service =
the serial port task<BR>
&nbsp;&nbsp;&nbsp; err =3D rt_task_create(&amp;read_task, =
&quot;read_task&quot;, 0, 51, 0);<BR>
3) for each byte read, activate the read task with rt_task_start<BR>
&nbsp;&nbsp;&nbsp; err =3D =
rt_task_start(&amp;read_task,&amp;read_task_proc,NULL);<BR>
&nbsp;&nbsp;&nbsp; 4) Within the Real Time read_task_proc, request one =
byte at a time within the rt_task_process using<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D rt_dev_ioctl(read_fd, =
RTSER_RTIOC_WAIT_EVENT, &amp;rx_event);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read =3D rt_dev_read(read_fd, =
buffer, 1);<BR>
5)&nbsp; read from the buffer into the user application in non-real time =
mode<BR>
<BR>
6)&nbsp; close when done<BR>
<BR>
The problem I am having with this method is that<BR>
int &nbsp;&nbsp;&nbsp; rt_task_start (RT_TASK *task, void(*fun)(void =
*cookie), void *cookie)<BR>
won't accept a pointer to an object method and requires a pointer to an =
instance to map into the void(*fun)(void *cookie), void *cookie =
section.<BR>
<BR>
With Pthreads, I instantiate a threaded main loop within an object as =
follows:<BR>
void * serial::thunk(void * param)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial *instance =3D (serial =
*) param;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
instance-&gt;read_task_proc();<BR>
<BR>
}<BR>
<BR>
Is there a similar way to do this with rt_tasks?&nbsp; In particular, if =
a c++ based serial read example were available for byte-at-a-time, that =
would be very useful.<BR>
<BR>
Also, xenomm-0.0.1 failed under ./configure with &quot;checking value of =
TM_UNSET in native/timer.h&quot;-- any ideas on how to get xenomm =
(xeno--) working?&nbsp; Is it useful?<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A4CA.B7381520--

