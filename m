Message-ID: <4555DFBE.4050609@domain.hid>
Date: Sat, 11 Nov 2006 15:35:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Xenomai configuration help for Linux 2.4
References: <4555C56B.3070205@domain.hid>
In-Reply-To: <4555C56B.3070205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig91B55D960947FB052402EA1A"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91B55D960947FB052402EA1A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> the attached patch adds Xenomai configuration help for Linux 2.4:

Cool that you picked this up! Frankly, I didn't expect that this would
really work without any pitfalls - but it seems to.

Just one addition feature wish: Could you enhance it so that it can also
upgrade an existing Configure.help patch? Maybe put some magic marks
(comments) around the xeno stuff and remove the whole block before
re-patching the help information?

Thanks,
Jan (who wishes that this would also work for Kconfig->Config.in...)


--------------enig91B55D960947FB052402EA1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVd++niDOoMHTA+kRAqMwAJ48xS9Zi/yPAHjStvB1aZ6N3xbnKgCcDnLY
yrZIHQN4oS115vUNm+F2nQc=
=Gaf3
-----END PGP SIGNATURE-----

--------------enig91B55D960947FB052402EA1A--

