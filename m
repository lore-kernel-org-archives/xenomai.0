Message-ID: <4C77B208.5090802@domain.hid>
Date: Fri, 27 Aug 2010 14:39:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C7783C9.5090501@domain.hid> <4C7788A5.2020307@domain.hid>
	<4C77B054.8080609@domain.hid>
In-Reply-To: <4C77B054.8080609@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Hi,
>>>
>>> I'm hitting that bug check in __xnpod_schedule after
>>> xnintr_clock_handler issued a xnpod_schedule like this:
>>>
>>> 	if (--sched->inesting == 0) {
>>> 		__clrbits(sched->status, XNINIRQ);
>>> 		xnpod_schedule();
>>> 	}
>>>
>>> Either the assumption behind the bug check is no longer correct (no call
>>> to xnpod_schedule() without a real need), or we should check for
>>> __xnpod_test_resched(sched) in xnintr_clock_handler (but under nklock then).
>>>
>>> Comments?
>> You probably have a real bug. This BUG_ON means that the scheduler is
>> about to switch context for real, whereas the resched bit is not set,
>> which is wrong.
> 
> This happened over my 2.6.35 port - maybe some spurious IRQ enabling.
> Debugging further...

You should look for something which changes the scheduler state without
setting the resched bit, or for something which clears the bit without
taking the scheduler changes into account.

-- 
					    Gilles.

