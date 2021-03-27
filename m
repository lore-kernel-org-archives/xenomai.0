From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/5] cobalt/syscall: dovetail: do not expose clock frequency
 to user
Date: Sat, 27 Mar 2021 11:35:20 +0100
Message-Id: <20210327103524.2305814-2-rpm@xenomai.org>
In-Reply-To: <20210327103524.2305814-1-rpm@xenomai.org>
References: <20210327103524.2305814-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

We don't need this with Dovetail, there is no timestamp arithmetics to
perform in userland whatsoever: we get timestamps from the regular
vDSO-based clock_gettime() call.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/dovetail/pipeline/pipeline.h | 6 ++++++
 include/cobalt/kernel/ipipe/pipeline/pipeline.h    | 6 ++++++
 kernel/cobalt/posix/syscall.c                      | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index a2e025e35..1d4e3f91d 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -7,6 +7,7 @@
 
 #include <linux/irq_pipeline.h>
 #include <cobalt/kernel/assert.h>
+#include <asm/xenomai/features.h>
 
 typedef unsigned long spl_t;
 
@@ -102,4 +103,9 @@ static inline void pipeline_prepare_panic(void)
 	/* N/A */
 }
 
+static inline void pipeline_collect_features(struct cobalt_featinfo *f)
+{
+	f->clock_freq = 0;	/* N/A */
+}
+
 #endif /* !_COBALT_KERNEL_DOVETAIL_PIPELINE_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
index ceba7e3b0..e9e357bb0 100644
--- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
+++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
@@ -10,6 +10,7 @@
 #endif
 
 #include <pipeline/machine.h>
+#include <asm/xenomai/features.h>
 
 #define xnsched_realtime_domain  cobalt_pipeline.domain
 
@@ -75,4 +76,9 @@ static inline void pipeline_prepare_panic(void)
 	ipipe_prepare_panic();
 }
 
+static inline void pipeline_collect_features(struct cobalt_featinfo *f)
+{
+	f->clock_freq = cobalt_pipeline.clock_freq;
+}
+
 #endif /* !_COBALT_KERNEL_IPIPE_PIPELINE_H */
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 3b3eaee8e..b9f33953a 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -332,7 +332,7 @@ static COBALT_SYSCALL(bind, lostage,
 	f->feat_abirev = XENOMAI_ABI_REV;
 	collect_arch_features(f);
 
-	f->clock_freq = cobalt_pipeline.clock_freq;
+	pipeline_collect_features(f);
 	f->vdso_offset = cobalt_umm_offset(&cobalt_ppd_get(1)->umm, nkvdso);
 
 	if (cobalt_copy_to_user(u_breq, &breq, sizeof(breq)))
-- 
2.29.2


