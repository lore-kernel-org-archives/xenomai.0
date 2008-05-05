Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8AF01.1AD77414"
Date: Mon, 5 May 2008 18:41:06 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F73@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: [Xenomai-help] rt_queue_alloc and ways to manage queue overruns
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

------_=_NextPart_001_01C8AF01.1AD77414
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,

I have tasks that normally run at 50 Hz dealing with serial ports.    I =
have a command task which sends queue messages to a receive task that =
communicates with the serial port. The receive task waits indefinitely =
for a message over rt_queue (with TM_INFINITE) and then proceeds to =
write to the serial port, then reads a response from the RT serial port. =
 Occasionally, the device on the receiving end of the port takes longer =
than the expected 20 msec,( 50Hz response) as I've set the RTSER CONFIG =
struct to look for a 100 msec timeout.  As a result, the number of =
queued messages quickly build up.  After that, I run out of allocation =
space with rt_queue_alloc.

Is there some way to check to make sure I am receiving the most current =
message, and if not, flush all of the queued up messages with =
rt_queue_free so I can send the latest data to the serial port and not =
encounter message "buffer" overruns? With the exception of datalogging =
to disk, I'm very interested in getting to the most current message in a =
timely manner.


Thank you,
Joshua Karch




------_=_NextPart_001_01C8AF01.1AD77414
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
<TITLE>rt_queue_alloc and ways to manage queue overruns</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
I have tasks that normally run at 50 Hz dealing with serial =
ports.&nbsp;&nbsp;&nbsp; I have a command task which sends queue =
messages to a receive task that communicates with the serial port. The =
receive task waits indefinitely for a message over rt_queue (with =
TM_INFINITE) and then proceeds to write to the serial port, then reads a =
response from the RT serial port.&nbsp; Occasionally, the device on the =
receiving end of the port takes longer than the expected 20 msec,( 50Hz =
response) as I've set the RTSER CONFIG struct to look for a 100 msec =
timeout.&nbsp; As a result, the number of queued messages quickly build =
up.&nbsp; After that, I run out of allocation space with =
rt_queue_alloc.<BR>
<BR>
Is there some way to check to make sure I am receiving the most current =
message, and if not, flush all of the queued up messages with =
rt_queue_free so I can send the latest data to the serial port and not =
encounter message &quot;buffer&quot; overruns? With the exception of =
datalogging to disk, I'm very interested in getting to the most current =
message in a timely manner.<BR>
<BR>
<BR>
Thank you,<BR>
Joshua Karch<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8AF01.1AD77414--

