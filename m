Message-ID: <44F35CA8.5000302@domain.hid>
Date: Mon, 28 Aug 2006 23:14:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] USB4RT and Framebuffer drivers
References: <200608281608.06625.witzel.thomas@domain.hid>
In-Reply-To: <200608281608.06625.witzel.thomas@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDE9FF0B10534584713D162C1"
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
To: witzel.thomas@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE9FF0B10534584713D162C1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thomas Witzel wrote:
> Hello,
>=20
> I have two questions.
> 1) Is there a USB4RT implementation for RTDM yet ?

USB4RT already uses RTDM to attach itself to the RTOS, but it does not
yet exports its own API via RTDM, only via the "classic" way of exported
symbols. The latter is long planned, but had to be deferred so far due
to lacking resources - though this isn't complex, just takes someone to
hack a bit and to test and cleanup a bit more.

Anyway, you can use USB4RT over any recent Xenomai.

> 2) Has anyone made a framebuffer driver for RTDM, so realtime graphics =
could  =20
>     be realized.

Dunno, haven't heard of any yet.

Jan


--------------enigDE9FF0B10534584713D162C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE81yoniDOoMHTA+kRAreuAJ9Oj8oizE9ZUyPy75CvqAQlNiqATACdFbpj
NJNSSJAsiWwMde4pznxVbhk=
=TdRB
-----END PGP SIGNATURE-----

--------------enigDE9FF0B10534584713D162C1--

