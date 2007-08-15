Message-ID: <46C2EADF.4030505@domain.hid>
Date: Wed, 15 Aug 2007 14:00:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2862c2c80708140315y6cb029e4j8b5f7e9d95ae2bf1@domain.hid>	<18113.34663.646158.524696@domain.hid>
	<2862c2c80708150224s4dd154b1j2aad7333ac04d150@domain.hid>
In-Reply-To: <2862c2c80708150224s4dd154b1j2aad7333ac04d150@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD99CD0B37B03BE3819A64FC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kernel Opps calling rtdm_irq_request
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD99CD0B37B03BE3819A64FC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yeoh Chun Yeow wrote:
> By the way, do we need to invoke the rtdm_irq_enable after the
> rtdm_irq_request? After excuting the ISR, is that the return of
> RTDM_IRQ_HANDLED will reenble the interrupt?

Depends on the version: With RTDM revision 6 (will be part of Xenomai
2.4), this is no longer required. Earlier revision needed it, though.
See documentation.

Jan


--------------enigBD99CD0B37B03BE3819A64FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFGwurfniDOoMHTA+kRAgdAAJd0bb6P4VqC6XC5iUrYz6OCoiEAAJ9NQoOK
o10o3NcWUTRNWGl+XyBRtQ==
=JWBq
-----END PGP SIGNATURE-----

--------------enigBD99CD0B37B03BE3819A64FC--

