From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 01/11] rtdm: Harden key services against invocations with
 disabled core
Date: Fri, 13 Sep 2019 15:18:50 +0200
Message-Id: <0f91ce29df178234c6fb0a7cca07e13711e51a4a.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
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

We already have check in rtdm_dev_register, but drivers (such as RTnet)
may call other services without checking the core state. Then we risk
crashes, rather than simple errors.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/device.c | 2 +-
 kernel/cobalt/rtdm/drvlib.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 4cfdb1c5b1..8fe0ed7355 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -380,7 +380,7 @@ static void unregister_driver(struct rtdm_driver *drv)
  * - -EAGAIN is returned if no registry slot is available (check/raise
  * CONFIG_XENO_OPT_REGISTRY_NRSLOTS).
  *
- * - -ENOSYS is returned if cobalt is disabled
+ * - -ENOSYS is returned if the real-time core is disabled.
  *
  * - -ENXIO is returned if no valid minor could be assigned
  *
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 316d87b29d..3bf23e7836 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -114,6 +114,9 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
 	struct xnthread_init_attr iattr;
 	int err;
 
+	if (!realtime_core_enabled())
+		return -ENOSYS;
+
 	iattr.name = name;
 	iattr.flags = 0;
 	iattr.personality = &xenomai_personality;
@@ -1418,6 +1421,8 @@ EXPORT_SYMBOL_GPL(rtdm_mutex_timedlock);
  *
  * - -EBUSY is returned if the specified IRQ line is already in use.
  *
+ * - -ENOSYS is returned if the real-time core is disabled.
+ *
  * @coretags{secondary-only}
  */
 int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
@@ -1426,6 +1431,9 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 {
 	int err;
 
+	if (!realtime_core_enabled())
+		return -ENOSYS;
+
 	if (!XENO_ASSERT(COBALT, xnsched_root_p()))
 		return -EPERM;
 
-- 
2.16.4


