Message-ID: <4DFCAAEA.7010007@domain.hid>
Date: Sat, 18 Jun 2011 15:40:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>
	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>
	<4DFBA305.9000303@domain.hid> <4DFC7C0E.1090700@domain.hid>
	<4DFC9575.1030904@domain.hid> <4DFC95B7.8070703@domain.hid>
	<4DFCA09B.20609@domain.hid> <4DFCA323.6030704@domain.hid>
	<4DFCA432.3070203@domain.hid> <4DFCA54B.1040405@domain.hid>
In-Reply-To: <4DFCA54B.1040405@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/18/2011 03:16 PM, Jan Kiszka wrote:
> On 2011-06-18 15:12, Gilles Chanteperdrix wrote:
>> On 06/18/2011 03:07 PM, Jan Kiszka wrote:
>>> On 2011-06-18 14:56, Gilles Chanteperdrix wrote:
>>>>
>>>> Maybe in the irq handlers, we should skip the XNHTICK replay, when
>>>> current_domain is root_domain.
>>>>
>>>
>>> That would be against the purpose of the XNTICK replay (it only targets
>>> that particular case). And it would still leave us with broken ipipe due
>>> to enabled IRQs on return from the Xenomai handlers.
>>
>> What I mean is that xnintr_clock_handler, we should skip the XNHTICK
>> replay when the current domain upon return from xnpod_schedule is not
>> root. From what I understand, this case only happens when xnpod_schedule
>> migrated the thread, and in that case, the tick will have been forwarded
>> during xnpod_schedule anyway.
> 
> In the problematic case, ie. when the XNHTICK replay uses an invalid
> sched, the current domain is root. It must be root because only then the
> context could have been migrated to a different CPU by Linux. So this
> does not help to avoid having to reload sched.

I mean replace:
	if (testbits(sched->lflags, XNHTICK) &&
	    xnthread_test_state(sched->curr, XNROOT))
		xnintr_host_tick(sched);

with
	if (!xnarch_root_domain_p() &&
	    testbits(sched->lflags, XNHTICK) &&
	    xnthread_test_state(sched->curr, XNROOT))
	    xnintr_host_tick(sched);

-- 
                                                                Gilles.

