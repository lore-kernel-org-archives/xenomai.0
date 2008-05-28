Message-ID: <483D1BB7.808@domain.hid>
Date: Wed, 28 May 2008 10:45:43 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <000501c8c06c$adb72100$2201a8c0@domain.hid>
In-Reply-To: <000501c8c06c$adb72100$2201a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] General questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Urs.Eichholzer" <urs.eichholzer@domain.hid>
Cc: xenomai@xenomai.org

Hi Urs,

Urs.Eichholzer wrote:
> Hi all,
> 
>  
> 
> We have some general questions
> 
>  
> 
> Our setup is:
> 
> Hardware MPC5200B on Microsys MPX5200
> 
> Linux version: 2.6.19
> 
> Adeos Patch: Compatible with this Linux
> 
> Xenomai version: 2.3.0

You should definitely update to 2.3.5 to benefit from bug fixes
accumulated over 1.5 years.

> 1.) Is the RT CAN socket deterministic? If I send immediately after
> knowing the code is in 4 mS gap interval, how long does the rt socket
> send this to the connected device from the time I command rt_dev_send to
> the real seding in the Xenomai? Will the Xenomai RT-CAN socket sending
> be interrupted by another task or resource?

RT-Socket-CAN is a real-time capable, deterministic CAN protocol stack.
The sending task might be interrupted by a higher priority task or an
interrupt handler. If more than one task is sending CAN messages to the
same device, the send call might block if a send is in progress, because
out-going messages are not queued for the sake of latency. How long the
sending tasks blocks depends on other task running at higher priority.

> 2.) Are all task application in Xenomai interruptable (or blockable) by
> another task or resource irregardless of priority? If this happens....

A task might be interrupted by a higher priority task or an interrupt
handler. Interrupt and exception handling is always handled first and
therefore the ISR should be small, which is usually the case.

> What is the most time delay it will consume to switch back to my
> rt-application task if it is blocked? Lets say I am sending CAN and at
> the same time 4 more rt-application are running...

As said, it depends on the task running at higher priority. The pure
context switch is in the order of tenth of micro-seconds for your
processor, I would guess.

> 3.) Is the highest priority application task can also be blocked by
> another process or resource? Will this task yield to another task or
> resource if it will be needed? For how long this task switching will
> occur so that my application takes control again?

The highest priority task can only be interrupted by interrupt handling,
which usually does not take that long. I would guess less than 10..20
micro-seconds.

> 4.) Where is rt_timer_read gets its timer value? Is this a predetermined
> resolution set in the Xenomai-OS? Is there any relationship of this
> timer value in real system pulse? 

The timer implementation is hardware dependent. On your system, a
one-shot timer based on the PowerPC decrementer is used. It runs at a
defined frequency. See also:
http://www.go-ecs.com/ppc/ppctek1.htm#DTB



> 5.) Is there a way that I can send directly to the RT socket buffer so
> that the xenomai can directly send the message without going to the
> rt_dev_send on the opened socket? Or is this way impossible and the only
> way to send in real-time is through RT CAN socket?

You could access the CAN hardware directly but you need an RTDM driver
to do it from user space. But I do not see a need to do that?
RT-Socket-CAN should do what you need, I think.

> 6.)  Is an rt application which runs in a periodic task mode will really
> executed in periodic intervals? What if the end of the code is not yet
> reached and the periodic interval is triggered? Will the task just
> continues or will it resign? And then what will happen? Is the periodic
> interval will not resign its code when the interval and the code running
> overlapped? Will the application code be blocked or will still remain in
> running state?

If the task overruns the period, it wakes up as soon as the wait
function is called. For further information see:

http://www.xenomai.org/documentation/trunk/html/api/index.html

> 7.)  Is there a general protection for a running code that it will be
> unblockable for all task and resource for certain lines to be executed?

Yes, e.g.:

http://www.xenomai.org/documentation/trunk/html/api/index.html

But disabling interrupts globally in user space is not possible.

> It is like I will enter to a critical code section and after sending my
> CAN message will leave the critical section so that my application will
> be able to send immediately and will not be blocked....

You do not need that to send out CAN messages. The task priority should
be enough.

> 8.) Why is it that the RT socket CAN of xenomai is still collecting the
> incoming frames of an opened socket handle even if it is not requesting
> for a read? If the socket will not read, the buffer is becoming full and
> will trigger the message buffer full (message discarded). Isn't it that
> the xenomai should throw away this frame and free the buffer since the
> default timeout will be triggered? The buffer is still being used until
> the message overflows when the socket will not read instead of handling
> the timeout... It is like as if the CAN device handler will pass the
> received CAN message to ALL referenced opened handle eveif it is not
> requesting to read the message. Isn't it that if a timeout is already
> defined, it should throw away and clear the buffer instead of
> continously buffering the "unwanted" frames of the opened socket handle?

If you bind a socket it will receive incoming messages and queue them in
a buffer by default, which might overrun if there is no task reading
them out. If you do not want to receive messages on a socket, either use
sendto without binding the socket as shown here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/rtcansend.c#089

or disable reception of messages on a bound socket as shown here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/rtcansend.c#252

The debug message can be disabled by unsetting the kernel configuration
option CONFIG_XENO_DRIVERS_CAN_DEBUG:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/Kconfig#009

Then the buffer overflows will silently be ignored. A counter RX_BufFull
is always incremented, which can be listed with "# cat
/proc/rtcan/sockets" as shown here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/README#117

> My question might be related or not related to my problem. But I need at
> least some of the answers so I can use effectively use the Xenomai task
> and have the scheduling in real-time that is accurate to the needed
> specification of the project I needed. Please give some recommendation
> and comments on things what we might use to address the need of our
> real-time project application...

What is your real problem? You seem to loose determinism somehow. This
can happen, when a real-time task blocks on a standard Linux system call
like write, read, printf, etc. Then the task switches to secondary mode
and determinism is lost. You can trigger a signal when that happens as
shown here:

http://www.xenomai.org/documentation/trunk/html/api/sigxcpu_8c-example.html

Concerning latencies. For a similar system I have measure a max. latency
of 120 us to acknowledge an external interrupt in a Xenomai user space
application. See also:

http://www.denx.de/wiki/DULG/AN2008_03_Xenomai_gpioirqbench

Wolfgang.


