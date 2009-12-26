From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B36515C.1070708@domain.hid>
References: <4B309A29.6030405@domain.hid> <4B316C4B.1030009@domain.hid>
	<4B320DF6.9010506@domain.hid> <4B35543D.2000809@domain.hid>
	<4B36515C.1070708@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 26 Dec 2009 19:27:42 +0100
Message-ID: <1261852062.19080.288.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build tests: analogy, blackfin, rtcan and nios2.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Sat, 2009-12-26 at 19:09 +0100, Gilles Chanteperdrix wrote:
> Alexis Berlemont wrote:
> > Hi Gilles,
> > 
> > Gilles Chanteperdrix wrote:
> >> Alexis Berlemont wrote:
> >>> Hi Gilles,
> >>>
> >>> Gilles Chanteperdrix wrote:
> >>>> Hi,
> >>>>
> >>>> Since I started talking about it, I have run build tests fixing a few
> >>>> things here and there. The current status is this (still at the same
> >>>> place: http://sisyphus.hd.free.fr/~gilles/bx):
> >>>>
> >>>> * analogy: I have tried to disable some parts of analogy when compiling
> >>>> on machines without CONFIG_PCI, as compiling parts using PCI on a
> >>>> machine without PCI support, give various levels of warning and even
> >>>> errors depending on the architecture. Doing this, I stumbled across this
> >>>> compilation error:
> >>>> http://sisyphus.hd.free.fr/~gilles/bx/beagle/2.6.28-arm-none-linux-gnueabi-gcc-4.3.3/log.html#1
> >>>> this is with CONFIG_NI_MIO, but without CONFIG_NI_MITE.
> >>>>
> >>>> So, Alex, could you:
> >>>> - fix that error, if this combination is supposed to make sense
> >>> Yes it makes sense. I think the MITE is integrated into all PCI boards
> >>> but the driver should work with the MITE disabled (one day, we could add
> >>> the ISA boards).
> >>>> - fix the Kconfig/Makefile so that no PCI code is compiled if CONFIG_PCI
> >>>> is not set (I tried and do this myself, but better one who knows than
> >>>> 100 who have to search...). As I said, doing this result in various
> >>>> levels of success depending on the architecture.
> >>> Ack. I will fix these problems as quickly as possible.
> >> Ok. The fix for the second problem would be nice to have soon, as
> >> analogy breaks the build on blackfin for this reason. If it is of any
> >> help, you can send me a patch for this fix only which I will apply on my
> >> side while you are working on other changes.
> >>
> > 
> > I modified the common part of the NI driver so that the PCI code can be 
> > disabled without any compilation issues.
> > 
> > I made a pull request which contains the fixes.
> 
> Thanks, but well, the compilation still fails on blackfin:
> http://sisyphus.hd.free.fr/~gilles/bx/bf537-stamp/2.6.30-bfin-uclinux-gcc-4.1.2/log.html#13
> 

This is because arch/blackfin/include/asm/pci.h does not include
asm-generic/pci-dma-compat.h in 2.6.30 yet. Upstream fixed this is
2.6.31.

So either we patch in some ugliness like below, or I issue a revised
pipeline patch for 2.6.30.6 which fixes this upstream bug.

diff --git a/include/asm-blackfin/wrappers.h b/include/asm-blackfin/wrappers.h
index 6556e74..6111f64 100644
--- a/include/asm-blackfin/wrappers.h
+++ b/include/asm-blackfin/wrappers.h
@@ -27,6 +27,11 @@
 #include <asm-generic/xenomai/wrappers.h> /* Read the generic portion. */
 #include <linux/interrupt.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+#include <linux/pci.h>
+#include <asm-generic/pci-dma-compat.h>
+#endif
+
 #define wrap_phys_mem_prot(filp,pfn,size,prot)	(prot)
 
 #define wrap_strncpy_from_user(dstP, srcP, n)	strncpy_from_user(dstP, srcP, n)

> And we get a new warning on most platforms (x86 and powerpc, and ixp4xx,
> which is an ARM with PCI support).
> 


-- 
Philippe.



