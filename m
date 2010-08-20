Message-ID: <4C6E8BFE.5090306@domain.hid>
Date: Fri, 20 Aug 2010 16:06:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C0692A9.2080806@domain.hid>	
	<1276080083.18906.52.camel@domain.hid>	
	<4C234A15.2030708@domain.hid> <4C6E75E6.5000408@domain.hid>
	<1282312845.1730.606.camel@domain.hid>
In-Reply-To: <1282312845.1730.606.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Mayday support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

Philippe Gerum wrote:
> On Fri, 2010-08-20 at 14:32 +0200, Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> I've toyed a bit to find a generic approach for the nucleus to regain
>>>> complete control over a userland application running in a syscall-less
>>>> loop.
>>>>
>>>> The original issue was about recovering gracefully from a runaway
>>>> situation detected by the nucleus watchdog, where a thread would spin in
>>>> primary mode without issuing any syscall, but this would also apply for
>>>> real-time signals pending for such a thread. Currently, Xenomai rt
>>>> signals cannot preempt syscall-less code running in primary mode either.
>>>>
>>>> The major difference between the previous approaches we discussed about
>>>> and this one, is the fact that we now force the runaway thread to run a
>>>> piece of valid code that calls into the nucleus. We do not force the
>>>> thread to run faulty code or at a faulty address anymore. Therefore, we
>>>> can reuse this feature to improve the rt signal management, without
>>>> having to forge yet-another signal stack frame for this.
>>>>
>>>> The code introduced only fixes the watchdog related issue, but also does
>>>> some groundwork for enhancing the rt signal support later. The
>>>> implementation details can be found here:
>>>> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=4cf21a2ae58354819da6475ae869b96c2defda0c
>>>>
>>>> The current mayday support is only available for powerpc and x86 for
>>>> now, more will come in the next days. To have it enabled, you have to
>>>> upgrade your I-pipe patch to 2.6.32.15-2.7-00 or 2.6.34-2.7-00 for x86,
>>>> 2.6.33.5-2.10-01 or 2.6.34-2.10-00 for powerpc. That feature relies on a
>>>> new interface available from those latest patches.
>>>>
>>>> The current implementation does not break the 2.5.x ABI on purpose, so
>>>> we could merge it into the stable branch.
>>>>
>>>> We definitely need user feedback on this. Typically, does arming the
>>>> nucleus watchdog with that patch support in, properly recovers from your
>>>> favorite "get me out of here" situation? TIA,
>>>>
>>>> You can pull this stuff from
>>>> git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.
>>>>
>>> I've retested the feature as it's now in master, and it has one
>>> remaining problem: If you run the cpu hog under gdb control and try to
>>> break out of the while(1) loop, this doesn't work before the watchdog
>>> expired - of course. But if you send the break before the expiry (or hit
>>> a breakpoint), something goes wrong. The Xenomai task continues to spin,
>>> and there is no chance to kill its process (only gdb).
>>>
>>> # cat /proc/xenomai/sched
>>> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>>>   0  0      idle    -1      -         master     RR         ROOT/0
> 
> Eeek, we really need to have a look at this funky STAT output.

I've a patch for this queued as well. Was only a cosmetic thing.

> 
>>>   1  0      idle    -1      -         master     R          ROOT/1
>>>   0  6120   rt      99      -         master     Tt         cpu-hog
>>> # cat /proc/xenomai/stat
>>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>>   0  0      0          0          0     00500088    0.0  ROOT/0
>>>   1  0      0          0          0     00500080   99.7  ROOT/1
>>>   0  6120   0          1          0     00342180  100.0  cpu-hog
>>>   0  0      0          21005      0     00000000    0.0  IRQ3340: [timer]
>>>   1  0      0          35887      0     00000000    0.3  IRQ3340: [timer]
>>>
>> Fixable by this tiny change:
>>
>> diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
>> index 5242d9f..04a344e 100644
>> --- a/ksrc/nucleus/sched.c
>> +++ b/ksrc/nucleus/sched.c
>> @@ -175,7 +175,8 @@ void xnsched_init(struct xnsched *sched, int cpu)
>>  			     xnthread_name(&sched->rootcb));
>>  
>>  #ifdef CONFIG_XENO_OPT_WATCHDOG
>> -	xntimer_init(&sched->wdtimer, &nktbase, xnsched_watchdog_handler);
>> +	xntimer_init_noblock(&sched->wdtimer, &nktbase,
>> +			     xnsched_watchdog_handler);
>>  	xntimer_set_name(&sched->wdtimer, "[watchdog]");
>>  	xntimer_set_priority(&sched->wdtimer, XNTIMER_LOPRIO);
>>  	xntimer_set_sched(&sched->wdtimer, sched);
>>
>>
>> I.e. the watchdog timer should not be stopped by any ongoing debug
>> session of a Xenomai app. Will queue this for upstream.
> 
> Yes, that makes a lot of sense now. The watchdog would not fire if the
> task was single-stepped anyway, since the latter would have been moved
> to secondary mode first.

Yep.

> 
> Did you see this bug happening in a uniprocessor context as well?

No, as it is impossible on a uniprocessor to interact with gdb if a cpu
hog - the only existing CPU is simply not available. :)

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

