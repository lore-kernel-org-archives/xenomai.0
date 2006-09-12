Message-ID: <4506A65E.2010208@domain.hid>
Date: Tue, 12 Sep 2006 14:21:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
References: <200609121330.16250.matthias.fuchs@domain.hid>
In-Reply-To: <200609121330.16250.matthias.fuchs@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C0EDB65224B625DD7987A52"
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
To: Matthias Fuchs <matthias.fuchs@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C0EDB65224B625DD7987A52
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Matthias Fuchs wrote:
> Hi,
>=20
> attached you will find a patch that adds support for memory mapped SJA1=
000 CAN=20
> controllers as they often can be found on embedded boards. The driver i=
s=20
> based on the rtmen_isa driver.

Thanks for your patch! Below are only cleanup comments, not all directed
to you as some of them originate back to the rtcan_isa driver.

>=20
> The driver has been tested on esd's embedded PowerPC boards with AMCC P=
PC405=20
> CPUs.
>=20
> Thanks to Jan for giving me some introduction to Xenomai during a night=
ly=20
> session last friday.
>=20
> There's one thing a I am not very satisfied with :-) Why passing half o=
f the=20
> external clock frequency to the module. Because of compatiblity reasons=
 I=20
> kept this behavior of the clock paramter from the ISA driver.

Wolfgang promised to rework this. I was also already about hacking some
can_sys_clock =3D clock[idx]/2 patch, but hesitated when I noticed that
the output in rtcan_raw_dev.c will print half of the provided frequency
then. Some smart documentation concept for those frequencies is required
first.

>=20
> Matthias
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: ksrc/drivers/can/sja1000/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/sja1000/Kconfig	(revision 1564)
> +++ ksrc/drivers/can/sja1000/Kconfig	(working copy)
> @@ -13,6 +13,16 @@
>         int "Maximum number of ISA devices"
>         default 4      =20
> =20
> +config XENO_DRIVERS_RTCAN_SJA1000_MEM
> +       depends on XENO_DRIVERS_RTCAN_SJA1000
> +       tristate "Memory mapped controllers"
> +       default n
> +
> +config XENO_DRIVERS_RTCAN_SJA1000_MEM_MAX_DEV
> +       depends on XENO_DRIVERS_RTCAN_SJA1000_MEM
> +       int "Maximum number of memory mapped controllers"
> +       default 4      =20
> +
>  config XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI
>         depends on XENO_DRIVERS_RTCAN_SJA1000
>         tristate "PEAK PCI Card"
> Index: ksrc/drivers/can/sja1000/rtcan_mem.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/sja1000/rtcan_mem.c	(revision 0)
> +++ ksrc/drivers/can/sja1000/rtcan_mem.c	(revision 0)
> @@ -0,0 +1,206 @@
> +/*
> + * Copyright (C) 2006 Matthias Fuchs <matthias.fuchs@domain.hid=
om>,
> + *                    Jan Kiszka <jan.kiszka@domain.hid>
> + *=20
> + * RTCAN driver for memory mapped SJA1000 CAN controller
> + * This code has been tested on esd's CPCI405/EPPC405 PPC405 systems.
> + *=20
> + * This driver is derived from the rtcan-isa driver by=20
> + * Wolfgang Grandegger and Sebastian Smolorz.=20
> + *
> + * Copyright (C) 2006 Wolfgang Grandegger <wg@domain.hid>
> + * Copyright (C) 2005, 2006 Sebastian Smolorz
> + *                          <Sebastian.Smolorz@domain.hid>
> + *
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; eitherer version 2 of the License, or=

> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but=

> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Foundat=
ion,
> + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/delay.h>
> +
> +#include <rtdm/rtdm_driver.h>
> +
> +#include <rtdm/rtcan.h>
> +#include <rtcan_dev.h>
> +#include <rtcan_raw.h>
> +#include <rtcan_internal.h>
> +#include <rtcan_sja1000.h>
> +#include <rtcan_sja1000_regs.h>
> +
> +#define RTCAN_DEV_NAME    "rtcan%d"
> +#define RTCAN_DRV_NAME    "sja1000-mem"

You don't use RTCAN_DRV_NAME, so we can kill it.

But this line triggered an idea about a new naming scheme for our CAN
drivers (the shorter, the better):

xeno_can		(core)

xeno_can_virt		(virtual CAN bus)

xeno_sja1000		(SJA1000 core)
xeno_sja1000_port (or _io)
xeno_sja1000_mem
xeno_sja1000_pci 	(generalised peak_pci if feasible)
xeno_sja1000_peakdng	(Peak parport dongle)

xeno_mscan


Moreover, file and CONFIG names should be shortened. I see no need for
rtcan-prefixes if the file reside in the drivers/can folder, or for
XENO_DRIVER_RTCAN when XENO already expresses "RT" (=3D>XENO_DRIVER_CAN).=


> +
> +#ifdef CONFIG_XENO_DRIVERS_RTCAN_MEM_MAX_DEVS
> +#define RTCAN_MEM_MAX_DEV CONFIG_XENO_DRIVERS_RTCAN_MEM_MAX_DEV
> +#else
> +#define RTCAN_MEM_MAX_DEV 2
> +#endif

This #ifdef is redundant (but copy&paste for rtcan_isa): there should be
no undefined CONFIG_XENO_DRIVERS_RTCAN_MEM_MAX_DEVS if this driver is
enabled for compilation.

> +
> +static char *mem_board_name =3D "mem mapped";
> +
> +MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@domain.hid>");
> +MODULE_DESCRIPTION("RTCAN driver for memory mapped SJA1000 controller"=
);
> +MODULE_SUPPORTED_DEVICE("mem mapped");
> +MODULE_LICENSE("GPL");
> +
> +static u32 mem[RTCAN_MEM_MAX_DEV];
> +static int irq[RTCAN_MEM_MAX_DEV];
> +static u32 clock[RTCAN_MEM_MAX_DEV];
> +static u8 ocr[RTCAN_MEM_MAX_DEV];
> +static u8 cdr[RTCAN_MEM_MAX_DEV];
> +
> +compat_module_int_param_array(mem, RTCAN_MEM_MAX_DEV);
> +compat_module_int_param_array(irq, RTCAN_MEM_MAX_DEV);
> +compat_module_int_param_array(clock, RTCAN_MEM_MAX_DEV);
> +compat_module_byte_param_array(ocr, RTCAN_MEM_MAX_DEV);
> +compat_module_byte_param_array(cdr, RTCAN_MEM_MAX_DEV);
> +
> +MODULE_PARM_DESC(mem, "The io-memory address");
> +MODULE_PARM_DESC(irq, "The interrupt number");
> +MODULE_PARM_DESC(clock, "CAN system clock frequency (default 8 MHz)");=

> +MODULE_PARM_DESC(ocr, "Value of output control register (default 0x1a)=
");
> +MODULE_PARM_DESC(cdr, "Value of clock divider register (default 0xc8")=
;
> +
> +#define RTCAN_MEM_RANGE 0x80
> +
> +struct rtcan_mem
> +{
> +    u8 *mem;=20
> +};
> +
> +static struct rtcan_device *rtcan_mem_devs[RTCAN_MEM_MAX_DEV];
> +
> +static u8 rtcan_mem_readreg(struct rtcan_device *dev, int reg)
> +{
> +    struct rtcan_mem *board =3D (struct rtcan_mem *)dev->board_priv;
> +    return readb(board->mem + reg);
> +}
> +
> +static void rtcan_mem_writereg(struct rtcan_device *dev, int reg, u8 v=
al)
> +{
> +    struct rtcan_mem *board =3D (struct rtcan_mem *)dev->board_priv;
> +    writeb(val, board->mem + reg);
> +}
> +
> +int __init rtcan_mem_init_one(int idx)
> +{
> +    struct rtcan_device *dev;
> +    struct rtcan_sja1000 *chip;
> +    struct rtcan_mem *board;
> +    int ret;
> +   =20
> +    if ((dev =3D rtcan_dev_alloc(sizeof(struct rtcan_sja1000),
> +			       sizeof(struct rtcan_mem))) =3D=3D NULL)
> +        return -ENOMEM;
> +
> +    chip =3D (struct rtcan_sja1000 *)dev->priv;
> +    board =3D (struct rtcan_mem *)dev->board_priv;
> +
> +    dev->board_name =3D mem_board_name;=20
> +
> +    chip->irq_num =3D irq[idx];
> +    chip->irq_flags =3D RTDM_IRQTYPE_SHARED;
> +    chip->read_reg =3D rtcan_mem_readreg;
> +    chip->write_reg =3D rtcan_mem_writereg;
> +
> +    /* ioremap io memory */
> +    if (!(board->mem =3D (u8*)ioremap(mem[idx], RTCAN_MEM_RANGE))) {
> +	ret =3D -EBUSY;
> +	goto out_dev_free;
> +    }
> +
> +    /* Clock frequency in Hz */
> +    if (clock[idx])
> +	dev->can_sys_clock =3D clock[idx];
> +    else
> +	dev->can_sys_clock =3D 8000000; /* 16/2 MHz */
> +
> +    /* Output control register */
> +    if (ocr[idx])
> +	chip->ocr =3D ocr[idx];
> +    else
> +	chip->ocr =3D SJA_OCR_MODE_NORMAL | SJA_OCR_TX0_PUSHPULL;
> +
> +    if (cdr[idx])
> +	chip->cdr =3D cdr[idx];
> +    else
> +	chip->cdr =3D SJA_CDR_CAN_MODE | SJA_CDR_CLK_OFF | SJA_CDR_CBP;
> +
> +    strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
> +
> +    ret =3D rtcan_sja1000_register(dev);
> +    if (ret) {
> +	printk(KERN_ERR "ERROR %d while trying to register SJA1000 device!\n"=
,
> +	       ret);
> +	goto out_free_region;
> +    }
> +   =20
> +    rtcan_mem_devs[idx] =3D dev;
> +    return 0;
> +   =20
> + out_free_region:
> +    iounmap(board->mem);
> +
> + out_dev_free:
> +    rtcan_dev_free(dev);
> +
> +    return ret;
> +}
> +
> +/** Init module */
> +static int __init rtcan_mem_init(void)
> +{
> +    int                         i;
> +    int                         ret;
> +    int done =3D 0;

Not nicely formatted. BTW, as this is new code to be included, we should
take the chance and convert it to kernel style right from the beginning. =
:)

> +    for (i =3D 0;=20
> +	 i < RTCAN_MEM_MAX_DEV && mem[i] !=3D 0;=20
> +	 i++) {
> +
> +	if ((ret =3D rtcan_mem_init_one(i) !=3D 0)) {
> +	    return ret;
> +	}
> +	done++;
> +    }
> +    if (done)
> +	return 0;
> +    printk(KERN_ERR "ERROR! No devices specified! "
> +	   "Use mem=3D<base_addr1>[,...] irq=3D<irq1>[,...]\n");
> +
> +    return -EINVAL;
> +}
> +
> +
> +/** Cleanup module */
> +static void __exit rtcan_mem_exit(void)
> +{
> +    int i;
> +    struct rtcan_device *dev;
> +    u8 *mem;
> +
> +    for (i =3D 0; i < RTCAN_MEM_MAX_DEV; i++) {
> +	    dev =3D rtcan_mem_devs[i];
> +	    if (!dev)
> +		    continue;
> +	    mem =3D ((struct rtcan_mem *)dev->board_priv)->mem;
> +	    rtcan_sja1000_unregister(dev);
> +	    iounmap(mem);
> +    }
> +}
> +
> +module_init(rtcan_mem_init);
> +module_exit(rtcan_mem_exit);
> Index: ksrc/drivers/can/sja1000/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/sja1000/Makefile	(revision 1564)
> +++ ksrc/drivers/can/sja1000/Makefile	(working copy)
> @@ -8,11 +8,13 @@
>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI) +=3D xeno_rtcan_peak=
_pci.o
>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_DNG) +=3D xeno_rtcan_peak=
_dng.o
>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_ISA) +=3D xeno_rtcan_isa.o
> +obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_MEM) +=3D xeno_rtcan_mem.o
> =20
>  xeno_rtcan_sja1000-y :=3D rtcan_sja1000.o rtcan_sja1000_proc.o
>  xeno_rtcan_peak_pci-y :=3D rtcan_peak_pci.o
>  xeno_rtcan_peak_dng-y :=3D rtcan_peak_dng.o
>  xeno_rtcan_isa-y :=3D rtcan_isa.o
> +xeno_rtcan_mem-y :=3D rtcan_mem.o
> =20
>  else
> =20
> @@ -24,6 +26,7 @@
>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI) +=3D xeno_rtcan_peak=
_pci.o=20
>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_DNG) +=3D xeno_rtcan_peak=
_dng.o=20
>  obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_ISA) +=3D xeno_rtcan_isa.o=20
> +obj-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_MEM) +=3D xeno_rtcan_mem.o
> =20
>  list-multi :=3D xeno_rtcan_sja1000.o=20
> =20
> @@ -31,6 +34,7 @@
>  xeno_rtcan_peak_pci-objs :=3D rtcan_peak_pci.o
>  xeno_rtcan_peak_dng-objs :=3D rtcan_peak_dng.o
>  xeno_rtcan_isa-objs :=3D rtcan_isa.o
> +xeno_rtcan_mem-objs :=3D rtcan_mem.o
> =20
>  export-objs :=3D $(xeno_rtcan_sja1000-objs)
> =20
> @@ -49,4 +53,7 @@
> =20
>  xeno_rtcan_isa.o: $(xeno_rtcan_isa-objs)
>  	$(LD) -r -o $@ $(xeno_rtcan_isa-objs)
> +
> +xeno_rtcan_mem.o: $(xeno_rtcan_mem-objs)
> +	$(LD) -r -o $@ $(xeno_rtcan_mem-objs)
>  endif
>=20

Patch for scripts/Modules.frag is missing (=3D> built-in compilation unde=
r
2.4) - just like for rtcan_isa... :-/

Jan


--------------enig8C0EDB65224B625DD7987A52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBqZeniDOoMHTA+kRAtZ9AJ9baUX+bXeP542ejaGHOI501wFJugCeN9Z8
zPlXjAP8VVRNHcy0agYRZ4s=
=3Jjh
-----END PGP SIGNATURE-----

--------------enig8C0EDB65224B625DD7987A52--

