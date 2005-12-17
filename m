Message-ID: <43A436A1.5070509@domain.hid>
Date: Sat, 17 Dec 2005 17:02:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE07BC4F5F11287A94079FB7C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] debug_maxlat as module_param
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE07BC4F5F11287A94079FB7C
Content-Type: multipart/mixed; boundary="------------090606010101080901050309"

This is a multi-part message in MIME format.
--------------090606010101080901050309
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

this tiny patch exports the NMI watchdog's threshold as module parameter
"debug_maxlat" of xeno_hal. This means that one can either override the
value via a kernel parameter or in sysfs/modules/xeno_hal/parameters
(before activating the hal).

Unfortunately, this tiny patch caused some headache to me as it first
made the kernel crash early during boot in sysfs_create_group(). I do
not understand why I need the second patch, I only guessed from the
kernel build output that some unlucky linking order screwed up
module_params in xenomai's non-generic arch files. If this is the only
solution, we have to verify if 2.4 still works (untested) and we have to
patch the Makefiles of the other archs.

Jan


PS: The NMI watchdog is nice, but we are really lacking a qualified
backtrace with all invoked functions in a critical path. I'm optimistic
that we will see Fu's first latency trace patch version already next
week. :)

--------------090606010101080901050309
Content-Type: text/x-patch;
 name="maxlat_arg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="maxlat_arg.patch"

Index: ksrc/arch/i386/hal.c
===================================================================
--- ksrc/arch/i386/hal.c	(Revision 285)
+++ ksrc/arch/i386/hal.c	(Arbeitskopie)
@@ -212,7 +212,8 @@
 unsigned long rthal_maxlat_tsc;
 EXPORT_SYMBOL(rthal_maxlat_tsc);
 
-static unsigned rthal_maxlat_us = CONFIG_XENO_HW_NMI_DEBUG_LATENCY_MAX;
+unsigned rthal_maxlat_us_arg = CONFIG_XENO_HW_NMI_DEBUG_LATENCY_MAX;
+module_param_named(debug_maxlat, rthal_maxlat_us_arg, uint, 0644);
 
 static void rthal_latency_above_max(struct pt_regs *regs)
 {
@@ -220,7 +221,7 @@
     snprintf(buf,
              sizeof(buf),
              "NMI watchdog detected timer latency above %u us\n",
-             rthal_maxlat_us);
+             rthal_maxlat_us_arg);
     die_nmi(regs, buf);
 }
 #endif
@@ -297,7 +298,7 @@
 
 #ifdef CONFIG_XENO_HW_NMI_DEBUG_LATENCY
     if (!p->mode) {
-        rthal_maxlat_tsc = rthal_llimd(rthal_maxlat_us * 1000ULL,
+        rthal_maxlat_tsc = rthal_llimd(rthal_maxlat_us_arg * 1000ULL,
                                        RTHAL_CPU_FREQ,
                                        1000000000);
 
@@ -307,7 +308,7 @@
             printk("Xenomai: NMI watchdog not available.\n");
         else
             printk("Xenomai: NMI watchdog started (threshold=%u us).\n",
-		   rthal_maxlat_us);
+		   rthal_maxlat_us_arg);
     }
 #endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
 

--------------090606010101080901050309
Content-Type: text/x-patch;
 name="arch_generic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_generic.patch"

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(Revision 285)
+++ scripts/prepare-kernel.sh	(Arbeitskopie)
@@ -301,6 +301,7 @@
 # compilation files.
 
 do_links $xenomai_root/ksrc/arch/$xenomai_arch $linux_tree/arch/$linux_arch/xenomai
+do_links $xenomai_root/ksrc/arch/generic $linux_tree/arch/$linux_arch/xenomai/generic
 do_links $xenomai_root/ksrc $linux_tree/kernel/xenomai
 do_links $xenomai_root/ksrc/drivers $linux_tree/drivers/xenomai
 do_links $xenomai_root/include/asm-$xenomai_arch $linux_tree/include/asm-$linux_arch/xenomai
Index: ksrc/Makefile
===================================================================
--- ksrc/Makefile	(Revision 285)
+++ ksrc/Makefile	(Arbeitskopie)
@@ -2,14 +2,12 @@
 
 # Makefile frag for Linux v2.6
 
-obj-$(CONFIG_XENOMAI) += arch/ nucleus/ skins/
+obj-$(CONFIG_XENOMAI) += nucleus/ skins/
 
 else
 
 # Makefile frag for Linux v2.4
 
-subdir-$(CONFIG_XENOMAI) += arch
-
 subdir-$(CONFIG_XENO_OPT_NUCLEUS) += nucleus
 
 mod-subdirs := skins
Index: ksrc/arch/Makefile
===================================================================
--- ksrc/arch/Makefile	(Revision 285)
+++ ksrc/arch/Makefile	(Arbeitskopie)
@@ -1,15 +0,0 @@
-ifeq ($(PATCHLEVEL),6)
-
-# Makefile frag for Linux v2.6
-
-obj-$(CONFIG_XENOMAI) += generic/
-
-else
-
-# Makefile frag for Linux v2.4
-
-subdir-y += generic
-
-include $(TOPDIR)/Rules.make
-
-endif
Index: ksrc/arch/i386/Makefile
===================================================================
--- ksrc/arch/i386/Makefile	(Revision 285)
+++ ksrc/arch/i386/Makefile	(Arbeitskopie)
@@ -2,7 +2,7 @@
 
 # Makefile frag for Linux v2.6
 
-obj-$(CONFIG_XENOMAI) += xeno_hal.o
+obj-$(CONFIG_XENOMAI) += xeno_hal.o generic/
 
 xeno_hal-y := hal.o usercopy.o
 
@@ -14,6 +14,8 @@
 
 # Makefile frag for Linux v2.4
 
+subdir-y += generic
+
 USE_STANDARD_AS_RULE := true
 
 O_TARGET := built-in.o

--------------090606010101080901050309--

--------------enigE07BC4F5F11287A94079FB7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDpDahniDOoMHTA+kRAqswAJ94yId95TTBJDB6uhEJlRir/BbB2QCeN0nt
7gMxIl2U/HptgSVKftLZfNw=
=NlQk
-----END PGP SIGNATURE-----

--------------enigE07BC4F5F11287A94079FB7C--

