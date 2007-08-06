Message-ID: <46B71EC3.9010101@domain.hid>
Date: Mon, 06 Aug 2007 15:14:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BCC5E4E7C20D3C4780433ADBFF20273C07C97A@GBPLESL203AMSX.gb001.siemens.net>
In-Reply-To: <BCC5E4E7C20D3C4780433ADBFF20273C07C97A@GBPLESL203AMSX.gb001.siemens.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig90891402B980187B00D6D251"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Random crash in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Richardson, Andy" <andy.richardson@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90891402B980187B00D6D251
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Richardson, Andy wrote:
> Dear all,
>   I keep on getting random crashes when the RTDM system is used for the=

> first time. Looking at previous posts it may be something todo with the=

> /proc file system interface, is there any way to disable  /proc
> interaction all together in the kernel compilation?

Normally, yes (unless some other subsystem or userland depends on it):
CONFIG_PROC.

However, I would be very interested in seeing the oops dump you get (try
to capture with a serial console if the system hangs) + some information
about the versions you use. We should try to kill that gremlin first
before considering workarounds (which may only postpone the crash, BTW).

Jan


--------------enig90891402B980187B00D6D251
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGtx7DniDOoMHTA+kRAjmHAJwO49mSY8igY8eFZewgHlGPdslSJACcCQtU
L9N3DUTAAew4N/WRZ/eS23k=
=C08R
-----END PGP SIGNATURE-----

--------------enig90891402B980187B00D6D251--

