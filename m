Message-ID: <4A30CB83.5080504@domain.hid>
Date: Thu, 11 Jun 2009 13:16:51 +0400
From: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060202040103040607060101"
Subject: [Xenomai-core] [PATCH] ksrc: respect struct proc_dir_entry changes
	in 2.6.30
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060202040103040607060101
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

please apply the attached simple patch, which resolves a kind of
compilation problems against 2.6.30 kernel.

-- 
With best wishes,
Vladimir


--------------060202040103040607060101
Content-Type: text/x-patch;
 name="0001-Made-conditional-inclusion-of-owner-field-in-struct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Made-conditional-inclusion-of-owner-field-in-struct.pat";
 filename*1="ch"

>From 894660f7dc91b406d8e078247b46606778562de9 Mon Sep 17 00:00:00 2001
From: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
Date: Thu, 11 Jun 2009 12:32:00 +0400
Subject: [PATCH] Made conditional inclusion of owner field in struct proc_dir_entry due to changes in 2.6.30

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
---
 ksrc/arch/generic/hal.c              |    6 ++++++
 ksrc/drivers/comedi/device.c         |    2 ++
 ksrc/drivers/comedi/rtdm_interface.c |    4 ++++
 ksrc/nucleus/registry.c              |    2 ++
 4 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index e4f0f31..b983b68 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -738,7 +738,9 @@ struct proc_dir_entry *rthal_add_proc_leaf(const char *name,
 	entry->data = data;
 	entry->read_proc = rdproc;
 	entry->write_proc = wrproc;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 	entry->owner = THIS_MODULE;
+#endif
 
 	return entry;
 }
@@ -756,7 +758,9 @@ struct proc_dir_entry *rthal_add_proc_seq(const char *name,
 		return NULL;
 
 	entry->proc_fops = fops;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 	entry->owner = THIS_MODULE;
+#endif
 
 	if (size)
 		entry->size = size;
@@ -773,7 +777,9 @@ static int rthal_proc_register(void)
 		return -1;
 	}
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 	rthal_proc_root->owner = THIS_MODULE;
+#endif
 
 	rthal_add_proc_leaf("hal", &hal_read_proc, NULL, NULL, rthal_proc_root);
 	rthal_add_proc_leaf("faults",
diff --git a/ksrc/drivers/comedi/device.c b/ksrc/drivers/comedi/device.c
index 51f1125..c35ae33 100644
--- a/ksrc/drivers/comedi/device.c
+++ b/ksrc/drivers/comedi/device.c
@@ -144,7 +144,9 @@ int comedi_proc_attach(comedi_cxt_t * cxt)
 	entry->data = dev->transfer;
 	entry->write_proc = NULL;
 	entry->read_proc = comedi_rdproc_transfer;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 	entry->owner = THIS_MODULE;
+#endif
 
       out_setup_proc_transfer:
 	/* Frees the file name buffer */
diff --git a/ksrc/drivers/comedi/rtdm_interface.c b/ksrc/drivers/comedi/rtdm_interface.c
index 7d78a45..a9ed574 100644
--- a/ksrc/drivers/comedi/rtdm_interface.c
+++ b/ksrc/drivers/comedi/rtdm_interface.c
@@ -78,7 +78,9 @@ int comedi_init_proc(void)
 	entry->data = NULL;
 	entry->write_proc = NULL;
 	entry->read_proc = comedi_rdproc_devs;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 	entry->owner = THIS_MODULE;
+#endif
 
 	/* Creates the drivers related file */
 	entry = create_proc_entry("drivers", 0444, comedi_proc_root);
@@ -93,7 +95,9 @@ int comedi_init_proc(void)
 	entry->data = NULL;
 	entry->write_proc = NULL;
 	entry->read_proc = comedi_rdproc_drvs;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 	entry->owner = THIS_MODULE;
+#endif
 
 	return 0;
 
diff --git a/ksrc/nucleus/registry.c b/ksrc/nucleus/registry.c
index 6c7ec20..833ee75 100644
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -280,7 +280,9 @@ static struct proc_dir_entry *add_proc_link(const char *name,
 	if (!entry)
 		return NULL;
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 	entry->owner = THIS_MODULE;
+#endif
 
 	return entry;
 }
-- 
1.6.2.4



--------------060202040103040607060101--

