Message-ID: <49B6684F.5050204@domain.hid>
Date: Tue, 10 Mar 2009 14:17:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49B3A126.6000602@domain.hid>
	<49B53AC3.10707@domain.hid>	<49B54780.6040504@domain.hid>
	<49B54D2C.5080001@domain.hid>	<49B55175.2070205@domain.hid>
	<49B55407.9000700@domain.hid> <49B558DF.7050109@domain.hid>
	<49B64A7F.4030809@domain.hid>
In-Reply-To: <49B64A7F.4030809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Watchdog / immediate Linux signal delivery
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Meanwhile I played with some light-weight approach to relax a thread
>>>>>> that received a signal (according to do_sigwake_event). Worked, but only
>>>>>> once due to a limitation (if not bug) of I-pipe x86: in __ipipe_run_isr,
>>>>>> it does not handle the case that a non-root handler may alter the
>>>>>> current domain, causing corruptions to the IPIPE_SYNC_FLAG states of the
>>>>>> involved domains.
>>>>> It is not a bug, this is wanted. ISR must neither change the current
>>>>> domain nor migrate CPU; allowing this would open Pandora's box.
>>>> And if there is no way to migrate from within an ISR, we can bury any
>>>> attempt to deliver signals to spinning Xenomai threads - or what other
>>>> context would remain to Xenomai for triggering migration?
>>>>
>>> The two-phase solution I have mentioned would work.
>> Something like:
>>
>> Index: ksrc/nucleus/sched.c
>> ===================================================================
>> --- ksrc/nucleus/sched.c        (revision 4678)
>> +++ ksrc/nucleus/sched.c        (working copy)
>> @@ -75,7 +75,13 @@ static void xnsched_watchdog_handler(str
>>                            thread, xnthread_name(thread));
>>                 xnprintf("watchdog triggered -- killing runaway thread
>> '%s'\n",
>>                          xnthread_name(thread));
>> -               xnpod_delete_thread(thread);
>> +#ifdef CONFIG_XENO_OPT_PERVASIVE
>> +               if (xnthread_user_task(thread)) {
>> +                       xnpod_suspend_thread(thread);
>> +                       xnshadow_send_sig(thread, SIGSEGV, 0, 1);
>> +               } else
>> +#endif /* CONFIG_XENO_OPT_PERVASIVE */
>> +                       xnpod_delete_thread(thread);
>>                 xnsched_reset_watchdog(sched);
>>         }
>>  }
> 
> Looks good - but we first have to establish that famous relax-on-pending
> signal thing...

Yes, obviously, it does not work, in other words...

-- 
                                                 Gilles.

