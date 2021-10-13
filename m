Subject: [PATCH v2 1/9] cobalt/dovetail: Use IRQ_WORK_INIT to please 5.11+
References: <cover.1634126152.git.jan.kiszka@siemens.com>
 <953b70771bea72a0b81d3974803ed6049373d2be.1634126152.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2af874a9-84bb-ab77-6fc7-bb4ec5e8b9c1@siemens.com>
Date: Wed, 13 Oct 2021 16:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <953b70771bea72a0b81d3974803ed6049373d2be.1634126152.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

And wrap the previous open-coded initialization for older kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - initialize .flags in older kernels more accurately

 include/cobalt/kernel/dovetail/pipeline/inband_work.h | 6 +-----
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h  | 7 +++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/inband_work.h b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
index 317a31de70..af3d70fc69 100644
--- a/include/cobalt/kernel/dovetail/pipeline/inband_work.h
+++ b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
@@ -19,11 +19,7 @@ struct pipeline_inband_work {
 
 #define PIPELINE_INBAND_WORK_INITIALIZER(__work, __handler)		\
 	{								\
-		.work = {						\
-			.func = (void (*)(struct irq_work *))		\
-			__handler,					\
-			.flags = ATOMIC_INIT(0),			\
-		},							\
+		.work = IRQ_WORK_INIT((void (*)(struct irq_work *))__handler), \
 	}
 
 #define pipeline_post_inband_work(__work)				\
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 54fdc8b05e..bf24f2b17f 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -231,4 +231,11 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 	kernel_read_file(__file, 0, __buf, __buf_size, __file_size, __id)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,11,0)
+#define IRQ_WORK_INIT(_func) (struct irq_work) {	\
+	.flags = ATOMIC_INIT(0),			\
+	.func = (_func),				\
+}
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
-- 
2.31.1

