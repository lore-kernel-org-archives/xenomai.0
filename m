From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:43 +0200
Message-Id: <efa29f58ac36fc911f3103b5be20c1ea51749313.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 02/23] RTDM: Plug race between
	proc_read_dev_info and device deregistration
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

As the device references passed to proc_read_dev_info may become invalid
while we dereference it, we need to acquire nrt_dev_lock and check the
pointer against our list of registered devices.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/proc.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/ksrc/skins/rtdm/proc.c b/ksrc/skins/rtdm/proc.c
index c797764..b889f73 100644
--- a/ksrc/skins/rtdm/proc.c
+++ b/ksrc/skins/rtdm/proc.c
@@ -203,11 +203,33 @@ static int proc_read_fildes(char *buf, char **start, off_t offset,
 static int proc_read_dev_info(char *buf, char **start, off_t offset,
 			      int count, int *eof, void *data)
 {
-	/* accessing the device during unregister (remove_proc_entry) might be
-	   racy, but no official workaround is known yet */
-	struct rtdm_device *device = data;
+	struct rtdm_device *device;
+	int i;
 	RTDM_PROC_PRINT_VARS(256);
 
+	if (down_interruptible(&nrt_dev_lock))
+		return -ERESTARTSYS;
+
+	/*
+	 * As the device may have disappeared while the handler was called,
+	 * first match the pointer against registered devices.
+	 */
+	for (i = 0; i < devname_hashtab_size; i++)
+		list_for_each_entry(device, &rtdm_named_devices[i],
+				    reserved.entry)
+			if (device == data)
+				goto found;
+
+	for (i = 0; i < protocol_hashtab_size; i++)
+		list_for_each_entry(device, &rtdm_protocol_devices[i],
+				    reserved.entry)
+			if (device == data)
+				goto found;
+
+	up(&nrt_dev_lock);
+	return -ENODEV;
+
+found:
 	if (!RTDM_PROC_PRINT("driver:\t\t%s\nversion:\t%d.%d.%d\n",
 			     device->driver_name,
 			     RTDM_DRIVER_MAJOR_VER(device->driver_version),
@@ -232,6 +254,7 @@ static int proc_read_dev_info(char *buf, char **start, off_t offset,
 			atomic_read(&device->reserved.refcount));
 
       done:
+	up(&nrt_dev_lock);
 	RTDM_PROC_PRINT_DONE;
 }
 
-- 
1.6.0.2


