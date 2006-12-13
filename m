Message-ID: <45800AA5.9000603@domain.hid>
Date: Wed, 13 Dec 2006 15:13:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai patched SMP kernel and "nosmp" kernel
	parameter
References: <12829436.1165928388617.JavaMail.ngmail@domain.hid>
In-Reply-To: <12829436.1165928388617.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD482F1312C58BCACD33A398"
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
--------------enigBD482F1312C58BCACD33A398
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I have a SMP kernel 2.6.17.7 on a Dual Core Pentium 4 running.
> SMP is enabled at the kernel configuration.
> This works fine.
> However, I want to compare UP with SMP operation, that's why
> I want to boot the system with the "nosmp" kernel parameter.
> However, booting of the PC with  nosmp does not work.
> First it starts fine, however when trying to access hdb (which is the C=
D ROM
> drive in my system) to get info about it, the message
> "hdb: lost interrupt"
> appears, and booting is stopped.=20
>=20
> Does the nosmp parameter work with a Xenomai patched kernel?
> Or what could be wrong with it....
>=20
> I am using the latest Xenomai SVN #1948.
> The kernel patch is adeos-ipipe-2.6.17-i386-1.5-02.patch
>=20
> Any ideas on this?

Same for maxcpus=3D0? I'm asking as this configures the system more
aggressively smp-less on x86 (patching spinlock alternatives for UP,
configuring LAPIC mode etc.).

Jan


--------------enigBD482F1312C58BCACD33A398
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgAqmniDOoMHTA+kRAiavAJ977cKoiuscCJYazkp1fcKSX5Jk6QCfYKA4
/QktfuN6HeyLm63AHiGga3k=
=avbS
-----END PGP SIGNATURE-----

--------------enigBD482F1312C58BCACD33A398--

