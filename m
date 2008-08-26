Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48B3F2C0.8070207@domain.hid>
Message-ID: <48B3EF34.90001@domain.hid>
Date: Tue, 26 Aug 2008 13:55:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B3ED52.7080101@domain.hid>
In-Reply-To: <48B3ED52.7080101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 4/6] Eliminate xnobjhash
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

Hook up xnobject directly to the hash table instead of establishing
dynamically created xnobjhash redirections.

---
 include/nucleus/registry.h |   10 +-----
 ksrc/nucleus/registry.c    |   73 +++++++++++++++++++--------------------------
 2 files changed, 33 insertions(+), 50 deletions(-)

Index: b/include/nucleus/registry.h
===================================================================
--- a/include/nucleus/registry.h
+++ b/include/nucleus/registry.h
@@ -55,6 +55,8 @@ typedef struct xnobject {
 
     u_long cstamp;	/* !< Creation stamp. */
 
+    struct xnobject *hnext;	/* !< Next in h-table */
+
 #ifdef CONFIG_PROC_FS
 
     struct xnpnode *pnode; /* !< /proc information class. */
@@ -65,14 +67,6 @@ typedef struct xnobject {
 
 } xnobject_t;
 
-typedef struct xnobjhash {
-
-    xnobject_t *object;
-
-    struct xnobjhash *next;	/* !< Next in h-table */
-
-} xnobjhash_t;
-
 #ifdef __cplusplus
 extern "C" {
 #endif
Index: b/ksrc/nucleus/registry.c
===================================================================
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -54,7 +54,7 @@ static xnqueue_t registry_obj_busyq;	/*
 
 static u_long registry_obj_stamp;
 
-static xnobjhash_t **registry_hash_table;
+static xnobject_t **registry_hash_table;
 
 static int registry_hash_entries;
 
@@ -132,8 +132,8 @@ int xnregistry_init(void)
 	registry_hash_entries =
 	    primes[obj_hash_max(CONFIG_XENO_OPT_REGISTRY_NRSLOTS / 100)];
 	registry_hash_table =
-	    (xnobjhash_t **) xnarch_alloc_host_mem(sizeof(xnobjhash_t *) *
-					     registry_hash_entries);
+	    (xnobject_t **) xnarch_alloc_host_mem(sizeof(xnobject_t *) *
+						  registry_hash_entries);
 
 	if (!registry_hash_table) {
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
@@ -153,45 +153,42 @@ int xnregistry_init(void)
 
 void xnregistry_cleanup(void)
 {
-	xnobjhash_t *ecurr, *enext;
+	xnobject_t *ecurr, *enext;
 	int n;
 
+#ifdef CONFIG_XENO_EXPORT_REGISTRY
 	for (n = 0; n < registry_hash_entries; n++) {
 		for (ecurr = registry_hash_table[n]; ecurr; ecurr = enext) {
-			enext = ecurr->next;
+			enext = ecurr->hnext;
 
-#ifdef CONFIG_XENO_EXPORT_REGISTRY
-			if (ecurr->object && ecurr->object->pnode) {
-				remove_proc_entry(ecurr->object->key,
-						  ecurr->object->pnode->dir);
+			if (ecurr->pnode) {
+				remove_proc_entry(ecurr->key,
+						  ecurr->pnode->dir);
 
-				if (--ecurr->object->pnode->entries <= 0) {
-					remove_proc_entry(ecurr->object->pnode->
+				if (--ecurr->pnode->entries <= 0) {
+					remove_proc_entry(ecurr->pnode->
 							  type,
-							  ecurr->object->pnode->
+							  ecurr->pnode->
 							  root->dir);
-					ecurr->object->pnode->dir = NULL;
+					ecurr->pnode->dir = NULL;
 
-					if (--ecurr->object->pnode->root->
+					if (--ecurr->pnode->root->
 					    entries <= 0) {
 						remove_proc_entry(ecurr->
-								  object->
 								  pnode->root->
 								  name,
 								  registry_proc_root);
-						ecurr->object->pnode->root->
+						ecurr->pnode->root->
 						    dir = NULL;
 					}
 				}
 			}
-#endif /* CONFIG_XENO_EXPORT_REGISTRY */
-
-			xnfree(ecurr);
 		}
 	}
+#endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
 	xnarch_free_host_mem(registry_hash_table,
-		       sizeof(xnobjhash_t *) * registry_hash_entries);
+		       sizeof(xnobject_t *) * registry_hash_entries);
 
 	xnsynch_destroy(&registry_hash_synch);
 
@@ -448,25 +445,19 @@ static unsigned registry_hash_crunch(con
 
 static inline int registry_hash_enter(const char *key, xnobject_t *object)
 {
-	xnobjhash_t *enew, *ecurr;
+	xnobject_t *ecurr;
 	unsigned s;
 
 	object->key = key;
 	s = registry_hash_crunch(key);
 
-	for (ecurr = registry_hash_table[s]; ecurr != NULL; ecurr = ecurr->next) {
-		if (ecurr->object == object || !strcmp(key, ecurr->object->key))
+	for (ecurr = registry_hash_table[s]; ecurr != NULL; ecurr = ecurr->hnext) {
+		if (ecurr == object || !strcmp(key, ecurr->key))
 			return -EEXIST;
 	}
 
-	enew = (xnobjhash_t *) xnmalloc(sizeof(*enew));
-
-	if (!enew)
-		return -ENOMEM;
-
-	enew->object = object;
-	enew->next = registry_hash_table[s];
-	registry_hash_table[s] = enew;
+	object->hnext = registry_hash_table[s];
+	registry_hash_table[s] = object;
 
 	return 0;
 }
@@ -474,17 +465,15 @@ static inline int registry_hash_enter(co
 static inline int registry_hash_remove(xnobject_t *object)
 {
 	unsigned s = registry_hash_crunch(object->key);
-	xnobjhash_t *ecurr, *eprev;
+	xnobject_t *ecurr, *eprev;
 
 	for (ecurr = registry_hash_table[s], eprev = NULL;
-	     ecurr != NULL; eprev = ecurr, ecurr = ecurr->next) {
-		if (ecurr->object == object) {
+	     ecurr != NULL; eprev = ecurr, ecurr = ecurr->hnext) {
+		if (ecurr == object) {
 			if (eprev)
-				eprev->next = ecurr->next;
+				eprev->hnext = ecurr->hnext;
 			else
-				registry_hash_table[s] = ecurr->next;
-
-			xnfree(ecurr);
+				registry_hash_table[s] = ecurr->hnext;
 
 			return 0;
 		}
@@ -495,12 +484,12 @@ static inline int registry_hash_remove(x
 
 static xnobject_t *registry_hash_find(const char *key)
 {
-	xnobjhash_t *ecurr;
+	xnobject_t *ecurr;
 
 	for (ecurr = registry_hash_table[registry_hash_crunch(key)];
-	     ecurr != NULL; ecurr = ecurr->next) {
-		if (!strcmp(key, ecurr->object->key))
-			return ecurr->object;
+	     ecurr != NULL; ecurr = ecurr->hnext) {
+		if (!strcmp(key, ecurr->key))
+			return ecurr;
 	}
 
 	return NULL;


