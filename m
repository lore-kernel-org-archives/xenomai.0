Message-ID: <49948E51.9000509@domain.hid>
Date: Thu, 12 Feb 2009 22:02:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7ed3bc8b0902120904r800de72q97e694001600051e@domain.hid>
	<499480EE.3040403@domain.hid>
In-Reply-To: <499480EE.3040403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2887DE2C8035D709BC6911C0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Known-to-work motherboards?
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
Cc: xenomai@xenomai.org, Stuart O Anderson <soa@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2887DE2C8035D709BC6911C0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Stuart O Anderson wrote:
>> If there isn't a list online that I've missed, is anyone running
>> xenomai on a relatively recent machine with 8 or more cores without
>> problems?  If so, can you provide hardware specs?
>=20
> Xenomai will have scalability problems when running on an 8 cores syste=
m
> (if you intend to run real-time tasks on each of the 8 cores).
>=20

We are running Xenomai on up to 4x4 boxes, but only with 1 or 2 cores
used by RT tasks. I've some patch hanging around that restricts Xenomai
(specifically its host timer hook) to a CPU subset in order to mitigate
the scalability issues - guess I should finally get it in shape and post =
it.

However, my point is: Massive parallel RT is not (yet) feasible with
Xenomai, but it is no black magic to have massive parallel non-RT load
living together with confined RT load on the same box.

Jan


--------------enig2887DE2C8035D709BC6911C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmUjlYACgkQniDOoMHTA+m4+QCdG168eIhjatpu6jGCjhex1tze
WxkAn2eZANGC/HpTGE6uxMDGjIHpnXCM
=5yb4
-----END PGP SIGNATURE-----

--------------enig2887DE2C8035D709BC6911C0--

