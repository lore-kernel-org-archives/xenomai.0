Message-ID: <47055EBB.6060300@domain.hid>
Date: Thu, 04 Oct 2007 23:44:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0710030717y7c65f127m8207bc37d192e28e@domain.hid>
In-Reply-To: <7289437c0710030717y7c65f127m8207bc37d192e28e@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC121AB7C69750C83156C70BC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RTDM question
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
--------------enigC121AB7C69750C83156C70BC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> Hello,
>=20
> I ask me some questions about RTDM module. Can we open several times th=
e
> same driver ? And have several DEV_FILE
> I have understood that we don't manage the number Major and Minor. So I=

> don't see how it works to do that.

You mean that the same driver source is handling multiple RTDM devices?
That is perfectly feasible, just look at the 16550A driver. But we
should also have some tutorial on this soon, check those two files
waiting to be merged into SVN:

http://zarb.org/~trem/tut03-skeleton-drv.c
http://zarb.org/~trem/tut03-skeleton-app.c

Jan


--------------enigC121AB7C69750C83156C70BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHBV69niDOoMHTA+kRAny/AJoD4vLeVRl+7IsMbTIxTbKBfjUN0gCfaLiD
SHHUs5bWcG3OtE1QkBiQzMQ=
=O94v
-----END PGP SIGNATURE-----

--------------enigC121AB7C69750C83156C70BC--

