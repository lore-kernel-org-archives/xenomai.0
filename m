Message-ID: <45897603.5070703@domain.hid>
Date: Wed, 20 Dec 2006 18:42:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
	<200612192202.58982.niklaus.giger@domain.hid>
	<4588F8D0.5060605@domain.hid>
	<200612201831.12472.niklaus.giger@domain.hid>
In-Reply-To: <200612201831.12472.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7F9830318474193E3FE13AE0"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F9830318474193E3FE13AE0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Mittwoch, 20. Dezember 2006 09:48 schrieb Gilles Chanteperdrix:
>> Niklaus Giger wrote:
>>> Am Dienstag, 19. Dezember 2006 21:38 schrieb Jan Kiszka:
>>>> I rather think c) is desired: checkout from svn, make dist, untar th=
at
>>>> archive and continue to work with *those* sources.
>>> This solution is also easily integretable into the actual Buildbot. I=

>>> suppose do it would be sufficient to add it only to the daily "full"
>>> builds. But I would need to know how the release is exactly generated=
=2E
>>> E.g. after a checkout to clean directory there is no Makefile and
>>> therefore "make dist" fails miserably. Could somebody please tell me =
the
>>> exact steps?
>> You need to create a build tree by running the configure script, then
>> run make dist (or preferably "make distcheck") in this build tree.
> What are the needed (minimal) options for configure? Because if I do no=
t=20
> specify any option I get the following error when running make:
>> make[2]: Entering directory `/home/hcu/kernel/tst_dist/src/testsuite'
>> list=3D'latency switchbench cyclic switchtest irqbench'; for subdir in=
 $list;
>> do \ if test "$subdir" =3D .; then :; else \
>>             test -dbuild=20
>> "/home/hcu/kernel/tst_dist/xenomai-2.2.92/src/testsuite/$subdir" \
>>
>>             || mkdir -p --
>>             || "/home/hcu/kernel/tst_dist/xenomai-2.2.92/src/testsuite=
/$sub
>>             ||dir" \ exit 1; \
>>
>>             distdir=3D`CDPATH=3D"${ZSH_VERSION+.}:" && cd
>> /home/hcu/kernel/tst_dist/xenomai-2.2.92/src/testsuite && pwd`; \
>> top_distdir=3D`CDPATH=3D"${ZSH_VERSION+.}:" && cd
>> /home/hcu/kernel/tst_dist/xenomai-2.2.92 && pwd`; \ (cd $subdir && \
>>               make  \
>>                 top_distdir=3D"$top_distdir" \
>>                 distdir=3D"$distdir/$subdir" \
>>                 distdir) \
>>
>>               || exit 1; \
>>
>>           fi; \
>>         done
>> make[3]: Entering directory
>> `/home/hcu/kernel/tst_dist/src/testsuite/latency' make[3]: *** No rule=
 to
>> make target `runinfo', needed by `distdir'.  Stop. make[3]: Leaving
>> directory `/home/hcu/kernel/tst_dist/src/testsuite/latency' make[2]: *=
**
>> [distdir] Error 1
>> make[2]: Leaving directory `/home/hcu/kernel/tst_dist/src/testsuite'
>> make[1]: *** [distdir] Error 1
>> make[1]: Leaving directory `/home/hcu/kernel/tst_dist/src'
>> make: *** [distdir] Error 1
>=20
> Do I need to run this on a system which is running a xenomai kernel?
> (I never tried to run it on my Intel MacMini.) Can I build it on a PPC =

> machine?

Argh, fallout from my last changes.

I fixed the Makefile.ams in SVN, but someone with fitting automake
(Gilles?) has to run bootstrap. I'm getting now even more diffs with my
toolchain than yesterday.

Jan


--------------enig7F9830318474193E3FE13AE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiXYDniDOoMHTA+kRAjAZAJ0VE8tdQcZzMnJhu1M061mB9LmaeACePHXa
7cpYQXcNUV9LGNgZZceD+y8=
=mNga
-----END PGP SIGNATURE-----

--------------enig7F9830318474193E3FE13AE0--

