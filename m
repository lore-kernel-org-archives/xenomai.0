From: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Date: Thu, 9 Aug 2007 20:37:09 +0200
Message-ID: <000c01c7dab4$4be648a0$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1186669123.17314.53.camel@domain.hid>
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
	threads in other processes
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

>>
>> Regarding send/receive/reply messaging with the native API, I am not
>> sure if I detected a mistake in the implementation (file
>> ksrc/skins/native/task.c). When a sender RT_TASK sends a message to a
>> receiver RT_TASK, then the priority is only inherited, if the
receiver's
>> priority is lower than the one of the sender. For my understanding,
the
>> priority should be inherited in any case.
>>
>> >From the reception of a message till the call of rt_task_reply() the
>> receiver RT_TASK works for the sender and should get its priority.
>> Otherwise we would have a priority inversion at this point, because
any
>> RT_TASK with a priority between the sender and receiver priority
would
>> now be blocked by the receiver (which works for the lower prioritized
>> sender at its old priority).
>>
>
>You are supposed to pick the right base priority for the server in the
>first place so this case never arises. Any other behaviour than the
>strict priority inheritance protocol would be broken by design because
a
>server might sleep while processing a request and requests might pile
up

I totally agree at first glance. When regarding the concepts based on
the work of Sha, Rajkumar, and Lehoczky ("Priority Inheritance
Protocols: An Approach to Real-Time Synchronization", IEEE Transactions
on Computers, Vol. 39, No. 9, 1990) you are generally right (I guess,
because I'm no expert). But in the particular case of "Synchronous
Message Passing" (send/receive/reply-messaging), I think the "QNX-way"
would make much more sense regarding real-time capabilities: Receivers
(servers) always inherit the priority of the senders (client), no matter
if the receiver's priority is lower or higher than the sender one's. A
description can be found here:

http://www.qnx.com/developers/docs/momentics621_docs/neutrino/sys_arch/k
ernel.html#NTOIPC

The major advantage is that priority inversion problems are completely
avoided here. As also described in the text above, are two rules, which
have to be observed:

1. You are not allowed to have two threads sending each other.
2. Threads must be arranged in a hierarchy, where send calls only go up.

When using the Xenomai native send/receive/reply calls, the system is
not real-time capable in general. The user always has to care for the
whole system, which really gets sophisticated in systems with a huge
number of threads/processes.

>(try with two senders having different priorities, highest priority
>first, and server entering a blocked state in the middle of its
>processing for the first request).

Regarding this example, I cannot see the problem. We won't have a
deadlock in both cases. Xenomai send/receive/reply messaging would work,
but here priority inversion might happen, if there is any other with a
priority between the sender with the low priority and the basis priority
of the receiver. 'Common' Synchronous Message Passing would work exactly
the same way. If the receiver thread blocks during the processing of the
first message from the high-priority sender thread, the second
low-priority thread might be scheduled and could send the second
message. But in this second case, the receiver remains in the high
priority until it calls the reply-function. When it then receives the
second message, the receiver inherits the low priority of the second
sender thread. But in this case, priority inversion problems cannot
arise.

Please let me know, if I'm mistaking. I'm not really a specialist in
this field. All I have experienced is that the basic flow chart of
send/receive/reply-messaging looks really simple - but its robust
real-time capable implementation is quite sophisticated.

Actually my aim is to develop 'common' real-time capable Synchronous
Message Passing for the posix skin of Xenomai, but right know my
conclusion is the following: its realization is not possible, except
_all_ threads are part of one and only one process. But this seems
really not to be practical and hence I'm looking for other solutions.
 
Any comments on this are really appreciated again.


Best regards from Braunschweig,
Torsten 


