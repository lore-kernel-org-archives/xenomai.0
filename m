Message-ID: <45DC3B13.5090200@domain.hid>
Date: Wed, 21 Feb 2007 13:29:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] latency results for ppc and x86
References: <725115.56324.qm@domain.hid>
	<Pine.LNX.4.60.0702211019590.2291@domain.hid>
	<45DC23D4.5090000@domain.hid>
	<Pine.LNX.4.60.0702211116020.2526@domain.hid>
In-Reply-To: <Pine.LNX.4.60.0702211116020.2526@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9FBC9E3CC376384F26BE5176"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Nicholas Mc Guire <der.herr@domain.hid>
Cc: adeos-main@gna.org, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9FBC9E3CC376384F26BE5176
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicholas Mc Guire wrote:
>>>> Latencies are mainly due to cache refills on the P4. Have you alread=
y
>>>> put load onto your system? If not, worst case latencies will be even=

>>>> longer.
>>>
>>>
>>> one posibility we found in RTLinux/GPL to reduce latency is to free u=
p
>>> TLBs by flushing a few of the TLB hot spots, basically these flushpoi=
nts
>>> are something like:
>>>
>>> __asm__ __volatile__("invlpg %0": :"m"
>>> (*(char*)__builtin_return_address(0)));
>>>
>>> put at places where we know we don't need thos lines any more (i.e.
>>> after switching tasks or the like). By inserting only a few such
>>> flushpoints in
>>> hot code on the kernel side we found a clear reduction of the worst c=
ase
>>> jitter and interrupt response times.
>=20
>> Interesting. Are these flushpoints present in latest kernel patches of=

>> RTLinux/GPL? Sounds like a nice thing to play with on a rainy day. :)
>=20
>=20
> yup - basically if you look at the latest patches (2.4.33-rtl3.2) you
> will find them in the kernel code. Or in the rtlinux core code
> (rtl_core.c and rtl_sched.c). The concept is off course not restricted
> to 2.4.X kernels note thought that some archs (notably MIPS)
> have a problem with __builtin_return_address.

OK, thanks.

>=20
>=20
>>>
>>> Aside from caches, BTB exhaustion in high load situations is also a
>>> problem that has not been addressed much in the realtime variants - w=
ith
>>> the P6 families having a botched BTB prediction unit, one can use som=
e
>>> "strange" constructions to reduce branch penalties - i.e.:
>>>
>>>   if(!condition){slow_path();}
>>>   else{fast_path();}
>>>
>>> if more predictalbe than
>>>
>>>   if(codition){fast_path();}
>>>   else{slow_path();}
>=20
>> I think this is also what likely()/unlikely() teaches to the the
>> compiler on x86 (where there is no branch prediction predicate for the=

>> instructions), isn't it?
>=20
>=20
> no not really - likely/unlikely give hints during compilation to reloca=
te
> the unlikey part to a distant location (some lable at the end of the
> file...) but that does not change the rpoblem at runtime with respect t=
o
> the worst case. The BTB uses a hysteresis of one miss/hit to adjust the=

> guess on P6 systems with the default (if the address is not present in
> the BTB) of not taken - thus if you reorder for the "not taken" case
> being the fast patch you will always have the fast path preloaded in
> the pipeline.
>=20
> if(likley(condition)){
>    fast_patch();
> else
>    slow_path();
>=20
> will be fast on average but the worst case is that the address is not
> in the BTB so the slow_patch() tag is loaded by default.

Ah, got the idea. How much arch/processor-type-dependent is this
optimisation? It would surely makes no sense to optimise for arch X in
generic code.

>=20
> There is a paper on this (a bit messy) published at RTLWS7 (Lile) 2005
> if you are interested in the details.
>=20
>>>
>>> as in the first case the branch prediction is static, thus the worst
>>> case
>>> is that you are jumping over a few bytes of object code when the
>>> condition
>>> is not met. in the second case the default if the BTB does not yet kn=
ow
>>> this branch is to guess not-taken and thus load the jump target of th=
e
>>> slow patch with the overhead of TLB/Cache penalties.
>>>
>>> Regarding the PPC numbers, the surprising thing for me is that the sa=
me
>>> archs are doing MUCH better with old RTAI/RTLinux versions, i.e. 2.4.=
4
>>> kernel on a 50MHz MPC860 shows a worst case of 57us - so I do questio=
n
>>> what is going wrong here in the 2.6.X branches of hard-realtime Linux=
 -
>=20
>> You forget that old stuff was kernel-only, lacking a lot of Linux
>> integration features. Recent I-pipe-based real-time via Xenomai normal=
ly
>> includes support for user-space RT (you can switch it off, but hardly
>> anyone does). So its not a useful comparison given that new real-time
>> projects almost always want full-featured user space these days. For a=

>> fairer comparison, one should consider a simple I-pipe domain that
>> contains the real-time "application".
>=20
>=20
> note that the numbers posted here WERE kernel numbers !

But with user space support enabled. There are no separate code paths
for kernel and user space threads, basic infrastructure is shared here
for good reasons.

> I know that people want to move to user-space - but what is the advanta=
ge
> over RT-preempt then if you use the dynamic tick patch (scheduled to go=

> mainline in 2.6.21 BTW) ?

So far, determinism (both /wrt mainline and latest -rt).

BTW, kernel space real time is specifically no longer recommendable for
commercial projects that have to worry about the (likely non-GPL)
license of their application code. And then there are those countless
technical advantages that speed up the development process of user space
apps.

>=20
>>> my suspicion is that there is too much work being done on fast-hot CP=
Us
>>> and the low-end is being neglected - which is bad as the numbers you
>>> post here for ADEOS are numbers reachable with mainstream preemptive
>>> kernel by now as well (off course not on the low end systems though).=

>=20
>> That's scenario-dependent. Simple setups like a plain timed task can
>> reach the dimension of I-pipe-based Xenomai, but more complex scenario=
s
>> suffer from the exploding complexity in mainstream Linux, even with -r=
t.
>> Just think of "simple" mutexes realised via futexes.
>=20
>=20
> do you have some code samples with numbers ? I would be very interested=
 in
> a demo that shows this problem - I was not able to really find a smokin=
g
> gun with RT-preempt and dynamic ticks (2.6.17.2).

I can't help with demo code, but I can name a few conceptual issues:

 o Futexes may require to allocate memory when suspending on a contented
   lock (refill_pi_state_cache)
 o Futexes depend on mmap_sem
 o Preemptible RCU read-sides can either lead to OOM or require
   intrusive read-side priority boosting (see Paul McKenney's LWN
   article)
 o Excessive lock nesting depths in critical code paths makes it hard to
   predict worst-case behaviour (or to verify that measurements actually
   already triggered them)
 o Any nanosleep&friends-using Linux process can schedule hrtimers at
   arbitrary dates, requiring to have a pretty close look at the
   (worst-case) timer usage pattern of the _whole_ system, not only the
   SCHED_FIFO/RR part

That's what I can tell from the heart. But one would have to analyse the
code more thoroughly I guess.

Jan


--------------enig9FBC9E3CC376384F26BE5176
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3DsTniDOoMHTA+kRAh4xAJ93mcP8ENBh3wik6O1pNhuuo4mpBQCfbuJS
3jnvoYz5ojt1rid+2Ezx2+M=
=lqlw
-----END PGP SIGNATURE-----

--------------enig9FBC9E3CC376384F26BE5176--

