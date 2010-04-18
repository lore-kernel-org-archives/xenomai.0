From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:49 +0200
Message-Id: <85087a491f22a06fb4a3500d3ecbb9c2b59c1445.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 08/23] RTDM: Convert device listings to
	seq_file
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

Given a large amount of devices, we could overflow the output page so
far. Fix it by moving to seq_file operations. This also allows us to
drop the RTDM_PROC_PRINT macros, now that the last user is converted.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/device.c   |   21 +----
 ksrc/skins/rtdm/internal.h |   19 ++++
 ksrc/skins/rtdm/proc.c     |  221 +++++++++++++++++++++++++++++---------------
 3 files changed, 168 insertions(+), 93 deletions(-)

diff --git a/ksrc/skins/rtdm/device.c b/ksrc/skins/rtdm/device.c
index e927ce7..d0e8b46 100644
--- a/ksrc/skins/rtdm/device.c
+++ b/ksrc/skins/rtdm/device.c
@@ -55,8 +55,8 @@ MODULE_PARM_DESC(protocol_hashtab_size,
 
 struct list_head *rtdm_named_devices;	/* hash table */
 struct list_head *rtdm_protocol_devices;	/* hash table */
-static int name_hashkey_mask;
-static int proto_hashkey_mask;
+int name_hashkey_mask;
+int proto_hashkey_mask;
 
 DECLARE_MUTEX(nrt_dev_lock);
 DEFINE_XNLOCK(rt_dev_lock);
@@ -77,23 +77,6 @@ int rtdm_select_bind_no_support(struct rtdm_dev_context *context,
 {
 	return -EBADF;
 }
-  
-static inline int get_name_hash(const char *str, int limit, int hashkey_mask)
-{
-	int hash = 0;
-
-	while (*str != 0) {
-		hash += *str++;
-		if (--limit == 0)
-			break;
-	}
-	return hash & hashkey_mask;
-}
-
-static inline int get_proto_hash(int protocol_family, int socket_type)
-{
-	return protocol_family & proto_hashkey_mask;
-}
 
 static inline void rtdm_reference_device(struct rtdm_device *device)
 {
diff --git a/ksrc/skins/rtdm/internal.h b/ksrc/skins/rtdm/internal.h
index 69299f8..86840f9 100644
--- a/ksrc/skins/rtdm/internal.h
+++ b/ksrc/skins/rtdm/internal.h
@@ -59,6 +59,8 @@ extern int open_fildes;
 extern struct semaphore nrt_dev_lock;
 extern unsigned int devname_hashtab_size;
 extern unsigned int protocol_hashtab_size;
+extern int name_hashkey_mask;
+extern int proto_hashkey_mask;
 extern struct list_head *rtdm_named_devices;
 extern struct list_head *rtdm_protocol_devices;
 extern struct proc_dir_entry *rtdm_proc_root;
@@ -79,6 +81,23 @@ static inline void rtdm_dereference_device(struct rtdm_device *device)
 	atomic_dec(&device->reserved.refcount);
 }
 
+static inline int get_name_hash(const char *str, int limit, int hashkey_mask)
+{
+	int hash = 0;
+
+	while (*str != 0) {
+		hash += *str++;
+		if (--limit == 0)
+			break;
+	}
+	return hash & hashkey_mask;
+}
+
+static inline int get_proto_hash(int protocol_family, int socket_type)
+{
+	return protocol_family & proto_hashkey_mask;
+}
+
 int __init rtdm_dev_init(void);
 
 static inline void rtdm_dev_cleanup(void)
diff --git a/ksrc/skins/rtdm/proc.c b/ksrc/skins/rtdm/proc.c
index 20c9ad8..84e3cc0 100644
--- a/ksrc/skins/rtdm/proc.c
+++ b/ksrc/skins/rtdm/proc.c
@@ -21,100 +21,173 @@
 
 #include "rtdm/internal.h"
 
-/* Derived from Erwin Rol's rtai_proc_fs.h.
-   Assumes that output fits into the provided buffer. */
-
-#define RTDM_PROC_PRINT_VARS(MAX_BLOCK_LEN)				\
-	const int max_block_len = MAX_BLOCK_LEN;			\
-	off_t __limit = count - MAX_BLOCK_LEN;				\
-	int __len = 0;							\
-									\
-	*eof = 1;							\
-	if (count < MAX_BLOCK_LEN)					\
-		return 0
-
-#define RTDM_PROC_PRINT(fmt, args...)					\
-({									\
-	__len += snprintf(buf + __len, max_block_len, fmt, ##args);	\
-	(__len <= __limit);						\
-})
-
-#define RTDM_PROC_PRINT_DONE						\
-	 return __len
-
 struct proc_dir_entry *rtdm_proc_root;	/* /proc/xenomai/rtdm */
 
-static int proc_read_named_devs(char *buf, char **start, off_t offset,
-				int count, int *eof, void *data)
+static void *devs_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	int i;
-	struct list_head *entry;
+	struct list_head *list = seq->private;
 	struct rtdm_device *device;
-	RTDM_PROC_PRINT_VARS(80);
+	loff_t n = *pos;
+	int i;
 
-	if (down_interruptible(&nrt_dev_lock))
-		return -ERESTARTSYS;
+	if (n == 0)
+		return SEQ_START_TOKEN;
 
-	if (!RTDM_PROC_PRINT("Hash\tName\t\t\t\tDriver\t\t/proc\n"))
-		goto done;
+	for (i = 0; i < protocol_hashtab_size; i++)
+		list_for_each_entry(device, &list[i], reserved.entry)
+			if (--n == 0)
+				return device;
+	return NULL;
+}
 
-	for (i = 0; i < devname_hashtab_size; i++)
-		list_for_each(entry, &rtdm_named_devices[i]) {
-			device = list_entry(entry, struct rtdm_device,
-					    reserved.entry);
-
-			if (!RTDM_PROC_PRINT("%02X\t%-31s\t%-15s\t%s\n",
-					     i, device->device_name,
-					     device->driver_name,
-					     device->proc_name))
-				break;
-		}
+static void *devs_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct list_head *list = seq->private;
+	struct rtdm_device *device = v;
+	struct list_head *lh;
+	int hashkey;
 
-      done:
-	up(&nrt_dev_lock);
+	++*pos;
 
-	RTDM_PROC_PRINT_DONE;
+	if (v == SEQ_START_TOKEN) {
+		hashkey = 0;
+		lh = list;
+	} else {
+		if (list == rtdm_named_devices)
+			hashkey = get_name_hash(device->device_name,
+						RTDM_MAX_DEVNAME_LEN,
+						name_hashkey_mask);
+		else
+			hashkey = get_proto_hash(device->protocol_family,
+						 device->socket_type);
+		lh = device->reserved.entry.next;
+	}
+
+	if (lh == &list[hashkey]) {
+		while (++hashkey < protocol_hashtab_size) {
+			lh = &list[hashkey];
+			if (!list_empty(lh))
+				return list_first_entry(lh, struct rtdm_device,
+							reserved.entry);
+		}
+		return NULL;
+	} else
+		return container_of(lh, struct rtdm_device, reserved.entry);
 }
 
 static void dummy_seq_stop(struct seq_file *seq, void *v)
 {
 }
 
-static int proc_read_proto_devs(char *buf, char **start, off_t offset,
-				int count, int *eof, void *data)
+static int named_devs_seq_show(struct seq_file *seq, void *v)
 {
-	int i;
-	struct list_head *entry;
-	struct rtdm_device *device;
-	char txt[32];
-	RTDM_PROC_PRINT_VARS(80);
+	struct rtdm_device *device = v;
+
+	if (v == SEQ_START_TOKEN)
+		seq_printf(seq, "Hash\tName\t\t\t\tDriver\t\t/proc\n");
+	else
+		seq_printf(seq, "%02X\t%-31s\t%-15s\t%s\n",
+			   get_name_hash(device->device_name,
+					 RTDM_MAX_DEVNAME_LEN,
+					 name_hashkey_mask),
+			   device->device_name, device->driver_name,
+			   device->proc_name);
+	return 0;
+}
+
+static struct seq_operations named_devs_op = {
+	.start = devs_seq_start,
+	.next = devs_seq_next,
+	.stop = dummy_seq_stop,
+	.show = named_devs_seq_show
+};
+
+static int named_devs_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int err;
 
 	if (down_interruptible(&nrt_dev_lock))
 		return -ERESTARTSYS;
 
-	if (!RTDM_PROC_PRINT("Hash\tProtocolFamily:SocketType\tDriver\t\t"
-			     "/proc\n"))
-		goto done;
+	err = seq_open(file, &named_devs_op);
+	if (err)
+		up(&nrt_dev_lock);
 
-	for (i = 0; i < protocol_hashtab_size; i++)
-		list_for_each(entry, &rtdm_protocol_devices[i]) {
-			device = list_entry(entry, struct rtdm_device,
-					    reserved.entry);
-
-			snprintf(txt, sizeof(txt), "%u:%u",
-				 device->protocol_family, device->socket_type);
-			if (!RTDM_PROC_PRINT("%02X\t%-31s\t%-15s\t%s\n", i,
-					     txt, device->driver_name,
-					     device->proc_name))
-				break;
-		}
+	seq = file->private_data;
+	seq->private = rtdm_named_devices;
+
+	return err;
+}
+
+static int devs_seq_release(struct inode *inode, struct file *file)
+{
+	int err = seq_release(inode, file);
 
-      done:
 	up(&nrt_dev_lock);
+	return err;
+}
 
-	RTDM_PROC_PRINT_DONE;
+static struct file_operations named_devs_operations = {
+	.owner = THIS_MODULE,
+	.open = named_devs_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = devs_seq_release,
+};
+
+static int proto_devs_seq_show(struct seq_file *seq, void *v)
+{
+	struct rtdm_device *device = v;
+	char buf[32];
+
+	if (v == SEQ_START_TOKEN)
+		seq_printf(seq,
+			   "Hash\tProtocolFamily:SocketType\tDriver\t\t/proc\n");
+	else {
+		snprintf(buf, sizeof(buf), "%u:%u",
+			 device->protocol_family, device->socket_type);
+		seq_printf(seq, "%02X\t%-31s\t%-15s\t%s\n",
+			   get_proto_hash(device->protocol_family,
+					  device->socket_type),
+			   buf, device->driver_name, device->proc_name);
+	}
+	return 0;
 }
 
+static const struct seq_operations proto_devs_op = {
+	.start	= devs_seq_start,
+	.next	= devs_seq_next,
+	.stop	= dummy_seq_stop,
+	.show	= proto_devs_seq_show
+};
+
+static int proto_devs_seq_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int err;
+
+	if (down_interruptible(&nrt_dev_lock))
+		return -ERESTARTSYS;
+
+	err = seq_open(file, &proto_devs_op);
+	if (err)
+		up(&nrt_dev_lock);
+
+	seq = file->private_data;
+	seq->private = rtdm_protocol_devices;
+
+	return err;
+}
+
+static const struct file_operations proto_devs_operations = {
+	.owner		= THIS_MODULE,
+	.open		= proto_devs_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= devs_seq_release,
+};
+
 static void *open_fildes_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	if (*pos > RTDM_FD_MAX)
@@ -360,17 +433,17 @@ int __init rtdm_proc_init(void)
 	if (!rtdm_proc_root)
 		goto error;
 
-	proc_entry = create_proc_entry("named_devices", S_IFREG | S_IRUGO,
-				       rtdm_proc_root);
+	proc_entry =
+		rthal_add_proc_seq("named_devices", &named_devs_operations,
+				   0, rtdm_proc_root);
 	if (!proc_entry)
 		goto error;
-	proc_entry->read_proc = proc_read_named_devs;
 
-	proc_entry = create_proc_entry("protocol_devices", S_IFREG | S_IRUGO,
-				       rtdm_proc_root);
+	proc_entry =
+		rthal_add_proc_seq("protocol_devices", &proto_devs_operations,
+				   0, rtdm_proc_root);
 	if (!proc_entry)
 		goto error;
-	proc_entry->read_proc = proc_read_proto_devs;
 
 	proc_entry =
 		rthal_add_proc_seq("open_fildes", &open_fildes_operations, 0,
-- 
1.6.0.2


