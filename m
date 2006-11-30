Message-ID: <456ECCE8.1070706@domain.hid>
Date: Thu, 30 Nov 2006 13:22:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] structure alignement problem in RTDM?
References: <20061130073522.3BBF9EE753@domain.hid>
	<456E8F94.8050600@domain.hid> <456E9BAC.3060508@domain.hid>
In-Reply-To: <456E9BAC.3060508@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE1D97872B0642D93CEC420C2"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1D97872B0642D93CEC420C2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Marc Brown wrote:
>>
>>> Hi,
>>>
>>> It seems that there are still structure alignment problems in RTDM (w=
hile running xenotest), as already=20
>>> talked about with Philippe. Compiled with a GCC 4.0.3-2 (on x86), her=
e is the=20
>>> problem (output trace and xenomai /proc are provided herewith):
>>
>> I rather suspect that you built all testing devices into the kernel or=

>> loaded xeno_switchtest before xeno_timerbench so that the latency test=

>> happens to open the switchtest device. Try "-D1" with latency, or chec=
k
>> /proc/xenomai/rtdm/rttestX/information for the actual mapping.
>> [We need to resolve this more gracefully...]
>=20
> A way to solve this may be to use the same method as switchtest: open
> all rttest devices in turn until the first ioctl succeeds.
>=20

Yeah, I'm going to check something in this direction (while still
keeping -D to override any automatism).


--------------enigE1D97872B0642D93CEC420C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbszoniDOoMHTA+kRAqtFAJwIWgaCLtCYtLmZS2KfPxjI0m8ySgCfSDg6
AE9S/C1HHcCQJv3R8nBK01E=
=8Vn9
-----END PGP SIGNATURE-----

--------------enigE1D97872B0642D93CEC420C2--

