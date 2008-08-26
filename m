Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48B3F2C0.2060102@domain.hid>
Message-ID: <48B3EDCA.9000804@domain.hid>
Date: Tue, 26 Aug 2008 13:49:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B3ED52.7080101@domain.hid>
In-Reply-To: <48B3ED52.7080101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 1/6] Remove / shorten critical sections in
	registry code
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

See Changelog.

---
 ChangeLog               |    6 ++++++
 ksrc/nucleus/registry.c |   44 +++++++++++++-------------------------------
 2 files changed, 19 insertions(+), 31 deletions(-)

Index: b/ChangeLog
===================================================================
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,9 @@
+2008-08-26  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/nucleus/registry.c (xnregistry_fetch/get/put): Remove
+	pointless locking, move XNOBJECT_SELF lookups out of critical
+	sections.
+
 2008-08-25  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* include/asm-generic/wrappers.h: Provide atomic_long wrappings.
Index: b/ksrc/nucleus/registry.c
===================================================================
--- a/ksrc/nucleus/registry.c
+++ b/ksrc/nucleus/registry.c
@@ -1024,16 +1024,14 @@ void *xnregistry_get(xnhandle_t handle)
 	void *objaddr;
 	spl_t s;
 
-	xnlock_get_irqsave(&nklock, s);
-
 	if (handle == XNOBJECT_SELF) {
-		if (!xnpod_primary_p()) {
-			objaddr = NULL;
-			goto unlock_and_exit;
-		}
+		if (!xnpod_primary_p())
+			return NULL;
 		handle = xnpod_current_thread()->registry.handle;
 	}
 
+	xnlock_get_irqsave(&nklock, s);
+
 	object = registry_validate(handle);
 
 	if (object) {
@@ -1042,8 +1040,6 @@ void *xnregistry_get(xnhandle_t handle)
 	} else
 		objaddr = NULL;
 
-      unlock_and_exit:
-
 	xnlock_put_irqrestore(&nklock, s);
 
 	return objaddr;
@@ -1087,17 +1083,14 @@ u_long xnregistry_put(xnhandle_t handle)
 	u_long newlock;
 	spl_t s;
 
-	xnlock_get_irqsave(&nklock, s);
-
 	if (handle == XNOBJECT_SELF) {
-		if (!xnpod_primary_p()) {
-			newlock = 0;
-			goto unlock_and_exit;
-		}
-
+		if (!xnpod_primary_p())
+			return 0;
 		handle = xnpod_current_thread()->registry.handle;
 	}
 
+	xnlock_get_irqsave(&nklock, s);
+
 	object = registry_validate(handle);
 
 	if (!object) {
@@ -1150,28 +1143,17 @@ u_long xnregistry_put(xnhandle_t handle)
 void *xnregistry_fetch(xnhandle_t handle)
 {
 	xnobject_t *object;
-	void *objaddr;
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
 
-	if (handle == XNOBJECT_SELF) {
-		objaddr = xnpod_primary_p()? xnpod_current_thread() : NULL;
-		goto unlock_and_exit;
-	}
+	if (handle == XNOBJECT_SELF)
+		return xnpod_primary_p()? xnpod_current_thread() : NULL;
 
 	object = registry_validate(handle);
 
-	if (object)
-		objaddr = object->objaddr;
-	else
-		objaddr = NULL;
-
-      unlock_and_exit:
+	if (!object)
+		return NULL;
 
-	xnlock_put_irqrestore(&nklock, s);
+	return object->objaddr;
 
-	return objaddr;
 }
 
 /*@}*/


