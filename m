Date: Wed, 21 Feb 2007 16:10:49 +0100 (CET)
From: Nicholas Mc Guire <der.herr@domain.hid>
Subject: Re: [Adeos-main] latency results for ppc and x86
In-Reply-To: <45DC5CAC.8020901@domain.hid>
Message-ID: <Pine.LNX.4.60.0702211552170.3327@domain.hid>
References: <725115.56324.qm@domain.hid>
	<Pine.LNX.4.60.0702211019590.2291@domain.hid>
	<45DC23D4.5090000@domain.hid>
	<Pine.LNX.4.60.0702211116020.2526@domain.hid>
	<45DC3B13.5090200@domain.hid>
	<Pine.LNX.4.60.0702211302290.2780@domain.hid>
	<45DC4E6A.6090708@domain.hid> <45DC5CAC.8020901@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Nicholas Mc Guire <der.herr@domain.hid>, adeos-main@gna.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> 
>>>>> do you have some code samples with numbers ? I would be very
>>>>> interested in
>>>>> a demo that shows this problem - I was not able to really find a 
>>>>> smoking
>>>>> gun with RT-preempt and dynamic ticks (2.6.17.2).
>>>> I can't help with demo code, but I can name a few conceptual issues:
>>>> o Futexes may require to allocate memory when suspending on a 
>>>> contented
>>>>   lock (refill_pi_state_cache)
>>>> o Futexes depend on mmap_sem
>>> ok - thats a nice one
>>> 
>>>> o Preemptible RCU read-sides can either lead to OOM or require
>>>>   intrusive read-side priority boosting (see Paul McKenney's LWN
>>>>   article)
>>>> o Excessive lock nesting depths in critical code paths makes it hard 
>>>> to
>>>>   predict worst-case behaviour (or to verify that measurements 
>>>> actually
>>>>   already triggered them)
>>> well thats true for ADEOS/RTAI/RTLinux as well - we are also only
>>> black-box testing the RT-kernel - there currently is absolutley NO
>>> prof for worst-case timing in any of the flavours of RT-Linux.
>> 
>> Nope, it isn't. There are neither sleeping not spinning lock nesting
>> depths of that kind in Xenomai or Adeos/I-pipe (or older RT extensions,
>> AFAIK) - ok, except for one spot in a driver we have scheduled for
>> re-design already.

that might be so - never the less there is no formal-proof that the worst
case of ADEOS/I-pipe is X-microseconds, the latency/jitter numbers are
based on black-box testing. In fact one problem is that there are not even
code-coverage tools (or I just did not find them) that can provide 
coverage data for ADEOS - thus how can one guarantee worst-case ?

>> 
>>>> o Any nanosleep&friends-using Linux process can schedule hrtimers at
>>>>   arbitrary dates, requiring to have a pretty close look at the
>>>>   (worst-case) timer usage pattern of the _whole_ system, not only the
>>>>   SCHED_FIFO/RR part
>>> true - but resource overload hits all flavours - and the splitt of
>>> timers and timeouts in 2.6.18++ does reduce the risk clearly.
>> 
>> Compared to making all Linux timers hrtimers? Yes, for sure. But that
>> would be an insane idea anyway, just considering all the network-related
>> timers.

well they were all on one timer wheel not too long ago - and yes - it was
insane ;)

>> 
>>>> That's what I can tell from the heart. But one would have to analyse 
>>>> the
>>>> code more thoroughly I guess.
>>> thanks for the imput - at the embedded world Thomas Gleixner
>>> demonstrated a simple control system that could sustain sub 10us
>>> scheduling jitter under load based on the latest rt-preempt + a bit
>>> of tuning I guess (actually don't know).
>> 
>> Without knowing the test (Wolfgang, did you see it?), I would guess the
>> setup as follows: dual-core GHz Pentium, isolated core for the timed
>> task, no peripheral interaction, no synchronisation means, likely even
>> no further syscalls except for the sleep service. Surely a progress over
>> plain Linux, but that one's only useful for very specific scenarios.
>
> No, I have not seen it. But I believe, that with careful hardware selection 
> it's possible to achieve that. On high-end systems the latency is dominate by 
> hardware. On low-end systems code size matters. So far I have not seen any 
> serious comparison for low-end Linux systems and -rt does not work yet on 
> PowerPC (the high-res support is still missing).

I did some on low end X86 (ELAN SC520 133MHz) the results are not going to
make many happy at this point (2.6.14-rt9 was my last test), but I have 
still to run benchmarks with dynamic tick and some of the tglx patches on 
low end X86. The fact that again all archs except X86 are laging behind is 
off course a key issue at this point.

>
>> No one claims -rt is not useful or too limited. Each approach has its
>> preferred application domain. Knowing strength and weaknesses of both is
>> required here. And providing the user the choice (like Xenomai 3 will).
>> 
>>> The essence for me is that with
>>> the work in 2.6.X I don't see the big performance jump provided by teh
>>> hard-RT variants around - especially with respect to guaranteed worst
>>> case (and not only "black-box" results).
>> 
>> Could it be a bit too enthusiastic to base such an assessment on a
>> corner-case demonstration?

its not a corener case demonstration, Ive been doing benchmarks on rt
preempt now for quite some time, there is still an advantage if you run
simple comparisons (jitter measurements) - but it is clearly going down,
The problem I have with RT-preempt being 50us and ADEOS is 15us is simply 
that the sector that does need those numbers that RT-preempt will most likely
never reach is generally interested in guaranteed times, and thats where
it becomes tough to argue any of the hard-realtime extensions at this 
point - that is not saying RT-preempt can replace ADEOS/RTAI/RTLinux-gpl
Im just saying that the numbers are no longer 2/3 orders of 
magnitude,which they were in 2.2.X/2.4.X and where arguing the use was
simple.

Don't get me wrong Im not trying to argue away ADEOS/RTAI or I would have 
given up RTLinux/GPL quite some time ago - but I belive if these 
low-jitter/latency systems want to keep there acceptance in industry a key 
issue will be to improve the tools for verification/validation - just take 
this discussion - it started out with:

<snip>
> RTD|      -1.585|       7.556|      16.275|       0|
>    -1.585|      16.275

Latencies are mainly due to cache refills on the P4. Have you already
put load onto your system? If not, worst case latencies will be even 
longer.

<snip>

  THAT is a problem in arguing for ADEOS/I-pipe - WHAT is the worst case 
now ? what is the cause of the worst case ? and can I really demonstrate 
by strong evidence that the worst case on this system is actually XXXX 
microseconds under arbitrary load and will not be higher in some strange 
corner cases ?

hofrat
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFF3GD9nU7rXZKfY2oRAptQAJ4iwYoaJtfTds9am4Gwxl6xSNqR1gCfcAMC
7p9PWIJ8a6mOErrMFGQ4MbI=
=QTjQ
-----END PGP SIGNATURE-----

