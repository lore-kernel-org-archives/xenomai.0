Message-ID: <45826122.9050209@domain.hid>
Date: Fri, 15 Dec 2006 09:47:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai patched SMP kernel and "nosmp" kernel
References: <45800AA5.9000603@domain.hid>
	<12829436.1165928388617.JavaMail.ngmail@domain.hid>
	<10171906.1166169332781.JavaMail.ngmail@domain.hid>
In-Reply-To: <10171906.1166169332781.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig41F341977FFC1874016C2C55"
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
--------------enig41F341977FFC1874016C2C55
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> I tried the kernel parameter maxcpus=3D0 on my SMP enabled, Xenomai-pat=
ched kernel (same as in mails below).
> The kernel does not boot.
> It stops after a couple of messages:
> IOAPIC[0]: Invalid reference to IRQ 0

OK, a few things more to verify:

 - kernel boots fine with your scenario except CONFIG_IPIPE disabled?
 - problem persists with 2.6.19-ipipe-1.6-02?

And could you post your .config and the boot log?

Jan


--------------enig41F341977FFC1874016C2C55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgmEiniDOoMHTA+kRAq/fAJoDRSBj8pS3lROvjSmkAh8BRFAL2gCgg8YC
jgYfZdRyQSdr13IYqXE0tQc=
=O+zt
-----END PGP SIGNATURE-----

--------------enig41F341977FFC1874016C2C55--

