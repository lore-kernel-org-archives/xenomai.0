Date: Wed, 21 Feb 2007 13:14:44 +0100 (CET)
From: Nicholas Mc Guire <der.herr@domain.hid>
Subject: Re: [Adeos-main] latency results for ppc and x86
In-Reply-To: <45DC3B13.5090200@domain.hid>
Message-ID: <Pine.LNX.4.60.0702211302290.2780@domain.hid>
References: <725115.56324.qm@domain.hid>
	<Pine.LNX.4.60.0702211019590.2291@domain.hid>
	<45DC23D4.5090000@domain.hid>
	<Pine.LNX.4.60.0702211116020.2526@domain.hid>
	<45DC3B13.5090200@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, Nicholas Mc Guire <der.herr@domain.hid>, Wolfgang Grandegger <wg@domain.hid>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>> the unlikey part to a distant location (some lable at the end of the
>> file...) but that does not change the rpoblem at runtime with respect to
>> the worst case. The BTB uses a hysteresis of one miss/hit to adjust the
>> guess on P6 systems with the default (if the address is not present in
>> the BTB) of not taken - thus if you reorder for the "not taken" case
>> being the fast patch you will always have the fast path preloaded in
>> the pipeline.
>>
>> if(likley(condition)){
>>    fast_patch();
>> else
>>    slow_path();
>>
>> will be fast on average but the worst case is that the address is not
>> in the BTB so the slow_patch() tag is loaded by default.
>
> Ah, got the idea. How much arch/processor-type-dependent is this
> optimisation? It would surely makes no sense to optimise for arch X in
> generic code.
>

thats the problem it is very x86 centric - p6 and AMD Duron/K7.

>>
>>> You forget that old stuff was kernel-only, lacking a lot of Linux
>>> integration features. Recent I-pipe-based real-time via Xenomai normally
>>> includes support for user-space RT (you can switch it off, but hardly
>>> anyone does). So its not a useful comparison given that new real-time
>>> projects almost always want full-featured user space these days. For a
>>> fairer comparison, one should consider a simple I-pipe domain that
>>> contains the real-time "application".
>>
>>
>> note that the numbers posted here WERE kernel numbers !
>
> But with user space support enabled. There are no separate code paths
> for kernel and user space threads, basic infrastructure is shared here
> for good reasons.
>
>> I know that people want to move to user-space - but what is the advantage
>> over RT-preempt then if you use the dynamic tick patch (scheduled to go
>> mainline in 2.6.21 BTW) ?
>
> So far, determinism (both /wrt mainline and latest -rt).
>
> BTW, kernel space real time is specifically no longer recommendable for
> commercial projects that have to worry about the (likely non-GPL)
> license of their application code. And then there are those countless
> technical advantages that speed up the development process of user space
> apps.
>

well I don't see that advantage at this point - determinism seems to be
in the same range as you get on ADEOS based systems. That there is a
move towards user-space is clear.

>>
>>>> my suspicion is that there is too much work being done on fast-hot CPUs
>>>> and the low-end is being neglected - which is bad as the numbers you
>>>> post here for ADEOS are numbers reachable with mainstream preemptive
>>>> kernel by now as well (off course not on the low end systems though).
>>
>>> That's scenario-dependent. Simple setups like a plain timed task can
>>> reach the dimension of I-pipe-based Xenomai, but more complex scenarios
>>> suffer from the exploding complexity in mainstream Linux, even with -rt.
>>> Just think of "simple" mutexes realised via futexes.
>>
>>
>> do you have some code samples with numbers ? I would be very interested in
>> a demo that shows this problem - I was not able to really find a smoking
>> gun with RT-preempt and dynamic ticks (2.6.17.2).
>
> I can't help with demo code, but I can name a few conceptual issues:
>
> o Futexes may require to allocate memory when suspending on a contented
>   lock (refill_pi_state_cache)
> o Futexes depend on mmap_sem

ok - thats a nice one

> o Preemptible RCU read-sides can either lead to OOM or require
>   intrusive read-side priority boosting (see Paul McKenney's LWN
>   article)
> o Excessive lock nesting depths in critical code paths makes it hard to
>   predict worst-case behaviour (or to verify that measurements actually
>   already triggered them)

well thats true for ADEOS/RTAI/RTLinux as well - we are also only 
black-box testing the RT-kernel - there currently is absolutley NO
prof for worst-case timing in any of the flavours of RT-Linux.

> o Any nanosleep&friends-using Linux process can schedule hrtimers at
>   arbitrary dates, requiring to have a pretty close look at the
>   (worst-case) timer usage pattern of the _whole_ system, not only the
>   SCHED_FIFO/RR part

true - but resource overload hits all flavours - and the splitt of
timers and timeouts in 2.6.18++ does reduce the risk clearly.

>
> That's what I can tell from the heart. But one would have to analyse the
> code more thoroughly I guess.
>
thanks for the imput - at the embedded world Thomas Gleixner 
demonstrated a simple control system that could sustain sub 10us
scheduling jitter under load based on the latest rt-preempt + a bit
of tuning I guess (actually don't know). The essence for me is that with 
the work in 2.6.X I don't see the big performance jump provided by teh
hard-RT variants around - especially with respect to guaranteed worst
case (and not only "black-box" results).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFF3De1nU7rXZKfY2oRAnjkAJ9jsT6PAhwlY6Wu8a3wddTjHbcWZQCgn6cZ
8Ve6WL2E+QuENP9ezT0I3HU=
=hSbF
-----END PGP SIGNATURE-----

