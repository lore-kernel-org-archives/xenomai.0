Message-ID: <45B4A1CF.8090304@domain.hid>
Date: Mon, 22 Jan 2007 12:36:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] weired behaviour around userspace interrupts
References: <45B495F9.6090808@domain.hid>
In-Reply-To: <45B495F9.6090808@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFDA7EBC302E6862E4BA9A0F5"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDA7EBC302E6862E4BA9A0F5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Hello all,
> I guess I found some weired memory bug in Xenomai's (userspace?)
> interrupt handling. When I run the attached testprogram (or another
> program using userspace interrupt's) it happens that 'cat
> /proc/xenomai/irq' delivers the following output:

Which Xenomai version? We recently fixed some maybe related issues, both
in trunk and the v2.3.x branch. Please give one of them a try as well.

Jan


--------------enigFDA7EBC302E6862E4BA9A0F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFtKHPniDOoMHTA+kRAo7QAJ4uW6KTDJYwX6eLA91NRo6czW71CQCfeSZ4
XvgUTCa+UOVdvj7Xyk50fmY=
=ZFdu
-----END PGP SIGNATURE-----

--------------enigFDA7EBC302E6862E4BA9A0F5--

