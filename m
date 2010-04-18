From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:46 +0200
Message-Id: <92150986bd68018951c6368ea1d9bae6914f3a35.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 05/23] RTDM: Convert device information proc
	entry to single-seq
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

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/proc.c |   77 ++++++++++++++++++++++++++++--------------------
 1 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/ksrc/skins/rtdm/proc.c b/ksrc/skins/rtdm/proc.c
index ff264b6..9b5d349 100644
--- a/ksrc/skins/rtdm/proc.c
+++ b/ksrc/skins/rtdm/proc.c
@@ -211,12 +211,10 @@ static const struct file_operations fildes_operations = {
 	.release	= single_release,
 };
 
-static int proc_read_dev_info(char *buf, char **start, off_t offset,
-			      int count, int *eof, void *data)
+static int dev_info_show(struct seq_file *seq, void *v)
 {
 	struct rtdm_device *device;
 	int i;
-	RTDM_PROC_PRINT_VARS(256);
 
 	if (down_interruptible(&nrt_dev_lock))
 		return -ERESTARTSYS;
@@ -228,47 +226,63 @@ static int proc_read_dev_info(char *buf, char **start, off_t offset,
 	for (i = 0; i < devname_hashtab_size; i++)
 		list_for_each_entry(device, &rtdm_named_devices[i],
 				    reserved.entry)
-			if (device == data)
+			if (device == seq->private)
 				goto found;
 
 	for (i = 0; i < protocol_hashtab_size; i++)
 		list_for_each_entry(device, &rtdm_protocol_devices[i],
 				    reserved.entry)
-			if (device == data)
+			if (device == seq->private)
 				goto found;
 
 	up(&nrt_dev_lock);
 	return -ENODEV;
 
 found:
-	if (!RTDM_PROC_PRINT("driver:\t\t%s\nversion:\t%d.%d.%d\n",
-			     device->driver_name,
-			     RTDM_DRIVER_MAJOR_VER(device->driver_version),
-			     RTDM_DRIVER_MINOR_VER(device->driver_version),
-			     RTDM_DRIVER_PATCH_VER(device->driver_version)))
-		goto done;
-	if (!RTDM_PROC_PRINT("peripheral:\t%s\nprovider:\t%s\n",
-			     device->peripheral_name, device->provider_name))
-		goto done;
-	if (!RTDM_PROC_PRINT("class:\t\t%d\nsub-class:\t%d\n",
-			     device->device_class, device->device_sub_class))
-		goto done;
-	if (!RTDM_PROC_PRINT("flags:\t\t%s%s%s\n",
-			     (device->device_flags & RTDM_EXCLUSIVE) ?
-			     "EXCLUSIVE  " : "",
-			     (device->device_flags & RTDM_NAMED_DEVICE) ?
-			     "NAMED_DEVICE  " : "",
-			     (device->device_flags & RTDM_PROTOCOL_DEVICE) ?
-			     "PROTOCOL_DEVICE  " : ""))
-		goto done;
-	RTDM_PROC_PRINT("lock count:\t%d\n",
-			atomic_read(&device->reserved.refcount));
+	seq_printf(seq, "driver:\t\t%-64s\nversion:\t%d.%d.%d\n",
+		   device->driver_name,
+		   RTDM_DRIVER_MAJOR_VER(device->driver_version),
+		   RTDM_DRIVER_MINOR_VER(device->driver_version),
+		   RTDM_DRIVER_PATCH_VER(device->driver_version));
+	seq_printf(seq, "peripheral:\t%-64s\nprovider:\t%-64s\n",
+		   device->peripheral_name, device->provider_name);
+	seq_printf(seq, "class:\t\t%d\nsub-class:\t%d\n",
+		     device->device_class, device->device_sub_class);
+	seq_printf(seq, "flags:\t\t%s%s%s\n",
+		   (device->device_flags & RTDM_EXCLUSIVE) ?
+			"EXCLUSIVE  " : "",
+		   (device->device_flags & RTDM_NAMED_DEVICE) ?
+			"NAMED_DEVICE  " : "",
+		   (device->device_flags & RTDM_PROTOCOL_DEVICE) ?
+			"PROTOCOL_DEVICE  " : "");
+	seq_printf(seq, "lock count:\t%d\n",
+		   atomic_read(&device->reserved.refcount));
 
-      done:
 	up(&nrt_dev_lock);
-	RTDM_PROC_PRINT_DONE;
+	return 0;
+}
+
+static int dev_info_proc_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int err;
+
+	err = single_open(file, dev_info_show, NULL);
+	if (!err) {
+		seq = file->private_data;
+		seq->private = PDE(inode)->data;
+	}
+	return err;
 }
 
+static const struct file_operations dev_info_operations = {
+	.owner		= THIS_MODULE,
+	.open		= dev_info_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 int rtdm_proc_register_device(struct rtdm_device *device)
 {
 	struct proc_dir_entry *dev_dir;
@@ -278,14 +292,13 @@ int rtdm_proc_register_device(struct rtdm_device *device)
 	if (!dev_dir)
 		goto err_out;
 
-	proc_entry = create_proc_entry("information", S_IFREG | S_IRUGO,
-				       dev_dir);
+	proc_entry = rthal_add_proc_seq("information", &dev_info_operations,
+					0, dev_dir);
 	if (!proc_entry) {
 		remove_proc_entry(device->proc_name, rtdm_proc_root);
 		goto err_out;
 	}
 	proc_entry->data = device;
-	proc_entry->read_proc = proc_read_dev_info;
 
 	device->proc_entry = dev_dir;
 
-- 
1.6.0.2


