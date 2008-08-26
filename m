Message-ID: <48B4387D.7060701@domain.hid>
Date: Tue, 26 Aug 2008 19:08:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B3ED52.7080101@domain.hid> <48B3EFFC.8020408@domain.hid>
	<48B42A68.3020400@domain.hid> <48B42D29.6030701@domain.hid>
	<48B42DB6.4050704@domain.hid>
In-Reply-To: <48B42DB6.4050704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RESEND][PATCH 6/6] Report registry slot usage
 via	/proc
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Some customer ran into the problem of lacking registry slots without
>>>> prior warning. We are lacking some report mechanism, specifically for
>>>> unexported (anonymous) entries (every native user object requires one
>>>> for its handle).
>>>>
>>>> This patch introduces /proc/xenomai/registry_usage in the form
>>>>
>>> Eeek. /proc/xenomai/registry/status or /usage. Otherwise, ok.
>> There was a reason, there was a reason... Ah! That subdir depends on
>> CONFIG_XENO_EXPORT_REGISTRY. Needs more refactoring then... :-]
>>
> 
> Ok, I'm freezing this one, waiting for next iteration.

Here it comes (previous version was also lacking a cleanup):

---
 ksrc/nucleus/registry.c |   68 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 11 deletions(-)

Index: b/ksrc/nucleus/registry.c
===================================================================
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -60,6 +60,8 @@ static int registry_hash_entries;
 
 static xnsynch_t registry_hash_synch;
 
+static unsigned registry_exported_objects;
+
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 
 #include <linux/workqueue.h>
@@ -76,12 +78,41 @@ static xnqueue_t registry_obj_procq;	/*
 static DECLARE_WORK_NODATA(registry_proc_work, &registry_proc_callback);
 #endif /* !CONFIG_PREEMPT_RT */
 
-static struct proc_dir_entry *registry_proc_root;
-
 static int registry_proc_apc;
 
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *registry_proc_root;
+
+static int
+registry_usage_read_proc(char *page, char **start, off_t off,
+			 int count, int *eof, void *data)
+{
+	int len;
+
+	if (!xnpod_active_p())
+		return -ESRCH;
+
+	len = sprintf(page, "slots=%u:used=%u:exported=%u\n",
+		      CONFIG_XENO_OPT_REGISTRY_NRSLOTS,
+		      CONFIG_XENO_OPT_REGISTRY_NRSLOTS -
+		      countq(&registry_obj_freeq),
+		      registry_exported_objects);
+
+	len -= off;
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+#endif /* CONFIG_PROC_FS */
+
 int xnregistry_init(void)
 {
 	static const int primes[] = {
@@ -100,22 +131,28 @@ int xnregistry_init(void)
 	if (registry_obj_slots == NULL)
 		return -ENOMEM;
 
+#ifdef CONFIG_PROC_FS
+	registry_proc_root = create_proc_entry("registry",
+					       S_IFDIR, rthal_proc_root);
+	if (!registry_proc_root)
+		return -ENOMEM;
+
+	rthal_add_proc_leaf("usage", registry_usage_read_proc,
+			    NULL, NULL, registry_proc_root);
+
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 	registry_proc_apc =
 	    rthal_apc_alloc("registry_export", &registry_proc_schedule, NULL);
 
-	if (registry_proc_apc < 0)
+	if (registry_proc_apc < 0) {
+		remove_proc_entry("usage", registry_proc_root);
+		remove_proc_entry("registry", rthal_proc_root);
 		return registry_proc_apc;
-
-	registry_proc_root = create_proc_entry("registry",
-					       S_IFDIR, rthal_proc_root);
-	if (!registry_proc_root) {
-		rthal_apc_free(registry_proc_apc);
-		return -ENOMEM;
 	}
 
 	initq(&registry_obj_procq);
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
+#endif /* CONFIG_PROC_FS */
 
 	initq(&registry_obj_freeq);
 	initq(&registry_obj_busyq);
@@ -136,10 +173,13 @@ int xnregistry_init(void)
 						  registry_hash_entries);
 
 	if (!registry_hash_table) {
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry("usage", registry_proc_root);
+		remove_proc_entry("registry", rthal_proc_root);
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 		rthal_apc_free(registry_proc_apc);
-		remove_proc_entry("registry", rthal_proc_root);
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
+#endif /* CONFIG_PROC_FS */
 		return -ENOMEM;
 	}
 
@@ -195,9 +235,13 @@ void xnregistry_cleanup(void)
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 	rthal_apc_free(registry_proc_apc);
 	flush_scheduled_work();
-	remove_proc_entry("registry", rthal_proc_root);
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("usage", registry_proc_root);
+	remove_proc_entry("registry", rthal_proc_root);
+#endif /* CONFIG_PROC_FS */
+
 	xnarch_free_host_mem(registry_obj_slots,
 			     CONFIG_XENO_OPT_REGISTRY_NRSLOTS * sizeof(xnobject_t));
 }
@@ -269,6 +313,7 @@ static DECLARE_WORK_FUNC(registry_proc_c
 		if (object->proc != XNOBJECT_PROC_RESERVED1)
 			goto unexport;
 
+		registry_exported_objects++;
 		++pnode->entries;
 		object->proc = XNOBJECT_PROC_RESERVED2;
 		appendq(&registry_obj_busyq, holder);
@@ -326,6 +371,7 @@ static DECLARE_WORK_FUNC(registry_proc_c
 		continue;
 
 	unexport:
+		registry_exported_objects--;
 		entries = --pnode->entries;
 		entry = object->proc;
 		object->proc = NULL;

