Message-ID: <49F018E7.7070102@domain.hid>
Date: Thu, 23 Apr 2009 09:29:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1061790776.3997201240471367689.JavaMail.root@domain.hid>
	<1388082696.3997731240471520688.JavaMail.root@domain.hid>
In-Reply-To: <1388082696.3997731240471520688.JavaMail.root@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig835834C3127B030FA4D13037"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problem of freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: btirefort@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig835834C3127B030FA4D13037
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

btirefort@domain.hid wrote:
> Hello
>=20
> I'am rookie in xenomai and i have a problem.
>=20
> Here my configuration :
>=20
> Linux base : CentOS v5.3 (with gnome)
> kernel : linux-2.6.28.7
> xenomai : 2.4.7
> processor cpu familly  : 6
>               type : 14 (Intel Core Duo T2500 2Ghz)
> memory : 1 GB
> HDD : SCSI with Adaptec AIC-7892B card
>=20
> I have installed xenomai with no problem.
> All options of ACPI, APM and CPU frequency scaling are disabled.
>=20
> All seems to be good, but i have a problem :
>=20
> Sometimes the system freeze, and i must reset the computer.
> The system freeze sometimes during the connection to gnome (when gnome =
are enabling my desktop).
> The system freeze also, when i am leaving the scrennsaver after a long =
period without using (after nigth for example).
> The system freeze all the time when I try to launch netbeans program.
>=20
> I don't understand why.
>=20
> Can you help me please ?

Please try adeos-ipipe-2.6.28.9-x86-2.2-07.patch from the Xenomai git
repository, it will probably fix you issue (in any case, feedback would
be very welcome!).

Jan


--------------enig835834C3127B030FA4D13037
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknwGOcACgkQniDOoMHTA+lXUACdEqpMezcgL87CvsOuy9/OoFVt
+QkAniK8Jzkk4ECsnNeS4ooafAkDbOi1
=amzx
-----END PGP SIGNATURE-----

--------------enig835834C3127B030FA4D13037--

