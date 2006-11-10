From: Sebastian Smolorz <ssm@domain.hid>
Date: Fri, 10 Nov 2006 12:23:41 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9EGVFKlPySzl9KO"
Message-Id: <E1GiUTz-00027a-G9@domain.hid>
Subject: [Xenomai-core] [PATCH] Missing include when compiling an ipiped
	Linux kernel with CONFIG_PREEMPT for ARM
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

--Boundary-00=_9EGVFKlPySzl9KO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

here comes a fix for I-pipe for ARM. Without it the kernel refuses to compile 
when configured with CONFIG_PREEMPT.

Sebastian

--Boundary-00=_9EGVFKlPySzl9KO
Content-Type: text/x-diff; charset="us-ascii";
	name="ipipe_preempt_compile.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ipipe_preempt_compile.patch"

=2D-- linux-2.6.15-ipipe.orig/include/asm-arm/ipipe.h	2006-11-08 16:44:02.0=
00000000 +0100
+++ linux-2.6.15-ipipe.work/include/asm-arm/ipipe.h	2006-11-10 12:12:44.000=
000000 +0100
@@ -34,6 +34,7 @@
 #include <asm/irq.h>
 #include <asm/bitops.h>
 #include <asm/mach/irq.h>
+#include <asm/percpu.h>
=20
 #define IPIPE_ARCH_STRING	"1.5-02"
 #define IPIPE_MAJOR_NUMBER	1
@@ -51,7 +52,7 @@
 #endif	/* CONFIG_SMP */
=20
 /* Note that we disable the interrupts around context_switch,
=2D * or we'll get into severe problems when scheduling Xenoma=EF
+ * or we'll get into severe problems when scheduling Xenomai's
  * user space real time threads.
  * This can however cause high latencies, see for example:
  * 	http://www.ussg.iu.edu/hypermail/linux/kernel/0405.2/1388.html

--Boundary-00=_9EGVFKlPySzl9KO--

