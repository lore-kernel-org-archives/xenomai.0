MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9v4TrRpw4v"
Content-Transfer-Encoding: 7bit
Message-ID: <17504.54807.68153.142769@domain.hid>
Date: Tue, 9 May 2006 19:49:11 +0200
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
In-Reply-To: <445F4CC5.20301@domain.hid>
References: <17502.13773.674199.219762@domain.hid>
	<17503.16072.557355.759746@domain.hid>
	<445F4CC5.20301@domain.hid>
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


--9v4TrRpw4v
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Gilles Chanteperdrix wrote:
 > >  > These patches are not ready for inclusion, they are not tested
 > >  > yet.
 > > 
 > > The attached versions are tested. I still wonder if handling this in
 > > shadow.c is the right solution, or if there should be an xnppd_set call
 > > that could be called from within the skins event callbacks.
 > >
 > 
 > That would likely be better, since some skin might not want any cleanup 
 > code to be called, and in the current implementation, every skin needs 
 > to provide some ppd info when returning from the event callback, even if 
 > only the CLIENT_ATTACH event is to be monitored. On the other hand, we 
 > could argue that registering an event callback requires to implement all 
 > requests, including CLIENT_DETACH, possibly by returning a no-op value, 
 > so that no ppd registration would be done from bind_to_interface(). 
 > Actually, I think the latter would be the better option.

If we want CLIENT_DETACH to be called even if CLIENT_ATTACH returned the
no-op value, we have to allocate and store a ppd holder
nevertheless. So, the ppd became opaque void * pointers, returned by
CLIENT_ATTACH and passed back to CLIENT_DETACH. The holder allocation is
no longer the event callbacks responsibility.


 > Maybe a better approach would be to simply hash holders referring to 
 > busy muxtable entries on mm struct pointers? This way, we would only 
 > have to scan a list handling one element per attached skin per 
 > terminating process, which will be most of the time a matter of walking 
 > through a 1/2 element queue.
 > 
 > i.e. indexing table entries on mm pointers from bind_to_interface() to 
 > ask for the CLIENT_DETACH event to be fired upon process cleanup:
 > 
 > (key: curr->mm) ->
 > 	(holder: &muxtable[muxid1]) ->
 > 	(holder: &muxtable[muxid2]) ->
 > 	(holder: &muxtable[muxid3])
 > 

I have kept a hash table, but hashed only on the mm pointer, so that
data for different skins but the same mm end up contiguously in the same
bucket and can conveniently be destroyed all at once by an ad-hoc
function. If you find this unreadable/too baroque, I will switch to the
two-staged structure you suggest.

 > then, scanning the list hashed on the terminating process's mm struct, 
 > in order to fire the appropriate event callbacks.
 > 
 > Btw, on 2.4 at least, the global Linux mm_lock is held before firing the 
 > process cleanup notification at Adeos level, so one has to be careful 
 > about what's actually done in those per-skin cleanup handlers.

POSIX skin will call xnheap_destroy_mapped for shared memory heaps that
were not unmapped by the process, will this work ?

-- 


					    Gilles Chanteperdrix.

--9v4TrRpw4v
Content-Type: text/plain
Content-Disposition: inline;
	filename="xenomai-ppd.3.diff"
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
 
@@ -109,6 +109,8 @@
 		       int sig,
 		       int specific);
 
+void *xnshadow_get_ppd(unsigned skin_muxid);
+
 extern struct xnskentry muxtable[];
 
 #ifdef __cplusplus
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 1058)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -48,8 +48,22 @@
 #include <nucleus/shadow.h>
 #include <nucleus/core.h>
 #include <nucleus/ltt.h>
+#include <nucleus/jhash.h>
 #include <asm/xenomai/features.h>
 
+typedef struct xnppd_key {
+    unsigned long skin_muxid;
+    struct mm_struct *mm;
+} xnppd_key_t;
+
+typedef struct xnppd_holder {
+    xnppd_key_t key;
+    void *data;
+    xnholder_t link;
+#define link2ppd(laddr) \
+    (xnppd_holder_t *)((char *)(laddr) - offsetof(xnppd_holder_t, link))
+} xnppd_holder_t;
+
 int nkthrptd;
 
 int nkerrptd;
@@ -95,10 +109,124 @@
 
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
+            (ppd->key.mm == key->mm && ppd->key.skin_muxid < key->skin_muxid)));
+
+    if (ppd->key.mm == key->mm && ppd->key.skin_muxid == key->skin_muxid)
+        {
+        /* found it, return it. */
+        *pholder = ppd;
+        return 1;
+        }
+
+    /* not found, return successor for insertion. */
+    if (ppd->key.mm < key->mm ||
+        (ppd->key.mm == key->mm && ppd->key.skin_muxid < key->skin_muxid))
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
+    unsigned found = xnppd_lookup_inner(&q, &next, &holder->key);
+    BUG_ON(found);
+    inith(&holder->link);
+    if (next)
+        insertq(q, &next->link, &holder->link);
+    else
+        appendq(q, &holder->link);
+}
+
+static struct xnppd_holder *xnppd_lookup(unsigned skin_muxid,
+                                         struct mm_struct *mm)
+{
+    xnppd_holder_t *holder;
+    xnppd_key_t key;
+    unsigned found;
+    xnqueue_t *q;
+
+    key.skin_muxid = skin_muxid;
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
+
+    found = xnppd_lookup_inner(&q, &holder, &holder->key);
+
+    if (!found)
+        return;
+
+    removeq(q, &holder->link);
+}
+
+static inline void xnppd_remove_mm(struct mm_struct *mm,
+                                   void (*callback)(xnppd_holder_t *))
+{
+    xnppd_holder_t *ppd;
+    xnholder_t *holder;
+    xnppd_key_t key;
+    xnqueue_t *q;
+
+    key.skin_muxid = 0;
+    key.mm = mm;
+    xnppd_lookup_inner(&q, &ppd, &key);
+
+    while (ppd && ppd->key.mm == mm)
+        {
+        holder = nextq(q, &ppd->link);
+        removeq(q, &ppd->link);
+        callback(ppd);
+        ppd = holder ? link2ppd(holder) : NULL;
+        }
+}
+
 static inline void request_syscall_restart(xnthread_t *thread,
                                            struct pt_regs *regs)
 {
@@ -916,6 +1044,7 @@
                              unsigned magic,
                              u_long featdep, u_long abirev, u_long infarg)
 {
+    xnppd_holder_t *holder = NULL;
     xnfeatinfo_t finfo;
     u_long featmis;
     int muxid;
@@ -980,20 +1109,49 @@
        earlier than that, do not refer to nkpod until the latter had a
        chance to call xnpod_init(). */
 
-    if (muxtable[muxid].eventcb) {
-        int err = muxtable[muxid].eventcb(XNSHADOW_CLIENT_ATTACH);
+    if (muxtable[muxid].eventcb)
+	{
+        holder = xnppd_lookup(muxid, curr->mm);
 
-        if (err) {
-            xnarch_atomic_dec(&muxtable[muxid].refcnt);
-            return err;
+        /* protect from the same process binding several time. */
+        if (!holder)
+            {
+            void *ppd = muxtable[muxid].eventcb(XNSHADOW_CLIENT_ATTACH, curr);
+            if (IS_ERR(ppd))
+                {
+                xnarch_atomic_dec(&muxtable[muxid].refcnt);
+                return PTR_ERR(holder->data);
+                }
+
+            holder = xnarch_sysalloc(sizeof(*holder));
+            if (!holder)
+                {
+                muxtable[muxid].eventcb(XNSHADOW_CLIENT_DETACH, ppd);
+                xnarch_atomic_dec(&muxtable[muxid].refcnt);
+                return -ENOMEM;
+                }
+
+            holder->key.skin_muxid = muxid;
+            holder->key.mm = curr->mm;
+            holder->data = ppd;
+            xnppd_insert(holder);
+            }
         }
-    }
 
-    if (!nkpod || testbits(nkpod->status, XNPIDLE))
-        /* Ok mate, but you really ought to create some pod in a way
-           or another if you want me to be of some help here... */
-        return -ENOSYS;
+    if (!nkpod || testbits(nkpod->status,XNPIDLE))
+	/* Ok mate, but you really ought to create some pod in a way
+	   or another if you want me to be of some help here... */
+        {
+        if (muxtable[muxid].eventcb && holder)
+            {
+            xnppd_remove(holder);
+            xnarch_sysfree(holder, sizeof(*holder));
+            }
 
+        xnarch_atomic_dec(&muxtable[muxid].refcnt);
+	return -ENOSYS;
+        }
+
     return ++muxid;
 }
 
@@ -1640,6 +1798,20 @@
 
 RTHAL_DECLARE_SETSCHED_EVENT(setsched_event);
 
+static void detach_ppd_holder(xnppd_holder_t *holder)
+{
+    muxtable[holder->key.skin_muxid].eventcb(XNSHADOW_CLIENT_DETACH,
+                                             holder->data);
+    xnarch_sysfree(holder, sizeof(*holder));
+}
+
+static inline void do_cleanup_event (struct mm_struct *mm)
+{
+    xnppd_remove_mm(mm, detach_ppd_holder);
+}
+
+RTHAL_DECLARE_CLEANUP_EVENT(cleanup_event);
+
 /*
  * xnshadow_register_interface() -- Register a new skin/interface.
  * NOTE: an interface can be registered without its pod being
@@ -1649,9 +1821,10 @@
  */
 
 int xnshadow_register_interface(const char *name,
-                                unsigned magic,
-                                int nrcalls,
-                                xnsysent_t *systab, int (*eventcb) (int))
+				unsigned magic,
+				int nrcalls,
+				xnsysent_t *systab,
+				void *(*eventcb)(int, void *))
 {
     int muxid;
     spl_t s;
@@ -1720,12 +1893,22 @@
     return err;
 }
 
+/* Call with nklock locked irqs off. */
+void *xnshadow_get_ppd(unsigned skin_muxid)
+{
+    if (xnpod_userspace_p())
+        return xnppd_lookup(skin_muxid - 1, current->mm)->data;
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
@@ -1734,10 +1917,12 @@
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
@@ -1775,6 +1960,17 @@
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
 
@@ -1782,6 +1978,9 @@
 {
     int cpu;
 
+    if (xnppd_hash)
+        xnarch_sysfree(xnppd_hash, sizeof(xnqueue_t) * XNPPD_HASH_SIZE);
+
     rthal_catch_losyscall(NULL);
     rthal_catch_hisyscall(NULL);
 
@@ -1813,5 +2012,6 @@
 EXPORT_SYMBOL(xnshadow_unregister_interface);
 EXPORT_SYMBOL(xnshadow_wait_barrier);
 EXPORT_SYMBOL(xnshadow_suspend);
+EXPORT_SYMBOL(xnshadow_get_ppd);
 EXPORT_SYMBOL(nkthrptd);
 EXPORT_SYMBOL(nkerrptd);

--9v4TrRpw4v--

