From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:47 +0200
Message-Id: <edc6915e9665ff9f56aa1e466add3773f0e91b40.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 06/23] RTDM: Convert open_fildes reading to
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

This avoids overflows in case the number of open file descriptors gets
too high.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/proc.c |  119 ++++++++++++++++++++++++++++++++----------------
 1 files changed, 80 insertions(+), 39 deletions(-)

diff --git a/ksrc/skins/rtdm/proc.c b/ksrc/skins/rtdm/proc.c
index 9b5d349..e83c0c4 100644
--- a/ksrc/skins/rtdm/proc.c
+++ b/ksrc/skins/rtdm/proc.c
@@ -76,6 +76,10 @@ static int proc_read_named_devs(char *buf, char **start, off_t offset,
 	RTDM_PROC_PRINT_DONE;
 }
 
+static void dummy_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
 static int proc_read_proto_devs(char *buf, char **start, off_t offset,
 				int count, int *eof, void *data)
 {
@@ -111,61 +115,90 @@ static int proc_read_proto_devs(char *buf, char **start, off_t offset,
 	RTDM_PROC_PRINT_DONE;
 }
 
-static int proc_read_open_fildes(char *buf, char **start, off_t offset,
-				 int count, int *eof, void *data)
+static void *open_fildes_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	int i;
-	int close_lock_count;
+	if (*pos > RTDM_FD_MAX)
+		return NULL;
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	return &fildes_table[*pos - 1];
+}
+
+static void *open_fildes_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+
+	if (*pos > RTDM_FD_MAX)
+		return NULL;
+
+	return &fildes_table[*pos - 1];
+}
+
+static int open_fildes_seq_show(struct seq_file *seq, void *v)
+{
+	struct rtdm_fildes *fildes = v;
+	struct rtdm_dev_context *context;
 	struct rtdm_device *device;
 	struct rtdm_process owner;
+	int close_lock_count;
 	spl_t s;
-	RTDM_PROC_PRINT_VARS(80);
 
-	if (!RTDM_PROC_PRINT("Index\tLocked\tDevice\t\tOwner [PID]\n"))
-		goto done;
+	if (v == SEQ_START_TOKEN) {
+		seq_printf(seq, "Index\tLocked\tDevice\t\tOwner [PID]\n");
+		return 0;
+	}
 
 	if (down_interruptible(&nrt_dev_lock))
 		return -ERESTARTSYS;
 
-	for (i = 0; i < RTDM_FD_MAX; i++) {
-		struct rtdm_dev_context *context;
-
-		xnlock_get_irqsave(&rt_fildes_lock, s);
+	xnlock_get_irqsave(&rt_fildes_lock, s);
 
-		context = fildes_table[i].context;
-		if (!context) {
-			xnlock_put_irqrestore(&rt_fildes_lock, s);
-			continue;
-		}
+	context = fildes->context;
+	if (!context) {
+		xnlock_put_irqrestore(&rt_fildes_lock, s);
+		goto unlock_out;
+	}
 
-		close_lock_count = atomic_read(&context->close_lock_count);
-		device = context->device;
+	close_lock_count = atomic_read(&context->close_lock_count);
+	device = context->device;
 
-		if (context->reserved.owner)
-			memcpy(&owner, context->reserved.owner, sizeof(owner));
-		else {
-			strcpy(owner.name, "<kernel>");
-			owner.pid = -1;
-		}
+	if (context->reserved.owner)
+		memcpy(&owner, context->reserved.owner, sizeof(owner));
+	else {
+		strcpy(owner.name, "<kernel>");
+		owner.pid = -1;
+	}
 
-		xnlock_put_irqrestore(&rt_fildes_lock, s);
+	xnlock_put_irqrestore(&rt_fildes_lock, s);
 
-		if (!RTDM_PROC_PRINT("%d\t%d\t%-15s %s [%d]\n", i,
-				     close_lock_count,
-				     (device->device_flags&RTDM_NAMED_DEVICE) ?
-				     device->device_name : device->proc_name,
-				     owner.name, owner.pid))
-			break;
-	}
+	seq_printf(seq, "%d\t%d\t%-15s %s [%d]\n",
+		   (int)(fildes - fildes_table), close_lock_count,
+		   (device->device_flags & RTDM_NAMED_DEVICE) ?
+				device->device_name : device->proc_name,
+		   owner.name, owner.pid);
 
+unlock_out:
 	up(&nrt_dev_lock);
+	return 0;
+}
 
-      done:
-	RTDM_PROC_PRINT_DONE;
+static const struct seq_operations open_fildes_op = {
+	.start	= open_fildes_seq_start,
+	.next	= open_fildes_seq_next,
+	.stop	= dummy_seq_stop,
+	.show	= open_fildes_seq_show
+};
+
+static int open_fildes_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &open_fildes_op);
 }
 
-static int proc_kill_open_fildes(struct file *file, const char __user *buffer,
-				 unsigned long count, void *data)
+static ssize_t
+proc_kill_open_fildes(struct file *file, const char __user *buffer,
+		      size_t count, loff_t *ppos)
 {
 	char krnl_buf[32];
 	int fd;
@@ -191,6 +224,15 @@ static int proc_kill_open_fildes(struct file *file, const char __user *buffer,
 	return count;
 }
 
+static const struct file_operations open_fildes_operations = {
+	.owner		= THIS_MODULE,
+	.open		= open_fildes_seq_open,
+	.read		= seq_read,
+	.write		= proc_kill_open_fildes,
+	.llseek		= seq_lseek,
+	.release	= seq_release_private,
+};
+
 static int fildes_show(struct seq_file *seq, void *v)
 {
 	seq_printf(seq, "total=%d:open=%d:free=%d\n",
@@ -331,11 +373,10 @@ int __init rtdm_proc_init(void)
 	proc_entry->read_proc = proc_read_proto_devs;
 
 	proc_entry =
-	    create_proc_entry("open_fildes", S_IFREG | S_IRUGO, rtdm_proc_root);
+		rthal_add_proc_seq("open_fildes", &open_fildes_operations, 0,
+				   rtdm_proc_root);
 	if (!proc_entry)
 		goto error;
-	proc_entry->read_proc = proc_read_open_fildes;
-	proc_entry->write_proc = proc_kill_open_fildes;
 
 	if (!rthal_add_proc_seq("fildes", &fildes_operations, 0,
 				rtdm_proc_root))
-- 
1.6.0.2


