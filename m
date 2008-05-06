Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8AF81.DDCE8FED"
Date: Tue, 6 May 2008 10:02:48 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F78@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F73@domain.hid>
	<48200CD1.1060809@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue overruns
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8AF81.DDCE8FED
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Phillipe,

Here's my setup in short.

I have a two-serial port setup where I read at 50 Hz from a sensor task =
(a navigation sensor) and I send queue messages from that sensor task to =
log data or CRC/byte errors to two separate log files using lower =
priority logging tasks.  Concurrently, the 50 Hz serial sensor task =
feeds state data in the form of a struct of mixed types (floats, ints) =
to a control law loop that runs at 50Hz (potentially asynchronously).  =
That control loop processes the data if available and sends a command at =
50 Hz to the second serial device discussed yesterday (a motor =
controller) running on another task. The motor controller takes in a =
fixed command packet and responds with a fixed packet usually without =
delay. If no data is received by the motor controller, it will not send =
data.  If the motor controller doesn't receive data from the control =
task within 100 msec, the device requires a separate reset packet in =
order to resume responding to input commands.  At that point, I want a =
timeout to occur on rt_serial read so that the task will send the =
appropriate reset packet. That timeout caused the queue to overrun =
yesterday when I tested that function.  When everything is working =
perfectly, there should be no timeouts throughout the system.=20

So essentially, my question is this--

Should I use the queue for all data-logging tasks and use semaphores or =
rt_task send/receive for the two paths from the navigation sensor to the =
control loop and from the control loop to the motor controller?

Thank you,

Joshua Karch


-----Original Message-----
From: Philippe Gerum on behalf of Philippe Gerum
Sent: Tue 5/6/2008 3:46 AM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue =
overruns
=20
Karch, Joshua wrote:
>=20
> Hello,
>=20
> I have tasks that normally run at 50 Hz dealing with serial ports.    =
I
> have a command task which sends queue messages to a receive task that
> communicates with the serial port. The receive task waits indefinitely
> for a message over rt_queue (with TM_INFINITE) and then proceeds to
> write to the serial port, then reads a response from the RT serial
> port.  Occasionally, the device on the receiving end of the port takes
> longer than the expected 20 msec,( 50Hz response) as I've set the =
RTSER
> CONFIG struct to look for a 100 msec timeout.  As a result, the number
> of queued messages quickly build up.  After that, I run out of
> allocation space with rt_queue_alloc.
>=20
> Is there some way to check to make sure I am receiving the most =
current
> message, and if not, flush all of the queued up messages with
> rt_queue_free so I can send the latest data to the serial port and not
> encounter message "buffer" overruns? With the exception of datalogging
> to disk, I'm very interested in getting to the most current message in =
a
> timely manner.

Maybe a queue is not the right tool to use in your case, you don't seem =
to
really need message buffering. From your description, I would rather =
think of
some kind of "blackboard" abstraction, something that holds a single =
data with a
validity stamp (time-based or not) for instance. There is no such object
available in the native API, but this could be easily built out of a =
semaphore
and common memory, using a shared counter to hold the transmit sequence =
number.

If you actually don't care for buffering, the other way is to use the =
message
passing API (i.e. rt_task_send, rt_task_receive, rt_task_reply) to get
synchronous messaging. In that case, the sender would be able to wait =
for the
receiver to get the status from the serial link. The receiver would send =
that
answer back to the initiator using rt_task_reply.
This needs XENO_OPT_NATIVE_MPS to be switched on in the kernel config.

--=20
Philippe.


------_=_NextPart_001_01C8AF81.DDCE8FED
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
<TITLE>RE: [Xenomai-help] rt_queue_alloc and ways to manage queue =
overruns</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Phillipe,<BR>
<BR>
Here's my setup in short.<BR>
<BR>
I have a two-serial port setup where I read at 50 Hz from a sensor task =
(a navigation sensor) and I send queue messages from that sensor task to =
log data or CRC/byte errors to two separate log files using lower =
priority logging tasks.&nbsp; Concurrently, the 50 Hz serial sensor task =
feeds state data in the form of a struct of mixed types (floats, ints) =
to a control law loop that runs at 50Hz (potentially =
asynchronously).&nbsp; That control loop processes the data if available =
and sends a command at 50 Hz to the second serial device discussed =
yesterday (a motor controller) running on another task. The motor =
controller takes in a fixed command packet and responds with a fixed =
packet usually without delay. If no data is received by the motor =
controller, it will not send data.&nbsp; If the motor controller doesn't =
receive data from the control task within 100 msec, the device requires =
a separate reset packet in order to resume responding to input =
commands.&nbsp; At that point, I want a timeout to occur on rt_serial =
read so that the task will send the appropriate reset packet. That =
timeout caused the queue to overrun yesterday when I tested that =
function.&nbsp; When everything is working perfectly, there should be no =
timeouts throughout the system.<BR>
<BR>
So essentially, my question is this--<BR>
<BR>
Should I use the queue for all data-logging tasks and use semaphores or =
rt_task send/receive for the two paths from the navigation sensor to the =
control loop and from the control loop to the motor controller?<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Philippe Gerum on behalf of Philippe Gerum<BR>
Sent: Tue 5/6/2008 3:46 AM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue =
overruns<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt;<BR>
&gt; Hello,<BR>
&gt;<BR>
&gt; I have tasks that normally run at 50 Hz dealing with serial =
ports.&nbsp;&nbsp;&nbsp; I<BR>
&gt; have a command task which sends queue messages to a receive task =
that<BR>
&gt; communicates with the serial port. The receive task waits =
indefinitely<BR>
&gt; for a message over rt_queue (with TM_INFINITE) and then proceeds =
to<BR>
&gt; write to the serial port, then reads a response from the RT =
serial<BR>
&gt; port.&nbsp; Occasionally, the device on the receiving end of the =
port takes<BR>
&gt; longer than the expected 20 msec,( 50Hz response) as I've set the =
RTSER<BR>
&gt; CONFIG struct to look for a 100 msec timeout.&nbsp; As a result, =
the number<BR>
&gt; of queued messages quickly build up.&nbsp; After that, I run out =
of<BR>
&gt; allocation space with rt_queue_alloc.<BR>
&gt;<BR>
&gt; Is there some way to check to make sure I am receiving the most =
current<BR>
&gt; message, and if not, flush all of the queued up messages with<BR>
&gt; rt_queue_free so I can send the latest data to the serial port and =
not<BR>
&gt; encounter message &quot;buffer&quot; overruns? With the exception =
of datalogging<BR>
&gt; to disk, I'm very interested in getting to the most current message =
in a<BR>
&gt; timely manner.<BR>
<BR>
Maybe a queue is not the right tool to use in your case, you don't seem =
to<BR>
really need message buffering. From your description, I would rather =
think of<BR>
some kind of &quot;blackboard&quot; abstraction, something that holds a =
single data with a<BR>
validity stamp (time-based or not) for instance. There is no such =
object<BR>
available in the native API, but this could be easily built out of a =
semaphore<BR>
and common memory, using a shared counter to hold the transmit sequence =
number.<BR>
<BR>
If you actually don't care for buffering, the other way is to use the =
message<BR>
passing API (i.e. rt_task_send, rt_task_receive, rt_task_reply) to =
get<BR>
synchronous messaging. In that case, the sender would be able to wait =
for the<BR>
receiver to get the status from the serial link. The receiver would send =
that<BR>
answer back to the initiator using rt_task_reply.<BR>
This needs XENO_OPT_NATIVE_MPS to be switched on in the kernel =
config.<BR>
<BR>
--<BR>
Philippe.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8AF81.DDCE8FED--

