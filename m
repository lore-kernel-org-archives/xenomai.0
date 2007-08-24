Message-ID: <46CF2970.6070804@domain.hid>
Date: Fri, 24 Aug 2007 20:54:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46CC16CD.7080603@domain.hid>
In-Reply-To: <46CC16CD.7080603@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3F4AC6E580B9240B8E5251DE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN driver for EMS CPC PCI card
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
--------------enig3F4AC6E580B9240B8E5251DE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> the following patch changes:
>=20
> 2007-08-22  Wolfgang Grandegger  <wg@domain.hid>
>=20
>     * ksrc/drivers/can/sja1000: Add the RT-Socket-CAN SJA1000 driver
>     rtcan_ems_pci.c for the EMS CPC PCI card from EMS Dr. Thomas
>     Wuensche (http://www.ems-wuensche.de).
>=20
> I would like to apply it to Xenomai's trunk and v2.3.x branch.
>=20

I few quick comments from my side:

 - Could you submit new code already Lindent'ified? This keeps the
   effort bounded to convert the rest one day.

> Index: ksrc/drivers/can/sja1000/rtcan_ems_pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(revision 0)
> +++ ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(revision 0)
=2E..
> +#define EMS_PCI_SINGLE 0 /* this is a single channel device */

This define is unused - is this intended?

> +static int rtcan_ems_pci_add_chan(struct pci_dev *pdev, int channel,
> +				   struct rtcan_device **master_dev)
> +{
> +    struct rtcan_device *dev;
> +    struct rtcan_sja1000 *chip;
> +    struct rtcan_ems_pci *board;
> +    unsigned long addr;
> +    int ret, init_step =3D 1;

ret!=3D0 always means error here? In that case I find "err" a more tellin=
g
variable name ("if (err) ..." -- personal flavour).

> +    /* Register and setup interrupt handling */
> +#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
> +    chip->irq_flags =3D RTDM_IRQTYPE_SHARED;
> +#else
> +    chip->irq_flags =3D 0;
> +#endif

That #ifdef is redundant, just use RTDM_IRQTYPE_SHARED unconditionally.

> +#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
> +    if ((ret =3D rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
> +				      &master_dev)))
> +	    goto failure_cleanup;
> +    if ((ret =3D rtcan_ems_pci_add_chan(pdev, EMS_PCI_SLAVE,
> +				      &master_dev)))
> +	    goto failure_cleanup;
> +#else
> +    printk("Shared interrupts not enabled, using single channel!\n");
> +    if ((ret =3D rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
> +				      &master_dev)))
> +	    goto failure_cleanup;
> +#endif

The master registration should be moved out off the #ifdef - it's identic=
al.

Besides this, I have no concerns merging it, also into 2.3. Thanks for
your effort!

Jan


--------------enig3F4AC6E580B9240B8E5251DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGzylwniDOoMHTA+kRAsgbAJ9ygtpO+mkN7mV9FcsXAQ4YNrYAVACcCAJG
dDXAnWJC1wzc11PTl+eIybg=
=sGpX
-----END PGP SIGNATURE-----

--------------enig3F4AC6E580B9240B8E5251DE--

