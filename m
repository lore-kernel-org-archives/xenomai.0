Message-ID: <4666CDE6.4030402@domain.hid>
Date: Wed, 06 Jun 2007 17:08:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46649F7E.3060104@domain.hid> <46651F7D.9090702@domain.hid>
	<4666AD52.1050101@domain.hid> <4666B6AE.2070209@domain.hid>
	<4666B879.7000907@domain.hid>
In-Reply-To: <4666B879.7000907@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A3DDB1039976008F3B946B6"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Updates, timerstats, rtdm-timers
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A3DDB1039976008F3B946B6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>
>>>> Jan Kiszka wrote:
>>>> ...
>>>>
>>>>> fast-tsc-to-ns-v2.patch
>>>>>
>>>>>    [Rebased, improved rounding of least significant digit]
>>>> Rounding in the fast path for the sake of the last digit was silly.
>>>> Instead, I'm now addressing the ugly interval printing via
>>>> xnarch_precise_tsc_to_ns when converting the timer interval back int=
o
>>>> nanos. -v3 incorporating this has just been uploaded.
>>>>
>>> After noticing yesterday that even unpatched Xenomai sometimes conver=
ts
>>> inaccurately when showing small timer intervals under /proc, I just g=
ot
>>> an idea how to address this beautification issue even better: -v4 now=

>>> rounds up in the slow, precise tsc-to-ns path, see
>>>
>>> http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/fast-tsc-to-ns=
-v4.patch
>> I am the one who decided of the rounding behaviour of llimd, RTAI
>> version had the same rounding policy as the one you propose, and I mad=
e
>> it for the following reasons:
>> - rouding towards 0 is the policy used by the C language, so doing thi=
s
>> for llimd made it consistent with what one expects from C code;
>> - values computed by llimd are used to program timers, and we prefer t=
he
>> timer to be programmed for a too short value than for a too long value=
=2E
>=20
> That's OK, I agree. In my patch for i386, this rounding is only relevan=
t
> for display purposes. It's just to help me finding the expected period =
T
> of my task in /proc instead of T-1 sometimes. Beautification. All we
> need for other archs is xnarch_tsc_to_ns according to the old scheme.
> Will rework this.

Done, -v5 is online.

This is not yet incorporating any change to the generic llmulshft. I
haven't thought about nor tried our code on a 64 bit arch yet. Did you
check this already? I wonder, eg., if it makes sense to exploit 128 bit
with 64 bit shifts there or stick with 94/32 bit accuracy and related
conversion errors. Depending on this, the generic version might have to
be reconsidered.

Jan


--------------enig0A3DDB1039976008F3B946B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZs3mniDOoMHTA+kRArGdAJsGHMHKJ7Q18myv8EJ8ADzHho+Q6gCeMlNW
CYnV3WiNmm4H80GHQB/9kuc=
=D1IN
-----END PGP SIGNATURE-----

--------------enig0A3DDB1039976008F3B946B6--

