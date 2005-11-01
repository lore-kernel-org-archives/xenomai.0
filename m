Message-ID: <43673A30.4080807@domain.hid>
Date: Tue, 01 Nov 2005 10:49:36 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
	<200510312121.14160.dmitry.adamushko@domain.hid>
	<436680D5.4010105@domain.hid>
	<200510312202.07522.dmitry.adamushko@domain.hid>
In-Reply-To: <200510312202.07522.dmitry.adamushko@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5C6F94BF5C5568E63CFAEC43"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C6F94BF5C5568E63CFAEC43
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On Monday 31 October 2005 21:38, you wrote:
>>> [...]
>>> In our case, the relation between xnintr_irq_handler() and
>>> rthal_irq_trampoline() is 1:1. The first one does much more things th=
at
>>> the second one which is really almost a pure redirection layer.
>>> Hopefully, xnintr_irq_handler() is i-cache-hot as long as possible un=
der
>>> high irq load. In this case, I guess, rthal_irq_trampoline() will be =
in
>>> cache as well (since it's really small) and the overhead is only abou=
t
>>> having one array indexing op. and issuing a call via a pointer to the=

>>> function (xnintr_irq_handler() in our case).
>>> Do you think that really gives a significant overhead? Well, maybe so=
=2E
>>> I'm not a profie here anyway...
>> ...compared to the usefulness I still have to understand - yes.
>>
>> Other option: what about merging [2] into [3], i.e. let
>> xnintr_irq_handler deal with the translation IRQ number -> cookie?
>=20
> In that case, the nucleus must keep track of all the irqs, i.e. some_st=
ruct=20
> irqs[IPIPE_NR_IRQS]. Ok, the rthal_realtime_irq[] may be removed here f=
rom=20
> hal.
> But there is already the per-irq array in ipipe_domain struct. Having g=
ot [1]=20
> and [2] merged, we would have this array as the only one and avoid the =
use of=20
> rthal_realtime_irq[] at all. Although, the ipipe_domain would become a =
bit=20
> more heavy :) Well, but [2] into [3] is leeeess intrusive on the other =
hand.

Due to the intrusiveness, I would vote for a [2]->[3] merge.

One issue remains in any case: the HAL currently maintains a /proc entry
for the registered IRQs. It reports if a handler is registered and the
IRQ hits per CPU. As I think this entry should also report the
registered driver names in the future, we have to hand the management
over to whatever part traces all registered handlers. Is this acceptable
from the layering point of view?

Jan



--------------enig5C6F94BF5C5568E63CFAEC43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDZzowncNeS9Q0k+IRArlUAJ4wjr2fATQjPCXBl1TjQbRyRwGqGQCdGyLN
9oT4+Jzfh9YFB9Ijkf6IL04=
=9qQb
-----END PGP SIGNATURE-----

--------------enig5C6F94BF5C5568E63CFAEC43--

