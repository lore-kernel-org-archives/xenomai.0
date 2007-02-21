Message-ID: <45DC23D4.5090000@domain.hid>
Date: Wed, 21 Feb 2007 11:49:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] latency results for ppc and x86
References: <725115.56324.qm@domain.hid>
	<Pine.LNX.4.60.0702211019590.2291@domain.hid>
In-Reply-To: <Pine.LNX.4.60.0702211019590.2291@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig21C2E07809BA2A44E895702C"
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
--------------enig21C2E07809BA2A44E895702C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nicholas Mc Guire wrote:
>=20
>> Latencies are mainly due to cache refills on the P4. Have you already
>> put load onto your system? If not, worst case latencies will be even
>> longer.
>=20
>=20
> one posibility we found in RTLinux/GPL to reduce latency is to free up
> TLBs by flushing a few of the TLB hot spots, basically these flushpoint=
s
> are something like:
>=20
> __asm__ __volatile__("invlpg %0": :"m"
> (*(char*)__builtin_return_address(0)));
>=20
> put at places where we know we don't need thos lines any more (i.e.
> after switching tasks or the like). By inserting only a few such
> flushpoints in
> hot code on the kernel side we found a clear reduction of the worst cas=
e
> jitter and interrupt response times.

Interesting. Are these flushpoints present in latest kernel patches of
RTLinux/GPL? Sounds like a nice thing to play with on a rainy day. :)

>=20
> Aside from caches, BTB exhaustion in high load situations is also a
> problem that has not been addressed much in the realtime variants - wit=
h
> the P6 families having a botched BTB prediction unit, one can use some
> "strange" constructions to reduce branch penalties - i.e.:
>=20
>   if(!condition){slow_path();}
>   else{fast_path();}
>=20
> if more predictalbe than
>=20
>   if(codition){fast_path();}
>   else{slow_path();}

I think this is also what likely()/unlikely() teaches to the the
compiler on x86 (where there is no branch prediction predicate for the
instructions), isn't it?

>=20
> as in the first case the branch prediction is static, thus the worst ca=
se
> is that you are jumping over a few bytes of object code when the condit=
ion
> is not met. in the second case the default if the BTB does not yet know=

> this branch is to guess not-taken and thus load the jump target of the
> slow patch with the overhead of TLB/Cache penalties.
>=20
> Regarding the PPC numbers, the surprising thing for me is that the same=

> archs are doing MUCH better with old RTAI/RTLinux versions, i.e. 2.4.4
> kernel on a 50MHz MPC860 shows a worst case of 57us - so I do question
> what is going wrong here in the 2.6.X branches of hard-realtime Linux -=


You forget that old stuff was kernel-only, lacking a lot of Linux
integration features. Recent I-pipe-based real-time via Xenomai normally
includes support for user-space RT (you can switch it off, but hardly
anyone does). So its not a useful comparison given that new real-time
projects almost always want full-featured user space these days. For a
fairer comparison, one should consider a simple I-pipe domain that
contains the real-time "application".

> my suspicion is that there is too much work being done on fast-hot CPUs=

> and the low-end is being neglected - which is bad as the numbers you
> post here for ADEOS are numbers reachable with mainstream preemptive
> kernel by now as well (off course not on the low end systems though).

That's scenario-dependent. Simple setups like a plain timed task can
reach the dimension of I-pipe-based Xenomai, but more complex scenarios
suffer from the exploding complexity in mainstream Linux, even with -rt.
Just think of "simple" mutexes realised via futexes.

Jan


--------------enig21C2E07809BA2A44E895702C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3CPUniDOoMHTA+kRAuA4AJ4o4p5N6G+nffiV5bve/NM8gn8SbgCff+m+
jyEgp2V/1Z09Vi0kBIgRrKI=
=yANS
-----END PGP SIGNATURE-----

--------------enig21C2E07809BA2A44E895702C--

