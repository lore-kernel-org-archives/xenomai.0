Message-ID: <47230D83.1030001@domain.hid>
Date: Sat, 27 Oct 2007 12:05:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47226B5E.2050303@domain.hid> <47227713.9020804@domain.hid>
	<4722F8BD.8010401@domain.hid>
In-Reply-To: <4722F8BD.8010401@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C112810BFB149E3E3AB68A0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] I-pipe/i386 for 2.6.24-rc1 - x86/x86_64 merge to
 come
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C112810BFB149E3E3AB68A0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> The I-pipe/i386 has been ported to 2.6.24-rc1, so that we could swall=
ow
>>> the i386/x86_64 merge which just happened upstream, without having to=

>>> fiddle at the same time with the slew of other core changes which wil=
l
>>> hit the street before 2.6.24 is released. You need the latest trunk/ =
to
>>> configure Xenomai for this kernel properly, or at least update those =
two
>>> files:
>>>
>>> - scripts/prepare_kernel.sh
>>> - ksrc/arch/i386/Kconfig.
>>>
>>> Please check if this patch runs your x86 hw reasonably well, while I'=
m
>>> busy merging ksrc/arch/{i386, x86_64} on the Xenomai side. The plan i=
s
>>> to have a unified x86* tree for Xenomai 2.4 which has to work with al=
l
>>> supported kernel releases, including 2.6.24. Yes, I know we are in -r=
c
>>> phase, but such merge should mostly reshuffle the directory layout, a=
nd
>>> not the implementation per se, otherwise, it will have to wait for 2.=
5.
>> [While building the new toy...] Hmm, I'm not a big fan of this schedul=
e.
>> Unless we want to delay Xenomai 2.4 for even more months,
>=20
> It usually takes about 2-4 weeks to port Xenomai to a new architecture,=


(To port, but not to test and mature with the help of third parties.)

> so merging two existing ones on a per-file basis can't delay 2.4 for
> months, really.

Months when we want to sync with a stable unified kernel, likely weeks
if we just want to do the internal merge - again: including a reasonable
test cycle via the community.

>=20
>  we will not be
>> able to develop the unification against any stable kernel (the
>> unification is not yet done with 2.6.24-rc1!).
>>
>=20
> The unification on the Xenomai side does not depend at all on the one
> ongoing upstream. The same way, we had the powerpc side unified for
> 32/64bit support long before the first I-pipe against the powerpc/ tree=

> was available, and this process is even still ongoing upstream right
> now, long after its came to an end on our side. Conversely, a unified
> Xenomai tree for x86 would still work with older kernels, so the fact
> that 2.6.24 is being under development has no impact for us whatsoever.=


If it is decoupled from the kernel, then it doesn't matter when we
merge, thus also no need to hurry _now_.

>=20
>> *IF* such an internal refactoring of Xenomai is actually that
>> straightforward, why not postpone it until some later 2.4 release?
>=20
> You don't want to change the build system in any significant way for
> stable releases, because downstream projects may rely on the way it
> works, or on the directory layout it processes. OTOH, it is still
> acceptable during -rc. Since we can't push this change during the stabl=
e
> cycle, and if we don't do it during the current -rc cycle either, then
> we would have to wait for 2.5. Our major release cycle is ~6 months
> long, even more in the 2.4 case, this would postpone our own unificatio=
n
> work until mid-2008.

Aren't those 6 months the actual problem?

>=20
> Even if we could keep two separate trees for ages while upstream
> provides only one, there is an opportunity to rationalize things right
> now. If we can't do this at no significant cost, then we would wait for=
 2.5.
>  I
>> would rather prefer to role out something matured, also
>> build-system-wise, now instead of risking to generate new regressions.=

>> But to make concreter: Do you plan to just create hal_32.c and hal_64.=
c,
>> or do you then also want to merge both into hal.c?
>>
>=20
> I like the way upstream did this, and I intend to follow this path. The=

> point is about preparing the directory tree now, so that we may make
> both implementations converge code-wise over time when it is sane and
> applicable. This means hal_32/64 for now, until we decide whether havin=
g
> a single HAL makes sense later. OTOH, there is no point in keeping
> separate smi.c files. Again, the first step is about _preparation_,
> which should pave the way for a deeper unification when it applies.
> And this later work would be allowed to take place during the stable 2.=
4
> series, since the framework would be already in place.

Even when focusing on infrastructure and really trivial merges, this
thing _will_ delay the 2.4 release by at least a 1-2 weeks. On the other
hand, there is still the broken blackfin arch...

Anyway, if you want to go this way, I will try to support the otherwise
very appreciated approach with testing and - when required - patching.

Jan


--------------enig7C112810BFB149E3E3AB68A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHIw2KniDOoMHTA+kRAj+IAJ9Gzw8PKOvy6XEvKrFOKXod7UnB5wCbB+KC
wgIZJkTsxtkbj7nvFSA4qY0=
=MA4T
-----END PGP SIGNATURE-----

--------------enig7C112810BFB149E3E3AB68A0--

