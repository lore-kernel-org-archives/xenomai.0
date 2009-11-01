Content-Type: multipart/mixed; boundary="===============2940860382053079932=="
MIME-Version: 1.0
Message-Id: <566451a98761369f757a.1257105488@domain.hid>
Date: Sun, 01 Nov 2009 19:58:08 -0000
From: Bernhard Walle <bernhard@domain.hid>
Subject: [Xenomai-core] [PATCH] Check frequency in xnarch_init_timeconv()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--===============2940860382053079932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

In some conditions, while testing Xenomai in VirtualBox, I had the error that
xnarch_init_timeconv() is called from init_32.h with a frequency of 0. That
leads to a division by zero, followed by a system oops.

Of course that is a bug in the virtualisation and Linux reports a CPU frequency
of 0 in /proc/cpuinfo. However, there's no harm if Xenomai checks that instead
of crashing the whole system.


Signed-off-by: Bernhard Walle <bernhard@domain.hid>


 include/asm-arm/bits/init.h         |   4 +++-
 include/asm-blackfin/bits/init.h    |   4 +++-
 include/asm-generic/bits/timeconv.h |  18 +++++++++++++++++-
 include/asm-nios2/bits/init.h       |   4 +++-
 include/asm-powerpc/bits/init.h     |   4 +++-
 include/asm-x86/bits/init_32.h      |   4 +++-
 include/asm-x86/bits/init_64.h      |   4 +++-
 src/skins/native/timer.c            |   7 ++++++-
 src/skins/posix/clock.c             |   8 +++++++-
 9 files changed, 48 insertions(+), 9 deletions(-)



--===============2940860382053079932==
Content-Type: text/x-patch; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=warn-about-broken-tsc.diff

In some conditions, while testing Xenomai in VirtualBox, I had the error that
xnarch_init_timeconv() is called from init_32.h with a frequency of 0. That
leads to a division by zero, followed by a system oops.

Of course that is a bug in the virtualisation and Linux reports a CPU frequency
of 0 in /proc/cpuinfo. However, there's no harm if Xenomai checks that instead
of crashing the whole system.


Signed-off-by: Bernhard Walle <bernhard@domain.hid>

diff --git a/include/asm-arm/bits/init.h b/include/asm-arm/bits/init.h
--- a/include/asm-arm/bits/init.h
+++ b/include/asm-arm/bits/init.h
@@ -82,7 +82,9 @@
 	set_cpus_allowed(current, cpumask_of_cpu(0));
 #endif /* CONFIG_SMP && MODULE */
 
-	xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	ret = xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	if (ret)
+		return ret;
 
 	ret = xnarch_calibrate_sched();
 	if (ret)
diff --git a/include/asm-blackfin/bits/init.h b/include/asm-blackfin/bits/init.h
--- a/include/asm-blackfin/bits/init.h
+++ b/include/asm-blackfin/bits/init.h
@@ -83,7 +83,9 @@
 	set_cpus_allowed(current, cpumask_of_cpu(0));
 #endif /* CONFIG_SMP && MODULE */
 
-	xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	ret = xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	if (ret)
+		return ret;
 
 	ret = xnarch_calibrate_sched();
 	if (ret)
diff --git a/include/asm-generic/bits/timeconv.h b/include/asm-generic/bits/timeconv.h
--- a/include/asm-generic/bits/timeconv.h
+++ b/include/asm-generic/bits/timeconv.h
@@ -100,8 +100,23 @@
 }
 #endif /* !XNARCH_HAVE_NODIV_LLIMD */
 
-static inline void xnarch_init_timeconv(unsigned long long freq)
+#ifndef xnarch_logerr
+#define xnarch_logerr(fmt, args...)
+#endif
+
+static inline int xnarch_init_timeconv(unsigned long long freq)
 {
+	/*
+	 * Division by zero is not defined (and in kernel context, it
+	 * especially leads to an oops)
+	 */
+	if (freq == 0) {
+		xnarch_logerr("xnarch_init_timeconv called with a "
+			      "frequency of 0. Probably this indicates a "
+			      "broken TSC.");
+		return -EINVAL;
+	}
+
 	clockfreq = freq;
 #ifdef XNARCH_HAVE_LLMULSHFT
 	xnarch_init_llmulshft(1000000000, freq, &tsc_scale, &tsc_shift);
@@ -110,6 +125,7 @@
 	xnarch_init_u32frac(&bln_frac, 1, 1000000000);
 #endif
 #endif
+	return 0;
 }
 
 #ifdef __KERNEL__
diff --git a/include/asm-nios2/bits/init.h b/include/asm-nios2/bits/init.h
--- a/include/asm-nios2/bits/init.h
+++ b/include/asm-nios2/bits/init.h
@@ -72,7 +72,9 @@
 	if (ret)
 		return ret;
 
-	xnarch_init_timeconv(RTHAL_CLOCK_FREQ);
+	ret = xnarch_init_timeconv(RTHAL_CLOCK_FREQ);
+	if (ret)
+		return ret;
 
 	ret = xnarch_calibrate_sched();
 	if (ret)
diff --git a/include/asm-powerpc/bits/init.h b/include/asm-powerpc/bits/init.h
--- a/include/asm-powerpc/bits/init.h
+++ b/include/asm-powerpc/bits/init.h
@@ -82,7 +82,9 @@
 	set_cpus_allowed(current, cpumask_of_cpu(0));
 #endif /* CONFIG_SMP && MODULE */
 
-	xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	ret = xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	if (ret)
+		return ret;
 
 	ret = xnarch_calibrate_sched();
 	if (ret)
diff --git a/include/asm-x86/bits/init_32.h b/include/asm-x86/bits/init_32.h
--- a/include/asm-x86/bits/init_32.h
+++ b/include/asm-x86/bits/init_32.h
@@ -88,7 +88,9 @@
 	set_cpus_allowed(current, cpumask_of_cpu(0));
 #endif /* CONFIG_SMP && MODULE */
 
-	xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	ret = xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	if (ret)
+		return ret;
 
 	ret = xnarch_calibrate_sched();
 	if (ret)
diff --git a/include/asm-x86/bits/init_64.h b/include/asm-x86/bits/init_64.h
--- a/include/asm-x86/bits/init_64.h
+++ b/include/asm-x86/bits/init_64.h
@@ -85,7 +85,9 @@
 	set_cpus_allowed(current, cpumask_of_cpu(0));
 #endif /* CONFIG_SMP && MODULE */
 
-	xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	ret = xnarch_init_timeconv(RTHAL_CPU_FREQ);
+	if (ret)
+		return ret;
 
 	ret = xnarch_calibrate_sched();
 	if (ret)
diff --git a/src/skins/native/timer.c b/src/skins/native/timer.c
--- a/src/skins/native/timer.c
+++ b/src/skins/native/timer.c
@@ -35,7 +35,12 @@
 		exit(EXIT_FAILURE);
 	}
 
-	xnarch_init_timeconv(sysinfo.cpufreq);
+	err = xnarch_init_timeconv(sysinfo.cpufreq);
+	if (err) {
+		fprintf(stderr, "Native skin init: "
+			"xnarch_init_timeconv: %s\n", strerror(-err));
+		exit(EXIT_FAILURE);
+	}
 }
 
 int rt_timer_set_mode(RTIME tickval)
diff --git a/src/skins/posix/clock.c b/src/skins/posix/clock.c
--- a/src/skins/posix/clock.c
+++ b/src/skins/posix/clock.c
@@ -38,7 +38,13 @@
 			"sys_info: %s\n", strerror(err));
 		exit(EXIT_FAILURE);
 	}
-	xnarch_init_timeconv(sysinfo.cpufreq);
+
+	err = xnarch_init_timeconv(sysinfo.cpufreq);
+	if (err) {
+		fprintf(stderr, "Xenomai Posix skin init: "
+			"xnarch_init_timeconv: %s\n", strerror(err));
+		exit(EXIT_FAILURE);
+	}
 }
 #endif /* XNARCH_HAVE_NONPRIV_TSC */
 

--===============2940860382053079932==--

