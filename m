MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rCQhvvHj1t"
Content-Transfer-Encoding: 7bit
Message-ID: <17505.58508.240692.324238@domain.hid>
Date: Wed, 10 May 2006 15:03:08 +0200
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
In-Reply-To: <44611320.8040909@domain.hid>
References: <17502.13773.674199.219762@domain.hid>
	<17503.16072.557355.759746@domain.hid>
	<445F4CC5.20301@domain.hid>
	<17504.54807.68153.142769@domain.hid>
	<44611320.8040909@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org


--rCQhvvHj1t
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Philippe Gerum wrote:
 > >  > Gilles Chanteperdrix wrote:
 > >  > > Gilles Chanteperdrix wrote:
 > >  > >  > These patches are not ready for inclusion, they are not tested
 > >  > >  > yet.
 > >  > > 
 > >  > > The attached versions are tested. I still wonder if handling this in
 > >  > > shadow.c is the right solution, or if there should be an xnppd_set call
 > >  > > that could be called from within the skins event callbacks.
 > >  > >
 > >  > 
 > >  > That would likely be better, since some skin might not want any cleanup 
 > >  > code to be called, and in the current implementation, every skin needs 
 > >  > to provide some ppd info when returning from the event callback, even if 
 > >  > only the CLIENT_ATTACH event is to be monitored. On the other hand, we 
 > >  > could argue that registering an event callback requires to implement all 
 > >  > requests, including CLIENT_DETACH, possibly by returning a no-op value, 
 > >  > so that no ppd registration would be done from bind_to_interface(). 
 > >  > Actually, I think the latter would be the better option.
 > > 
 > > If we want CLIENT_DETACH to be called even if CLIENT_ATTACH returned the
 > > no-op value,
 > 
 > No, we want CLIENT_DETACH to be avoided if CLIENT_ATTACH returned a 
 > no-op value.
 > 

The attached version of the patch do that.

-- 


					    Gilles Chanteperdrix.

--rCQhvvHj1t
Content-Type: text/plain
Content-Disposition: inline;
	filename="xenomai-ppd.4.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-generic/hal.h
===================================================================
--- include/asm-generic/hal.h	(revision 1058)
+++ include/asm-generic/hal.h	(working copy)
@@ -236,6 +236,14 @@
     return RTHAL_EVENT_PROPAGATE; \
 }
 
+#define RTHAL_DECLARE_CLEANUP_EVENT(hdlr) \
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
 
+#define rthal_catch_cleanup(hdlr)         \
+    ipipe_catch_event(ipipe_root_domain,IPIPE_EVENT_CLEANUP,hdlr)
 #define rthal_catch_taskexit(hdlr)	\
     ipipe_catch_event(ipipe_root_domain,IPIPE_EVENT_EXIT,hdlr)
 #define rthal_catch_sigwake(hdlr)	\
--- /dev/null	2006-05-10 02:46:08.416452000 +0200
+++ include/nucleus/ppd.h	2006-05-10 14:27:11.000000000 +0200
@@ -0,0 +1,26 @@
+#ifndef PPD_H
+#define PPD_H
+
+#include <nucleus/queue.h>
+
+struct mm_struct;
+
+typedef struct xnppd_key {
+    unsigned long muxid;
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
+#define xnppd_muxid(ppd) ((ppd)->key.muxid)
+
+#define xnppd_mm(ppd)    ((ppd)->key.mm)
+
+xnppd_holder_t *xnppd_get(unsigned muxid);
+
+#endif /* PPD_H */
Index: include/nucleus/shadow.h
===================================================================
--- include/nucleus/shadow.h	(revision 1058)
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
--- ksrc/nucleus/shadow.c	(revision 1058)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -48,6 +48,8 @@
 #include <nucleus/shadow.h>
 #include <nucleus/core.h>
 #include <nucleus/ltt.h>
+#include <nucleus/jhash.h>
+#include <nucleus/ppd.h>
 #include <asm/xenomai/features.h>
 
 int nkthrptd;
@@ -95,10 +97,141 @@
 
 static struct task_struct *switch_lock_owner[XNARCH_NR_CPUS];
 
+static xnqueue_t *xnppd_hash;
+#define XNPPD_HASH_SIZE 13
+
 void xnpod_declare_iface_proc(struct xnskentry *iface);
 
 void xnpod_discard_iface_proc(struct xnskentry *iface);
 
+/* ppd holder with the same mm collide and are stored contiguously in the same
+   bucket, so that they can all be destroyed with only one hash lookup by
+   xnppd_remove_mm. */
+static unsigned
+xnppd_lookup_inner(xnqueue_t **pq, xnppd_holder_t **pholder, xnppd_key_t *key)
+{
+    unsigned bucket = jhash2((uint32_t *)&key->mm,
+                             sizeof(key->mm)/sizeof(uint32_t), 0);
+    xnppd_holder_t *ppd;
+    xnholder_t *holder;
+
+    *pq = &xnppd_hash[bucket % XNPPD_HASH_SIZE];
+    holder = getheadq(*pq);
+
+    if (!holder)
+        {
+        *pholder = NULL;
+        return 0;
+        }
+    
+    do 
+        {
+        ppd = link2ppd(holder);
+        holder = nextq(*pq, holder);
+        }
+    while (holder &&
+           (ppd->key.mm < key->mm ||
+            (ppd->key.mm == key->mm && ppd->key.muxid < key->muxid)));
+
+    if (ppd->key.mm == key->mm && ppd->key.muxid == key->muxid)
+        {
+        /* found it, return it. */
+        *pholder = ppd;
+        return 1;
+        }
+
+    /* not found, return successor for insertion. */
+    if (ppd->key.mm < key->mm ||
+        (ppd->key.mm == key->mm && ppd->key.muxid < key->muxid))
+        *pholder = holder ? link2ppd(holder) : NULL;
+    else
+        *pholder = ppd;
+
+    return 0;
+}
+
+static void xnppd_insert(xnppd_holder_t *holder)
+{
+    xnppd_holder_t *next;
+    xnqueue_t *q;
+    unsigned found;
+    spl_t s;
+
+    xnlock_get_irqsave(&nklock, s);
+    found = xnppd_lookup_inner(&q, &next, &holder->key);
+    BUG_ON(found);
+    inith(&holder->link);
+    if (next)
+        insertq(q, &next->link, &holder->link);
+    else
+        appendq(q, &holder->link);
+    xnlock_put_irqrestore(&nklock, s);
+}
+
+/* will be called by skin code, nklock locked irqs off. */
+static struct xnppd_holder *xnppd_lookup(unsigned muxid,
+                                         struct mm_struct *mm)
+{
+    xnppd_holder_t *holder;
+    xnppd_key_t key;
+    unsigned found;
+    xnqueue_t *q;
+
+    key.muxid = muxid;
+    key.mm = mm;
+    found = xnppd_lookup_inner(&q, &holder, &key);
+
+    if (!found)
+        return NULL;
+
+    return holder;
+}
+
+static void xnppd_remove(xnppd_holder_t *holder)
+{
+    unsigned found;
+    xnqueue_t *q;
+    spl_t s;
+
+    xnlock_get_irqsave(&nklock, s);
+    found = xnppd_lookup_inner(&q, &holder, &holder->key);
+
+    if (found)
+        removeq(q, &holder->link);
+
+    xnlock_put_irqrestore(&nklock, s);
+}
+
+static inline void xnppd_remove_mm(struct mm_struct *mm,
+                                   void (*destructor)(xnppd_holder_t *))
+{
+    xnppd_holder_t *ppd;
+    xnholder_t *holder;
+    xnppd_key_t key;
+    xnqueue_t *q;
+    spl_t s;
+
+    key.muxid = 0;
+    key.mm = mm;
+    xnlock_get_irqsave(&nklock, s);
+    xnppd_lookup_inner(&q, &ppd, &key);
+
+    while (ppd && ppd->key.mm == mm)
+        {
+        holder = nextq(q, &ppd->link);
+        removeq(q, &ppd->link);
+        xnlock_put_irqrestore(&nklock, s);
+        /* releasing nklock is safe here, if we assume that no insertion for the
+           same mm will take place while we are running xnpod_remove_mm. */
+        destructor(ppd);
+
+        ppd = holder ? link2ppd(holder) : NULL;
+        xnlock_get_irqsave(&nklock, s);
+        }
+
+    xnlock_put_irqrestore(&nklock, s);
+}
+
 static inline void request_syscall_restart(xnthread_t *thread,
                                            struct pt_regs *regs)
 {
@@ -916,6 +1049,7 @@
                              unsigned magic,
                              u_long featdep, u_long abirev, u_long infarg)
 {
+    xnppd_holder_t *ppd = NULL;
     xnfeatinfo_t finfo;
     u_long featmis;
     int muxid;
@@ -981,18 +1115,39 @@
        chance to call xnpod_init(). */
 
     if (muxtable[muxid].eventcb) {
-        int err = muxtable[muxid].eventcb(XNSHADOW_CLIENT_ATTACH);
+        xnlock_get_irqsave(&nklock, s);
+        ppd = xnppd_lookup(muxid, curr->mm);
+        xnlock_put_irqrestore(&nklocks, s);
 
-        if (err) {
-            xnarch_atomic_dec(&muxtable[muxid].refcnt);
-            return err;
+        /* protect from the same process binding several time. */
+        if (!ppd) {
+            ppd = (xnppd_holder_t *)
+                muxtable[muxid].eventcb(XNSHADOW_CLIENT_ATTACH, curr);
+
+            if (IS_ERR(ppd)) {
+                xnarch_atomic_dec(&muxtable[muxid].refcnt);
+                return PTR_ERR(ppd);
+            }
+
+            if (ppd) {
+                ppd->key.muxid = muxid;
+                ppd->key.mm = curr->mm;
+                xnppd_insert(ppd);
+            }
         }
     }
 
-    if (!nkpod || testbits(nkpod->status, XNPIDLE))
+    if (!nkpod || testbits(nkpod->status, XNPIDLE)) {
         /* Ok mate, but you really ought to create some pod in a way
            or another if you want me to be of some help here... */
+        if (muxtable[muxid].eventcb && ppd) {
+            xnppd_remove(ppd);
+            muxtable[muxid].eventcb(XNSHADOW_CLIENT_DETACH, ppd);
+        }
+
+        xnarch_atomic_dec(&muxtable[muxid].refcnt);
         return -ENOSYS;
+    }
 
     return ++muxid;
 }
@@ -1640,6 +1795,18 @@
 
 RTHAL_DECLARE_SETSCHED_EVENT(setsched_event);
 
+static void detach_ppd(xnppd_holder_t *ppd)
+{
+    muxtable[holder->key.muxid].eventcb(XNSHADOW_CLIENT_DETACH, ppd);
+}
+
+static inline void do_cleanup_event (struct mm_struct *mm)
+{
+    xnppd_remove_mm(mm, &detach_ppd);
+}
+
+RTHAL_DECLARE_CLEANUP_EVENT(cleanup_event);
+
 /*
  * xnshadow_register_interface() -- Register a new skin/interface.
  * NOTE: an interface can be registered without its pod being
@@ -1651,7 +1818,8 @@
 int xnshadow_register_interface(const char *name,
                                 unsigned magic,
                                 int nrcalls,
-                                xnsysent_t *systab, int (*eventcb) (int))
+                                xnsysent_t *systab,
+                                void *(*eventcb)(int, void *))
 {
     int muxid;
     spl_t s;
@@ -1720,12 +1888,22 @@
     return err;
 }
 
+/* Call with nklock locked irqs off. */
+xnppd_holder_t *xnppd_get(unsigned muxid)
+{
+    if (xnpod_userspace_p())
+        return xnppd_lookup(muxid - 1, current->mm);
+
+    return NULL;
+}
+
 void xnshadow_grab_events(void)
 {
     rthal_catch_taskexit(&taskexit_event);
     rthal_catch_sigwake(&sigwake_event);
     rthal_catch_schedule(&schedule_event);
     rthal_catch_setsched(&setsched_event);
+    rthal_catch_cleanup(&cleanup_event);
 }
 
 void xnshadow_release_events(void)
@@ -1734,10 +1912,12 @@
     rthal_catch_sigwake(NULL);
     rthal_catch_schedule(NULL);
     rthal_catch_setsched(NULL);
+    rthal_catch_cleanup(NULL);
 }
 
 int xnshadow_mount(void)
 {
+    unsigned i, size;
     int cpu;
 
 #ifdef CONFIG_XENO_OPT_ISHIELD
@@ -1775,6 +1955,17 @@
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
 
@@ -1782,6 +1973,9 @@
 {
     int cpu;
 
+    if (xnppd_hash)
+        xnarch_sysfree(xnppd_hash, sizeof(xnqueue_t) * XNPPD_HASH_SIZE);
+
     rthal_catch_losyscall(NULL);
     rthal_catch_hisyscall(NULL);
 
@@ -1815,3 +2009,4 @@
 EXPORT_SYMBOL(xnshadow_suspend);
 EXPORT_SYMBOL(nkthrptd);
 EXPORT_SYMBOL(nkerrptd);
+EXPORT_SYMBOL(xnppd_get);

--rCQhvvHj1t--

