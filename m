From: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Date: Thu, 9 Aug 2007 16:27:25 +0200
Message-ID: <000b01c7da91$684d54c0$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <2ff1a98a0708090651k39f895c6ncefbd3fd3eabd18d@domain.hid>
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters
	ofthreads in other processes
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

>>>> Thanks for this immediate answer. I just read some parts of the
posix
>>>> specification, and if I'm not mistaking posix message queues do not
>>>> inherit thread priorities.
>>>
>>>My idea was that you could encode the request in a message that you
>>>would handle in the receiving process by receiving messages and
>>>calling pthread_setschedparam.
>>
>> That was also one of my first ideas. But it won't be
real-time-capable.
>> When a high-priority sender thread sends a message (using posix
message
>> queues) to a low-priority receiver thread and blocks right after the
>
>I do not understand why you need pthread_setschedparam to happen with
>a high priority, but anyway In the process that will receive the
>messages, there will be a thread whose only job will be to receive
>messages from the message queue. Why not giving this particular thread
>the highest priority available ?

That was also one of my next ideas. This has two significant
disadvantages. The first is that in such a case the receiver would
always be scheduled after reception of a message. When having more than
one thread running at the same priority of the sender, the scheduling
policy, round robin or fifo, would get disordered, because the receiver
thread would get scheduled for a very short time (until
pthread_setschedparam() is called). The second disadvantage would be
that the use of a time out (mq_timedreceive()) would lead also lead to
undesired system behavior. If mq_timedreceive() is called periodically
with a time out value of a very few ms for example, than it would
interrupt other threads, which actually have a higher priority, i.e. it
would lead to priority inversion for very short times (from the
reception of a message/time out till the call of
pthread_setschedparam()). Due to the effect of much more context
switches, this would also lead to a worse overall system performance.

In general, I agree, this might be a solution for the problem, but I'm
afraid that the resulting system behavior is not strictly deterministic,
because a low priority receiver thread might slow down high-priority
threads.

>
>> I guess this is a general problem of the posix specification. As fare
as
>> I know, there is no way to change the priority of a thread running in
>> another process. You would need something like SchedSet() from the
>> QNX-OS. Here you can specify a process ID and a thread ID in order to
>> change the thread's scheduling parameters.
>
>The problem I see is, how in one process, do you know the thread ID of
>a threa d belonging to another process. If you solve this issue in
>your application, then  the message queue solution can work.
>
I do this with shared memory. How are message queues implemented in the
posix skin? I had a look into the code (file ksrc/skins/posix/mq.c) and
there I could not find the part for thread priority inheritance (not
message priority). As I said, regarding the posix specs, posix message
queues do not apply priority inheritance, because a receiver thread
would get the priority of the sender for all the time, and there is not
necessarily a point, where the receiver would be set back to its base
priority.

As consequence, I'd guess, that message queues won't work here.


Kind regards and thanks for this - I think very nice - conversation,
Torsten


