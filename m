Message-ID: <46C33453.8060402@domain.hid>
Date: Wed, 15 Aug 2007 19:13:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2862c2c80708140315y6cb029e4j8b5f7e9d95ae2bf1@domain.hid>	<18113.34663.646158.524696@domain.hid>	<2862c2c80708150224s4dd154b1j2aad7333ac04d150@domain.hid>	<46C2EADF.4030505@domain.hid>
	<18114.64293.110182.524820@domain.hid>
In-Reply-To: <18114.64293.110182.524820@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3C473C4DBE2D86BBCD312614"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C473C4DBE2D86BBCD312614
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Yeoh Chun Yeow wrote:
>  > > By the way, do we need to invoke the rtdm_irq_enable after the
>  > > rtdm_irq_request? After excuting the ISR, is that the return of
>  > > RTDM_IRQ_HANDLED will reenble the interrupt?
>  >=20
>  > Depends on the version: With RTDM revision 6 (will be part of Xenoma=
i
>  > 2.4), this is no longer required. Earlier revision needed it, though=
=2E
>  > See documentation.
>=20
> An if I am not wrong, RTDM revision 6 offers timers services as well,

Yep.

> so, Yeoh, developing your own timer management system really looks like=

> going the wrong way.

It takes fairly unusual requirements to go some non-standard way here.

Jan


--------------enig3C473C4DBE2D86BBCD312614
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwzRUniDOoMHTA+kRAuAMAJwKrjHPpWnSI+186TIHOHCklNRJrgCggRM6
jtYF4GTmuKRJgVMBgP0E91I=
=CU5Q
-----END PGP SIGNATURE-----

--------------enig3C473C4DBE2D86BBCD312614--

