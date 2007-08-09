From: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Date: Thu, 9 Aug 2007 15:06:41 +0200
Message-ID: <000901c7da86$2171afc0$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <18106.60807.692746.230882@domain.hid>
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

>> this is my first email to this list, and I would like to start with a
>> question. I use the posix skin of Xenomai 2.3.1, and I have several
>> processes running, each consisting of several threads. Is there a
>> possibility for a thread A1 running in process A to change the
>> scheduling parameters, in particular the priority, of a thread B1
>> running in process B?
>>
>> Regarding the posix specification I cannot find this functionality
there
>> and so I guess there is no way doing it with
"pthread_setschedparam()".
>> But is there another possibility?
>
>No, the only way you could do that is by using an IPC to pass the
>request from a process to another. You could use message queues for
>that.
>

Thanks for this immediate answer. I just read some parts of the posix
specification, and if I'm not mistaking posix message queues do not
inherit thread priorities. They only sort messages in (message-)priority
order. I guess you mean synchronous message passing provided by
rt_task_send(), rt_task_receive(), and rt_task_reply() in the native
API. This would of course be an alternative. But therefore I would have
to port many code to the native API. Would then be possible to let one
RT_TASK change the prioriy of any other RT_TASK by simply calling
rt_task_set_priority()? 

Regarding send/receive/reply messaging with the native API, I am not
sure if I detected a mistake in the implementation (file
ksrc/skins/native/task.c). When a sender RT_TASK sends a message to a
receiver RT_TASK, then the priority is only inherited, if the receiver's
priority is lower than the one of the sender. For my understanding, the
priority should be inherited in any case.

>From the reception of a message till the call of rt_task_reply() the
receiver RT_TASK works for the sender and should get its priority.
Otherwise we would have a priority inversion at this point, because any
RT_TASK with a priority between the sender and receiver priority would
now be blocked by the receiver (which works for the lower prioritized
sender at its old priority).


Many many thanks in advance for your help,
Torsten


