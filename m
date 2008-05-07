Message-ID: <4821E2D0.4040608@domain.hid>
Date: Wed, 07 May 2008 19:11:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F73@domain.hid>
	<48200CD1.1060809@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F78@domain.hid>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F78@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue overruns
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

Karch, Joshua wrote:
> Phillipe,
> 
> Here's my setup in short.
> 
> I have a two-serial port setup where I read at 50 Hz from a sensor task (a navigation sensor) and I send queue messages from that sensor task to log data or CRC/byte errors to two separate log files using lower priority logging tasks.  Concurrently, the 50 Hz serial sensor task feeds state data in the form of a struct of mixed types (floats, ints) to a control law loop that runs at 50Hz (potentially asynchronously).  That control loop processes the data if available and sends a command at 50 Hz to the second serial device discussed yesterday (a motor controller) running on another task. The motor controller takes in a fixed command packet and responds with a fixed packet usually without delay. If no data is received by the motor controller, it will not send data.  If the motor controller doesn't receive data from the control task within 100 msec, the device requires a separate reset packet in order to resume responding to input commands.  At that point, I want a timeout to 
occur on rt_serial read so that the task will send the appropriate reset packet. That timeout caused the queue to overrun yesterday when I tested that function.  When everything is working perfectly, there should be no timeouts throughout the system. 
> 
> So essentially, my question is this--
> 
> Should I use the queue for all data-logging tasks and use semaphores or rt_task send/receive for the two paths from the navigation sensor to the control loop and from the control loop to the motor controller?
>

>From my understanding of your design, you should probably use:

- message pipes (RT_PIPE) between the sensor task (RT side) to the regular
logging tasks (non RT side). The rationale here is that your logging tasks will
have to run most of their active time in secondary (i.e. plain Linux) mode to
write the data to disk files, not in real-time mode. If those tasks still need
to synchronize at some point with the real-time side, such as waiting for an
event or a semaphore posted from there, make those tasks non-RT shadows, passing
a zero priority for them when calling rt_task_create(), rt_task_spawn() or
rt_task_shadow() - whatever you happen to use to create those Xenomai tasks.

- a real-time queue (RT_QUEUE) between the sensor and the control loop tasks,
because of the real-time and asynchronous nature of that data path.

- message passing calls (rt_task_send/receive/reply) between the control loop
and the motor controller, since the real-time protocol they share seems purely
synchronous.

By using a timeout of 100ms in rt_task_receive(), the motor controller should be
able to wakeup then abort the serial read of the sensor task by issuing
rt_task_unblock() (at least, this would be the case if you were reading bytes
through RTDM's rt_dev_read() call). If rt_dev_read() returns -EINTR, then your
sensor should send a reset to the device. Any blocking call (except
rt_task_suspend()) - from the native API may be aborted using rt_task_unblock(),
and will return -EINTR in that case.

PS: in case it is not done already, you may want to have a look at this document:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf

> Thank you,
> 
> Joshua Karch
> 
> 
> -----Original Message-----
> From: Philippe Gerum on behalf of Philippe Gerum
> Sent: Tue 5/6/2008 3:46 AM
> To: Karch, Joshua
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_queue_alloc and ways to manage queue overruns
>  
> Karch, Joshua wrote:
>> Hello,
>>
>> I have tasks that normally run at 50 Hz dealing with serial ports.    I
>> have a command task which sends queue messages to a receive task that
>> communicates with the serial port. The receive task waits indefinitely
>> for a message over rt_queue (with TM_INFINITE) and then proceeds to
>> write to the serial port, then reads a response from the RT serial
>> port.  Occasionally, the device on the receiving end of the port takes
>> longer than the expected 20 msec,( 50Hz response) as I've set the RTSER
>> CONFIG struct to look for a 100 msec timeout.  As a result, the number
>> of queued messages quickly build up.  After that, I run out of
>> allocation space with rt_queue_alloc.
>>
>> Is there some way to check to make sure I am receiving the most current
>> message, and if not, flush all of the queued up messages with
>> rt_queue_free so I can send the latest data to the serial port and not
>> encounter message "buffer" overruns? With the exception of datalogging
>> to disk, I'm very interested in getting to the most current message in a
>> timely manner.
> 
> Maybe a queue is not the right tool to use in your case, you don't seem to
> really need message buffering. From your description, I would rather think of
> some kind of "blackboard" abstraction, something that holds a single data with a
> validity stamp (time-based or not) for instance. There is no such object
> available in the native API, but this could be easily built out of a semaphore
> and common memory, using a shared counter to hold the transmit sequence number.
> 
> If you actually don't care for buffering, the other way is to use the message
> passing API (i.e. rt_task_send, rt_task_receive, rt_task_reply) to get
> synchronous messaging. In that case, the sender would be able to wait for the
> receiver to get the status from the serial link. The receiver would send that
> answer back to the initiator using rt_task_reply.
> This needs XENO_OPT_NATIVE_MPS to be switched on in the kernel config.
> 


-- 
Philippe.

