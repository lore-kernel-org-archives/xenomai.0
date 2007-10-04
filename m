Message-ID: <470563EE.9000406@domain.hid>
Date: Fri, 05 Oct 2007 00:06:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0710040254t676bf4u2615d5d794e82045@domain.hid>
In-Reply-To: <7289437c0710040254t676bf4u2615d5d794e82045@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA01806AA21872B2C11969B41"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] IRQ managment with RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA01806AA21872B2C11969B41
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> Hello,
>=20
> I would like to know how we configure interrupts in falling edge or ris=
ing
> edge with RTDM.
> I have to rewrite a linux driver in RTDM module and I don't find the
> equivalent of IRQF_TRIGGER_FALLING.

There is no such thing in RTDM. You can use set_irq_type() for this,
like some Linux drivers do as well. But the cleaner approach indeed seem
to be to let RTDM manage the flags (and check if there conflicts in case
of shared IRQs). Will put it on the todo list, but not with a high prio.

Jan


--------------enigA01806AA21872B2C11969B41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHBWPuniDOoMHTA+kRAh9NAJoDjl3OhhCZRS3uSmN2qgaaWkBsdACeJkbn
B/MoMrnzS08/PUKBHogNOng=
=b7pM
-----END PGP SIGNATURE-----

--------------enigA01806AA21872B2C11969B41--

