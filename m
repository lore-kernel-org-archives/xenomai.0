Message-ID: <48898A23.9030308@domain.hid>
Date: Fri, 25 Jul 2008 10:09:07 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0137F8FD@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0137F8FD@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Thread policy and priority in secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
>>>> __real_pthread_setschedparam(). Note: this will propagate the 
>>>> priority to the underlying Xenomai thread as well.
>>>>
>>> Does this mean that the Xenomai thread will run with the new (Linux)
>>> priority when it returns to primary mode ?
>> Yes. However, the propagation only occurs when the skin and Linux have
>> compatible priority scales, which is the case with the POSIX skin.
>>
>>> And the other way round :
>>> when a posix thread switches to secondary mode (without using
>>> __real_pthread_setschedparam), does it run in Linux with 
>> the priority
>>> set in Xenomai (with pthread_setschedparam)?
>> Yes.
>>
>>> Or better : what is the Linux-prority when a Xenomai thread 
>> (posix or or
>>> any other Xenomai thread)switches to secondaary mode ?
>>>
>> It depends on the skin. When the priority scales are 
>> compatible (i.e. a given
>> priority level exists in both and scales are both upwarding, 
>> like POSIX skin <->
>> Linux, and native skin <-> Linux), you get the same priority 
>> level in both
>> modes, and changing the priority from one mode affects the 
>> other mode as well.
>>
>> When they are not compatible, the skin-based priority is 
>> "normalized" and
>> applied to the Linux side when needed (e.g. when VxWorks 
>> taskPrioritySet() is
>> invoked), but __real_pthread_setschedparam does not trigger 
>> the converse
>> propagation (since 2.4.4 actually, because experience showed 
>> that propagating in
>> that case made little sense, and would beget weird 
>> behaviours). The way priority
>> levels are normalized depends on the skin.
>>
> 
> Do you know how a Linux priority, set with pthread_setschedparam
> (real_pthread_setschedparam),
> correlates with the priorities shown by "ps l". In our case we realized
> that ps does not show the priority set with pthread_setschedparam. Is
> there a command which shows the "real" priority ?

With 2.6 you can list the priority with:

# ps -meo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm

But it's normally not available with the busybox ps command. Then you 
can look into /proc/<id>/stat directly. Here is the kernel's printk 
statement:

  http://lxr.linux.no/linux/fs/proc/array.c#L472

Unfortunately, this will not work for 2.4 either. The only simple way I 
see is to write a little program using sched_getscheduler() to read the 
RT priority and policy for the specified pid.

Wolfgang.

