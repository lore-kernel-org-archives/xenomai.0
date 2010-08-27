Message-ID: <4C77FB05.4090301@domain.hid>
Date: Fri, 27 Aug 2010 19:51:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C7783C9.5090501@domain.hid> <4C7788A5.2020307@domain.hid>
	<4C77B054.8080609@domain.hid> <4C77B208.5090802@domain.hid>
	<4C77F142.4030103@domain.hid> <4C77F5EF.3010701@domain.hid>
	<4C77F65E.5000208@domain.hid>
In-Reply-To: <4C77F65E.5000208@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] False positive XENO_BUGON(NUCLEUS,
 need_resched == 0)?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm hitting that bug check in __xnpod_schedule after
>>>>>>> xnintr_clock_handler issued a xnpod_schedule like this:
>>>>>>>
>>>>>>> 	if (--sched->inesting == 0) {
>>>>>>> 		__clrbits(sched->status, XNINIRQ);
>>>>>>> 		xnpod_schedule();
>>>>>>> 	}
>>>>>>>
>>>>>>> Either the assumption behind the bug check is no longer correct (no call
>>>>>>> to xnpod_schedule() without a real need), or we should check for
>>>>>>> __xnpod_test_resched(sched) in xnintr_clock_handler (but under nklock then).
>>>>>>>
>>>>>>> Comments?
>>>>>> You probably have a real bug. This BUG_ON means that the scheduler is
>>>>>> about to switch context for real, whereas the resched bit is not set,
>>>>>> which is wrong.
>>>>> This happened over my 2.6.35 port - maybe some spurious IRQ enabling.
>>>>> Debugging further...
>>>> You should look for something which changes the scheduler state without
>>>> setting the resched bit, or for something which clears the bit without
>>>> taking the scheduler changes into account.
>>> It looks like a generic Xenomai issue on SMP boxes, though a mostly
>>> harmless one:
>>>
>>> The task that was scheduled in without XNRESCHED set locally has been
>>> woken up by a remote CPU. The waker requeued the task and set the
>>> resched condition for itself and in the resched proxy mask for the
>>> remote CPU. But there is at least one place in the Xenomai code where we
>>> drop the nklock between xnsched_set_resched and xnpod_schedule:
>>> do_taskexit_event (I bet there are even more). Now the resched target
>>> CPU runs into a timer handler, issues xnpod_schedule unconditionally,
>>> and happens to find the woken-up task before it is actually informed via
>>> an IPI.
>>>
>>> I think this is a harmless race, but it ruins the debug assertion
>>> "need_resched != 0".
>> Not that harmless, since without the debugging code, we would miss the
>> reschedule too...
> 
> Ok. But we would finally reschedule when handling the IPI. So, the
> effect we see is a useless delay in the rescheduling.
> 

Depends on the POV: The interrupt or context switch between set_resched
and xnpod_reschedule that may defer rescheduling may also hit us before
we were able to wake up the thread at all. The worst case should not
differ significantly.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

