From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hYlQisUBFj"
Content-Transfer-Encoding: 7bit
Message-ID: <17503.16072.557355.759746@domain.hid>
Date: Mon, 8 May 2006 14:51:20 +0200
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
In-Reply-To: <17502.13773.674199.219762@domain.hid>
References: <17502.13773.674199.219762@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--hYlQisUBFj
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
 > These patches are not ready for inclusion, they are not tested
 > yet.

The attached versions are tested. I still wonder if handling this in
shadow.c is the right solution, or if there should be an xnppd_set call
that could be called from within the skins event callbacks.

-- 


					    Gilles Chanteperdrix.

--hYlQisUBFj
Content-Type: text/plain
Content-Disposition: inline;
	filename="adeos-process-exit-event.diff"
Content-Transfer-Encoding: 7bit

--- ./include/asm-i386/ipipe.h~	2006-05-07 16:00:37.000000000 +0200
+++ ./include/asm-i386/ipipe.h	2006-05-07 19:00:34.000000000 +0200
@@ -135,7 +135,8 @@ do { \
 #define IPIPE_EVENT_SIGWAKE	(IPIPE_FIRST_EVENT + 2)
 #define IPIPE_EVENT_SETSCHED	(IPIPE_FIRST_EVENT + 3)
 #define IPIPE_EVENT_EXIT	(IPIPE_FIRST_EVENT + 4)
-#define IPIPE_LAST_EVENT	IPIPE_EVENT_EXIT
+#define IPIPE_EVENT_PEXIT	(IPIPE_FIRST_EVENT + 5)
+#define IPIPE_LAST_EVENT	IPIPE_EVENT_PEXIT
 #define IPIPE_NR_EVENTS		(IPIPE_LAST_EVENT + 1)
 
 struct ipipe_domain;
--- ./include/linux/ipipe.h~	2006-05-07 16:00:36.000000000 +0200
+++ ./include/linux/ipipe.h	2006-05-07 19:01:01.000000000 +0200
@@ -439,6 +439,12 @@ static inline void ipipe_exit_notify(str
 		__ipipe_dispatch_event(IPIPE_EVENT_EXIT,p);
 }
 
+static inline void ipipe_pexit_notify(struct mm_struct *m)
+{
+	if (__ipipe_event_pipelined_p(IPIPE_EVENT_PEXIT))
+		__ipipe_dispatch_event(IPIPE_EVENT_PEXIT,m);
+}
+
 static inline int ipipe_trap_notify(int ex, struct pt_regs *regs)
 {
 	return __ipipe_event_pipelined_p(ex) ? __ipipe_dispatch_event(ex,regs) : 0;
@@ -633,6 +639,7 @@ void fastcall *ipipe_get_ptd(int key);
 #define ipipe_sigwake_notify(p)			do { } while(0)
 #define ipipe_setsched_notify(p)		do { } while(0)
 #define ipipe_exit_notify(p)			do { } while(0)
+#define ipipe_mmput_notify(m)			do { } while(0)
 #define ipipe_init_proc()			do { } while(0)
 #define ipipe_trap_notify(t,r)			0
 
--- ./kernel/fork.c~	2006-05-07 16:00:36.000000000 +0200
+++ ./kernel/fork.c	2006-05-07 19:00:02.000000000 +0200
@@ -368,6 +368,7 @@ void fastcall __mmdrop(struct mm_struct 
 void mmput(struct mm_struct *mm)
 {
 	if (atomic_dec_and_test(&mm->mm_users)) {
+		ipipe_pexit_notify(mm);
 		exit_aio(mm);
 		exit_mmap(mm);
 		if (!list_empty(&mm->mmlist)) {

--hYlQisUBFj
Content-Type: text/plain
Content-Disposition: inline;
	filename="xenomai-ppd.2.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-generic/hal.h
===================================================================
--- include/asm-generic/hal.h	(revision 1029)
+++ include/asm-generic/hal.h	(working copy)
@@ -236,6 +236,14 @@
     return RTHAL_EVENT_PROPAGATE; \
 }
 
+#define RTHAL_DECLARE_PEXIT_EVENT(hdlr) \
+static int hdlr (unsigned event, struct ipipe_domain *ipd, void *data) \
+{ \
+    struct mm_struct *mm = (struct mm_struct *)data; \
+    do_##hdlr(mm);                                   \
+    return RTHAL_EVENT_PROPAGATE; \
+}
+
 #ifndef IPIPE_EVENT_SELF
 /* Some early I-pipe versions don't have this. */
 #define IPIPE_EVENT_SELF  0
@@ -255,6 +263,8 @@
 #define IPIPE_WIRED_MASK  0
 #endif /* !IPIPE_WIRED_MASK */
 
+#define rthal_catch_pexit(hdlr)         \
+    ipipe_catch_event(ipipe_root_domain,IPIPE_EVENT_PEXIT,hdlr)
 #define rthal_catch_taskexit(hdlr)	\
     ipipe_catch_event(ipipe_root_domain,IPIPE_EVENT_EXIT,hdlr)
 #define rthal_catch_sigwake(hdlr)	\
--- /dev/null	2006-05-08 00:21:12.004363750 +0200
+++ include/nucleus/ppd.h	2006-05-07 18:42:46.000000000 +0200
@@ -0,0 +1,22 @@
+#ifndef PPD_H
+#define PPD_H
+
+#include <nucleus/queue.h>
+
+struct mm_struct;
+
+typedef struct xnppd_key {
+    unsigned long skin_magic;
+    struct mm_struct *mm;
+} xnppd_key_t;
+
+typedef struct xnppd_holder {
+    xnppd_key_t key;
+    xnholder_t link;
+#define link2ppd(laddr) \
+    (xnppd_holder_t *)((char *)(laddr) - offsetof(xnppd_holder_t, link))
+} xnppd_holder_t;
+
+xnppd_holder_t *xnppd_get(unsigned skin_magic);
+
+#endif /* PPD_H */
Index: include/nucleus/shadow.h
===================================================================
--- include/nucleus/shadow.h	(revision 1029)
+++ include/nucleus/shadow.h	(working copy)
@@ -48,7 +48,7 @@
     unsigned magic;
     int nrcalls;
     atomic_counter_t refcnt;
-    int (*eventcb)(int);
+    void *(*eventcb)(int, void *);
     xnsysent_t *systab;
 #ifdef CONFIG_PROC_FS
     struct proc_dir_entry *proc;
@@ -89,7 +89,7 @@
 				unsigned magic,
 				int nrcalls,
 				xnsysent_t *systab,
-				int (*eventcb)(int event));
+				void *(*eventcb)(int event, void *data));
 
 int xnshadow_unregister_interface(int muxid);
 
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 1029)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -48,6 +48,8 @@
 #include <nucleus/shadow.h>
 #include <nucleus/core.h>
 #include <nucleus/ltt.h>
+#include <nucleus/jhash.h>
+#include <nucleus/ppd.h>
 #include <asm/xenomai/features.h>
 
 int nkthrptd;
@@ -95,10 +97,65 @@
 
 static struct task_struct *switch_lock_owner[XNARCH_NR_CPUS];
 
+static xnqueue_t *xnppd_hash;
+#define XNPPD_HASH_SIZE 13
+
 void xnpod_declare_iface_proc(struct xnskentry *iface);
 
 void xnpod_discard_iface_proc(struct xnskentry *iface);
 
+static inline unsigned
+xnppd_lookup_inner(xnqueue_t **pq, xnppd_holder_t **pholder, xnppd_key_t *key)
+{
+    unsigned bucket = jhash2((uint32_t *)key, sizeof(*key)/sizeof(uint32_t), 0);
+    xnholder_t *holder;
+
+    *pq = &xnppd_hash[bucket % XNPPD_HASH_SIZE];
+    for (holder = getheadq(*pq); holder; holder = nextq(*pq, holder))
+        {
+        xnppd_holder_t *ppd = link2ppd(holder);
+
+        if (ppd->key.skin_magic == key->skin_magic && ppd->key.mm == key->mm) 
+            {
+            *pholder = ppd;
+            return 1;
+            }
+        }
+
+    return 0;
+}
+
+static void xnppd_insert(xnppd_holder_t *holder)
+{
+    xnppd_holder_t *ignored;
+    xnqueue_t *q;
+    unsigned found = xnppd_lookup_inner(&q, &ignored, &holder->key);
+    BUG_ON(found);
+    inith(&holder->link);
+    appendq(q, &holder->link);
+}
+
+static inline struct xnppd_holder *
+xnppd_lookup(unsigned skin_magic, struct mm_struct *mm, unsigned remove)
+{
+    xnppd_holder_t *holder;
+    xnppd_key_t key;
+    unsigned found;
+    xnqueue_t *q;
+
+    key.skin_magic = skin_magic;
+    key.mm = mm;
+    found = xnppd_lookup_inner(&q, &holder, &key);
+
+    if (!found)
+        return NULL;
+
+    if (remove)
+        removeq(q, &holder->link);
+
+    return holder;
+}
+
 static inline void request_syscall_restart (xnthread_t *thread, struct pt_regs *regs)
 
 {
@@ -1024,19 +1081,37 @@
 
     if (muxtable[muxid].eventcb)
 	{
-	int err = muxtable[muxid].eventcb(XNSHADOW_CLIENT_ATTACH);
+        xnppd_holder_t *ppd;
 
-	if (err)
-	    {
-	    xnarch_atomic_dec(&muxtable[muxid].refcnt);
-	    return err;
-	    }
-	}
+        ppd = xnppd_lookup(muxtable[muxid].magic, curr->mm, 0);
 
+        /* protect from the same process binding several time. */
+        if (!ppd)
+            {
+            ppd = (xnppd_holder_t *)
+                muxtable[muxid].eventcb(XNSHADOW_CLIENT_ATTACH, curr);
+
+            if (IS_ERR(ppd))
+                {
+                xnarch_atomic_dec(&muxtable[muxid].refcnt);
+                return PTR_ERR(ppd);
+                }
+
+            ppd->key.skin_magic = muxtable[muxid].magic;
+            ppd->key.mm = curr->mm;
+            xnppd_insert(ppd);
+            }
+        }
+
     if (!nkpod || testbits(nkpod->status,XNPIDLE))
 	/* Ok mate, but you really ought to create some pod in a way
 	   or another if you want me to be of some help here... */
+        {
+        if (muxtable[muxid].eventcb)
+            xnppd_lookup(muxtable[muxid].magic, curr->mm, 1);
+        xnarch_atomic_dec(&muxtable[muxid].refcnt);
 	return -ENOSYS;
+        }
 
     return ++muxid;
 }
@@ -1733,6 +1808,29 @@
 
 RTHAL_DECLARE_SETSCHED_EVENT(setsched_event);
 
+static inline void do_pexit_event (struct mm_struct *mm)
+{
+    unsigned muxid;
+    spl_t s;
+    
+    for (muxid = 0; muxid < XENOMAI_MUX_NR; muxid++)
+        {
+        xnlock_get_irqsave(&nklock, s);
+        if (muxtable[muxid].systab && muxtable[muxid].eventcb)
+            {
+            struct xnppd_holder *ppd;
+
+            ppd = xnppd_lookup(muxtable[muxid].magic, mm, 1);
+
+            if (ppd)
+                muxtable[muxid].eventcb(XNSHADOW_CLIENT_DETACH, ppd);
+            }
+        xnlock_put_irqrestore(&nklock, s);
+        }
+}
+
+RTHAL_DECLARE_PEXIT_EVENT(pexit_event);
+
 /*
  * xnshadow_register_interface() -- Register a new skin/interface.
  * NOTE: an interface can be registered without its pod being
@@ -1745,7 +1843,7 @@
 				 unsigned magic,
 				 int nrcalls,
 				 xnsysent_t *systab,
-				 int (*eventcb)(int))
+				 void *(*eventcb)(int, void *))
 {
     int muxid;
     spl_t s;
@@ -1819,6 +1917,15 @@
     return err;
 }
 
+/* Call with nklock locked irqs off. */
+xnppd_holder_t *xnppd_get(unsigned skin_magic)
+{
+    if (xnpod_userspace_p())
+        return xnppd_lookup(skin_magic, current->mm, 0);
+
+    return NULL;
+}
+
 void xnshadow_grab_events (void)
 
 {
@@ -1826,6 +1933,7 @@
     rthal_catch_sigwake(&sigwake_event);
     rthal_catch_schedule(&schedule_event);
     rthal_catch_setsched(&setsched_event);
+    rthal_catch_pexit(&pexit_event);
 }
 
 void xnshadow_release_events (void)
@@ -1835,11 +1943,13 @@
     rthal_catch_sigwake(NULL);
     rthal_catch_schedule(NULL);
     rthal_catch_setsched(NULL);
+    rthal_catch_pexit(NULL);
 }
 
 int xnshadow_mount (void)
 
 {
+    unsigned i, size;
     int cpu;
 
 #ifdef CONFIG_XENO_OPT_ISHIELD
@@ -1878,6 +1988,17 @@
     rthal_catch_losyscall(&losyscall_event);
     rthal_catch_hisyscall(&hisyscall_event);
 
+    size = sizeof(xnqueue_t) * XNPPD_HASH_SIZE;
+    xnppd_hash = (xnqueue_t *) xnarch_sysalloc(size);
+    if (!xnppd_hash)
+        {
+        xnshadow_cleanup();
+        printk(KERN_WARNING "Xenomai: cannot allocate PPD hash table.\n");
+        return -ENOMEM;
+        }
+
+    for (i = 0; i < XNPPD_HASH_SIZE; i++)
+        initq(&xnppd_hash[i]);
     return 0;
 }
 
@@ -1886,6 +2007,9 @@
 {
     int cpu;
 
+    if (xnppd_hash)
+        xnarch_sysfree(xnppd_hash, sizeof(xnqueue_t) * XNPPD_HASH_SIZE);
+
     rthal_catch_losyscall(NULL);
     rthal_catch_hisyscall(NULL);
 
@@ -1919,3 +2043,4 @@
 EXPORT_SYMBOL(xnshadow_suspend);
 EXPORT_SYMBOL(nkthrptd);
 EXPORT_SYMBOL(nkerrptd);
+EXPORT_SYMBOL(xnppd_get);

--hYlQisUBFj--

