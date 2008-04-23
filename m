Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A587.EF2844FB"
Date: Wed, 23 Apr 2008 17:20:46 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F1F@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid><18446.32522.986935.299094@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid><2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid><2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid><51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
	<18447.31623.723753.421351@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: [Xenomai-help] FW: Xenomai serial port c++ code and / or
	xeno--(xenomm-0.0.1) install problem
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

------_=_NextPart_001_01C8A587.EF2844FB
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




-----Original Message-----
From: Karch, Joshua
Sent: Wed 4/23/2008 5:15 PM
To: Gilles Chanteperdrix
Subject: RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem
=20

Gilles,

I decided to eliminate the pthread and create a task that handles the =
entire packet process, from reading the serial port, to decoding data, =
to disk io (saving the data to disk)  The only thing that's serviced =
occasionally is the main loop, which looks every half second for a =
keypress to quit.

Now, I get overrun errors once every 10 seconds to 30 seconds.  The =
machine is a PC/104 and I'm using fprintf to print the data received =
from the sensor to file-- should I use perhaps an RT version?.
I know it's an overrun because the CRC error is triggered, and then I =
did an IOCTL to find out what was wrong with the status register on that =
error.
rtser_status_t serstatus;
err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, &serstatus);

	if(!serstatus.line_status=3D=3D96)
	     printf(RTASK_PREFIX "Error code line_status=3D%d =
modem_status=3D%d\n",serstatus.line_status, serstatus.modem_status);

        I get a line_status code of rtser_status_t (serstatus) =3D 98 =
when the crc fails, which corresponds to 1100010.  the second lsb =
corresponds to overrun. =20

This is the famous overrun I had with regular linux, it only happens =
much less often.=20

The packet processing task was started with the following priority
	err =3D rt_task_create(&read_task, "read_task", 0, 51, 0);

I appreciate your help with this-- I agree that I should keep mutexes =
out, etc.

Thank you,

Joshua Karch




-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Wed 4/23/2008 2:10 PM
To: Karch, Joshua
Cc: xenomai-help
Subject: RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem
=20
Karch, Joshua wrote:
 > Gilles,
 >=20
 > I've attached my old serial port code that uses the /dev/ttyS0 port.
 > What I have here is a "read byte on demand" function that uses the
 > select statement to block until data is ready.  My initial goal was
 > to replicate this functionality using the Xenomai Serial Driver.  It
 > seems, however, that the following is not possible under Xenomai.

It is possible, the serial driver has two things that may help you:
the RTSER_RTIOC_WAIT_EVENT ioctl, which will work like select.
the RTSER_SET_TIMEOUT_RX configuration bit, that will let you define a
timeout for data reception.=20
If you wonder where these things are documented, have a look at:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.html

With a timeout on reception, you can call read directly, this will save
you a system call, this matters for latency.

 > What I'm starting to conclude is that I can only receive data from a
 > serial port within the context of a task, and that printing error
 > codes from strerr produce "Operation not permitted" If I directly =
call
 > read in a manner similar to the linux serial port code (posted below)
 > by requesting a read from my sensor packet processing thread without
 > using an RT_TASK.  Here is what my sensor thread used to do to get
 > data from /dev/ttyS0=20
 >=20
 >=20
 > in the Pthread sensor processing thread...
 >=20
 > void sensorthreadmainloop()
 > {
 >     while(1)
 >     {
 >=20
 > 	if(serialport->readbyte())
 > 			{
 > 				SENSORID=3Dsensorpacket->processChar(ser->getreadbyte());
 > 			}
 > 			else
 > 			{
 > 				printf("One Second timeout detected on serial port, sensor data =
not received\n");
 > 			}
 > 		=09
 >                         // measure timestamp, process byte, checksum, =
etc, if timestamp is too
 >                         //great an error has occurred, etc.  If valid =
packet is received, send a
 >                         //condition variable signal to the main loop =
that data is available
 >                         //break out of loop if the application =
requests thread termination
 >                         .
 >                         .
 >                         .
 >                         //
 >     }
 > }
 >=20
 > It appears that I have to do something else with Xenomai-- set up a =
real time task which reads bytes from the rtser0 device.=20
 > When data is received, trigger a semaphore/condition variable to the =
above thread that one byte is ready for processing.
 >=20
 > What this basically means is that I would have an rt task like the =
following in the serial port reader code where the task has been =
pre-initialized and started.=20
 > =20
 > void read_task_proc(void *arg)
 > {
 > 	while (1)
 >         {
 > 		int read =3D rt_dev_read(read_fd, inbyte, 2250);
 > 		if (read <0) {
 > 			printf("error on rt_dev_read, code %s\n",
 > 			       strerror(-err));
 > 			break;
 > 		}
 >                 else
 >                 {
 >                           //data received, trigger  condition =
variable
 > 			  pthread_mutex_lock(&run_mutex);
 > 		          pthread_cond_signal(&run_cv);
 > 			  pthread_mutex_unlock(&run_mutex);
 >=20
 > 		}
 >=20
 > 	}
 >=20
 >=20
 > }
 >=20
 > In my sensor  thread I would have the following:
 >=20
 > void sensorthreadmainloop()
 > {
 >     while(1)
 >     {
 >=20
 > =09
 > 		pthread_mutex_lock(&run_mutex);
 > 		pthread_cond_wait(&run_cv, &run_mutex);
 > 		pthread_mutex_unlock(&run_mutex);
 >                 //if data received
 > 		SENSORID=3Dsensorpacket->processChar(ser->getreadbyte());
 > 		//and figure out a way to signal other important information such =
as timeouts=09
 >                         // measure timestamp, process byte, checksum, =
etc, if timestamp is too
 >                         //great an error has occurred, etc.  If valid =
packet is received, send a
 >                         //condition variable signal to the main loop =
that a completed sensor packet is available
 >                         //break out of loop if the application =
requests thread termination
 >                         .
 >                         .
 >                         .
 >                         //
 >     }
 > }
 > If I use a condition variable from a continuously running RT_TASK =
that reads from the serial port to trigger processing, is that the right =
way to make this work?=20
 > Can I mix pthreads, mutexes, and tasks together, or should every
 > thread my program has (and it reads 3 sensors using the above
 > methods) all use RT_TASKS and specially set up Mutexes/Condition
 > variables.=20

Everything is possible, but let us keep something in mind: if you use
Xenomai it is because you are not satisfied with Linux natural
latency. You probably have some treatment to do upon reception of a
character on the serial line, some time of real-time control loop. If:
- you transfer control from the real time task receiving characters to a
  non real-time task to to the treatment;
- or you call some non real-time services from the task receiving
  characters;=20
- or you have the real-time task receiving character wait for a non
  real-time task;
the real-time task receiving characters from the serial line will depend
on Linux latencies. In other words, you loose any interest in using
Xenomai.

--=20


					    Gilles.



------_=_NextPart_001_01C8A587.EF2844FB
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
<TITLE>FW: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: Karch, Joshua<BR>
Sent: Wed 4/23/2008 5:15 PM<BR>
To: Gilles Chanteperdrix<BR>
Subject: RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem<BR>
<BR>
<BR>
Gilles,<BR>
<BR>
I decided to eliminate the pthread and create a task that handles the =
entire packet process, from reading the serial port, to decoding data, =
to disk io (saving the data to disk)&nbsp; The only thing that's =
serviced occasionally is the main loop, which looks every half second =
for a keypress to quit.<BR>
<BR>
Now, I get overrun errors once every 10 seconds to 30 seconds.&nbsp; The =
machine is a PC/104 and I'm using fprintf to print the data received =
from the sensor to file-- should I use perhaps an RT version?.<BR>
I know it's an overrun because the CRC error is triggered, and then I =
did an IOCTL to find out what was wrong with the status register on that =
error.<BR>
rtser_status_t serstatus;<BR>
err =3D rt_dev_ioctl(read_fd, RTSER_RTIOC_GET_STATUS, =
&amp;serstatus);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if(!serstatus.line_status=3D=3D96)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; =
printf(RTASK_PREFIX &quot;Error code line_status=3D%d =
modem_status=3D%d\n&quot;,serstatus.line_status, =
serstatus.modem_status);<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I get a line_status code of =
rtser_status_t (serstatus) =3D 98 when the crc fails, which corresponds =
to 1100010.&nbsp; the second lsb corresponds to overrun.&nbsp;<BR>
<BR>
This is the famous overrun I had with regular linux, it only happens =
much less often.<BR>
<BR>
The packet processing task was started with the following priority<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rt_task_create(&amp;read_task, &quot;read_task&quot;, 0, 51, 0);<BR>
<BR>
I appreciate your help with this-- I agree that I should keep mutexes =
out, etc.<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Gilles Chanteperdrix [<A =
HREF=3D"mailto:gilles.chanteperdrix@xenomai.org">mailto:gilles.chanteperdri=
x@domain.hid</A>]<BR>
Sent: Wed 4/23/2008 2:10 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai-help<BR>
Subject: RE: [Xenomai-help] Xenomai serial port c++ code and / or =
xeno--(xenomm-0.0.1) install problem<BR>
<BR>
Karch, Joshua wrote:<BR>
&nbsp;&gt; Gilles,<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; I've attached my old serial port code that uses the =
/dev/ttyS0 port.<BR>
&nbsp;&gt; What I have here is a &quot;read byte on demand&quot; =
function that uses the<BR>
&nbsp;&gt; select statement to block until data is ready.&nbsp; My =
initial goal was<BR>
&nbsp;&gt; to replicate this functionality using the Xenomai Serial =
Driver.&nbsp; It<BR>
&nbsp;&gt; seems, however, that the following is not possible under =
Xenomai.<BR>
<BR>
It is possible, the serial driver has two things that may help you:<BR>
the RTSER_RTIOC_WAIT_EVENT ioctl, which will work like select.<BR>
the RTSER_SET_TIMEOUT_RX configuration bit, that will let you define =
a<BR>
timeout for data reception.<BR>
If you wonder where these things are documented, have a look at:<BR>
<A =
HREF=3D"http://www.xenomai.org/documentation/branches/v2.4.x/html/api/ind=
ex.html">http://www.xenomai.org/documentation/branches/v2.4.x/html/api/in=
dex.html</A><BR>
<BR>
With a timeout on reception, you can call read directly, this will =
save<BR>
you a system call, this matters for latency.<BR>
<BR>
&nbsp;&gt; What I'm starting to conclude is that I can only receive data =
from a<BR>
&nbsp;&gt; serial port within the context of a task, and that printing =
error<BR>
&nbsp;&gt; codes from strerr produce &quot;Operation not permitted&quot; =
If I directly call<BR>
&nbsp;&gt; read in a manner similar to the linux serial port code =
(posted below)<BR>
&nbsp;&gt; by requesting a read from my sensor packet processing thread =
without<BR>
&nbsp;&gt; using an RT_TASK.&nbsp; Here is what my sensor thread used to =
do to get<BR>
&nbsp;&gt; data from /dev/ttyS0<BR>
&nbsp;&gt;<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; in the Pthread sensor processing thread...<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; void sensorthreadmainloop()<BR>
&nbsp;&gt; {<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; while(1)<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; if(serialport-&gt;readbyte())<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SENSORID=3Dsensorpacket-&gt;processChar(ser-&gt;getreadbyte());<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;One Second =
timeout detected on serial port, sensor data not received\n&quot;);<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; // measure timestamp, process byte, checksum, etc, if timestamp =
is too<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; //great an error has occurred, etc.&nbsp; If valid packet is =
received, send a<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; //condition variable signal to the main loop that data is =
available<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; //break out of loop if the application requests thread =
termination<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; .<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; .<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; .<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; //<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&gt; }<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; It appears that I have to do something else with Xenomai-- =
set up a real time task which reads bytes from the rtser0 device.<BR>
&nbsp;&gt; When data is received, trigger a semaphore/condition variable =
to the above thread that one byte is ready for processing.<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; What this basically means is that I would have an rt task =
like the following in the serial port reader code where the task has =
been pre-initialized and started.<BR>
&nbsp;&gt;&nbsp;<BR>
&nbsp;&gt; void read_task_proc(void *arg)<BR>
&nbsp;&gt; {<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; while (1)<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int read =3D =
rt_dev_read(read_fd, inbyte, 2250);<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read &lt;0) {<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;error on =
rt_dev_read, code %s\n&quot;,<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror(-err));<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; //data received, trigger&nbsp; condition =
variable<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
pthread_mutex_lock(&amp;run_mutex);<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pthread_cond_signal(&amp;run_cv);<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
pthread_mutex_unlock(&amp;run_mutex);<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&gt;<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; }<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; In my sensor&nbsp; thread I would have the following:<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; void sensorthreadmainloop()<BR>
&nbsp;&gt; {<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; while(1)<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&gt;<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pthread_mutex_lock(&amp;run_mutex);<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pthread_cond_wait(&amp;run_cv, &amp;run_mutex);<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pthread_mutex_unlock(&amp;run_mutex);<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //if data received<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SENSORID=3Dsensorpacket-&gt;processChar(ser-&gt;getreadbyte());<BR>
&nbsp;&gt; &nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //and figure out a way to =
signal other important information such as timeouts&nbsp;&nbsp;<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; // measure timestamp, process byte, checksum, etc, if timestamp =
is too<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; //great an error has occurred, etc.&nbsp; If valid packet is =
received, send a<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; //condition variable signal to the main loop that a completed =
sensor packet is available<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; //break out of loop if the application requests thread =
termination<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; .<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; .<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; .<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; //<BR>
&nbsp;&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&gt; }<BR>
&nbsp;&gt; If I use a condition variable from a continuously running =
RT_TASK that reads from the serial port to trigger processing, is that =
the right way to make this work?<BR>
&nbsp;&gt; Can I mix pthreads, mutexes, and tasks together, or should =
every<BR>
&nbsp;&gt; thread my program has (and it reads 3 sensors using the =
above<BR>
&nbsp;&gt; methods) all use RT_TASKS and specially set up =
Mutexes/Condition<BR>
&nbsp;&gt; variables.<BR>
<BR>
Everything is possible, but let us keep something in mind: if you =
use<BR>
Xenomai it is because you are not satisfied with Linux natural<BR>
latency. You probably have some treatment to do upon reception of a<BR>
character on the serial line, some time of real-time control loop. =
If:<BR>
- you transfer control from the real time task receiving characters to =
a<BR>
&nbsp; non real-time task to to the treatment;<BR>
- or you call some non real-time services from the task receiving<BR>
&nbsp; characters;<BR>
- or you have the real-time task receiving character wait for a non<BR>
&nbsp; real-time task;<BR>
the real-time task receiving characters from the serial line will =
depend<BR>
on Linux latencies. In other words, you loose any interest in using<BR>
Xenomai.<BR>
<BR>
--<BR>
<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
Gilles.<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A587.EF2844FB--

