From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v5 1/8] drivers/can: add corectl to retrieve configuration
Date: Sun, 19 Dec 2021 10:38:01 +0100
Message-Id: <20211219093809.21765-2-dariobin@libero.it>
In-Reply-To: <20211219093809.21765-1-dariobin@libero.it>
References: <20211219093809.21765-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Michael Trimarchi <michael@amarulasolutions.com>, Jan Kiszka <jan.kiszka@siemens.com>, Dario Binacchi <dariobin@libero.it>, Philippe Gerum <rpm@xenomai.org>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>

Signed-off-by: Dario Binacchi <dariobin@libero.it>

---

Changes in v5:
- Add the patch to the series.

 include/cobalt/uapi/corectl.h     |  2 ++
 kernel/drivers/can/Makefile       |  4 +--
 kernel/drivers/can/corectl.c      | 41 +++++++++++++++++++++++++++++++
 kernel/drivers/can/rtcan_module.c |  6 +++++
 4 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 kernel/drivers/can/corectl.c

diff --git a/include/cobalt/uapi/corectl.h b/include/cobalt/uapi/corectl.h
index 98d989d63..412684626 100644
--- a/include/cobalt/uapi/corectl.h
+++ b/include/cobalt/uapi/corectl.h
@@ -62,6 +62,8 @@
 #   define _CC_COBALT_NET_CAP		0x00000800
 #   define _CC_COBALT_NET_PROXY		0x00001000
 
+#define _CC_COBALT_GET_CAN_CONFIG	10
+#   define _CC_COBALT_CAN		0x00000001
 
 enum cobalt_run_states {
 	COBALT_STATE_DISABLED,
diff --git a/kernel/drivers/can/Makefile b/kernel/drivers/can/Makefile
index f78f6afdf..339a1c99f 100644
--- a/kernel/drivers/can/Makefile
+++ b/kernel/drivers/can/Makefile
@@ -1,10 +1,10 @@
 
-ccflags-y += -I$(srctree)/drivers/xenomai/can
+ccflags-y += -I$(srctree)/drivers/xenomai/can -I$(srctree)/kernel/
 
 obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/ peak_canfd/
 obj-$(CONFIG_XENO_DRIVERS_CAN_FLEXCAN) += xeno_can_flexcan.o
 obj-$(CONFIG_XENO_DRIVERS_CAN_VIRT) += xeno_can_virt.o
 
-xeno_can-y := rtcan_dev.o rtcan_socket.o rtcan_module.o rtcan_raw.o rtcan_raw_dev.o rtcan_raw_filter.o
+xeno_can-y := corectl.o rtcan_dev.o rtcan_socket.o rtcan_module.o rtcan_raw.o rtcan_raw_dev.o rtcan_raw_filter.o
 xeno_can_virt-y := rtcan_virt.o
 xeno_can_flexcan-y := rtcan_flexcan.o
diff --git a/kernel/drivers/can/corectl.c b/kernel/drivers/can/corectl.c
new file mode 100644
index 000000000..317e1f82f
--- /dev/null
+++ b/kernel/drivers/can/corectl.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021, Dario Binacchi <dariobin@libero.it>
+ */
+
+#include <asm/xenomai/syscall.h>
+#include <xenomai/posix/corectl.h>
+
+static int rtcan_corectl_call(struct notifier_block *self, unsigned long arg,
+			      void *cookie)
+{
+	struct cobalt_config_vector *vec = cookie;
+	int ret = 0;
+
+	if (arg != _CC_COBALT_GET_CAN_CONFIG)
+		return NOTIFY_DONE;
+
+	if (vec->u_bufsz < sizeof(ret))
+		return notifier_from_errno(-EINVAL);
+
+	if (IS_ENABLED(CONFIG_XENO_DRIVERS_CAN))
+		ret |= _CC_COBALT_CAN;
+
+	ret = cobalt_copy_to_user(vec->u_buf, &ret, sizeof(ret));
+
+	return ret ? notifier_from_errno(-EFAULT) : NOTIFY_STOP;
+}
+
+static struct notifier_block rtcan_corectl_notifier = {
+	.notifier_call = rtcan_corectl_call,
+};
+
+void rtcan_corectl_register(void)
+{
+	cobalt_add_config_chain(&rtcan_corectl_notifier);
+}
+
+void rtcan_corectl_unregister(void)
+{
+	cobalt_remove_config_chain(&rtcan_corectl_notifier);
+}
diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index 3d07eaed9..94b8c6412 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -35,6 +35,8 @@
 
 MODULE_LICENSE("GPL");
 
+void rtcan_corectl_register(void);
+void rtcan_corectl_unregister(void);
 
 const char rtcan_rtdm_provider_name[] =
     "(C) 2006 RT-Socket-CAN Development Team";
@@ -419,6 +421,8 @@ int __init rtcan_init(void)
 	goto out;
 #endif
 
+    rtcan_corectl_register();
+
  out:
     return err;
 }
@@ -426,6 +430,8 @@ int __init rtcan_init(void)
 
 void __exit rtcan_exit(void)
 {
+    rtcan_corectl_unregister();
+
     rtcan_raw_proto_unregister();
 #ifdef CONFIG_PROC_FS
     rtcan_proc_unregister();
-- 
2.17.1


