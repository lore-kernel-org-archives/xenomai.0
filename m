Message-ID: <4587B059.7040800@domain.hid>
Date: Tue, 19 Dec 2006 10:26:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: Aw: Re: [Xenomai-help] NMI watchdog: Loading of xeno_native leads
	to
References: <4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
In-Reply-To: <358035.1166518774710.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C024FADB952BF7E1FD36553"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C024FADB952BF7E1FD36553
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi!
>=20
> I have modified the configuration to disable profiling and to set the N=
MI time value to 100.
> However, there is no difference.
> Could this be a compiler issue?
> I am using gcc 4.1.2 (debian etch prerelease)

My feeling is no (I'm using 4.1 here, .2 should only fix regressions in
theory).

> I try to recompile the kernel using an older gcc-3.3 to see if this hel=
ps.

After that let us forget about the NMI for a while and check if the soft
watchdog + CONFIG_XENO_OPT_DEBUG_NUCLEUS may already reveal some detail
of the RTnet issue.

Jan


--------------enig2C024FADB952BF7E1FD36553
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFh7BZniDOoMHTA+kRAssyAJ9jubG+n/z1uHX3tdZ1GC6L2JsSfQCeNxZt
5xXzqjVMpquQNhhrJryviD4=
=0Ee/
-----END PGP SIGNATURE-----

--------------enig2C024FADB952BF7E1FD36553--

