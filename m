Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200611151544.00429.s.zimmermann@domain.hid>
References: <200611151121.51836.s.zimmermann@domain.hid>
	<b647ffbd0611150519w1a510582n40782bdccaa7562d@domain.hid>
	<200611151544.00429.s.zimmermann@domain.hid>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 12:57:26 +0100
Message-Id: <1163678246.4962.53.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-11-15 at 15:44 +0100, Stephan Zimmermann wrote:
> Am Mittwoch, 15. November 2006 14:19 schrieb Dmitry Adamushko:
> > Hello,
> >
> > I got some trouble with the native skin and queues, when creating /
> > deleting
> >
> > > queues, my Kernel sometimes (actually very often...) crashes, leading to
> > > a frozen system, with my Xenomai program continuing until it returns. I
> > > tried
> > > to isolate / reproduce the problem, which lead me to the following
> > > demo-code.
> >

[...]

Cannot test it yet, but could you try out this patch? TIA,

--- ksrc/nucleus/registry.c	(revision 1838)
+++ ksrc/nucleus/registry.c	(working copy)
@@ -65,10 +65,8 @@
 
 static void registry_proc_schedule(void *cookie);
 
-static xnqueue_t registry_obj_exportq;	/* Objects waiting for /proc export. */
+static xnqueue_t registry_obj_procq;	/* Objects waiting for /proc handling. */
 
-static xnqueue_t registry_obj_unexportq;	/* Objects waiting for /proc unexport. */
-
 #ifndef CONFIG_PREEMPT_RT
 static DECLARE_WORK(registry_proc_work, &registry_proc_callback, NULL);
 #endif /* !CONFIG_PREEMPT_RT */
@@ -106,8 +104,7 @@
 		return -ENOMEM;
 	}
 
-	initq(&registry_obj_exportq);
-	initq(&registry_obj_unexportq);
+	initq(&registry_obj_procq);
 #endif /* CONFIG_XENO_EXPORT_REGISTRY */
 
 	initq(&registry_obj_freeq);
@@ -274,16 +271,20 @@
 
 	xnlock_get_irqsave(&nklock, s);
 
-	while ((holder = getq(&registry_obj_exportq)) != NULL) {
+	while ((holder = getq(&registry_obj_procq)) != NULL) {
 		object = link2xnobj(holder);
 		pnode = object->pnode;
 		type = pnode->type;
+		dir = pnode->dir;
+		rdir = pnode->root->dir;
 		root = pnode->root->name;
+
+		if (object->proc != XNOBJECT_PROC_RESERVED1)
+			goto unexport;
+
 		++pnode->entries;
 		object->proc = XNOBJECT_PROC_RESERVED2;
 		appendq(&registry_obj_busyq, holder);
-		dir = pnode->dir;
-		rdir = pnode->root->dir;
 
 		xnlock_put_irqrestore(&nklock, s);
 
@@ -334,19 +335,14 @@
 			object->pnode = NULL;
 			--pnode->entries;
 		}
-	}
 
-	while ((holder = getq(&registry_obj_unexportq)) != NULL) {
-		object = link2xnobj(holder);
-		pnode = object->pnode;
-		object->pnode = NULL;
+		continue;
+
+	unexport:
+		entries = --pnode->entries;
 		entry = object->proc;
 		object->proc = NULL;
-		type = pnode->type;
-		dir = pnode->dir;
-		rdir = pnode->root->dir;
-		root = pnode->root->name;
-		entries = --pnode->entries;
+		object->pnode = NULL;
 
 		if (entries <= 0) {
 			pnode->dir = NULL;
@@ -398,7 +394,7 @@
 	object->proc = XNOBJECT_PROC_RESERVED1;
 	object->pnode = pnode;
 	removeq(&registry_obj_busyq, &object->link);
-	appendq(&registry_obj_exportq, &object->link);
+	appendq(&registry_obj_procq, &object->link);
 	rthal_apc_schedule(registry_proc_apc);
 }
 
@@ -406,13 +402,13 @@
 {
 	if (object->proc != XNOBJECT_PROC_RESERVED1) {
 		removeq(&registry_obj_busyq, &object->link);
-		appendq(&registry_obj_unexportq, &object->link);
+		appendq(&registry_obj_procq, &object->link);
 		rthal_apc_schedule(registry_proc_apc);
 	} else {
 		/* Unexporting before the lower stage has had a chance to
 		   export. Move back the object to the busyq just like if no
 		   export had been requested. */
-		removeq(&registry_obj_exportq, &object->link);
+		removeq(&registry_obj_procq, &object->link);
 		appendq(&registry_obj_busyq, &object->link);
 		object->pnode = NULL;
 		object->proc = NULL;


-- 
Philippe.



