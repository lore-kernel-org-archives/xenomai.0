Message-ID: <4690B8B1.10303@domain.hid>
Date: Sun, 08 Jul 2007 12:13:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1183144465.6574.99.camel@domain.hid>
	<46908B79.30908@domain.hid>	<1183882578.6014.58.camel@domain.hid>
	<4690B062.4090000@domain.hid>
In-Reply-To: <4690B062.4090000@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig430999F2B82801AFE7A6A2B4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Support for 2.6.22/x86
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig430999F2B82801AFE7A6A2B4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> Philippe Gerum wrote:
>> Hi Jim,
>>
>> On Sun, 2007-07-08 at 01:00 -0600, Jim Cromie wrote:
>>  =20
>>> Philippe Gerum wrote:
>>>    =20
>>>> Our development trunk now contains the necessary support for running=

>>>> Xenomai over 2.6.22/x86. This work boils down to enabling Xenomai to=
 use
>>>> the generic clock event device abstraction that comes with newest
>>>> kernels. Other archs / kernel versions still work the older way, unt=
il
>>>> all archs eventually catch up with clockevents upstream.
>>>>
>>>> This support won't be backported to 2.3.x, because it has some
>>>> significant impact on the nucleus. Tested as thoroughly as possible =
here
>>>> on low-end and mid-range x86 boxen, including SMP.
>>>>
>>>> Please give this hell.
>>>>
>>>> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-r=
c6-i386-1.9-00.patch
>>>>
>>>>  =20
>>>>      =20
>>> Ive been running 22-rc7 on my Sony VAIO with this patch applied since=
=20
>>> July 3,
>>>
>>> the only thing wrong Ive seen is that perl ( both bleed and maint )
>>> is failing its time related regression tests.
>>> ie
>>>     rsync -avz rsync://public.activestate.com/perl-current/ .
>>>     rsync -avz rsync://public.activestate.com/perl-5.8.x .
>>>
>>> Failed 3 tests out of 1429, 99.79% okay.
>>>         ../ext/Time/HiRes/t/HiRes.t
>>>         ../lib/Benchmark.t
>>>         op/time.t
>>>
>>> the lib/Benchmark.t test is hanging, and must be killed manually
>>>    =20
>> Thanks for the feedback.
>>
>> Does this happen with the I-pipe switched off too?
>> Also, is Xenomai patched in your kernel with any of the skins statical=
ly
>> enabled, or just the I-pipe?
>>
>>  =20
>=20
> Im not sure what 'switched off' means, so heres the 'relevant' parts of=
=20

There are a few stages of Xenomai/I-pipe support we usually test when
weird this come up:

1. Xenomai fully enabled and running (like you probably did)
2. Xenomai enabled, but no skin loaded (=3D> all skins must be modular)
3. Xenomai disabled in the .config, only I-pipe
4. I-pipe patched in but disabled (under "Processor types and features")
5. Vanilla kernel (but otherwise identical .config)

There is no strict order what to try first. It rather depends on
intuition and the compilation time you want to invest (fiddling with
CONFIG_IPIPE means full kernel rebuild).

> the .config
> Now that I look at it, Ive obviously not attended to the advice in=20
> README.INSTALL.
>=20
> This config worked nicely with ntp, FWIW.
>=20
> Given that this is a laptop, Id like to keep ACPI and/or CPU-freq if=20
> possible,

ACPI is OK (except ACPI_PROCESSOR), but CPU_FREQ is a no-go for Xenomai
unless you force the frequency governor into the fixed maximum
performance mode (which means at least temporary CPU_FREQ off).
Otherwise, Xenomai timing will by totally screwed up.

> but I'll try some combos to see if any work for both the battery,
> and for the perl tests.  I'll try a conservative/recommended config too=
=2E
> Any suggestions or test-requests are welcome.
>=20

First of all, it would be good to identify which stage of Xenomai
support (see above) breaks your test case. Then, as it seems to be some
timer issue, you could try to use kernel timer debugging features. E.g.
have a look /proc/timer_list. Is there your perl test stalled on some
timer, maybe with a silly expiry date? What does strace report if you
let your test run over it, ie. which syscall does not return?

Jan


--------------enig430999F2B82801AFE7A6A2B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkLixniDOoMHTA+kRAmrJAJ0QqixYEHJpCzwpVdVnkQZwJtLSEQCfW+sO
nJoaiaPXOV8Itax4iklsiFs=
=U5gZ
-----END PGP SIGNATURE-----

--------------enig430999F2B82801AFE7A6A2B4--

