From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
Date: Sun, 24 Sep 2006 22:47:56 +0200
References: <200609232013.27649.niklaus.giger@domain.hid>
	<45159F4F.3010805@domain.hid>
In-Reply-To: <45159F4F.3010805@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_97uFFFc+rUqYRVB"
Message-Id: <200609242247.57024.niklaus.giger@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_97uFFFc+rUqYRVB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Samstag, 23. September 2006 22:55 schrieb Wolfgang Grandegger:
> Hi Niklaus,
>
> Niklaus Giger wrote:
<..>
>          if (flags & IPIPE_RESET_TIMER)
>                  ticks = tb_ticks_per_jiffy;
>          else {
>                  ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
>   		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                  if (ticks > tb_ticks_per_jiffy)
>                          return -EINVAL;
<..>
> Does replacing the calculation of ticks with
>
>          ticks = ns * (tb_ticks_per_jiffy / 10000) / (100000 / HZ);
>
> help. A proper calculation might use mulhwu or rthal_imuldiv.
Yes. I does. There are two occurrences fixed with the attached patch (+ one 
small ifdef to eliminate a compiler warning in the PPC40x case).
Timing is okay as tested with a small vxworks test program.

Could someone please apply it?

Thanks for your cooperation. 

Best regards

-- 
Niklaus Giger

--Boundary-00=_97uFFFc+rUqYRVB
Content-Type: text/x-diff; charset="iso-8859-1"; name="ppc40x_periodic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ppc40x_periodic.patch"

Index: ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch
===================================================================
--- ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch	(Revision 1650)
+++ ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.4-00.patch	(Arbeitskopie)
@@ -3595,7 +3595,7 @@
 +	if (flags & IPIPE_RESET_TIMER)
 +		ticks = tb_ticks_per_jiffy;
 +	else {
-+		ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
++		ticks = ns * (tb_ticks_per_jiffy / 10000) / (100000 / HZ);
 +
 +		if (ticks > tb_ticks_per_jiffy)
 +			return -EINVAL;
Index: ksrc/arch/powerpc/hal.c
===================================================================
--- ksrc/arch/powerpc/hal.c	(Revision 1650)
+++ ksrc/arch/powerpc/hal.c	(Arbeitskopie)
@@ -81,7 +81,9 @@
  */
 static void rthal_set_local_cpu_timer(void)
 {
+#ifndef CONFIG_40x
     long ticks;
+#endif
     rthal_declare_cpuid;
 
     rthal_load_cpuid();
@@ -110,7 +112,7 @@
     if (ns == 0)
         ticks = tb_ticks_per_jiffy;
     else {
-        ticks = ns * tb_ticks_per_jiffy / (1000000000 / HZ);
+	ticks = ns * (tb_ticks_per_jiffy / 10000) / (100000 / HZ);
 
         if (ticks > tb_ticks_per_jiffy) {
             DBG("rthal_set_cpu_timers_unsafe: -EINVAL (%lu)\n", ticks);

--Boundary-00=_97uFFFc+rUqYRVB--

