Message-ID: <47228277.40800@domain.hid>
Date: Sat, 27 Oct 2007 02:12:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47226B5E.2050303@domain.hid> <47227713.9020804@domain.hid>
In-Reply-To: <47227713.9020804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig808F22234F577D4175B543FE"
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
--------------enig808F22234F577D4175B543FE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> The I-pipe/i386 has been ported to 2.6.24-rc1, so that we could swallo=
w
>> the i386/x86_64 merge which just happened upstream, without having to
>> fiddle at the same time with the slew of other core changes which will=

>> hit the street before 2.6.24 is released. You need the latest trunk/ t=
o
>> configure Xenomai for this kernel properly, or at least update those t=
wo
>> files:
>>
>> - scripts/prepare_kernel.sh
>> - ksrc/arch/i386/Kconfig.
>>
>> Please check if this patch runs your x86 hw reasonably well, while I'm=

>> busy merging ksrc/arch/{i386, x86_64} on the Xenomai side. The plan is=

>> to have a unified x86* tree for Xenomai 2.4 which has to work with all=

>> supported kernel releases, including 2.6.24. Yes, I know we are in -rc=

>> phase, but such merge should mostly reshuffle the directory layout, an=
d
>> not the implementation per se, otherwise, it will have to wait for 2.5=
=2E
>=20
> [While building the new toy...] Hmm, I'm not a big fan of this schedule=
=2E
> Unless we want to delay Xenomai 2.4 for even more months, we will not b=
e
> able to develop the unification against any stable kernel (the
> unification is not yet done with 2.6.24-rc1!).
>=20
> *IF* such an internal refactoring of Xenomai is actually that
> straightforward, why not postpone it until some later 2.4 release? I
> would rather prefer to role out something matured, also
> build-system-wise, now instead of risking to generate new regressions.
> But to make concreter: Do you plan to just create hal_32.c and hal_64.c=
,
> or do you then also want to merge both into hal.c?
>=20
>> At the end of the day (i.e. sometime during the v2.4 maintenance cycle=
),
>> we should have the I-pipe/x86_64 merged with the I-pipe/i386 support,
>> leading to the I-pipe/x86-2.0 series, on top of 2.6.24, and all of tha=
t
>> usable with a unified ia32/64 Xenomai support, which is basically what=

>> we already have now on the powerpc side of the universe.
>>
>> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.24-rc1=
-i386-1.10-11.patch
>>
>> PS: slightly tested here. Looks ok, sun is still shining, birds are
>> still singing, hardware is not burning - yet.
>>
>=20
> Will let you know the result from my box soon.

Appears to work fine here as well, including SMP. Just one oddity so
far: /sys/module/xeno_nucleus is missing, thus a way to tune module
parameters of the built-in nucleus. xeno_hal or xeno_native, e.g., are
there. Strange.

But beyond this, I really like 2.6.24 - my new notebook finally
generates sound with its built-in speakers! 8)

Jan


--------------enig808F22234F577D4175B543FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHIoJ6niDOoMHTA+kRAig9AJ9NV3OwGCUlUSQghknIbq7nCe2YaQCfanAQ
SISdrAxIUzle7LJRO71dzYY=
=ewhj
-----END PGP SIGNATURE-----

--------------enig808F22234F577D4175B543FE--

