Message-ID: <483D172B.1070604@domain.hid>
Date: Wed, 28 May 2008 10:26:19 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <000501c8c06c$adb72100$2201a8c0@domain.hid>
In-Reply-To: <000501c8c06c$adb72100$2201a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Urs.Eichholzer wrote:
> Hi all,
>  
> We have some general questions
>  
> Our setup is:
> Hardware MPC5200B on Microsys MPX5200
> Linux version: 2.6.19
> Adeos Patch: Compatible with this Linux
> Xenomai version: 2.3.0
>  
> 1.) Is the RT CAN socket deterministic?

It was wrote with this goal and it uses the service of a real-time 
operating system. So *if* RT-Socket CAN weren't deterministic it would 
be a bug that had to be fixed.

> If I send immediately after
> knowing the code is in 4 mS gap interval, how long does the rt socket
> send this to the connected device from the time I command rt_dev_send to
> the real seding in the Xenomai?

You have to distinguish two cases:
1. The CAN hardware is immediately ready to accept the message that an 
application wants to send. In this case the registers of the hardware 
are filled appropriately and the hardware is instructed to send the CAN 
message. Without waiting for completion of writing the message to the 
CAN bus the rt_dev_send function returns.

2. If the CAN hardware is in the process of sending an message and 
another rt_dev_send call is executed for the same CAN bus rt_dev_send 
blocks as long as the hardware reports that is is ready to accept a new 
message.

> Will the Xenomai RT-CAN socket sending
> be interrupted by another task or resource?

rt_dev_send is executed in the context of the calling task. If it blocks 
(e.g. case 2 above) or if another task with a higer priority wants to 
run the rt_dev_send routine is interrupted.

> 2.) Are all task application in Xenomai interruptable (or blockable) by
> another task or resource irregardless of priority?

Your question covers a bunch of problems ... Generally, Xenomai tasks 
are interruptible. Of course, tasks with higher priorities can interrupt 
tasks with lower ones. All tasks can block on according synchronisation 
objects or during certain system calls. Additionally, real-time 
interrupt handler are executed regardless of any tasks.

> If this happens....
> What is the most time delay it will consume to switch back to my
> rt-application task if it is blocked? Lets say I am sending CAN and at
> the same time 4 more rt-application are running...

There is no general answer for this question. It depends on the 
priorities of the tasks and their work. It is also important what you 
mean with "blocked" e.g. blocked on a Xenomai resource or interrupted by 
the Xenomai scheduler due to a task with a higer priority which is able 
to run.

>  
> 3.) Is the highest priority application task can also be blocked by
> another process or resource?

First, it can block itself e.g. with rt_mutex_acquire if the mutex is 
hold by another task. If you want to block the task from another running 
"context" and it has the highest priority then it is only possible when 
this task is already blocked or interrupted e.g. by an real-time 
interrupt handler.

> Will this task yield to another task or
> resource if it will be needed? For how long this task switching will
> occur so that my application takes control again?

Again, this depends on many things.

> 4.) Where is rt_timer_read gets its timer value? Is this a predetermined
> resolution set in the Xenomai-OS? Is there any relationship of this
> timer value in real system pulse?

As the documentation states (for 2.3) rt_timer_read returns the time 
either in nanoseconds or in local CPU ticks. The conversion between them 
can be done with rt_timer_ticks2ns() and rt_timer_ns2ticks(). I don't 
know the timer source of your special board but I can imagine that a 
dedicated hardware timer is used for this.

> 5.) Is there a way that I can send directly to the RT socket buffer so
> that the xenomai can directly send the message without going to the
> rt_dev_send on the opened socket? Or is this way impossible and the only
> way to send in real-time is through RT CAN socket?

Why do you want to do this? This is really a bad idea. And for this 
reason there is no provided way.

> 6.)  Is an rt application which runs in a periodic task mode will really
> executed in periodic intervals? What if the end of the code is not yet
> reached and the periodic interval is triggered? Will the task just
> continues or will it resign?
> And then what will happen? Is the periodic
> interval will not resign its code when the interval and the code running
> overlapped? Will the application code be blocked or will still remain in
> running state?

If you use the rt_task_wait_period() function all answers can be find in 
the API documentation:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__task.html#g1645d3a072ef3cefeed3bcbb27dcf108

>  
> 7.)  Is there a general protection for a running code that it will be
> unblockable for all task and resource for certain lines to be executed?
> It is like I will enter to a critical code section and after sending my
> CAN message will leave the critical section so that my application will
> be able to send immediately and will not be blocked....

Normally, user applications should not need to block the whole system in 
  such a way i.e. including other tasks and interrupts. A critical 
section usually is critical in respect of data shared between several 
tasks. For this case there are synchronisation methods like mutexes and 
semaphores. A careful designed application structure including the 
allocation of task priorities is also important.

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

So you only want to get CAN messages when an application is in the 
process of executing rt_dev_recv? Can you control that when the task is 
between two rt_dev_recv calls no message will arrive? You can't. 
Therefore the driver receives all messages and copies them to those 
sockets which have an interest in them. You can set a filter for each 
socket which messages are to be received with rt_dev_setsockopt. Please 
see the CAN device profile for more details:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtcan.html

Probably you didn't set any filter in your application which means that 
your sockets receive all messages. Without any rt_dev_recv call it is 
clear that your socket buffer will be full eventually.

-- 
Sebastian

