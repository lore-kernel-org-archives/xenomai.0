Message-ID: <455C88C7.6080509@domain.hid>
Date: Thu, 16 Nov 2006 16:50:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Interrupt shield
References: <E1Gke0B-0003BT-CA@mailer.emlix.com>
In-Reply-To: <E1Gke0B-0003BT-CA@mailer.emlix.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig23019639575BEC4E166B140E"
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig23019639575BEC4E166B140E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Hello,
>=20
> can anybody confirm this behaviour? If I configure the I-shield into th=
e=20
> kernel and start the latency test the RT tasks have not activated T_SHI=
ELD=20
> although the documentation states it (and btw in rt_task_create this bi=
t is=20
> set). If I try to set T_SHIELD inside the display task, the system hang=
s, a=20
> soft lockup appears and sometimes a few correct lines of the display ta=
sk are=20
> printed, followed by the next lockup.
>=20
> Explainable?
>=20
> I'm testing on ARM with my S3C24xx I-pipe patch.

Have you tried over x86, too? The shield used to be off by default for
quite some time, and it's a fairly special feature. I wouldn't be
surprised if there is some regression sleeping. But it might also be an
ARM-specific issue.

Soft lockup sounds like the shield is not released appropriately again.
The tracer would visualise this nicely in verbose mode...

Jan


--------------enig23019639575BEC4E166B140E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXIjHniDOoMHTA+kRArbNAJ0X3CTKawBGoNM5iZSIuVyq6d7+fgCfZDgx
qIhnonRo27XIBJ8e8h3rROg=
=2oGE
-----END PGP SIGNATURE-----

--------------enig23019639575BEC4E166B140E--

