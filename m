From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] pipeline: Fix conversion of preset gravitiy values
Message-ID: <f53c64c2-40cc-ba56-2c54-335df7a585b3@siemens.com>
Date: Wed, 25 Aug 2021 12:54:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

The values in xnclock_gravity are in ticks, not nanoseconds. Make sure
nanosecond values are converted before storing them.

This was originally broken by bc761d8cf25c, for all architectures except
arm, arm64 and powerpc. During the dovetail port, this also sneaked into
the arm and arm64 headers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

The I-pipe part is to be ported to stable as well.

 .../arch/arm/dovetail/include/asm/xenomai/calibration.h    | 7 ++++---
 .../arch/arm64/dovetail/include/asm/xenomai/calibration.h  | 7 ++++---
 .../arch/x86/dovetail/include/asm/xenomai/calibration.h    | 7 ++++---
 .../arch/x86/ipipe/include/asm/xenomai/calibration.h       | 7 ++++---
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
index c4724372d5..3cf58259b1 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
@@ -31,9 +31,10 @@ static inline void xnarch_get_latencies(struct xnclock_gravity *p)
 #else
 	sched_latency = 5000;
 #endif
-	p->user = sched_latency;
-	p->kernel = CONFIG_XENO_OPT_TIMING_KSCHEDLAT;
-	p->irq = CONFIG_XENO_OPT_TIMING_IRQLAT;
+	p->user = xnclock_ns_to_ticks(&nkclock, sched_latency);
+	p->kernel = xnclock_ns_to_ticks(&nkclock,
+					CONFIG_XENO_OPT_TIMING_KSCHEDLAT);
+	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
 }
 
 #endif /* !_COBALT_ARM_DOVETAIL_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
index 05cb6f3a54..cd9496b66c 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
@@ -16,9 +16,10 @@ static inline void xnarch_get_latencies(struct xnclock_gravity *p)
 #else
 	sched_latency = 5000;
 #endif
-	p->user = sched_latency;
-	p->kernel = CONFIG_XENO_OPT_TIMING_KSCHEDLAT;
-	p->irq = CONFIG_XENO_OPT_TIMING_IRQLAT;
+	p->user = xnclock_ns_to_ticks(&nkclock, sched_latency);
+	p->kernel = xnclock_ns_to_ticks(&nkclock,
+					CONFIG_XENO_OPT_TIMING_KSCHEDLAT);
+	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
 }
 
 #endif /* !_COBALT_ARM64_DOVETAIL_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h
index 29d2924477..7f2dde70ca 100644
--- a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h
@@ -29,9 +29,10 @@ static inline void xnarch_get_latencies(struct xnclock_gravity *p)
 	sched_latency = num_online_cpus() > 1 ? 3350 : 2000;
 #endif /* !CONFIG_XENO_OPT_TIMING_SCHEDLAT */
 
-	p->user = sched_latency;
-	p->kernel = CONFIG_XENO_OPT_TIMING_KSCHEDLAT;
-	p->irq = CONFIG_XENO_OPT_TIMING_IRQLAT;
+	p->user = xnclock_ns_to_ticks(&nkclock, sched_latency);
+	p->kernel = xnclock_ns_to_ticks(&nkclock,
+					CONFIG_XENO_OPT_TIMING_KSCHEDLAT);
+	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
 }
 
 #endif /* !_COBALT_X86_ASM_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
index a9190e169c..eaecc48d43 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
@@ -62,9 +62,10 @@ static inline void xnarch_get_latencies(struct xnclock_gravity *p)
 	}
 #endif /* !CONFIG_XENO_OPT_TIMING_SCHEDLAT */
 
-	p->user = sched_latency;
-	p->kernel = CONFIG_XENO_OPT_TIMING_KSCHEDLAT;
-	p->irq = CONFIG_XENO_OPT_TIMING_IRQLAT;
+	p->user = xnclock_ns_to_ticks(&nkclock, sched_latency);
+	p->kernel = xnclock_ns_to_ticks(&nkclock,
+					CONFIG_XENO_OPT_TIMING_KSCHEDLAT);
+	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
 }
 
 #endif /* !_COBALT_X86_ASM_CALIBRATION_H */
-- 
2.31.1

