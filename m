Message-ID: <48AAF14F.2020204@domain.hid>
Date: Tue, 19 Aug 2008 18:14:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2/2] Report registry slot usage via /proc
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Some customer ran into the problem of lacking registry slots without
prior warning. We are lacking some report mechanism, specifically for
unexported entries (every user object requires one for its handle).

This patch introduces /proc/xenomai/registry_usage in the form

slots=512:used=1:exported=0

to address the deficit.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/registry.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

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
@@ -82,6 +84,35 @@ static int registry_proc_apc;
 
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
+#ifdef CONFIG_PROC_FS
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
@@ -117,6 +148,11 @@ int xnregistry_init(void)
 	initq(&registry_obj_procq);
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
+#ifdef CONFIG_PROC_FS
+	rthal_add_proc_leaf("registry_usage", registry_usage_read_proc,
+			    NULL, NULL, rthal_proc_root);
+#endif /* CONFIG_PROC_FS */
+
 	initq(&registry_obj_freeq);
 	initq(&registry_obj_busyq);
 	registry_obj_stamp = 0;
@@ -136,6 +172,9 @@ int xnregistry_init(void)
 					     registry_hash_entries);
 
 	if (!registry_hash_table) {
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry("registry_usage", rthal_proc_root);
+#endif /* CONFIG_PROC_FS */
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 		rthal_apc_free(registry_proc_apc);
 		remove_proc_entry("registry", rthal_proc_root);
@@ -272,6 +311,7 @@ static DECLARE_WORK_FUNC(registry_proc_c
 		if (object->proc != XNOBJECT_PROC_RESERVED1)
 			goto unexport;
 
+		registry_exported_objects++;
 		++pnode->entries;
 		object->proc = XNOBJECT_PROC_RESERVED2;
 		appendq(&registry_obj_busyq, holder);
@@ -329,6 +369,7 @@ static DECLARE_WORK_FUNC(registry_proc_c
 		continue;
 
 	unexport:
+		registry_exported_objects--;
 		entries = --pnode->entries;
 		entry = object->proc;
 		object->proc = NULL;

