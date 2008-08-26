Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48B3F2C0.9060108@domain.hid>
Message-ID: <48B3EE57.2000606@domain.hid>
Date: Tue, 26 Aug 2008 13:51:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B3ED52.7080101@domain.hid>
In-Reply-To: <48B3ED52.7080101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2/6] Allow key-less registry entries
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

No need to add anonymous registry entries with pseudo names to the hash
table - no one will look them up anyway. Reduces hash key collisions for
named objects.

---
 ChangeLog               |    3 +++
 ksrc/nucleus/registry.c |   34 ++++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)

Index: b/ksrc/nucleus/registry.c
===================================================================
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -542,7 +542,9 @@ static inline unsigned registry_wakeup_s
  * @param key A valid NULL-terminated string by which the object will
  * be indexed and later retrieved in the registry. Since it is assumed
  * that such key is stored into the registered object, it will *not*
- * be copied but only kept by reference in the registry.
+ * be copied but only kept by reference in the registry. Pass an empty
+ * string if the object shall only occupy a registry slot
+ * for handle-based lookups.
  *
  * @param objaddr An opaque pointer to the object to index by @a
  * key.
@@ -560,8 +562,8 @@ static inline unsigned registry_wakeup_s
  *
  * @return 0 is returned upon success. Otherwise:
  *
- * - -EINVAL is returned if @a key or @a objaddr are NULL, or if @a
- * key constains an invalid '/' character.
+ * - -EINVAL is returned if @a objaddr are NULL, or if @a key constains
+ * an invalid '/' character.
  *
  * - -ENOMEM is returned if the system fails to get enough dynamic
  * memory from the global real-time heap in order to register the
@@ -601,6 +603,18 @@ int xnregistry_enter(const char *key,
 
 	object = link2xnobj(holder);
 
+	xnsynch_init(&object->safesynch, XNSYNCH_FIFO);
+	object->objaddr = objaddr;
+	object->cstamp = ++registry_obj_stamp;
+	object->safelock = 0;
+	object->pnode = NULL;
+
+	if (!*key) {
+		object->key = NULL;
+		*phandle = object - registry_obj_slots;
+		return 0;
+	}
+
 	err = registry_hash_enter(key, object);
 
 	if (err) {
@@ -608,10 +622,6 @@ int xnregistry_enter(const char *key,
 		goto unlock_and_exit;
 	}
 
-	xnsynch_init(&object->safesynch, XNSYNCH_FIFO);
-	object->objaddr = objaddr;
-	object->cstamp = ++registry_obj_stamp;
-	object->safelock = 0;
 	appendq(&registry_obj_busyq, holder);
 
 	/* <!> Make sure the handle is written back before the
@@ -621,10 +631,6 @@ int xnregistry_enter(const char *key,
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 	if (pnode)
 		registry_proc_export(object, pnode);
-	else {
-		object->proc = NULL;
-		object->pnode = NULL;
-	}
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
 	if (registry_wakeup_sleepers(key))
@@ -831,10 +837,14 @@ int xnregistry_remove(xnhandle_t handle)
 			  object->pnode->type);
 #endif
 
-	registry_hash_remove(object);
 	object->objaddr = NULL;
 	object->cstamp = 0;
 
+	if (!object->key)
+		goto unlock_and_exit;
+
+	registry_hash_remove(object);
+
 #ifdef CONFIG_XENO_EXPORT_REGISTRY
 	if (object->pnode) {
 		registry_proc_unexport(object);
Index: b/ChangeLog
===================================================================
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,5 +1,8 @@
 2008-08-26  Jan Kiszka  <jan.kiszka@domain.hid>
 
+	* ksrc/nucleus/registry.c (xnregistry_enter/remove): Allow for
+	key-less anonymous object registration.
+
 	* ksrc/nucleus/registry.c (xnregistry_fetch/get/put): Remove
 	pointless locking, move XNOBJECT_SELF lookups out of critical
 	sections.


