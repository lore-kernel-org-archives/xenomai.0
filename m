From: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Date: Thu, 9 Aug 2007 15:32:05 +0200
Message-ID: <000a01c7da89$ada93230$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <2ff1a98a0708090614u3b223ff4n196f0d5ed2a5db41@domain.hid>
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

>>>> this is my first email to this list, and I would like to start with
a
>>>> question. I use the posix skin of Xenomai 2.3.1, and I have several
>>>> processes running, each consisting of several threads. Is there a
>>>> possibility for a thread A1 running in process A to change the
>>>> scheduling parameters, in particular the priority, of a thread B1
>>>> running in process B?
>>>>
>>>> Regarding the posix specification I cannot find this functionality
>>>> there
>>>> and so I guess there is no way doing it with
>>>> "pthread_setschedparam()".
>>>> But is there another possibility?
>>>
>>>No, the only way you could do that is by using an IPC to pass the
>>>request from a process to another. You could use message queues for
>>>that.
>>>
>>
>> Thanks for this immediate answer. I just read some parts of the posix
>> specification, and if I'm not mistaking posix message queues do not
>> inherit thread priorities.
>
>My idea was that you could encode the request in a message that you
>would handle in the receiving process by receiving messages and
>calling pthread_setschedparam.

That was also one of my first ideas. But it won't be real-time-capable.
When a high-priority sender thread sends a message (using posix message
queues) to a low-priority receiver thread and blocks right after the
mq_send() call, then receiver thread should (immediately) get inherit
the high priority of the sender thread. But if there is any other
middle-priority thread in the ready queue, the scheduler would prefer
the middle-priority one instead of the receiver thread, which remains at
its low priority until it becomes scheduled. As result, we would have
the problem of priority inversion again, because the low-priority
receiver is supposed to work for the high-priority sender, i.e. it
should work with high priority.

So this won't work, I'd say.
 
>But then another problem arises: a pthread_t identifier is only valid
>in one process, so how could you designate in one process the threads
>of another process ?
>

I guess this is a general problem of the posix specification. As fare as
I know, there is no way to change the priority of a thread running in
another process. You would need something like SchedSet() from the
QNX-OS. Here you can specify a process ID and a thread ID in order to
change the thread's scheduling parameters.


Best regards and thanks for your _fast_ help again,
Torsten


