Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADC2F99.3000307@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Oct 2009 11:20:52 +0200
Message-ID: <20091019092052.2502.1090.stgit@domain.hid>
In-Reply-To: <20091019092051.2502.31525.stgit@domain.hid>
References: <20091019092051.2502.31525.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 1/2] nucleus: Add semaphore heap statistics
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This extends /proc/xenomai/heap with statistics about the global as well
as all per-process semaphore heaps. This is helpful to track down the
reason for ENOMEM (system or sem heap full?) and to find out that we
are leaking memory from the global heap on automatic native mutex,
queue, and heap deletion.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/nucleus/sys_ppd.h |   11 +++++++++++
 ksrc/nucleus/heap.c       |   30 ++++++++++++++++++++++++++++++
 ksrc/nucleus/shadow.c     |   23 +++++++++++++++++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/include/nucleus/sys_ppd.h b/include/nucleus/sys_ppd.h
index 8f8cb44..015af53 100644
--- a/include/nucleus/sys_ppd.h
+++ b/include/nucleus/sys_ppd.h
@@ -3,11 +3,17 @@
 
 #include <nucleus/ppd.h>
 #include <nucleus/heap.h>
+#include <nucleus/queue.h>
 
 struct xnsys_ppd {
 	xnshadow_ppd_t ppd;
 	xnheap_t sem_heap;
 
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	xnholder_t link;
+	pid_t pid;
+#endif
+
 #define ppd2sys(addr) container_of(addr, struct xnsys_ppd, ppd)
 };
 
@@ -15,6 +21,11 @@ extern struct xnsys_ppd __xnsys_global_ppd;
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 
+#include <linux/spinlock.h>
+
+extern xnqueue_t xnsys_ppds;
+extern spinlock_t xnsys_ppd_lock;
+
 static inline struct xnsys_ppd *xnsys_ppd_get(int global)
 {
 	xnshadow_ppd_t *ppd;
diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index 9ca2591..4a3abd0 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -67,6 +67,7 @@ HEAP {
 #include <nucleus/thread.h>
 #include <nucleus/heap.h>
 #include <nucleus/assert.h>
+#include <nucleus/sys_ppd.h>
 #include <asm/xenomai/bits/heap.h>
 
 xnheap_t kheap;		/* System heap */
@@ -1277,11 +1278,17 @@ int xnheap_destroy_mapped(xnheap_t *heap, void (*release)(struct xnheap *heap),
 #ifdef CONFIG_PROC_FS
 
 #include <linux/proc_fs.h>
+#include <nucleus/sys_ppd.h>
 
 static int heap_read_proc(char *page,
 			  char **start,
 			  off_t off, int count, int *eof, void *data)
 {
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	xnholder_t *entry;
+	struct xnsys_ppd *sys_ppd;
+#endif
+	xnheap_t *sem_heap;
 	int len;
 
 	if (!xnpod_active_p())
@@ -1298,6 +1305,29 @@ static int heap_read_proc(char *page,
 		       xnheap_used_mem(&kstacks),
 		       xnheap_page_size(&kstacks));
 #endif
+	sem_heap = &__xnsys_global_ppd.sem_heap;
+	if (sem_heap)
+		len += sprintf(page + len, "size=%lu:used=%lu:pagesz=%lu  "
+					   "(global sem heap)\n",
+			       xnheap_usable_mem(sem_heap),
+			       xnheap_used_mem(sem_heap),
+			       xnheap_page_size(sem_heap));
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	spin_lock(&xnsys_ppd_lock);
+	entry = getheadq(&xnsys_ppds);
+	while (entry) {
+		sys_ppd = container_of(entry, struct xnsys_ppd, link);
+		sem_heap = &sys_ppd->sem_heap;
+		len += sprintf(page + len, "size=%lu:used=%lu:pagesz=%lu  "
+					   "(private sem heap [%d])\n",
+			       xnheap_usable_mem(sem_heap),
+			       xnheap_used_mem(sem_heap),
+			       xnheap_page_size(sem_heap),
+			       sys_ppd->pid);
+		entry = nextq(&xnsys_ppds, entry);
+	}
+	spin_unlock(&xnsys_ppd_lock);
+#endif
 
 	len -= off;
 	if (len <= off + count)
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index d6d1203..ec69438 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -515,6 +515,9 @@ void xnshadow_rpi_check(void)
 
 #endif /* !CONFIG_XENO_OPT_RPIDISABLE */
 
+DEFINE_XNQUEUE(xnsys_ppds);
+DEFINE_SPINLOCK(xnsys_ppd_lock);
+
 static xnqueue_t *ppd_hash;
 #define PPD_HASH_SIZE 13
 
@@ -652,6 +655,20 @@ static inline void ppd_remove_mm(struct mm_struct *mm,
 	xnlock_put_irqrestore(&nklock, s);
 }
 
+static void xnsys_ppd_register(struct xnsys_ppd *sys_ppd)
+{
+	spin_lock(&xnsys_ppd_lock);
+	appendq(&xnsys_ppds, &sys_ppd->link);
+	spin_unlock(&xnsys_ppd_lock);
+}
+
+static void xnsys_ppd_unregister(struct xnsys_ppd *sys_ppd)
+{
+	spin_lock(&xnsys_ppd_lock);
+	removeq(&xnsys_ppds, &sys_ppd->link);
+	spin_unlock(&xnsys_ppd_lock);
+}
+
 static inline void request_syscall_restart(xnthread_t *thread,
 					   struct pt_regs *regs,
 					   int sysflags)
@@ -1892,10 +1909,16 @@ static void *xnshadow_sys_event(int event, void *data)
 			return ERR_PTR(err);
 		}
 
+		p->pid = current->pid;
+		xnsys_ppd_register(p);
+
 		return &p->ppd;
 
 	case XNSHADOW_CLIENT_DETACH:
 		p = ppd2sys((xnshadow_ppd_t *) data);
+
+		xnsys_ppd_unregister(p);
+
 		xnheap_destroy_mapped(&p->sem_heap, post_ppd_release, NULL);
 
 		return NULL;


