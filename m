Message-ID: <4545C416.6030001@domain.hid>
Date: Mon, 30 Oct 2006 10:21:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] InterProcessCommunication between Xenomai
	taskand	Linux process
References: <5D63919D95F87E4D9D34FF7748CE2C2A5FFB1C@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A5FFB1C@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
>>Roderik_Wildenburg@domain.hid wrote:
>>
>>>Is there a standard way for communication between nativ Linux 
>>>processes and Xenomai task which ensures that the Xenomai task does 
>>>not lose its raltime capability (e.g. can I use Xenomai 
>>
>>(Posix)-queues 
>>
>>>within Linux processes ?).
>>>I just need a hint, where I can read about it.
>>
>>Xenomai POSIX messages queues can only be used by Xenomai 
>>tasks, but Xenomai tasks do not switch to secondary mode when 
>>using POSIX messages queues. Note that when using the POSIX 
>>skin, all tasks are Xenomai tasks, the SCHED_OTHER policy 
>>being reserved to non-realtime task.
> 
> 
> How do I use "POSIX messages queues" and not "Xenomai POSIX messages
> queues" within a Xenomai task. Do I have to use the real_-prefix (e.g.
> real_mq_open()) ?

Yes, but if you use the regular POSIX messages queues, Xenomai tasks
will switch to secondary mode.

I insist: the best option if you want to use the POSIX skin, is to
make your non real-time side of the queue a Xenomai task using the
SCHED_OTHER policy.

> Can a Xenomai-task-queues and a Linux-process-queues use the same queue
> name (Linux: mq_open("queuename",..) and Xeno:
> real_mq_open("queuename",....) (or can I even use
> mq_open("queuename,.)in Xenomai)) ?

You can use the same name, but you will get two different unrelated
objects.

-- 
                                                  Gilles Chanteperdrix

