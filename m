Message-ID: <47AC9FAE.7070608@domain.hid>
Date: Fri, 08 Feb 2008 19:30:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376A62@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376A62@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD813387A16CA009B84467AA2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] BUG fs/buffer.c:1245
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD813387A16CA009B84467AA2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> I get the following bug when sending data over tcp/ip from a linux
> thread with xenomai apps running:
>=20
> =20
>=20
> The reason I ask the list is because the call that triggers this is
> irqs_disabled().
>=20
> =20
>=20
> What I'm doing is sending data over an RT_PIPE from a realtime task,
> while a linux thread wakes up and receives a message from the pipe and
> then sends it out over tcp/ip.

Sporadic or deterministic bug? Specifically in case of the latter I=20
would be interested in your .config.

Unless the slowdown papers over the actual issue, letting the ipipe=20
tracer run, so that it reports a nice backtrace on the BUG, may help us=20
tracking down the point where irq_enable is missing (also in=20
non-Xenomai/Ipipe code).

Jan


--------------enigD813387A16CA009B84467AA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFHrJ+xniDOoMHTA+kRAqM2AJiSV3mE0XqtWT8pw/0nwL4k90CuAJ9qWuxa
gvOzUtlvhOaoxO25M2eu8g==
=i3tb
-----END PGP SIGNATURE-----

--------------enigD813387A16CA009B84467AA2--

