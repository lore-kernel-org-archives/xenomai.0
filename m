From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] PPC405: DMA-problem solved!
Date: Mon, 22 Jan 2007 08:22:47 +0100
References: <200701172333.25574.niklaus.giger@domain.hid>
	<200701200006.45387.niklaus.giger@domain.hid>
	<45B1CD21.1090307@domain.hid>
In-Reply-To: <45B1CD21.1090307@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IZGtFuGejo9MNLo"
Message-Id: <200701220822.48046.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_IZGtFuGejo9MNLo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Forgot to cc @xenomai-core this e-mail sent yesterday to Jan)
Am Samstag, 20. Januar 2007 09:04 schrieben Sie:
> Niklaus Giger wrote:
<..>
> This demo is about how to use the driver API (/wrt interrupts) + how to
> do PPC4xx-specific DMA. So my suggestion:
>
> examples/rtdm/driver-api/dma-ppc4xx.c
Agreed. See new version in the attached patch.
>
> In any case, we need to resolve the arch dependency somehow. I guess
> it will =A0currently not fly when I kick the full build in examples/ for a
> non-PPC platform. Any *simple* way to catch this? Would also be
> applicable to the heartbeat-x86 example then, though this will not cause
> build troubles.
Is my proposed solution in the Makefile okay for you?
How do you kick your full build? Does it still work now?

<..>
> > + * The following patches must be applied to your kernel to fix bugs
>
> Which kernel? I guess this issue will not persist forever.
> > + *
> > http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025697.html +
> > * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025700.html
> > + *
> > + * Beware!
> > + * The kernel option PPC4xx DMA must be activated for this test.
>
> Please provide the full CONFIG_OPTION_NAME here.
=46ixed.
<..>
> Why do we have a compiler warning here, why not a comment?
=46ixed.
> > +#warning flush_dcache_all is a performance killer, but I do not know at
> > the +#warning moment how to flush only the parts needed
>
> Can we resolve this? Wolfgang?
> > +=A0=A0=A0flush_dcache_all(); /* from arch/ppc/kernel/misc.S */
I think we cannot fix this, as it is probably a weakness of the port to
PPC4xx. I tried various procedures *dcache* procedure which all lead to ker=
nel=20
oops. I changed the comment a little to reflect the change.

I looked also at dma_alloc_coherent, but this need a driver structure which=
 I=20
do not have in this example. I have no time at this moment to really dig=20
deeper into the 4xx-DMA problems. But I might be forced to do it later once=
 I=20
get hands on our new PPC440EPx based board later (around March/April this=20
year). I remember spending quite a few hours on this problem years ago on o=
ur=20
first PPC403GA board (but running vxWorks).

<..>
>
> This demo will go to trunk, thus rtdm_irq_enable is no longer needed.
>
Didn't know. Fixed.
<..>
> Disabling is typically not needed, unless it is the only way to silence
> the IRQ source. Keep in mind that this disabling would be fatal if the
> IRQ happened to be shared (though unusual on PPC, AFAIK).
>
Thanks for catching this error. Fixed.
<..>
> > +install:: =A0 $(APPLICATIONS)
> > +=A0=A0=A0cp $(APPLICATIONS) $(EXEC_PREFIX)/
> > +
>
> NACK. I'd rather like to keep the makefile focused (the next step would
> be to add uninstall, then ...).
Added a comment on top of the Makefile about how to call it for cross=20
compiling.

I changed the target to modules_install, but still think that this is usefu=
l=20
for my use, eg. without it I have no direct way to access the kernel module=
=20
from my NFS-mounted rootfs when I want to run a test on my target board.
Another solution would be to add an example script to cross compile like th=
e=20
following (tested) snippet
> make \
> -C =A0 /usr/src/linux-2.6.19.1 \
> KSRC=3D/usr/src/linux-2.6.19.1 \
> ARCH=3Dppc \
> O=3D/usr/src/build-hcu3-2.6.19.1 \
> INSTALL_MOD_PATH=3D/home/hcu/rootfs/niklaus_2.6.19 \
> CROSS_COMPILE=3Dppc_4xx- =A0\
> PATH=3D/opt/eldk/4_0/usr/bin:$PATH \
> SUBDIRS=3D`pwd` \
> modules modules_install

Thanks for your careful review.

Best regards
=2D--
Niklaus Giger

--Boundary-00=_IZGtFuGejo9MNLo
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dma-ppc4xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dma-ppc4xx.patch"

Index: examples/rtdm/driver-api/dma-ppc4xx.c
===================================================================
--- examples/rtdm/driver-api/dma-ppc4xx.c	(Revision 0)
+++ examples/rtdm/driver-api/dma-ppc4xx.c	(Revision 0)
@@ -0,0 +1,169 @@
+/* * Written by Niklaus Giger <niklaus.giger@domain.hid>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ ****************************************************************************
+ *
+ * This is an example howto write a Xenomai kernel module which handles a
+ * HW interrupt. The example is PPC4xx specific (testd on a PPC405 board)
+ * Probably also works on a PPC44x (not yet tested, needs a different irq?).
+ *
+ * Beware!
+ * The following patches had to be applied against the 2.6.19.2 linux kernel
+ * to fix bugs in arch/ppc/syslib/ppc4xx_dma.c
+ * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025697.html
+ * http://ozlabs.org/pipermail/linuxppc-embedded/2007-January/025700.html
+ *
+ * Beware!
+ * The kernel option CONFIG_PPC4xx_DMA must be activated for this test.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <asm/ppc4xx_dma.h>
+
+#include <rtdm/rtdm_driver.h>
+#include <rtdm/rtdm.h>
+rtdm_irq_t irq_handle;
+
+MODULE_DESCRIPTION("PPC4xx DMA3 interrupt demo");
+MODULE_AUTHOR("niklaus.giger@domain.hid");
+MODULE_LICENSE("GPL");
+
+#define DMA_NR 3
+int irq = DMA_NR + 5; /* DMA-x interrupt line  on PPC405GPr */
+
+#define TEST_STRING  "Could we use a DMA + interrupt to copy a string?"
+#define TEST_STRING2 "Should be overwritten."
+#define STRING_SIZE 128
+
+char *SRC;
+char *DST;
+
+static ppc_dma_ch_t p_init;
+
+#define show_irq(irq) 	{						\
+	printk("%32s: IRQ %2d uipr 0x%08x uier 0x%08x uisr 0x%08x\n",	\
+		__FUNCTION__, irq, 					\
+		mfdcr(DCRN_UIC_PR(UIC0)), mfdcr(DCRN_UIC_ER(UIC0)),	\
+		mfdcr(DCRN_UIC_SR(UIC0)));				\
+	printk("%32s: residue %d status 0x08%x cntrl 0x%08x\n",__FUNCTION__,\
+		ppc4xx_get_dma_residue(DMA_NR),				\
+		ppc4xx_get_dma_status(),				\
+		mfdcr(DCRN_DMACR0 + (DMA_NR * 0x8)));			\
+	printk("src at %p is %s\ndst at %p is %s\n", (char *)SRC,	\
+		SRC, &DST[0], &DST[0]); }
+
+void dma_mem_to_mem(void *src, void *dst, unsigned int length,
+			unsigned int use_interrupt)
+{
+	/* Do not use dma_mem_to_mem for OnChipMemory! It will not work. */
+	int res = 0;
+	memset((char *)&p_init, sizeof(p_init), 0);
+	p_init.polarity = 0;
+	p_init.pwidth   = PW_8;
+ 	res = ppc4xx_init_dma_channel(DMA_NR, &p_init);
+	if (res) {
+		printk("%32s: nit_dma_channel return %d %d bytes dest %p\n",
+			__FUNCTION__, res, length, dst);
+	}
+	res = ppc4xx_clr_dma_status(DMA_NR);
+	if (res) { 
+		printk("%32s: ppc4xx_clr_dma_status %d\n", __FUNCTION__, res);
+	}
+	/*
+	 * flush_dcache_all is a performance killer, but is does work on a
+	 * PPC405GPr as it does not use any of the DCU instructions like dcbf.
+	 * Procedures like flush_dcache_range produce:
+	 * Oops: kernel access of bad area, sig: 11 [#1]
+	 * Probably all these procedure should be fixe for PPC40x
+	*/
+	flush_dcache_all(); /* from arch/ppc/kernel/misc.S */
+	ppc4xx_set_dma_mode(DMA_NR, DMA_MODE_MM);
+	ppc4xx_set_src_addr(DMA_NR, virt_to_bus(src));
+	ppc4xx_set_dst_addr(DMA_NR, virt_to_bus(dst));
+	ppc4xx_set_dma_count(DMA_NR, length);
+	ppc4xx_enable_dma(DMA_NR);
+	if (use_interrupt) {
+		res = ppc4xx_enable_dma_interrupt(DMA_NR);
+	} else {
+		res = ppc4xx_disable_dma_interrupt(DMA_NR);
+	}
+	if (res) { 
+		printk("%32s: en/disable_dma_interrupt %d return %d per %d\n",
+		__FUNCTION__, use_interrupt, res, 
+		ppc4xx_get_peripheral_width(DMA_NR));
+	}
+}
+
+int dma_irq_handler(rtdm_irq_t *irq_handle)
+{
+	ppc4xx_disable_dma(DMA_NR);
+	ppc4xx_disable_dma_interrupt(DMA_NR);
+	show_irq(irq);
+	return RTDM_IRQ_HANDLED;
+}
+
+int init_module()
+{
+	if (rtdm_irq_request(&irq_handle, irq,  
+			dma_irq_handler, 0, "dma3_4xx", 0)) {
+		printk("%s:%s Error: rtdm_irq_request failed\n",
+			 __FILE__, __FUNCTION__);
+		return 1;
+	}
+	SRC = (char *)__get_free_pages(GFP_KERNEL | GFP_DMA, 
+				get_order(STRING_SIZE));
+	DST = (char *)__get_free_pages(GFP_KERNEL | GFP_DMA, 
+				get_order(STRING_SIZE));
+
+	strncpy(SRC, TEST_STRING,  STRING_SIZE);
+	strncpy(DST, TEST_STRING2, STRING_SIZE);
+
+	dma_mem_to_mem(SRC, DST, STRING_SIZE, 1);
+	if (ppc4xx_get_dma_residue(DMA_NR)) { 
+		printk("%32s: residue %d status 0x%x\n",__FUNCTION__,
+		ppc4xx_get_dma_residue(DMA_NR),
+		ppc4xx_get_dma_status());
+	}
+	return 0;
+	
+	
+}
+
+void cleanup_module ()
+{
+	ppc_dma_ch_t dma_ch;
+	if (ppc4xx_get_dma_residue(DMA_NR)) {
+		printk("%32s: residue %d status 0x%x\n",__FUNCTION__,
+		ppc4xx_get_dma_residue(DMA_NR),
+		ppc4xx_get_dma_status());
+	}
+	ppc4xx_get_channel_config(DMA_NR, &dma_ch);
+	printk("%32s: dma_ch.control 0x%x %d SRC %p %s\n",__FUNCTION__,
+		dma_ch.control,	dma_ch.pwidth, SRC,__TIME__);
+
+	if (rtdm_irq_free (&irq_handle)) {
+		printk("%32s: rtdm_irq_free failed\n",__FUNCTION__);
+	}
+	show_irq(irq);
+	if (strncmp(DST, TEST_STRING, STRING_SIZE) == 0) {
+		printk("%32s: DMA transfer succedded\n",__FUNCTION__);
+	} else {
+		printk("%32s: DMA transfer failed !!!!!\n",__FUNCTION__);
+	}
+}
Index: examples/rtdm/driver-api/Makefile
===================================================================
--- examples/rtdm/driver-api/Makefile	(Revision 2079)
+++ examples/rtdm/driver-api/Makefile	(Arbeitskopie)
@@ -1,14 +1,45 @@
 ###### CONFIGURATION ######
+# If Xenomai was installed with DESTDIR set, the same must be provided here.
+# To cross-compile you might call make with something like:
+# make 	ARCH=ppc \
+#	DESTDIR=/home/hcu/rootfs/linux_2.6.19 \
+#	O=/usr/src/build-hcu3-2.6.19.1 \
+#	KSRC=/usr/src/linux-2.6.19.1  \
+#	CROSS_COMPILE=ppc_4xx-  \
+#	PATH=/opt/eldk/4_0/usr/bin:$PATH \
+#	all
 
 ### List of applications to be build
-APPLICATIONS =
 
+PPC_APPLICATIONS =
+X86_APPLICATIONS =
+
 ### Note: to override the search path for the xeno-config script, use "make XENO=..."
 
-
 ### List of modules to be build
-MODULES = heartbeat-x86
+PPC_MODULES = dma-ppc4xx
+X86_MODULES = heartbeat-x86
 
+### Set modules to build depending on ARCH, defaults to currently running machine
+ifdef ARCH
+ifeq ($(ARCH), ppc)
+MODULES      ?= $(PPC_MODULES)
+APPLICATIONS ?= $(PPC_APPLICATIONS)
+else ifeq ($(ARCH), x86)
+MODULES      ?= $(X86_MODULES)
+APPLICATIONS ?= $(X86_APPLICATIONS)
+endif
+else	# ARCH not defined
+ifeq ($(shell uname -m), ppc)
+MODULES      ?= $(PPC_MODULES)
+APPLICATIONS ?= $(PPC_APPLICATIONS)
+endif
+ifeq (86,$(findstring 86,$(shell (uname -m))))
+MODULES      ?= $(X86_MODULES)
+APPLICATIONS ?= $(X86_APPLICATIONS)
+endif
+endif	# ARCH not defined
+
 ### Default to sources of currently running kernel
 KSRC ?= /lib/modules/$(shell uname -r)/build
 
@@ -57,9 +88,15 @@
 obj-m        := $(OBJS)
 EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)
 
-all::
+modules:
 	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules
 
+modules_install: modules
+	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) INSTALL_MOD_PATH=$(DESTDIR) modules modules_install
+
+all::	modules
+	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules
+
 ### Kernel 2.4
 else
 
@@ -67,16 +104,17 @@
 INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
 CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE)
 
+## Target for capturing 2.4 module CFLAGS
+modules:
+	@echo "$(CFLAGS)"
+
 all:: $(OBJS)
 
 endif
 
-## Target for capturing 2.4 module CFLAGS
-modules:
-	@echo "$(CFLAGS)"
-
 clean::
-	$(RM) $(CLEANMOD) *.cmd *.o *.ko *.mod.c Module*.symvers
+	$(RM) $(CLEANMOD) .*.cmd *.o *.ko *.mod.c Module*.symvers
 	$(RM) -R .tmp*
 
 endif
+

--Boundary-00=_IZGtFuGejo9MNLo--

