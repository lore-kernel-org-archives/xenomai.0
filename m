Message-ID: <460529D2.7020406@domain.hid>
Date: Sat, 24 Mar 2007 14:38:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-Socket-CAN bus error rate and latencies
References: <46002EE0.9040406@domain.hid>	<460167F8.50703@domain.hid>	<46017CA7.2080801@domain.hid>	<4601958C.90502@domain.hid>
	<4601A6E4.9020908@domain.hid>	<46023991.4020301@domain.hid>	<46036D32.7000603@domain.hid>
	<46036F22.60709@domain.hid>	<46039128.90609@domain.hid>
	<4603950D.9040801@domain.hid> <460510D8.2010205@domain.hid>
In-Reply-To: <460510D8.2010205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3199A6246D381050ECEF911F"
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
Cc: socketcan-core@domain.hid, Oliver Hartkopp <socketcan@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3199A6246D381050ECEF911F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> ...
> Attached is the patch and it works fine. The key function
> rtcan_sja_enable_bus_err() is called from sendmsg():
>=20
> void rtcan_sja_enable_bus_err(struct rtcan_device *dev)
> {
>     struct rtcan_sja1000 *chip =3D (struct rtcan_sja1000 *)dev->priv;
>=20
>     if (chip->bus_err_on < 2) {
>     if (chip->bus_err_on < 1)
>         chip->read_reg(dev, SJA_ECC);
>     chip->bus_err_on =3D 2;
>     }
> }
>=20
> And I do also do not see a real problem with multiple readers. I would
> commit this solution. I'm just unsure if we should select it silently o=
r
> if the user should have the choice.

I would say no to user-selectability unless someone comes up with a
serious downside of this approach.

Are there any other error interrupt sources we should treat the same
way? Or all? Just to make the behaviour as regular as reasonable. I have
no opinion yet, I only want to make sure we have considered this as well
before we set the change API in stone.

Nice work!

Jan


--------------enig3199A6246D381050ECEF911F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGBSnSniDOoMHTA+kRAvXrAJ96LM53at0108WaywNXVZpOvp1dYACeJRBW
6CsuhkvScv+R+myBKmcUer4=
=crHP
-----END PGP SIGNATURE-----

--------------enig3199A6246D381050ECEF911F--

