Message-ID: <4538D4C8.1090603@domain.hid>
Date: Fri, 20 Oct 2006 15:53:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] x86: revert IRQs replay order
References: <4538A613.80606@domain.hid> <1161350478.4988.17.camel@domain.hid>
In-Reply-To: <1161350478.4988.17.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6041D5E0175816C99A5F94D6"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6041D5E0175816C99A5F94D6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-10-20 at 12:33 +0200, Jan Kiszka wrote:
>> While digging into a latency issue with multiple IRQs pending (patch
>> will likely follow soon), I noticed that the replay order on x86 is th=
e
>> inverse of the hardware order. Instead of iterating from lowest IRQ
>> number to highest, ipipe currently starts with the highest one. The
>> attached patch fixes this.
>>
>=20
> We want to give a priority boost to virtual IRQs over real ones, at
> least for the root domain. Since virqs are high-numbered, bsrl has been=


Hmm, are the virtual IRQs differently numbered on blackfin? Because
there we have ffs behind __ipipe_ffnz.

> used on purpose to scan the pending IRQ mask. Additionally, low-numbere=
d
> IRQs have higher priority only if you consider the ISA ones as managed
> by the 8259. Bringing the APIC into the picture, the APIC-based timer
> IRQ used by RTOSes over Adeos is a high-numbered one.

Ok, so there is no simple way to emulate reality, thus we can simply
leave it as it is. No problem.

Jan


--------------enig6041D5E0175816C99A5F94D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFONTIniDOoMHTA+kRApNyAJ9n24FRJW8Lj1XQC2KTP+7aWHbArACZAUyh
iI3eXn8rnUXuSvHEltFyvDk=
=OqU7
-----END PGP SIGNATURE-----

--------------enig6041D5E0175816C99A5F94D6--

