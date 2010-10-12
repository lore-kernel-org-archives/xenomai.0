Message-ID: <4CB3F950.8070106@domain.hid>
Date: Tue, 12 Oct 2010 07:59:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>	<1286611432.13186.200.camel@domain.hid>	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>	<4CB2B98A.8010605@domain.hid>	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>	<4CB36116.8090507@domain.hid>
	<4CB367AA.6020403@domain.hid>	<AANLkTimpY=60yJbWBwnu7KWZMst5ajFvrRoFzVx092oN@mail.gmail.com>	<AANLkTimTRK9RG6md3vVoohx7KFw2uwczZGGaXvajnPxq@domain.hid>
	<AANLkTimhhDqZnoURH8+8CU8bPx1KKMhemDJjwo8ni2sj@domain.hid>
In-Reply-To: <AANLkTimhhDqZnoURH8+8CU8bPx1KKMhemDJjwo8ni2sj@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig682E3C6E53F0DBF9258C528B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig682E3C6E53F0DBF9258C528B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 12.10.2010 03:55, Peter Pastor wrote:
> Hey Wolfgang,
>=20
> I made some great progress in the last few hours. I figured that the PE=
AK
> PCI can bus card had IRQ 11 according to "lspci" and after the kernel
> modules are loaded it switched to IRQ 16 which caused all the trouble s=
ince
> the USB and the SCSI controller have the same IRQ.
>=20
> Now, I just went ahead and hard coded
>=20
> /usr/src/xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c
> FUNCTION rtcan_sja1000_register...
> #############
>=20
>     chip->bus_err_on =3D 1;
>=20
>     printk("PETER chip->irq_num =3D %i\n", chip->irq_num);
>     chip->irq_num =3D 11;
>     printk("PETER chip->irq_num =3D %i\n", chip->irq_num);
>=20
>     ret =3D rtdm_irq_request(&dev->irq_handle,
>                chip->irq_num, rtcan_sja_interrupt,
>                chip->irq_flags, sja_ctrl_name, dev);

You can't change reality (physical wiring) this way.

If you do not need the USB interface, unbind the driver so that the
Linux IRQ usage ends:

echo 0000:00:1a.0 > /sys/bus/pci/drivers/ehci_hcd/unbind
     ^^^^^^^^^^^^
(fill in the according PCI ID)

Jan


--------------enig682E3C6E53F0DBF9258C528B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkyz+V0ACgkQitSsb3rl5xQzNwCggMS9iie3rzr8uYiW4pfHauHF
uasAn3gqBJkOJCFgPlzVqH/cYKyK4xNx
=FNVh
-----END PGP SIGNATURE-----

--------------enig682E3C6E53F0DBF9258C528B--

