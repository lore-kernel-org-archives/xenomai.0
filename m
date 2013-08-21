Message-ID: <5214D9C9.9090904@siemens.com>
Date: Wed, 21 Aug 2013 17:16:25 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] analogy: Update procfs usage to latest kernel API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Alexis Berlemont <alexis.berlemont@gmail.com>

This makes the Analogy layer compatible with kernel 3.10. We simply
switch all procfs nodes to seq_file.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

For review. Only build-tested.

 include/analogy/device.h              |    4 +--
 include/analogy/driver.h              |    4 +--
 include/analogy/transfer.h            |    4 +--
 ksrc/drivers/analogy/device.c         |   51 ++++++++++++--------------------
 ksrc/drivers/analogy/driver.c         |   32 ++++-----------------
 ksrc/drivers/analogy/rtdm_interface.c |   42 ++++++++++++++++++--------
 ksrc/drivers/analogy/transfer.c       |   32 ++++-----------------
 7 files changed, 63 insertions(+), 106 deletions(-)

diff --git a/include/analogy/device.h b/include/analogy/device.h
index 76aca28..93cc760 100644
--- a/include/analogy/device.h
+++ b/include/analogy/device.h
@@ -83,9 +83,7 @@ typedef struct a4l_dev_info a4l_dvinfo_t;
 /* --- Devices tab related functions --- */
 void a4l_init_devs(void);
 int a4l_check_cleanup_devs(void);
-int a4l_rdproc_devs(char *page,
-		    char **start,
-		    off_t off, int count, int *eof, void *data);
+int a4l_rdproc_devs(struct seq_file *p, void *data);
 
 /* --- Context related function / macro --- */
 void a4l_set_dev(a4l_cxt_t *cxt);
diff --git a/include/analogy/driver.h b/include/analogy/driver.h
index a7abb00..88c8e56 100644
--- a/include/analogy/driver.h
+++ b/include/analogy/driver.h
@@ -68,9 +68,7 @@ int a4l_register_drv(a4l_drv_t * drv);
 int a4l_unregister_drv(a4l_drv_t * drv);
 int a4l_lct_drv(char *pin, a4l_drv_t ** pio);
 #ifdef CONFIG_PROC_FS
-int a4l_rdproc_drvs(char *page,
-		    char **start,
-		    off_t off, int count, int *eof, void *data);
+int a4l_rdproc_drvs(struct seq_file *p, void *data);
 #endif /* CONFIG_PROC_FS */
 
 #endif /* !DOXYGEN_CPP */
diff --git a/include/analogy/transfer.h b/include/analogy/transfer.h
index 2850834..a823772 100644
--- a/include/analogy/transfer.h
+++ b/include/analogy/transfer.h
@@ -68,9 +68,7 @@ typedef struct a4l_transfer a4l_trf_t;
 
 /* --- Proc function --- */
 
-int a4l_rdproc_transfer(char *page,
-			char **start,
-			off_t off, int count, int *eof, void *data);
+int a4l_rdproc_transfer(struct seq_file *p, void *data);
 
 /* --- Upper layer functions --- */
 
diff --git a/ksrc/drivers/analogy/device.c b/ksrc/drivers/analogy/device.c
index c00d38c..b93ae72 100644
--- a/ksrc/drivers/analogy/device.c
+++ b/ksrc/drivers/analogy/device.c
@@ -69,14 +69,12 @@ void a4l_set_dev(a4l_cxt_t *cxt)
 
 #ifdef CONFIG_PROC_FS
 
-int a4l_rdproc_devs(char *page,
-		    char **start, off_t off, int count, int *eof, void *data)
+int a4l_rdproc_devs(struct seq_file *p, void *data)
 {
-	int i, len = 0;
-	char *p = page;
+	int i;
 
-	p += sprintf(p, "--  Analogy devices --\n\n");
-	p += sprintf(p, "| idx | status | driver\n");
+	seq_printf(p, "--  Analogy devices --\n\n");
+	seq_printf(p, "| idx | status | driver\n");
 
 	for (i = 0; i < A4L_NB_DEVICES; i++) {
 		char *status, *name;
@@ -93,29 +91,23 @@ int a4l_rdproc_devs(char *page,
 			name = "Unknown";
 		}
 
-		p += sprintf(p, "|  %02d | %s | %s\n", i, status, name);
+		seq_printf(p, "|  %02d | %s | %s\n", i, status, name);
 	}
+	return 0;
+}
 
-	/* Handle any proc-file reading way */
-	len = p - page - off;
-	/* If the requested size is greater than we provide,
-	   the read operation is over */
-	if (len <= off + count)
-		*eof = 1;
-	/* In case the read operation is performed in many steps,
-	   the start pointer must be redefined */
-	*start = page + off;
-	/* If the requested size is lower than we provide,
-	   the read operation will be done in more than one step */
-	if (len > count)
-		len = count;
-	/* In case the offset is not correct (too high) */
-	if (len < 0)
-		len = 0;
-
-	return len;
+static int a4l_proc_transfer_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, a4l_rdproc_transfer, PDE_DATA(inode));
 }
 
+static const struct file_operations a4l_proc_transfer_ops = {
+	.open		= a4l_proc_transfer_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 int a4l_proc_attach(a4l_cxt_t * cxt)
 {
 	int ret = 0;
@@ -135,7 +127,8 @@ int a4l_proc_attach(a4l_cxt_t * cxt)
 	strncpy(p, dev->driver->board_name, A4L_NAMELEN);
 
 	/* Create the proc entry */
-	entry = create_proc_entry(entry_name, 0444, a4l_proc_root);
+	entry = proc_create_data(entry_name, 0444, a4l_proc_root,
+				 &a4l_proc_transfer_ops, &dev->transfer);
 	if (entry == NULL) {
 		__a4l_err("a4l_proc_attach: "
 			  "failed to create /proc/analogy/%s\n",
@@ -144,12 +137,6 @@ int a4l_proc_attach(a4l_cxt_t * cxt)
 		goto out_setup_proc_transfer;
 	}
 
-	entry->nlink = 1;
-	entry->data = &dev->transfer;
-	entry->write_proc = NULL;
-	entry->read_proc = a4l_rdproc_transfer;
-	wrap_proc_dir_entry_owner(entry);
-
       out_setup_proc_transfer:
 	/* Free the file name buffer */
 	rtdm_free(entry_name);
diff --git a/ksrc/drivers/analogy/driver.c b/ksrc/drivers/analogy/driver.c
index 3e67b0d..362ee49 100644
--- a/ksrc/drivers/analogy/driver.c
+++ b/ksrc/drivers/analogy/driver.c
@@ -89,40 +89,20 @@ int a4l_unregister_drv(a4l_drv_t * drv)
 
 /* --- Driver list proc section --- */
 
-int a4l_rdproc_drvs(char *page,
-		       char **start, off_t off, int count, int *eof, void *data)
+int a4l_rdproc_drvs(struct seq_file *p, void *data)
 {
-	int i = 0, len = 0;
-	char *p = page;
+	int i = 0;
 	struct list_head *this;
 
-	p += sprintf(p, "--  Analogy drivers --\n\n");
-	p += sprintf(p, "| idx | driver name\n");
+	seq_printf(p, "--  Analogy drivers --\n\n");
+	seq_printf(p, "| idx | driver name\n");
 
 	list_for_each(this, &a4l_drvs) {
 		a4l_drv_t *drv = list_entry(this, a4l_drv_t, list);
 
-		p += sprintf(p, "|  %02d | %s\n", i++, drv->board_name);
+		seq_printf(p, "|  %02d | %s\n", i++, drv->board_name);
 	}
-
-	/* Handles any proc-file reading way */
-	len = p - page - off;
-	/* If the requested size is greater than we provide,
-	   the read operation is over */
-	if (len <= off + count)
-		*eof = 1;
-	/* In case the read operation is performed in many steps,
-	   the start pointer must be redefined */
-	*start = page + off;
-	/* If the requested size is lower than we provide,
-	   the read operation will be done in more than one step */
-	if (len > count)
-		len = count;
-	/* In case the offset is not correct (too high) */
-	if (len < 0)
-		len = 0;
-
-	return len;
+	return 0;
 }
 
 #endif /* CONFIG_PROC_FS */
diff --git a/ksrc/drivers/analogy/rtdm_interface.c b/ksrc/drivers/analogy/rtdm_interface.c
index 3042ad5..e921b56 100644
--- a/ksrc/drivers/analogy/rtdm_interface.c
+++ b/ksrc/drivers/analogy/rtdm_interface.c
@@ -58,13 +58,37 @@ int (*a4l_ioctl_functions[NB_IOCTL_FUNCTIONS]) (a4l_cxt_t *, void *) = {
 #ifdef CONFIG_PROC_FS
 struct proc_dir_entry *a4l_proc_root;
 
+static int a4l_proc_devs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, a4l_rdproc_devs, NULL);
+}
+
+static const struct file_operations a4l_proc_devs_ops = {
+	.open		= a4l_proc_devs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int a4l_proc_drvs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, a4l_rdproc_drvs, NULL);
+}
+
+static const struct file_operations a4l_proc_drvs_ops = {
+	.open		= a4l_proc_drvs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 int a4l_init_proc(void)
 {
 	int ret = 0;
 	struct proc_dir_entry *entry;
 
 	/* Creates the global directory */
-	a4l_proc_root = create_proc_entry("analogy", S_IFDIR, 0);
+	a4l_proc_root = proc_mkdir("analogy", NULL);
 	if (a4l_proc_root == NULL) {
 		__a4l_err("a4l_proc_init: "
 			  "failed to create /proc/analogy\n");
@@ -72,33 +96,25 @@ int a4l_init_proc(void)
 	}
 
 	/* Creates the devices related file */
-	entry = create_proc_entry("devices", 0444, a4l_proc_root);
+	entry = proc_create("devices", 0444, a4l_proc_root,
+			    &a4l_proc_devs_ops);
 	if (entry == NULL) {
 		__a4l_err("a4l_proc_init: "
 			  "failed to create /proc/analogy/devices\n");
 		ret = -ENOMEM;
 		goto err_proc_init;
 	}
-
-	entry->nlink = 1;
-	entry->data = NULL;
-	entry->write_proc = NULL;
-	entry->read_proc = a4l_rdproc_devs;
 	wrap_proc_dir_entry_owner(entry);
 
 	/* Creates the drivers related file */
-	entry = create_proc_entry("drivers", 0444, a4l_proc_root);
+	entry = proc_create("drivers", 0444, a4l_proc_root,
+			    &a4l_proc_drvs_ops);
 	if (entry == NULL) {
 		__a4l_err("a4l_proc_init: "
 			  "failed to create /proc/analogy/drivers\n");
 		ret = -ENOMEM;
 		goto err_proc_init;
 	}
-
-	entry->nlink = 1;
-	entry->data = NULL;
-	entry->write_proc = NULL;
-	entry->read_proc = a4l_rdproc_drvs;
 	wrap_proc_dir_entry_owner(entry);
 
 	return 0;
diff --git a/ksrc/drivers/analogy/transfer.c b/ksrc/drivers/analogy/transfer.c
index 5861a83..add4414 100644
--- a/ksrc/drivers/analogy/transfer.c
+++ b/ksrc/drivers/analogy/transfer.c
@@ -213,16 +213,13 @@ unsigned int a4l_get_irq(a4l_dev_t * dev)
 
 #ifdef CONFIG_PROC_FS
 
-int a4l_rdproc_transfer(char *page,
-			char **start,
-			off_t off, int count, int *eof, void *data)
+int a4l_rdproc_transfer(struct seq_file *p, void *data)
 {
-	int i, len = 0;
-	char *p = page;
+	int i;
 	a4l_trf_t *transfer = (a4l_trf_t *) data;
 
-	p += sprintf(p, "--  Subdevices --\n\n");
-	p += sprintf(p, "| idx | type\n");
+	seq_printf(p, "--  Subdevices --\n\n");
+	seq_printf(p, "| idx | type\n");
 
 	/* Gives the subdevice type's name */
 	for (i = 0; i < transfer->nb_subd; i++) {
@@ -268,27 +265,10 @@ int a4l_rdproc_transfer(char *page,
 			type = "Unknown subdevice";
 		}
 
-		p += sprintf(p, "|  %02d | %s\n", i, type);
+		seq_printf(p, "|  %02d | %s\n", i, type);
 	}
 
-	/* Handles any proc-file reading way */
-	len = p - page - off;
-	/* If the requested size is greater than we provide,
-	   the read operation is over */
-	if (len <= off + count)
-		*eof = 1;
-	/* In case the read operation is performed in many steps,
-	   the start pointer must be redefined */
-	*start = page + off;
-	/* If the requested size is lower than we provide,
-	   the read operation will be done in more than one step */
-	if (len > count)
-		len = count;
-	/* In case the offset is not correct (too high) */
-	if (len < 0)
-		len = 0;
-
-	return len;
+	return 0;
 }
 
 #endif /* CONFIG_PROC_FS */
-- 
1.7.3.4

