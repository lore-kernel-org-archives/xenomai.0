Message-ID: <44B21018.4060702@domain.hid>
Date: Mon, 10 Jul 2006 10:30:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] isr
References: <20060710080757.4430@domain.hid>
In-Reply-To: <20060710080757.4430@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92A384147BF0C32714EEAB05"
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
To: Keinen Namen <GSM909@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92A384147BF0C32714EEAB05
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Keinen Namen wrote:
> Hi I useing Xenomai 2.1 and the native skin=20
>=20
> I want create a intr in kernel space with rt_intr_create, the 4th argum=
ent is the pointer is the ISR.
>=20
> My Question is which form does the ISR must have
>=20
> rt_isr_t myisr ( ??? )
> {
> ...
> }
>=20

int my_isr(rt_intr_t *intr);

That's indeed undocumented, you had to browse the code for this
information. :-/

[Note: unless you are writing some specialised or experimental code,
developing drivers over the RTDM skin is recommended now. This aims at
unifying the device interfaces for all skins.]

Jan


--------------enig92A384147BF0C32714EEAB05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEshAbniDOoMHTA+kRAvCWAJ9pteXpOED13J2p5ZY/s4IHWbWFDACghUaD
wmMsAX5P3o9yXE1LUqO9om8=
=00jr
-----END PGP SIGNATURE-----

--------------enig92A384147BF0C32714EEAB05--

