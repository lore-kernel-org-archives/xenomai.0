Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B06D.3D3F14CA"
Date: Wed, 7 May 2008 14:07:40 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F80@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F73@domain.hid>
	<48200CD1.1060809@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F78@domain.hid>
	<4821E2D0.4040608@domain.hid>
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

------_=_NextPart_001_01C8B06D.3D3F14CA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Phillipe,

this is great information and advice and it helps me better frame the =
architecture for my system.

What I've made work so far is to use rt_task_send from the navigation =
sensor to trigger the control law loop synchronously.  Essentially, the =
control loop will block to synchronize on successful receipt of data =
from the navigation sensor. At some point I will consider making it =
asynchronous and use rt_queues if I add in more sensors. I then will =
send an rt_task_send to synchronously control the servo controller task. =
 The rt_queues seem to be doing an excellent job of reliably sending =
data to the disk logging tasks.  The logging tasks are rt tasks but they =
are running in very low priority mode with a large queue buffer-- is =
there any reason to switch from using queues for data logging to RT =
Pipes if this is working?  i.e. should the logging rt_tasks become =
non-realtime logging pthreads instead and use pipes?

The document you referenced is very good information in terms of =
determining what type of messaging service to use.

Regarding the rt_task_send/receive bug, I'm doing the objdump now and =
will post code to replicate the problem shortly.

Thank you for all your help with this,

Josh


-----Original Message-----
From: Philippe Gerum on behalf of Philippe Gerum
Sent: Wed 5/7/2008 1:11 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue =
overruns
=20
Karch, Joshua wrote:
> Phillipe,
>=20
> Here's my setup in short.
>=20
> I have a two-serial port setup where I read at 50 Hz from a sensor =
task (a navigation sensor) and I send queue messages from that sensor =
task to log data or CRC/byte errors to two separate log files using =
lower priority logging tasks.  Concurrently, the 50 Hz serial sensor =
task feeds state data in the form of a struct of mixed types (floats, =
ints) to a control law loop that runs at 50Hz (potentially =
asynchronously).  That control loop processes the data if available and =
sends a command at 50 Hz to the second serial device discussed yesterday =
(a motor controller) running on another task. The motor controller takes =
in a fixed command packet and responds with a fixed packet usually =
without delay. If no data is received by the motor controller, it will =
not send data.  If the motor controller doesn't receive data from the =
control task within 100 msec, the device requires a separate reset =
packet in order to resume responding to input commands.  At that point, =
I want a timeout to=20
=20
occur on rt_serial read so that the task will send the appropriate reset =
packet. That timeout caused the queue to overrun yesterday when I tested =
that function.  When everything is working perfectly, there should be no =
timeouts throughout the system.=20
>=20
> So essentially, my question is this--
>=20
> Should I use the queue for all data-logging tasks and use semaphores =
or rt_task send/receive for the two paths from the navigation sensor to =
the control loop and from the control loop to the motor controller?
>

>From my understanding of your design, you should probably use:

- message pipes (RT_PIPE) between the sensor task (RT side) to the =
regular
logging tasks (non RT side). The rationale here is that your logging =
tasks will
have to run most of their active time in secondary (i.e. plain Linux) =
mode to
write the data to disk files, not in real-time mode. If those tasks =
still need
to synchronize at some point with the real-time side, such as waiting =
for an
event or a semaphore posted from there, make those tasks non-RT shadows, =
passing
a zero priority for them when calling rt_task_create(), rt_task_spawn() =
or
rt_task_shadow() - whatever you happen to use to create those Xenomai =
tasks.

- a real-time queue (RT_QUEUE) between the sensor and the control loop =
tasks,
because of the real-time and asynchronous nature of that data path.

- message passing calls (rt_task_send/receive/reply) between the control =
loop
and the motor controller, since the real-time protocol they share seems =
purely
synchronous.

By using a timeout of 100ms in rt_task_receive(), the motor controller =
should be
able to wakeup then abort the serial read of the sensor task by issuing
rt_task_unblock() (at least, this would be the case if you were reading =
bytes
through RTDM's rt_dev_read() call). If rt_dev_read() returns -EINTR, =
then your
sensor should send a reset to the device. Any blocking call (except
rt_task_suspend()) - from the native API may be aborted using =
rt_task_unblock(),
and will return -EINTR in that case.

PS: in case it is not done already, you may want to have a look at this =
document:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-=
rev-C.pdf

> Thank you,
>=20
> Joshua Karch
>=20
>=20
> -----Original Message-----
> From: Philippe Gerum on behalf of Philippe Gerum
> Sent: Tue 5/6/2008 3:46 AM
> To: Karch, Joshua
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue =
overruns
> =20
> Karch, Joshua wrote:
>> Hello,
>>
>> I have tasks that normally run at 50 Hz dealing with serial ports.    =
I
>> have a command task which sends queue messages to a receive task that
>> communicates with the serial port. The receive task waits =
indefinitely
>> for a message over rt_queue (with TM_INFINITE) and then proceeds to
>> write to the serial port, then reads a response from the RT serial
>> port.  Occasionally, the device on the receiving end of the port =
takes
>> longer than the expected 20 msec,( 50Hz response) as I've set the =
RTSER
>> CONFIG struct to look for a 100 msec timeout.  As a result, the =
number
>> of queued messages quickly build up.  After that, I run out of
>> allocation space with rt_queue_alloc.
>>
>> Is there some way to check to make sure I am receiving the most =
current
>> message, and if not, flush all of the queued up messages with
>> rt_queue_free so I can send the latest data to the serial port and =
not
>> encounter message "buffer" overruns? With the exception of =
datalogging
>> to disk, I'm very interested in getting to the most current message =
in a
>> timely manner.
>=20
> Maybe a queue is not the right tool to use in your case, you don't =
seem to
> really need message buffering. From your description, I would rather =
think of
> some kind of "blackboard" abstraction, something that holds a single =
data with a
> validity stamp (time-based or not) for instance. There is no such =
object
> available in the native API, but this could be easily built out of a =
semaphore
> and common memory, using a shared counter to hold the transmit =
sequence number.
>=20
> If you actually don't care for buffering, the other way is to use the =
message
> passing API (i.e. rt_task_send, rt_task_receive, rt_task_reply) to get
> synchronous messaging. In that case, the sender would be able to wait =
for the
> receiver to get the status from the serial link. The receiver would =
send that
> answer back to the initiator using rt_task_reply.
> This needs XENO_OPT_NATIVE_MPS to be switched on in the kernel config.
>=20


--=20
Philippe.


------_=_NextPart_001_01C8B06D.3D3F14CA
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
this is great information and advice and it helps me better frame the =
architecture for my system.<BR>
<BR>
What I've made work so far is to use rt_task_send from the navigation =
sensor to trigger the control law loop synchronously.&nbsp; Essentially, =
the control loop will block to synchronize on successful receipt of data =
from the navigation sensor. At some point I will consider making it =
asynchronous and use rt_queues if I add in more sensors. I then will =
send an rt_task_send to synchronously control the servo controller =
task.&nbsp; The rt_queues seem to be doing an excellent job of reliably =
sending data to the disk logging tasks.&nbsp; The logging tasks are rt =
tasks but they are running in very low priority mode with a large queue =
buffer-- is there any reason to switch from using queues for data =
logging to RT Pipes if this is working?&nbsp; i.e. should the logging =
rt_tasks become non-realtime logging pthreads instead and use pipes?<BR>
<BR>
The document you referenced is very good information in terms of =
determining what type of messaging service to use.<BR>
<BR>
Regarding the rt_task_send/receive bug, I'm doing the objdump now and =
will post code to replicate the problem shortly.<BR>
<BR>
Thank you for all your help with this,<BR>
<BR>
Josh<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Philippe Gerum on behalf of Philippe Gerum<BR>
Sent: Wed 5/7/2008 1:11 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue =
overruns<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt; Phillipe,<BR>
&gt;<BR>
&gt; Here's my setup in short.<BR>
&gt;<BR>
&gt; I have a two-serial port setup where I read at 50 Hz from a sensor =
task (a navigation sensor) and I send queue messages from that sensor =
task to log data or CRC/byte errors to two separate log files using =
lower priority logging tasks.&nbsp; Concurrently, the 50 Hz serial =
sensor task feeds state data in the form of a struct of mixed types =
(floats, ints) to a control law loop that runs at 50Hz (potentially =
asynchronously).&nbsp; That control loop processes the data if available =
and sends a command at 50 Hz to the second serial device discussed =
yesterday (a motor controller) running on another task. The motor =
controller takes in a fixed command packet and responds with a fixed =
packet usually without delay. If no data is received by the motor =
controller, it will not send data.&nbsp; If the motor controller doesn't =
receive data from the control task within 100 msec, the device requires =
a separate reset packet in order to resume responding to input =
commands.&nbsp; At that point, I want a timeout to<BR>
<BR>
occur on rt_serial read so that the task will send the appropriate reset =
packet. That timeout caused the queue to overrun yesterday when I tested =
that function.&nbsp; When everything is working perfectly, there should =
be no timeouts throughout the system.<BR>
&gt;<BR>
&gt; So essentially, my question is this--<BR>
&gt;<BR>
&gt; Should I use the queue for all data-logging tasks and use =
semaphores or rt_task send/receive for the two paths from the navigation =
sensor to the control loop and from the control loop to the motor =
controller?<BR>
&gt;<BR>
<BR>
>From my understanding of your design, you should probably use:<BR>
<BR>
- message pipes (RT_PIPE) between the sensor task (RT side) to the =
regular<BR>
logging tasks (non RT side). The rationale here is that your logging =
tasks will<BR>
have to run most of their active time in secondary (i.e. plain Linux) =
mode to<BR>
write the data to disk files, not in real-time mode. If those tasks =
still need<BR>
to synchronize at some point with the real-time side, such as waiting =
for an<BR>
event or a semaphore posted from there, make those tasks non-RT shadows, =
passing<BR>
a zero priority for them when calling rt_task_create(), rt_task_spawn() =
or<BR>
rt_task_shadow() - whatever you happen to use to create those Xenomai =
tasks.<BR>
<BR>
- a real-time queue (RT_QUEUE) between the sensor and the control loop =
tasks,<BR>
because of the real-time and asynchronous nature of that data path.<BR>
<BR>
- message passing calls (rt_task_send/receive/reply) between the control =
loop<BR>
and the motor controller, since the real-time protocol they share seems =
purely<BR>
synchronous.<BR>
<BR>
By using a timeout of 100ms in rt_task_receive(), the motor controller =
should be<BR>
able to wakeup then abort the serial read of the sensor task by =
issuing<BR>
rt_task_unblock() (at least, this would be the case if you were reading =
bytes<BR>
through RTDM's rt_dev_read() call). If rt_dev_read() returns -EINTR, =
then your<BR>
sensor should send a reset to the device. Any blocking call (except<BR>
rt_task_suspend()) - from the native API may be aborted using =
rt_task_unblock(),<BR>
and will return -EINTR in that case.<BR>
<BR>
PS: in case it is not done already, you may want to have a look at this =
document:<BR>
<A =
HREF=3D"http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-A=
PI-Tour-rev-C.pdf">http://www.xenomai.org/documentation/branches/v2.3.x/p=
df/Native-API-Tour-rev-C.pdf</A><BR>
<BR>
&gt; Thank you,<BR>
&gt;<BR>
&gt; Joshua Karch<BR>
&gt;<BR>
&gt;<BR>
&gt; -----Original Message-----<BR>
&gt; From: Philippe Gerum on behalf of Philippe Gerum<BR>
&gt; Sent: Tue 5/6/2008 3:46 AM<BR>
&gt; To: Karch, Joshua<BR>
&gt; Cc: xenomai@xenomai.org<BR>
&gt; Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue =
overruns<BR>
&gt;&nbsp;<BR>
&gt; Karch, Joshua wrote:<BR>
&gt;&gt; Hello,<BR>
&gt;&gt;<BR>
&gt;&gt; I have tasks that normally run at 50 Hz dealing with serial =
ports.&nbsp;&nbsp;&nbsp; I<BR>
&gt;&gt; have a command task which sends queue messages to a receive =
task that<BR>
&gt;&gt; communicates with the serial port. The receive task waits =
indefinitely<BR>
&gt;&gt; for a message over rt_queue (with TM_INFINITE) and then =
proceeds to<BR>
&gt;&gt; write to the serial port, then reads a response from the RT =
serial<BR>
&gt;&gt; port.&nbsp; Occasionally, the device on the receiving end of =
the port takes<BR>
&gt;&gt; longer than the expected 20 msec,( 50Hz response) as I've set =
the RTSER<BR>
&gt;&gt; CONFIG struct to look for a 100 msec timeout.&nbsp; As a =
result, the number<BR>
&gt;&gt; of queued messages quickly build up.&nbsp; After that, I run =
out of<BR>
&gt;&gt; allocation space with rt_queue_alloc.<BR>
&gt;&gt;<BR>
&gt;&gt; Is there some way to check to make sure I am receiving the most =
current<BR>
&gt;&gt; message, and if not, flush all of the queued up messages =
with<BR>
&gt;&gt; rt_queue_free so I can send the latest data to the serial port =
and not<BR>
&gt;&gt; encounter message &quot;buffer&quot; overruns? With the =
exception of datalogging<BR>
&gt;&gt; to disk, I'm very interested in getting to the most current =
message in a<BR>
&gt;&gt; timely manner.<BR>
&gt;<BR>
&gt; Maybe a queue is not the right tool to use in your case, you don't =
seem to<BR>
&gt; really need message buffering. From your description, I would =
rather think of<BR>
&gt; some kind of &quot;blackboard&quot; abstraction, something that =
holds a single data with a<BR>
&gt; validity stamp (time-based or not) for instance. There is no such =
object<BR>
&gt; available in the native API, but this could be easily built out of =
a semaphore<BR>
&gt; and common memory, using a shared counter to hold the transmit =
sequence number.<BR>
&gt;<BR>
&gt; If you actually don't care for buffering, the other way is to use =
the message<BR>
&gt; passing API (i.e. rt_task_send, rt_task_receive, rt_task_reply) to =
get<BR>
&gt; synchronous messaging. In that case, the sender would be able to =
wait for the<BR>
&gt; receiver to get the status from the serial link. The receiver would =
send that<BR>
&gt; answer back to the initiator using rt_task_reply.<BR>
&gt; This needs XENO_OPT_NATIVE_MPS to be switched on in the kernel =
config.<BR>
&gt;<BR>
<BR>
<BR>
--<BR>
Philippe.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8B06D.3D3F14CA--

