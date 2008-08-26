Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48B3F2C0.6030705@domain.hid>
Message-ID: <48B3EF73.7020801@domain.hid>
Date: Tue, 26 Aug 2008 13:56:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B3ED52.7080101@domain.hid>
In-Reply-To: <48B3ED52.7080101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RESEND][PATCH 5/6] Avoid add_proc_leaf duplicates
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

For unknown (historical?) reasons, there are 3 identical implementations
of add_proc_leaf services in Xenomai right now. This patch switches them
all to the rthal provided version.

---
 include/asm-generic/hal.h |   10 +++----
 ksrc/arch/generic/hal.c   |   18 +++++++-------
 ksrc/arch/generic/nmi.c   |    6 ++--
 ksrc/arch/x86/nmi_32.c    |    6 ++--
 ksrc/nucleus/module.c     |   58 +++++++++++++++-------------------------------
 ksrc/nucleus/registry.c   |   31 +++---------------------
 6 files changed, 44 insertions(+), 85 deletions(-)

Index: b/include/asm-generic/hal.h
===================================================================
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -459,11 +459,11 @@ void rthal_timer_release(int cpu);
 
 extern struct proc_dir_entry *rthal_proc_root;
 
-struct proc_dir_entry *__rthal_add_proc_leaf(const char *name,
-					     read_proc_t rdproc,
-					     write_proc_t wrproc,
-					     void *data,
-					     struct proc_dir_entry *parent);
+struct proc_dir_entry *rthal_add_proc_leaf(const char *name,
+					   read_proc_t rdproc,
+					   write_proc_t wrproc,
+					   void *data,
+					   struct proc_dir_entry *parent);
 #endif /* CONFIG_PROC_FS */
 
 #ifdef CONFIG_IPIPE_TRACE
Index: b/ksrc/arch/generic/hal.c
===================================================================
--- a/ksrc/arch/generic/hal.c
+++ b/ksrc/arch/generic/hal.c
@@ -723,11 +723,11 @@ static int apc_read_proc(char *page,
     return len;
 }
 
-struct proc_dir_entry *__rthal_add_proc_leaf(const char *name,
-                                             read_proc_t rdproc,
-                                             write_proc_t wrproc,
-                                             void *data,
-                                             struct proc_dir_entry *parent)
+struct proc_dir_entry *rthal_add_proc_leaf(const char *name,
+                                           read_proc_t rdproc,
+                                           write_proc_t wrproc,
+                                           void *data,
+                                           struct proc_dir_entry *parent)
 {
     int mode = wrproc ? 0644 : 0444;
     struct proc_dir_entry *entry;
@@ -756,12 +756,12 @@ static int rthal_proc_register(void)
 
     rthal_proc_root->owner = THIS_MODULE;
 
-    __rthal_add_proc_leaf("hal", &hal_read_proc, NULL, NULL, rthal_proc_root);
+    rthal_add_proc_leaf("hal", &hal_read_proc, NULL, NULL, rthal_proc_root);
 
-    __rthal_add_proc_leaf("faults",
-                          &faults_read_proc, NULL, NULL, rthal_proc_root);
+    rthal_add_proc_leaf("faults",
+                        &faults_read_proc, NULL, NULL, rthal_proc_root);
 
-    __rthal_add_proc_leaf("apc", &apc_read_proc, NULL, NULL, rthal_proc_root);
+    rthal_add_proc_leaf("apc", &apc_read_proc, NULL, NULL, rthal_proc_root);
 
     rthal_nmi_proc_register();
 
Index: b/ksrc/arch/generic/nmi.c
===================================================================
--- a/ksrc/arch/generic/nmi.c
+++ b/ksrc/arch/generic/nmi.c
@@ -108,9 +108,9 @@ static int maxlat_write_proc(struct file
 
 void rthal_nmi_proc_register(void)
 {
-    __rthal_add_proc_leaf("nmi_maxlat",
-                          &maxlat_read_proc,
-                          &maxlat_write_proc, NULL, rthal_proc_root);
+    rthal_add_proc_leaf("nmi_maxlat",
+                        &maxlat_read_proc,
+                        &maxlat_write_proc, NULL, rthal_proc_root);
 }
 
 void rthal_nmi_proc_unregister(void)
Index: b/ksrc/arch/x86/nmi_32.c
===================================================================
--- a/ksrc/arch/x86/nmi_32.c
+++ b/ksrc/arch/x86/nmi_32.c
@@ -232,9 +232,9 @@ int rthal_nmi_request(void (*emergency)
 	nmi_watchdog_tick = &rthal_nmi_watchdog_tick;
 
 #ifdef CONFIG_PROC_FS
-	__rthal_add_proc_leaf("nmi_early_shots",
-			      &earlyshots_read_proc,
-			      NULL, NULL, rthal_proc_root);
+	rthal_add_proc_leaf("nmi_early_shots",
+			    &earlyshots_read_proc,
+			    NULL, NULL, rthal_proc_root);
 #endif /* CONFIG_PROC_FS */
 
 	return 0;
Index: b/ksrc/nucleus/module.c
===================================================================
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -987,29 +987,6 @@ static int affinity_write_proc(struct fi
 	return count;
 }
 
-static struct proc_dir_entry *add_proc_leaf(const char *name,
-					    read_proc_t rdproc,
-					    write_proc_t wrproc,
-					    void *data,
-					    struct proc_dir_entry *parent)
-{
-	int mode = wrproc ? 0644 : 0444;
-	struct proc_dir_entry *entry;
-
-	entry = create_proc_entry(name, mode, parent);
-
-	if (!entry)
-		return NULL;
-
-	entry->nlink = 1;
-	entry->data = data;
-	entry->read_proc = rdproc;
-	entry->write_proc = wrproc;
-	entry->owner = THIS_MODULE;
-
-	return entry;
-}
-
 static struct proc_dir_entry *add_proc_fops(const char *name,
 					    struct file_operations *fops,
 					    size_t size,
@@ -1046,26 +1023,31 @@ void xnpod_init_proc(void)
 #endif /* CONFIG_XENO_OPT_STATS */
 
 #if defined(CONFIG_SMP) && XENO_DEBUG(NUCLEUS)
-	add_proc_leaf("lock", &lock_read_proc, NULL, NULL, rthal_proc_root);
+	rthal_add_proc_leaf("lock", &lock_read_proc, NULL, NULL,
+			    rthal_proc_root);
 #endif /* CONFIG_SMP && XENO_DEBUG(NUCLEUS) */
 
-	add_proc_leaf("latency",
-		      &latency_read_proc,
-		      &latency_write_proc, NULL, rthal_proc_root);
+	rthal_add_proc_leaf("latency",
+			    &latency_read_proc,
+			    &latency_write_proc, NULL, rthal_proc_root);
 
-	add_proc_leaf("version", &version_read_proc, NULL, NULL,
-		      rthal_proc_root);
+	rthal_add_proc_leaf("version", &version_read_proc, NULL, NULL,
+			    rthal_proc_root);
 
-	add_proc_leaf("timer", &timer_read_proc, NULL, NULL, rthal_proc_root);
+	rthal_add_proc_leaf("timer", &timer_read_proc, NULL, NULL,
+			    rthal_proc_root);
 
-	add_proc_leaf("timebases", &timebase_read_proc, NULL, NULL, rthal_proc_root);
+	rthal_add_proc_leaf("timebases", &timebase_read_proc, NULL, NULL,
+			    rthal_proc_root);
 
-	add_proc_leaf("irq", &irq_read_proc, NULL, NULL, rthal_proc_root);
+	rthal_add_proc_leaf("irq", &irq_read_proc, NULL, NULL,
+			    rthal_proc_root);
 
-	add_proc_leaf("heap", &heap_read_proc, NULL, NULL, rthal_proc_root);
+	rthal_add_proc_leaf("heap", &heap_read_proc, NULL, NULL,
+			    rthal_proc_root);
 
-	add_proc_leaf("affinity", &affinity_read_proc, &affinity_write_proc,
-		      NULL, rthal_proc_root);
+	rthal_add_proc_leaf("affinity", &affinity_read_proc,
+			    &affinity_write_proc, NULL, rthal_proc_root);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	iface_proc_root =
@@ -1129,9 +1111,9 @@ static int iface_read_proc(char *page,
 
 void xnpod_declare_iface_proc(struct xnskin_slot *iface)
 {
-	add_proc_leaf(iface->props->name,
-		      &iface_read_proc, NULL, iface,
-		      iface_proc_root);
+	rthal_add_proc_leaf(iface->props->name,
+			    &iface_read_proc, NULL, iface,
+			    iface_proc_root);
 }
 
 void xnpod_discard_iface_proc(const char *iface_name)
Index: b/ksrc/nucleus/registry.c
===================================================================
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -225,29 +225,6 @@ static inline xnobject_t *registry_valid
    like are hopefully properly handled due to a careful
    synchronization of operations across domains. */
 
-static struct proc_dir_entry *add_proc_leaf(const char *name,
-					    read_proc_t rdproc,
-					    write_proc_t wrproc,
-					    void *data,
-					    struct proc_dir_entry *parent)
-{
-	int mode = wrproc ? 0644 : 0444;
-	struct proc_dir_entry *entry;
-
-	entry = create_proc_entry(name, mode, parent);
-
-	if (!entry)
-		return NULL;
-
-	entry->nlink = 1;
-	entry->data = data;
-	entry->read_proc = rdproc;
-	entry->write_proc = wrproc;
-	entry->owner = THIS_MODULE;
-
-	return entry;
-}
-
 static struct proc_dir_entry *add_proc_link(const char *name,
 					    link_proc_t *link_proc,
 					    void *data,
@@ -332,10 +309,10 @@ static DECLARE_WORK_FUNC(registry_proc_c
 						     object->objaddr, dir);
 		else
 			/* Entry allows to get/set object properties. */
-			object->proc = add_proc_leaf(object->key,
-						     pnode->read_proc,
-						     pnode->write_proc,
-						     object->objaddr, dir);
+			object->proc = rthal_add_proc_leaf(object->key,
+							   pnode->read_proc,
+							   pnode->write_proc,
+							   object->objaddr, dir);
 	      fail:
 		xnlock_get_irqsave(&nklock, s);
 


