Message-ID: <4551F62A.9030607@domain.hid>
Date: Wed, 08 Nov 2006 16:22:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] LATENCIES > 100 us or CRASH WITH X (with joints
	pieces)
References: <4551F2E5.5050200@domain.hid>
In-Reply-To: <4551F2E5.5050200@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE6E3F0F8D3501C0CCBCE2FF"
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
To: Jean-Luc Pamart <jlpamart@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE6E3F0F8D3501C0CCBCE2FF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jean-Luc Pamart wrote:
> Hello
>=20
> I am a newbie with Xeno. My goal for the beginning of 2007 is to launch=

> a project for 4 french studiants : a box with Linux embedded and a usb
> camera. The embedded application will analyse the movies in Real time
> and lead a mobile machine with CAN-BUS.
> Now i play with Xeno for my knowledge (without specific hardware) :  a
> little linux installed in a usb key with a little embedded distrib
>=20
> - vanilla kernel 2.6.16 with patch for usb [.config is joint]
> - Xenomai 2.1.2
> - essentially BusyBox
> - for xenomai : only "latency" directory and libs in usr/libs
> I have checked "SMI woraround" for the kernel.
> In BIOS I have UNchecked  "legacy usb".
>=20
>=20
> my Desktop PC (a AMD ATHLON) can boot with this little vanilla kernel a=
nd
> 1/ a little embedded distrib of my own
>=20
> OR
>=20
> 2/ a complete mandrake 9.1 on a partition of a classic hard disk
>=20
> I have 2 differents problems when I lauch this :
>=20
> 1/ with the linux embedded directories on the usb key
> high latency > 100 us are ok ? perhaps usb work is not compatible with =
RT ?

Try loading the standard USB drivers (at least uhci_hcd) if they aren't
yet. Actually, I've seen boxes (granted, they were far older) where I
had to switch legacy USB *on* to avoid disturbances. In any case, check
carefully if you followed all tips in TROUBLESHOOTING regarding latency
issues (APM, ACPI, etc.).

>=20
>=20
> 2/ with the complete mandrake 9.1 :
> it crashes X after 1 or few minutes.
> What is the relation between X and Xenomai ?
> Is Xenomai compatible with X ?

Yes, as long as X is not playing against us, e.g. by hard-disabling
interrupts or doing (too) evil things on the buses. Any non-GPL driver
in this game here (NVidia&Co)? Better avoid this. Also try to disable
accelerated mode in your X setup to see if things improve.

Jan


--------------enigAE6E3F0F8D3501C0CCBCE2FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUfYqniDOoMHTA+kRAjcIAJ9X2v0ZKz+JFJQ/KfYdO71M+wkI4gCfSL7N
SaP0UlCEtW+CYxS4tLbPjA0=
=3EgO
-----END PGP SIGNATURE-----

--------------enigAE6E3F0F8D3501C0CCBCE2FF--

