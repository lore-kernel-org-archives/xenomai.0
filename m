Message-ID: <4A30EFBE.10508@domain.hid>
Date: Thu, 11 Jun 2009 15:51:26 +0400
From: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
MIME-Version: 1.0
References: <4A30CB83.5080504@domain.hid> <4A30CF49.8010007@domain.hid>	
	<4A30D3CD.8050908@domain.hid> <4A30D969.6080501@domain.hid>
	<1244716635.7890.134.camel@domain.hid>
In-Reply-To: <1244716635.7890.134.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------080004090400020502000601"
Subject: Re: [Xenomai-core] [PATCH] ksrc: respect struct proc_dir_entry
	changes in 2.6.30
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080004090400020502000601
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you very much for the detailed explanation.
The updated patch is attached.

With best wishes,
Vladimir


Philippe Gerum wrote:
> On Thu, 2009-06-11 at 12:16 +0200, Jan Kiszka wrote:
>> Vladimir Zapolskiy wrote:
>>> Hi Jan,
>>> I observed that LINUX_VERSION_CODE comparisons are common enough in
>>> Xenomai code. Do you propose to make a separate header, which is
>>> included from nucleus, drivers and arch files?
>> Yes, it's common, but we also keep a lot of wrapping in asm-*/wrappers.h.
>>
> 
> No, it's not that common actually. Most of them are used in the HAL,
> half of those in assembly files because we don't have assembly-level
> wrappers, and the remaining spots are located in a few RT drivers
> (namely serial, CAN and irqbench).
> 
> So the canonical way to fix this is indeed to add the proper wrapper to
> include/asm-generic/wrappers.h. TIA,
> 
>> Jan
>>
>> PS: Please avoid top-posts.
>>

--------------080004090400020502000601
Content-Type: text/x-patch;
 name="0001-Made-conditional-inclusion-of-owner-field-in-struct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Made-conditional-inclusion-of-owner-field-in-struct.pat";
 filename*1="ch"

>From aa0d1003333982f5840879d0b435b9673986ea2f Mon Sep 17 00:00:00 2001
From: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
Date: Thu, 11 Jun 2009 15:26:19 +0400
Subject: [PATCH] Made conditional inclusion of owner field in struct proc_dir_entry due to changes in 2.6.30.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
---
 include/asm-generic/wrappers.h       |   13 +++++++++++++
 ksrc/arch/generic/hal.c              |    6 +++---
 ksrc/drivers/comedi/device.c         |    2 +-
 ksrc/drivers/comedi/rtdm_interface.c |    4 ++--
 ksrc/nucleus/registry.c              |    2 +-
 5 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index 12e4070..cbb8c43 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -523,4 +523,17 @@ static inline int wrap_raise_cap(int cap)
 }
 #endif /* LINUX_VERSION_CODE >= 2.6.29 */
 
+#ifdef CONFIG_PROC_FS
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+static inline void wrap_proc_dir_entry_owner(struct proc_dir_entry *entry)
+{
+    entry->owner = THIS_MODULE;
+}
+#else  /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30) */
+#define wrap_proc_dir_entry_owner(entry)
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30) */
+#endif /* CONFIG_PROC_FS */
+
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
index e4f0f31..762e544 100644
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -738,7 +738,7 @@ struct proc_dir_entry *rthal_add_proc_leaf(const char *name,
 	entry->data = data;
 	entry->read_proc = rdproc;
 	entry->write_proc = wrproc;
-	entry->owner = THIS_MODULE;
+	wrap_proc_dir_entry_owner(entry);
 
 	return entry;
 }
@@ -756,7 +756,7 @@ struct proc_dir_entry *rthal_add_proc_seq(const char *name,
 		return NULL;
 
 	entry->proc_fops = fops;
-	entry->owner = THIS_MODULE;
+	wrap_proc_dir_entry_owner(entry);
 
 	if (size)
 		entry->size = size;
@@ -773,7 +773,7 @@ static int rthal_proc_register(void)
 		return -1;
 	}
 
-	rthal_proc_root->owner = THIS_MODULE;
+	wrap_proc_dir_entry_owner(rthal_proc_root);
 
 	rthal_add_proc_leaf("hal", &hal_read_proc, NULL, NULL, rthal_proc_root);
 	rthal_add_proc_leaf("faults",
diff --git a/ksrc/drivers/comedi/device.c b/ksrc/drivers/comedi/device.c
index 51f1125..f60dfcd 100644
--- a/ksrc/drivers/comedi/device.c
+++ b/ksrc/drivers/comedi/device.c
@@ -144,7 +144,7 @@ int comedi_proc_attach(comedi_cxt_t * cxt)
 	entry->data = dev->transfer;
 	entry->write_proc = NULL;
 	entry->read_proc = comedi_rdproc_transfer;
-	entry->owner = THIS_MODULE;
+	wrap_proc_dir_entry_owner(entry);
 
       out_setup_proc_transfer:
 	/* Frees the file name buffer */
diff --git a/ksrc/drivers/comedi/rtdm_interface.c b/ksrc/drivers/comedi/rtdm_interface.c
index 7d78a45..d4ea5ac 100644
--- a/ksrc/drivers/comedi/rtdm_interface.c
+++ b/ksrc/drivers/comedi/rtdm_interface.c
@@ -78,7 +78,7 @@ int comedi_init_proc(void)
 	entry->data = NULL;
 	entry->write_proc = NULL;
 	entry->read_proc = comedi_rdproc_devs;
-	entry->owner = THIS_MODULE;
+	wrap_proc_dir_entry_owner(enrty);
 
 	/* Creates the drivers related file */
 	entry = create_proc_entry("drivers", 0444, comedi_proc_root);
@@ -93,7 +93,7 @@ int comedi_init_proc(void)
 	entry->data = NULL;
 	entry->write_proc = NULL;
 	entry->read_proc = comedi_rdproc_drvs;
-	entry->owner = THIS_MODULE;
+	wrap_proc_dir_entry_owner(enrty);
 
 	return 0;
 
diff --git a/ksrc/nucleus/registry.c b/ksrc/nucleus/registry.c
index 6c7ec20..6d67dfd 100644
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -280,7 +280,7 @@ static struct proc_dir_entry *add_proc_link(const char *name,
 	if (!entry)
 		return NULL;
 
-	entry->owner = THIS_MODULE;
+	wrap_proc_dir_entry_owner(entry);
 
 	return entry;
 }
-- 
1.6.2.4


--------------080004090400020502000601--

