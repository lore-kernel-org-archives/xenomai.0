Message-ID: <48AE8481.40905@domain.hid>
Date: Fri, 22 Aug 2008 11:18:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48ADC134.7060605@domain.hid>
	<48ADC224.9030409@domain.hid>	<48ADC3B0.4080204@domain.hid>
	<48ADC493.7000009@domain.hid> <48ADC7C4.8040902@domain.hid>
In-Reply-To: <48ADC7C4.8040902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fast userspace locks for native skin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
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
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Hi Gilles,
>>>>>
>>>>> do you - or anyone else - happen to have some patches under preparation
>>>>> to extend also the native skin with the newly added CONFIG_XENO_FASTSEM
>>>>> support? Just to avoid duplicate work (we are about to work on this).
>>>> Not yet. But the fastsem work is largely unfinished in other areas: for
>>>> instance, semaphores are not implemented yet.
>>> neither is x86_64 support, which is a shame...
>>>
>> Uhh, that's bad. But I guess we are just lacking the required atomic ops
>> here, aren't we?
> 
> Yes. And with a little luck, these will probably be a cut-n-past of the
> x86_32. At the time I started doing this, I had no access to an x86_64,
> and since I have an x86_64 at hand, I had no time to implement it.

OK, will look into this.

> 
>> What about pthread_cond_*?
> 
> Well, nothing can be gained for pthread_cond_wait since it will suspend,
> so needs a call to kernel.

That's true.

> pthread_cond_signal needs a scheduler
> decision (we could store the first pending thread priority in a
> user/kernel shared area, with the complication that we would need
> updating this priority if it ever changes, but to get the priority of
> the current thread, we also need a syscall, moreover switching to
> secondary mode).

I'm not thinking about the case where there is already someone waiting.
That will need a kernel entry anyway (the low-prio waiter may sit on
some other CPU...). But in case signaling always happens before pending,
there is no need at all to consult the kernel.

> 
>> And do we have test cases for the support in the posix skin? Or did
>> anyone look at the stuff LTP is doing for realtime testing? I guess that
>> should be reusable (hmm, with some search&replace also for native...).
> 
> I have a small test, attached to this mail. It does not test XNROBBED.
> About LTP, a long time ago, I started running the open posix testsuite
> with Xenomai, the recurring problem I had was that this testsuite
> assumes that the SCHED_OTHER policy means time sharing, so uses the CPU
> in endless loops. Needless to say that it systematically caused lockups
> with Xenomai (we had not SCHED_OTHER support in Xenomai at that time).

Thanks, we will look into this as well, hopefully with the result that
we can add some more regression or even performance tests to xeno-test
e.g. ...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

