Message-ID: <4D74EE69.5020705@domain.hid>
Date: Mon, 07 Mar 2011 15:40:41 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Build and run xenomai 2.5.5.2 - linux-2.6.33 on imx27
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear all,

I'm currently evaluating xenomai 2.5.5.2 on a i.MX27 platform with=20
adeos-ipipe-2.6.33-arm-1.18-01.patch.


I've encountred two issues for the time being  (same with=20
adeos-ipipe-2.6.33-arm-1.18-00.patch).

1=B0/ First one happens when building a 2.6.33.3 kernel (after xenomai=20
prepare/configure/compile stage):

CC      arch/arm/plat-mxc/time.o
arch/arm/plat-mxc/time.c: In function 'mxc_timer_init':
arch/arm/plat-mxc/time.c:400: error: 'TIM1_BASE_ADDR' undeclared (first=20
use in this function)
arch/arm/plat-mxc/time.c:400: error: (Each undeclared identifier is=20
reported only once
arch/arm/plat-mxc/time.c:400: error: for each function it appears in.)
make[1]: *** [arch/arm/plat-mxc/time.o] Erreur 1
make: *** [arch/arm/plat-mxc] Erreur 2


I first tried 2.6.31 kernel that was compiling (patched with=20
adeos-ipipe-2.6.31-arm-1.16-02.patch).
Looking for differences lead me to patch my kernel with:

Index: linux-2.6.33.3/arch/arm/plat-mxc/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.33.3.orig/arch/arm/plat-mxc/time.c    2011-02-28=20
11:44:02.000000000 +0100
+++ linux-2.6.33.3/arch/arm/plat-mxc/time.c    2011-02-28=20
11:48:19.000000000 +0100
@@ -395,12 +395,17 @@
      tsc_info.freq =3D clk_get_rate(timer_clk);
      mxc_min_delay =3D ((__ipipe_cpu_freq + 500000) / 1000000) ?: 1;

-    if (cpu_is_mx1() || cpu_is_mx2()) {
-#if defined(CONFIG_ARCH_MX1) || defined(CONFIG_ARCH_MX2)
+    if (cpu_is_mx1()) {
+#ifdef CONFIG_ARCH_MX1
          tsc_info.u.counter_paddr =3D (TIM1_BASE_ADDR + MX1_2_TCN);
          tsc_info.counter_vaddr =3D
              (unsigned long)(timer_base + MX1_2_TCN);
  #endif
+    } else if (cpu_is_mx2()) {
+#ifdef CONFIG_ARCH_MX2
+        tsc_info.u.counter_paddr =3D (GPT1_BASE_ADDR + MX1_2_TCN);
+        tsc_info.counter_vaddr =3D (unsigned long)(timer_base + MX1_2_TCN);
+#endif
      } else if (cpu_is_mx3()) {
  #ifdef CONFIG_ARCH_MX3
          tsc_info.u.counter_paddr =3D (GPT1_BASE_ADDR + MX3_TCN);


2=B0/ Second issue comes when trying to launch xeno-test:
[...]
root@domain.hid:~ /usr/xenomai/share/xenomai/testsuite/latency/run -- -sh=20
-T 120 -t0
*
*
* Type ^C to stop this application.
*
*
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
Unhandled fault: external abort on non-linefetch (0x008) at 0x40021010
Bus error
[...]


Looking at that thread:
http://www.mail-archive.com/xenomai@xenomai.org
It appears a similar issue has already been fixed on an i.MX25 by=20
clearing supervisor's protection bit.


So, I tried the following, that seem to fix the issue as well:
Index: linux-2.6.33.3/arch/arm/mach-mx2/devices.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.33.3.orig/arch/arm/mach-mx2/devices.c    2011-03-01=20
10:51:53.000000000 +0100
+++ linux-2.6.33.3/arch/arm/mach-mx2/devices.c    2011-03-02=20
17:44:08.000000000 +0100
@@ -680,3 +680,16 @@
  {
      return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
  }
+
+#ifdef CONFIG_IPIPE
+static int post_cpu_init(void)
+{
+    /* Allow userspace access through the
+     * peripheral access register (PAR).
+     */
+    if (cpu_is_mx27 ())
+        ipipe_mach_allow_uaccess(AIPI_BASE_ADDR, 3);
+    return 0;
+}
+postcore_initcall(post_cpu_init);
+#endif /* CONFIG_IPIPE */
Index: linux-2.6.33.3/arch/arm/plat-mxc/cpu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.33.3.orig/arch/arm/plat-mxc/cpu.c    2011-03-01=20
15:11:57.000000000 +0100
+++ linux-2.6.33.3/arch/arm/plat-mxc/cpu.c    2011-03-02=20
09:38:28.000000000 +0100
@@ -1,5 +1,6 @@
  #include <linux/module.h>
  #include <linux/io.h>
+#include <mach/hardware.h>

  unsigned int __mxc_cpu_type;
  EXPORT_SYMBOL(__mxc_cpu_type);
@@ -34,4 +35,16 @@
      aips_reg &=3D 0x00FFFFFF;
      __raw_writel(aips_reg, aips2 + 0x50);
  }
+
+#if defined(CONFIG_ARCH_MX1) || defined(CONFIG_ARCH_MX2)
+void ipipe_mach_allow_uaccess(unsigned long aipi_base_addr, unsigned=20
long bit_num)
+{
+    u32 tmp;
+
+    tmp =3D __raw_readl(IO_ADDRESS(aipi_base_addr + 0x00000008));
+    __raw_writel(tmp & ~(1 << bit_num), IO_ADDRESS(aipi_base_addr +=20
0x00000008));
+
+}
+#endif
+
  #endif /* CONFIG_IPIPE */
Index: linux-2.6.33.3/arch/arm/plat-mxc/include/mach/common.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.33.3.orig/arch/arm/plat-mxc/include/mach/common.h   =20
2011-03-01 15:14:35.000000000 +0100
+++ linux-2.6.33.3/arch/arm/plat-mxc/include/mach/common.h    2011-03-02=20
09:47:34.000000000 +0100
@@ -47,6 +47,9 @@

  #ifdef CONFIG_IPIPE
  void ipipe_mach_allow_hwtimer_uaccess(unsigned long aips1, unsigned=20
long aips2);
+#if defined(CONFIG_ARCH_MX1) || defined(CONFIG_ARCH_MX2)
+void ipipe_mach_allow_uaccess(unsigned long aipi_base_addr, unsigned=20
long bit_num);
+#endif
  #endif

  #endif



Could someone advise me on the modifications brought here?
Do these modifications look like ok to you?

Thanks in advance,

Fabrice



