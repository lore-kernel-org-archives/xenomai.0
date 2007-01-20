Message-ID: <45B1CD21.1090307@domain.hid>
Date: Sat, 20 Jan 2007 09:04:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PPC405: DMA-problem solved!
References: <200701172333.25574.niklaus.giger@domain.hid>	<45AF306E.4070606@domain.hid>
	<200701200006.45387.niklaus.giger@domain.hid>
In-Reply-To: <200701200006.45387.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB4FB1FB617F50AAA5DFDA020"
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4FB1FB617F50AAA5DFDA020
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Donnerstag, 18. Januar 2007 09:31 schrieb Wolfgang Grandegger:
>> Niklaus Giger wrote:
>>> Hi
>>>
>>> I tried to simply an example program how to use interrupts
>>> with Xenomai (see attached Makefile & dma_4xx_int_module.c).
>>>
>>> The interrupt part of the example works, but the DMA transfer (memory=
 to
>>> memory) using the OnChipMemory fails. I think I must somewhere specif=
y
>>> that the src/dst adressed should not be cached, but I do not know how=
 to
>>> do it.
>> consistant_alloc() should help. It's used in the kernel in various
>> places, e.g. in "drivers/net/ibm_emac".
>=20
> Thank you for your tips.
>=20
> After fixing two bugs in arch/ppc/syslib/ppc4xx_dma.c. See =20
>  * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025697.ht=
ml
>  * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025700.ht=
ml
> my example code worked (tested with DMA channel 0 and DMA channel 3).
> <..>
>=20
> Interrupt code is ported to RTDM.
>=20
> @Jan: Can the attached patch be applied?

Almost, just the usual nitpicking comments below. :)

>=20
> Best regards
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: examples/rtdm/pp4xx_interrupt/dma_4xx_int_module.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- examples/rtdm/pp4xx_interrupt/dma_4xx_int_module.c	(Revision 0)
> +++ examples/rtdm/pp4xx_interrupt/dma_4xx_int_module.c	(Revision 0)

This demo is about how to use the driver API (/wrt interrupts) + how to
do PPC4xx-specific DMA. So my suggestion:

examples/rtdm/driver-api/dma-ppc4xx.c

In any case, we need to resolve the arch dependency somehow. I guess
it will  currently not fly when I kick the full build in examples/ for a
non-PPC platform. Any *simple* way to catch this? Would also be
applicable to the heartbeat-x86 example then, though this will not cause
build troubles.

> @@ -0,0 +1,167 @@
> +/* * Written by Niklaus Giger <niklaus.giger@domain.hid>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
> + *
> + *********************************************************************=
*******
> + *
> + * This is an example howto write a Xenomai kernel module which handle=
s a
> + * HW interrupt. The example is PPC4xx specific (testd on a PPC405 boa=
rd)
> + * Probably also works on a PPC44x (not yet tested, needs a different =
irq?).
> + *
> + * Beware!
> + * The following patches must be applied to your kernel to fix bugs

Which kernel? I guess this issue will not persist forever.

> + * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025697.h=
tml
> + * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025700.h=
tml
> + *
> + * Beware!
> + * The kernel option PPC4xx DMA must be activated for this test.

Please provide the full CONFIG_OPTION_NAME here.

> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <asm/ppc4xx_dma.h>
> +
> +#include <rtdm/rtdm_driver.h>
> +#include <rtdm/rtdm.h>
> +rtdm_irq_t irq_handle;
> +
> +MODULE_DESCRIPTION("PPC4xx DMA3 interrupt demo");
> +MODULE_AUTHOR("niklaus.giger@domain.hid");
> +MODULE_LICENSE("GPL");
> +
> +#define DMA_NR 3
> +int irq =3D DMA_NR + 5; /* DMA-x interrupt line  on PPC405GPr */
> +
> +#define TEST_STRING  "Could we use a DMA + interrupt to copy a string?=
"
> +#define TEST_STRING2 "Should be overwritten."
> +#define STRING_SIZE 128
> +
> +char *SRC;
> +char *DST;
> +
> +static ppc_dma_ch_t p_init;
> +
> +#define show_irq(irq) 	{						\
> +	printk("%32s: IRQ %2d uipr 0x%08x uier 0x%08x uisr 0x%08x\n",	\
> +		__FUNCTION__, irq, 					\
> +		mfdcr(DCRN_UIC_PR(UIC0)), mfdcr(DCRN_UIC_ER(UIC0)),	\
> +		mfdcr(DCRN_UIC_SR(UIC0)));				\
> +	printk("%32s: residue %d status 0x08%x cntrl 0x%08x\n",__FUNCTION__,\=

> +		ppc4xx_get_dma_residue(DMA_NR),				\
> +		ppc4xx_get_dma_status(),				\
> +		mfdcr(DCRN_DMACR0 + (DMA_NR * 0x8)));			\
> +	printk("src at %p is %s\ndst at %p is %s\n", (char *)SRC,	\
> +		SRC, &DST[0], &DST[0]); }
> +
> +void dma_mem_to_mem(void *src, void *dst, unsigned int length,
> +			unsigned int use_interrupt)
> +{
> +#warning Do not use dma_mem_to_mem for OnChipMemory! It will not work.=


Why do we have a compiler warning here, why not a comment?

> +	int res =3D 0;
> +	memset((char *)&p_init, sizeof(p_init), 0);
> +	p_init.polarity =3D 0;
> +	p_init.pwidth   =3D PW_8;
> + 	res =3D ppc4xx_init_dma_channel(DMA_NR, &p_init);
> +	if (res) {
> +		printk("%32s: nit_dma_channel return %d %d bytes dest %p\n",
> +			__FUNCTION__, res, length, dst);
> +	}
> +	res =3D ppc4xx_clr_dma_status(DMA_NR);
> +	if (res) {=20
> +		printk("%32s: ppc4xx_clr_dma_status %d\n", __FUNCTION__, res);
> +	}
> +#warning flush_dcache_all is a performance killer, but I do not know a=
t the=20
> +#warning moment how to flush only the parts needed

Can we resolve this? Wolfgang?

> +	flush_dcache_all(); /* from arch/ppc/kernel/misc.S */
> +
> +	ppc4xx_set_dma_mode(DMA_NR, DMA_MODE_MM);
> +	ppc4xx_set_src_addr(DMA_NR, virt_to_bus(src));
> +	ppc4xx_set_dst_addr(DMA_NR, virt_to_bus(dst));
> +	ppc4xx_set_dma_count(DMA_NR, length);
> +	ppc4xx_enable_dma(DMA_NR);
> +	if (use_interrupt) {
> +		res =3D ppc4xx_enable_dma_interrupt(DMA_NR);
> +	} else {
> +		res =3D ppc4xx_disable_dma_interrupt(DMA_NR);
> +	}
> +	if (res) {=20
> +		printk("%32s: en/disable_dma_interrupt %d return %d per %d\n",
> +		__FUNCTION__, use_interrupt, res,=20
> +		ppc4xx_get_peripheral_width(DMA_NR));
> +	}
> +}
> +
> +int dma_irq_handler(rtdm_irq_t *irq_handle)
> +{
> +	ppc4xx_disable_dma(DMA_NR);
> +	ppc4xx_disable_dma_interrupt(DMA_NR);
> +	show_irq(irq);
> +	return RTDM_IRQ_HANDLED;
> +}
> +
> +int init_module()
> +{
> +	if (rtdm_irq_request(&irq_handle, irq,  dma_irq_handler, 0, "dma3_4xx=
", 0)) {
> +		printk("%s:%s Error: rtdm_irq_request failed\n",
> +			 __FILE__, __FUNCTION__);
> +		return 1;
> +	}
> +	show_irq(irq);
> +	if (rtdm_irq_enable (&irq_handle)) {
> +		printk("%s:%s Error: rtdm_irq_enable failed\n",
> +			 __FILE__, __FUNCTION__);
> +		return 1;
> +	}

This demo will go to trunk, thus rtdm_irq_enable is no longer needed.

> +
> +	SRC =3D (char *)__get_free_pages(GFP_KERNEL | GFP_DMA, get_order(STRI=
NG_SIZE));
> +	DST =3D (char *)__get_free_pages(GFP_KERNEL | GFP_DMA, get_order(STRI=
NG_SIZE));
> +
> +	strncpy(SRC, TEST_STRING,  STRING_SIZE);
> +	strncpy(DST, TEST_STRING2, STRING_SIZE);
> +
> +	flush_dcache_all(); /* from arch/ppc/kernel/misc.S */
> +	dma_mem_to_mem(SRC, DST, STRING_SIZE, 1);
> +	if (ppc4xx_get_dma_residue(DMA_NR)) {=20
> +		printk("%32s: residue %d status 0x%x\n",__FUNCTION__,
> +		ppc4xx_get_dma_residue(DMA_NR),
> +		ppc4xx_get_dma_status());
> +	}
> +	return 0;
> +=09
> +=09
> +}
> +
> +void cleanup_module ()
> +{
> +	ppc_dma_ch_t dma_ch;
> +	if (ppc4xx_get_dma_residue(DMA_NR)) {
> +		printk("%32s: residue %d status 0x%x\n",__FUNCTION__,
> +		ppc4xx_get_dma_residue(DMA_NR),
> +		ppc4xx_get_dma_status());
> +	}
> +	ppc4xx_get_channel_config(DMA_NR, &dma_ch);
> +	printk("%32s: dma_ch.control 0x%x %d SRC %p %s\n",__FUNCTION__, dma_c=
h.control,
> +		dma_ch.pwidth, SRC,__TIME__);
> +
> +	if (rtdm_irq_disable (&irq_handle)) {
> +		printk("%32s: rtdm_irq_disable failed\n",__FUNCTION__);
> +	}

Disabling is typically not needed, unless it is the only way to silence
the IRQ source. Keep in mind that this disabling would be fatal if the
IRQ happened to be shared (though unusual on PPC, AFAIK).

> +	if (rtdm_irq_free (&irq_handle)) {
> +		printk("%32s: rtdm_irq_free failed\n",__FUNCTION__);
> +	}
> +	show_irq(irq);
> +}
> Index: examples/rtdm/pp4xx_interrupt/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- examples/rtdm/pp4xx_interrupt/Makefile	(Revision 0)
> +++ examples/rtdm/pp4xx_interrupt/Makefile	(Revision 0)
> @@ -0,0 +1,47 @@
> +###### CONFIGURATION ######
> +###### Please adapt it to your needs
> +O:=3D/usr/src/build-hcu3-2.6.19.1
> +DESTDIR:=3D/home/hcu/rootfs/niklaus_2.6.19
> +KSRC:=3D/usr/src/linux-2.6.19.1
> +
> +ARCH:=3Dppc
> +CROSS_COMPILE:=3Dppc_4xx-
> +PATH:=3D/home/opt/eldk/4_0/usr/bin:/usr/local/bin:/usr/bin:/bin
> +M:=3D$(shell pwd)
> +
> +### List of applications to be build
> +XENO=3D$(DESTDIR)/usr/xenomai
> +### Note: to override the search path for the xeno-config script, use =
"make XENOCONFIG=3D..."
> +
> +
> +### List of modules to be build
> +MODULES =3D dma_4xx_int_module
> +
> +### Note: to override the kernel source path, use "make KSRC=3D..."
> +
> +###### KERNEL MODULE BUILD (no change required normally) ######
> +ifneq ($(MODULES),)
> +
> +OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
> +CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
> +PWD      :=3D $(shell if [ "$$PWD" !=3D "" ]; then echo $$PWD; else pw=
d; fi)
> +
> +### Kernel 2.6
> +obj-m        :=3D $(OBJS)
> +EXTRA_CFLAGS :=3D-I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/p=
osix $(ADD_CFLAGS)
> +
> +MODMAKE:=3Dmake CROSS_COMPILE=3D$(CROSS_COMPILE)  ARCH=3D$(ARCH) O=3D$=
(O) -C $(KSRC) M=3D$(M) PATH=3D$(PATH) -I$(KSRC)/include/xenomai
> +
> +modules:
> +	$(MODMAKE) modules
> +
> +install:	modules
> +	$(MODMAKE) INSTALL_MOD_PATH=3D$(DESTDIR) modules_install
> +
> +all::	modules
> +
> +clean::
> +	$(RM) $(CLEANMOD) *.cmd *.o *.ko *.mod.c Module*.symvers
> +	$(RM) -R .tmp*
> +
> +endif
> Index: examples/common/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- examples/common/Makefile	(Revision 2079)
> +++ examples/common/Makefile	(Arbeitskopie)
> @@ -3,9 +3,9 @@
>  ### List of applications to be build
>  APPLICATIONS =3D hw_direct_io
> =20
> -### Note: to override the search path for the xeno-config script, use =
"make XENO=3D..."
> +### Note: to override the search path for the xeno-config script, use =
"make XENOCONFIG=3D..."

If you prefer XENOCONFIG, please provide patches for the whole examples
repos. :)

> +### Note: if you installed it into a non standard place add DESTDIR=3D=
/path/to/installed/xenomai"

The hint to DESTDIR is useful, but the explanation should be more like
"if Xenomai was installed with DESTDIR set, the same must be provided her=
e".

> =20
> -
>  ### List of modules to be build
>  MODULES =3D
> =20
> @@ -14,6 +14,8 @@
> =20
>  ### Note: to override the kernel source path, use "make KSRC=3D..."
> =20
> +# default place to install the resulting binaries
> +EXEC_PREFIX :=3D $(DESTDIR)/usr/xenomai/bin
> =20
> =20
>  ###### USER SPACE BUILD (no change required normally) ######
> @@ -24,7 +26,9 @@
>  ### Sanity check
>  ifeq ($(XENOCONFIG),)
>  all::
> -	@echo ">>> Invoke make like this: \"make XENO=3D/path/to/xeno-config\=
" <<<"
> +	@echo ">>> Invoke make like this: \"make XENOCONFIG=3D/path/to/xeno-c=
onfig\" <<<"
> +	@echo ">>> add KSRC=3D.. to override the default kernel source at /li=
b/modules/$(shell uname -r)/build <<<"

KSRC is unrelated here (user space part of the makefile).

> +	@echo ">>> add DESTDIR=3D/path/to/installed/xenomai if you installed =
it into a non standard place <<<"

See earlier comment.

>  	@echo
>  endif
> =20
> @@ -40,6 +44,9 @@
>  clean::
>  	$(RM) $(APPLICATIONS) *.o
> =20
> +install::   $(APPLICATIONS)
> +	cp $(APPLICATIONS) $(EXEC_PREFIX)/
> +

NACK. I'd rather like to keep the makefile focused (the next step would
be to add uninstall, then ...).

>  endif
> =20
> =20
> @@ -80,3 +87,4 @@
>  	$(RM) -R .tmp*
> =20
>  endif
> +
>=20
>=20

Jan



--------------enigB4FB1FB617F50AAA5DFDA020
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsc0hniDOoMHTA+kRAgtRAJ0TIVCH2MNtWQbQE1gvg4AS2tZBdgCaApDv
THd5eUBQLaJJ7X3S+biMwSA=
=V3hC
-----END PGP SIGNATURE-----

--------------enigB4FB1FB617F50AAA5DFDA020--

