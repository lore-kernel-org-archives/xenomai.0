Message-ID: <435683BC.1010007@domain.hid>
Date: Wed, 19 Oct 2005 19:34:52 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newbie question
References: <4353F109.7000707@domain.hid>	<4353F411.4000500@domain.hid>	<4353F896.1040508@domain.hid>	<435402B4.5060004@domain.hid>
	<435403C8.80400@domain.hid>	<43540531.8050304@domain.hid>	<435406E0.8020405@domain.hid>
	<435408E5.8020007@domain.hid>	<435419B0.8030004@domain.hid>	<4354AD5A.7010305@domain.hid>	<17237.13723.766826.515585@domain.hid>	<43553F22.80805@domain.hid>	<17237.19216.373031.430361@domain.hid>	<43554BD2.1050305@domain.hid>	<17237.20014.842135.310718@domain.hid>	<43555065.40704@domain.hid>
	<435605E7.90201@domain.hid> <43567F17.2020302@domain.hid>
In-Reply-To: <43567F17.2020302@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE106C4F45AB997FB07A72D59"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE106C4F45AB997FB07A72D59
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> I'm quite new to xenomai (switching from RTAI). I noticed that the
> latency_rt.ko module fails to start the timer if the posix skin module
> (xeno_posix.ko) is loaded. Is this the expected behaviour?
>=20

Expected yes, wanted no.

Avoid xeno_posix being loaded for this test. It starts the timer when
being insmoded, while latency_rt (as a xeno_native application) does
this on program start up (and fails if it already runs).

I think I already mentioned here that I don't like this situation and
that xeno_native should provide the same timer control interface as the
other skins, didn't I? Will file a feature request now! :)

Jan


--------------enigE106C4F45AB997FB07A72D59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVoO9ncNeS9Q0k+IRAgtjAKCHxSC4zR/oeegC/O5+B8ToaWep3gCaAy1h
q3H5zg28VWxVdWWO06ogl+g=
=v/Zy
-----END PGP SIGNATURE-----

--------------enigE106C4F45AB997FB07A72D59--

