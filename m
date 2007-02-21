Date: Wed, 21 Feb 2007 11:26:39 +0100 (CET)
From: Nicholas Mc Guire <der.herr@domain.hid>
Subject: Re: [Adeos-main] latency results for ppc and x86
In-Reply-To: <45DC23D4.5090000@domain.hid>
Message-ID: <Pine.LNX.4.60.0702211116020.2526@domain.hid>
References: <725115.56324.qm@domain.hid>
	<Pine.LNX.4.60.0702211019590.2291@domain.hid>
	<45DC23D4.5090000@domain.hid>
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

>>> Latencies are mainly due to cache refills on the P4. Have you already
>>> put load onto your system? If not, worst case latencies will be even
>>> longer.
>>
>>
>> one posibility we found in RTLinux/GPL to reduce latency is to free up
>> TLBs by flushing a few of the TLB hot spots, basically these flushpoints
>> are something like:
>>
>> __asm__ __volatile__("invlpg %0": :"m"
>> (*(char*)__builtin_return_address(0)));
>>
>> put at places where we know we don't need thos lines any more (i.e.
>> after switching tasks or the like). By inserting only a few such
>> flushpoints in
>> hot code on the kernel side we found a clear reduction of the worst case
>> jitter and interrupt response times.
>
> Interesting. Are these flushpoints present in latest kernel patches of
> RTLinux/GPL? Sounds like a nice thing to play with on a rainy day. :)
>

yup - basically if you look at the latest patches (2.4.33-rtl3.2) you
will find them in the kernel code. Or in the rtlinux core code 
(rtl_core.c and rtl_sched.c). The concept is off course not 
restricted to 2.4.X kernels note thought that some archs (notably MIPS)
have a problem with __builtin_return_address.


>>
>> Aside from caches, BTB exhaustion in high load situations is also a
>> problem that has not been addressed much in the realtime variants - with
>> the P6 families having a botched BTB prediction unit, one can use some
>> "strange" constructions to reduce branch penalties - i.e.:
>>
>>   if(!condition){slow_path();}
>>   else{fast_path();}
>>
>> if more predictalbe than
>>
>>   if(codition){fast_path();}
>>   else{slow_path();}
>
> I think this is also what likely()/unlikely() teaches to the the
> compiler on x86 (where there is no branch prediction predicate for the
> instructions), isn't it?
>

no not really - likely/unlikely give hints during compilation to relocate
the unlikey part to a distant location (some lable at the end of the 
file...) but that does not change the rpoblem at runtime with respect to
the worst case. The BTB uses a hysteresis of one miss/hit to adjust the
guess on P6 systems with the default (if the address is not present in
the BTB) of not taken - thus if you reorder for the "not taken" case
being the fast patch you will always have the fast path preloaded in
the pipeline.

if(likley(condition)){
    fast_patch();
else
    slow_path();

will be fast on average but the worst case is that the address is not
in the BTB so the slow_patch() tag is loaded by default.

There is a paper on this (a bit messy) published at RTLWS7 (Lile) 2005
if you are interested in the details.

>>
>> as in the first case the branch prediction is static, thus the worst case
>> is that you are jumping over a few bytes of object code when the condition
>> is not met. in the second case the default if the BTB does not yet know
>> this branch is to guess not-taken and thus load the jump target of the
>> slow patch with the overhead of TLB/Cache penalties.
>>
>> Regarding the PPC numbers, the surprising thing for me is that the same
>> archs are doing MUCH better with old RTAI/RTLinux versions, i.e. 2.4.4
>> kernel on a 50MHz MPC860 shows a worst case of 57us - so I do question
>> what is going wrong here in the 2.6.X branches of hard-realtime Linux -
>
> You forget that old stuff was kernel-only, lacking a lot of Linux
> integration features. Recent I-pipe-based real-time via Xenomai normally
> includes support for user-space RT (you can switch it off, but hardly
> anyone does). So its not a useful comparison given that new real-time
> projects almost always want full-featured user space these days. For a
> fairer comparison, one should consider a simple I-pipe domain that
> contains the real-time "application".
>

note that the numbers posted here WERE kernel numbers !
I know that people want to move to user-space - but what is the advantage
over RT-preempt then if you use the dynamic tick patch (scheduled to go
mainline in 2.6.21 BTW) ?

>> my suspicion is that there is too much work being done on fast-hot CPUs
>> and the low-end is being neglected - which is bad as the numbers you
>> post here for ADEOS are numbers reachable with mainstream preemptive
>> kernel by now as well (off course not on the low end systems though).
>
> That's scenario-dependent. Simple setups like a plain timed task can
> reach the dimension of I-pipe-based Xenomai, but more complex scenarios
> suffer from the exploding complexity in mainstream Linux, even with -rt.
> Just think of "simple" mutexes realised via futexes.
>

do you have some code samples with numbers ? I would be very interested in
a demo that shows this problem - I was not able to really find a smoking
gun with RT-preempt and dynamic ticks (2.6.17.2).

hofrat
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFF3B5hnU7rXZKfY2oRAmrGAJwN6SK3pGLMBcxSa2MT9HGQv0q4+wCfZVuq
Yxaynkg4Bitl0uMlFug6Yak=
=5xzd
-----END PGP SIGNATURE-----

