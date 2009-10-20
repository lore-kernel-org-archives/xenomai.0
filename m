Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.7070402@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:26 +0200
Message-ID: <20091020113726.9069.95593.stgit@domain.hid>
In-Reply-To: <20091020113724.9069.23594.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 9/9] nucleus: Include all heaps in
	statistics
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

This extends /proc/xenomai/heap with statistics about all currently used
heaps. It takes care to flush nklock while iterating of this potentially
long list.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/nucleus/heap.h    |   12 +++-
 ksrc/drivers/ipc/iddp.c   |    3 +
 ksrc/drivers/ipc/xddp.c   |    6 ++
 ksrc/nucleus/heap.c       |  131 ++++++++++++++++++++++++++++++++++++++++-----
 ksrc/nucleus/module.c     |    2 -
 ksrc/nucleus/pod.c        |    5 +-
 ksrc/nucleus/shadow.c     |    5 +-
 ksrc/skins/native/heap.c  |    6 +-
 ksrc/skins/native/pipe.c  |    4 +
 ksrc/skins/native/queue.c |    6 +-
 ksrc/skins/posix/shm.c    |    4 +
 ksrc/skins/psos+/rn.c     |    6 +-
 ksrc/skins/rtai/shm.c     |    7 ++
 ksrc/skins/vrtx/heap.c    |    6 +-
 ksrc/skins/vrtx/syscall.c |    3 +
 15 files changed, 169 insertions(+), 37 deletions(-)

diff --git a/include/nucleus/heap.h b/include/nucleus/heap.h
index 44db738..f653cd7 100644
--- a/include/nucleus/heap.h
+++ b/include/nucleus/heap.h
@@ -115,6 +115,10 @@ typedef struct xnheap {
 
 	XNARCH_DECL_DISPLAY_CONTEXT();
 
+	xnholder_t stat_link;	/* Link in heapq */
+
+	char name[48];
+
 } xnheap_t;
 
 extern xnheap_t kheap;
@@ -202,7 +206,8 @@ void xnheap_cleanup_proc(void);
 
 int xnheap_init_mapped(xnheap_t *heap,
 		       u_long heapsize,
-		       int memflags);
+		       int memflags,
+		       const char *name, ...);
 
 void xnheap_destroy_mapped(xnheap_t *heap,
 			   void (*release)(struct xnheap *heap),
@@ -224,7 +229,10 @@ void xnheap_destroy_mapped(xnheap_t *heap,
 int xnheap_init(xnheap_t *heap,
 		void *heapaddr,
 		u_long heapsize,
-		u_long pagesize);
+		u_long pagesize,
+		const char *name, ...);
+
+void xnheap_set_name(xnheap_t *heap, const char *name, ...);
 
 void xnheap_destroy(xnheap_t *heap,
 		    void (*flushfn)(xnheap_t *heap,
diff --git a/ksrc/drivers/ipc/iddp.c b/ksrc/drivers/ipc/iddp.c
index a407946..b6382f1 100644
--- a/ksrc/drivers/ipc/iddp.c
+++ b/ksrc/drivers/ipc/iddp.c
@@ -559,7 +559,8 @@ static int __iddp_bind_socket(struct rtipc_private *priv,
 		}
 
 		ret = xnheap_init(&sk->privpool,
-				  poolmem, poolsz, XNHEAP_PAGE_SIZE);
+				  poolmem, poolsz, XNHEAP_PAGE_SIZE,
+				  "ippd: %d", port);
 		if (ret) {
 			xnarch_free_host_mem(poolmem, poolsz);
 			goto fail;
diff --git a/ksrc/drivers/ipc/xddp.c b/ksrc/drivers/ipc/xddp.c
index f62147a..a5dafef 100644
--- a/ksrc/drivers/ipc/xddp.c
+++ b/ksrc/drivers/ipc/xddp.c
@@ -703,7 +703,7 @@ static int __xddp_bind_socket(struct rtipc_private *priv,
 		}
 
 		ret = xnheap_init(&sk->privpool,
-				  poolmem, poolsz, XNHEAP_PAGE_SIZE);
+				  poolmem, poolsz, XNHEAP_PAGE_SIZE, "");
 		if (ret) {
 			xnarch_free_host_mem(poolmem, poolsz);
 			goto fail;
@@ -746,6 +746,10 @@ static int __xddp_bind_socket(struct rtipc_private *priv,
 	sk->minor = ret;
 	sa->sipc_port = ret;
 	sk->name = *sa;
+
+	if (poolsz > 0)
+		xnheap_set_name(sk->bufpool, "xddp: %d", sa->sipc_port);
+
 	/* Set default destination if unset at binding time. */
 	if (sk->peer.sipc_port < 0)
 		sk->peer = *sa;
diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index 96c46f8..793d1c5 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -76,6 +76,9 @@ EXPORT_SYMBOL_GPL(kheap);
 xnheap_t kstacks;	/* Private stack pool */
 #endif
 
+static DEFINE_XNQUEUE(heapq);	/* Heap list for /proc reporting */
+static unsigned long heapq_rev;
+
 static void init_extent(xnheap_t *heap, xnextent_t *extent)
 {
 	caddr_t freepage;
@@ -108,7 +111,7 @@ static void init_extent(xnheap_t *heap, xnextent_t *extent)
  */
 
 /*!
- * \fn xnheap_init(xnheap_t *heap,void *heapaddr,u_long heapsize,u_long pagesize)
+ * \fn xnheap_init(xnheap_t *heap,void *heapaddr,u_long heapsize,u_long pagesize,const char *name,...)
  * \brief Initialize a memory heap.
  *
  * Initializes a memory heap suitable for time-bounded allocation
@@ -145,6 +148,10 @@ static void init_extent(xnheap_t *heap, xnextent_t *extent)
  * best one for your needs. In the current implementation, pagesize
  * must be a power of two in the range [ 8 .. 32768 ] inclusive.
  *
+ * @param name Name displayed in statistic outputs. This parameter can
+ * be a format string, in which case succeeding parameters will be used
+ * to resolve the final name.
+ *
  * @return 0 is returned upon success, or one of the following error
  * codes:
  *
@@ -161,12 +168,13 @@ static void init_extent(xnheap_t *heap, xnextent_t *extent)
  * Rescheduling: never.
  */
 
-int xnheap_init(xnheap_t *heap,
-		void *heapaddr, u_long heapsize, u_long pagesize)
+static int xnheap_init_va(xnheap_t *heap, void *heapaddr, u_long heapsize,
+			  u_long pagesize, const char *name, va_list args)
 {
 	unsigned cpu, nr_cpus = xnarch_num_online_cpus();
 	u_long hdrsize, shiftsize, pageshift;
 	xnextent_t *extent;
+	spl_t s;
 
 	/*
 	 * Perform some parametrical checks first.
@@ -232,12 +240,71 @@ int xnheap_init(xnheap_t *heap,
 
 	appendq(&heap->extents, &extent->link);
 
+	vsnprintf(heap->name, sizeof(heap->name), name, args);
+
+	xnlock_get_irqsave(&nklock, s);
+	appendq(&heapq, &heap->stat_link);
+	heapq_rev++;
+	xnlock_put_irqrestore(&nklock, s);
+
 	xnarch_init_display_context(heap);
 
 	return 0;
 }
+
+int xnheap_init(xnheap_t *heap, void *heapaddr, u_long heapsize,
+		u_long pagesize, const char *name, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, name);
+	ret = xnheap_init_va(heap, heapaddr, heapsize, pagesize, name, args);
+	va_end(args);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(xnheap_init);
 
+/*!
+ * \fn xnheap_set_name(xnheap_t *heap,const char *name,...)
+ * \brief Overwrite the heap's name.
+ *
+ * Set the heap name that will be used in statistic outputs. This service
+ * is useful if the final name is not yet defined on xnheap_init().
+ *
+ * @param heap The address of a heap descriptor.
+ *
+ * @param name Name displayed in statistic outputs. This parameter can
+ * be a format string, in which case succeeding parameters will be used
+ * to resolve the final name.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Kernel-based task
+ * - User-space task
+ *
+ * Rescheduling: never.
+ */
+
+void xnheap_set_name(xnheap_t *heap, const char *name, ...)
+{
+	va_list args;
+	spl_t s;
+
+	va_start(args, name);
+
+	xnlock_get_irqsave(&nklock, s);
+	vsnprintf(heap->name, sizeof(heap->name), name, args);
+	xnlock_put_irqrestore(&nklock, s);
+
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(xnheap_set_name);
+
 /*! 
  * \fn void xnheap_destroy(xnheap_t *heap, void (*flushfn)(xnheap_t *heap, void *extaddr, u_long extsize, void *cookie), void *cookie)
  * \brief Destroys a memory heap.
@@ -273,6 +340,11 @@ void xnheap_destroy(xnheap_t *heap,
 	xnholder_t *holder;
 	spl_t s;
 
+	xnlock_get_irqsave(&nklock, s);
+	removeq(&heapq, &heap->stat_link);
+	heapq_rev++;
+	xnlock_put_irqrestore(&nklock, s);
+
 	if (!flushfn)
 		return;
 
@@ -1140,9 +1212,11 @@ deref_out:
 	return err;
 }
 
-int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags)
+int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags,
+		       const char *name, ...)
 {
 	void *heapbase;
+	va_list args;
 	int err;
 
 	/* Caller must have accounted for internal overhead. */
@@ -1156,7 +1230,9 @@ int xnheap_init_mapped(xnheap_t *heap, u_long heapsize, int memflags)
 	if (!heapbase)
 		return -ENOMEM;
 
-	err = xnheap_init(heap, heapbase, heapsize, PAGE_SIZE);
+	va_start(args, name);
+	err = xnheap_init_va(heap, heapbase, heapsize, PAGE_SIZE, name, args);
+	va_end(args);
 	if (err) {
 		__unreserve_and_free_heap(heapbase, heapsize, memflags);
 		return err;
@@ -1178,6 +1254,7 @@ void xnheap_destroy_mapped(xnheap_t *heap,
 			   void __user *mapaddr)
 {
 	unsigned long len;
+	spl_t s;
 
 	/*
 	 * Trying to unmap user memory without providing a release handler for
@@ -1185,6 +1262,11 @@ void xnheap_destroy_mapped(xnheap_t *heap,
 	 */
 	XENO_ASSERT(NUCLEUS, !mapaddr || release, /* nop */);
 
+	xnlock_get_irqsave(&nklock, s);
+	removeq(&heapq, &heap->stat_link);
+	heapq_rev++;
+	xnlock_put_irqrestore(&nklock, s);
+
 	spin_lock(&kheapq_lock);
 
 	removeq(&kheapq, &heap->link); /* Prevent further mapping. */
@@ -1285,22 +1367,41 @@ static int heap_read_proc(char *page,
 			  char **start,
 			  off_t off, int count, int *eof, void *data)
 {
+	unsigned long rev;
+	xnholder_t *entry;
+	xnheap_t *heap;
 	int len;
+	spl_t s;
 
 	if (!xnpod_active_p())
 		return -ESRCH;
 
-	len = sprintf(page, "size=%lu:used=%lu:pagesz=%lu  (main heap)\n",
-		      xnheap_usable_mem(&kheap),
-		      xnheap_used_mem(&kheap),
-		      xnheap_page_size(&kheap));
+	xnlock_get_irqsave(&nklock, s);
 
-#if CONFIG_XENO_OPT_SYS_STACKPOOLSZ > 0
-	len += sprintf(page + len, "size=%lu:used=%lu:pagesz=%lu  (stack pool)\n",
-		       xnheap_usable_mem(&kstacks),
-		       xnheap_used_mem(&kstacks),
-		       xnheap_page_size(&kstacks));
-#endif
+restart:
+	len = 0;
+
+	entry = getheadq(&heapq);
+	while (entry) {
+		heap = container_of(entry, xnheap_t, stat_link);
+		len += sprintf(page + len,
+			       "size=%lu:used=%lu:pagesz=%lu  (%s)\n",
+			       xnheap_usable_mem(heap),
+			       xnheap_used_mem(heap),
+			       xnheap_page_size(heap),
+			       heap->name);
+
+		rev = heapq_rev;
+
+		xnlock_sync_irq(&nklock, s);
+
+		if (heapq_rev != rev)
+			goto restart;
+
+		entry = nextq(&heapq, entry);
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
 
 	len -= off;
 	if (len <= off + count)
diff --git a/ksrc/nucleus/module.c b/ksrc/nucleus/module.c
index 141276a..a0efc14 100644
--- a/ksrc/nucleus/module.c
+++ b/ksrc/nucleus/module.c
@@ -100,7 +100,7 @@ int __init __xeno_sys_init(void)
 #ifndef __XENO_SIM__
 	ret = xnheap_init_mapped(&__xnsys_global_ppd.sem_heap,
 				 CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ * 1024,
-				 XNARCH_SHARED_HEAP_FLAGS);
+				 XNARCH_SHARED_HEAP_FLAGS, "global sem heap");
 	if (ret)
 		goto cleanup_arch;
 #endif
diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 370ad28..07fbcdb 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -384,9 +384,8 @@ int xnpod_init(void)
 	heapaddr = xnarch_alloc_host_mem(xnmod_sysheap_size);
 	if (heapaddr == NULL ||
 	    xnheap_init(&kheap, heapaddr, xnmod_sysheap_size,
-			XNHEAP_PAGE_SIZE) != 0) {
+			XNHEAP_PAGE_SIZE, "main heap") != 0)
 		return -ENOMEM;
-	}
 
 #if CONFIG_XENO_OPT_SYS_STACKPOOLSZ > 0
 	/*
@@ -404,7 +403,7 @@ int xnpod_init(void)
 	heapaddr = xnarch_alloc_stack_mem(CONFIG_XENO_OPT_SYS_STACKPOOLSZ * 1024);
 	if (heapaddr == NULL ||
 	    xnheap_init(&kstacks, heapaddr, CONFIG_XENO_OPT_SYS_STACKPOOLSZ * 1024,
-			XNHEAP_PAGE_SIZE) != 0) {
+			XNHEAP_PAGE_SIZE, "stack pool") != 0) {
 		xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
 		return -ENOMEM;
 	}
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index d6d1203..e8876d8 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1886,7 +1886,9 @@ static void *xnshadow_sys_event(int event, void *data)
 
 		err = xnheap_init_mapped(&p->sem_heap,
 					 CONFIG_XENO_OPT_SEM_HEAPSZ * 1024,
-					 XNARCH_SHARED_HEAP_FLAGS);
+					 XNARCH_SHARED_HEAP_FLAGS,
+					 "private sem heap [%d]",
+					 current->pid);
 		if (err) {
 			xnarch_free_host_mem(p, sizeof(*p));
 			return ERR_PTR(err);
@@ -1896,6 +1898,7 @@ static void *xnshadow_sys_event(int event, void *data)
 
 	case XNSHADOW_CLIENT_DETACH:
 		p = ppd2sys((xnshadow_ppd_t *) data);
+
 		xnheap_destroy_mapped(&p->sem_heap, post_ppd_release, NULL);
 
 		return NULL;
diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
index 886758c..3072f99 100644
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -266,7 +266,8 @@ int rt_heap_create(RT_HEAP *heap, const char *name, size_t heapsize, int mode)
 					 heapsize,
 					 ((mode & H_DMA) ? GFP_DMA : 0)
 					 | ((mode & H_NONCACHED) ?
-					    XNHEAP_GFP_NONCACHED : 0));
+					    XNHEAP_GFP_NONCACHED : 0),
+					 "rt_heap: %s", name);
 		if (err)
 			return err;
 
@@ -286,7 +287,8 @@ int rt_heap_create(RT_HEAP *heap, const char *name, size_t heapsize, int mode)
 		if (!heapmem)
 			return -ENOMEM;
 
-		err = xnheap_init(&heap->heap_base, heapmem, heapsize, XNHEAP_PAGE_SIZE);
+		err = xnheap_init(&heap->heap_base, heapmem, heapsize,
+				  XNHEAP_PAGE_SIZE, "rt_heap: %s", name);
 		if (err) {
 			xnarch_free_host_mem(heapmem, heapsize);
 			return err;
diff --git a/ksrc/skins/native/pipe.c b/ksrc/skins/native/pipe.c
index 672fa7a..18d9aa0 100644
--- a/ksrc/skins/native/pipe.c
+++ b/ksrc/skins/native/pipe.c
@@ -295,7 +295,9 @@ int rt_pipe_create(RT_PIPE *pipe, const char *name, int minor, size_t poolsize)
 			return -ENOMEM;
 
 		/* Use natural page size */
-		err = xnheap_init(&pipe->privpool, poolmem, poolsize, XNHEAP_PAGE_SIZE);
+		err = xnheap_init(&pipe->privpool, poolmem, poolsize,
+				  XNHEAP_PAGE_SIZE,
+				  "rt_pipe: %d / %s", minor, name);
 		if (err) {
 			xnarch_free_host_mem(poolmem, poolsize);
 			return err;
diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
index 249947a..becc0f0 100644
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -229,7 +229,8 @@ int rt_queue_create(RT_QUEUE *q,
 		err = xnheap_init_mapped(&q->bufpool,
 					 poolsize,
 					 ((mode & Q_DMA) ? GFP_DMA 
-					  : XNARCH_SHARED_HEAP_FLAGS));
+					  : XNARCH_SHARED_HEAP_FLAGS),
+					 "rt_queue: %s", name);
 		if (err)
 			return err;
 
@@ -249,7 +250,8 @@ int rt_queue_create(RT_QUEUE *q,
 		if (!poolmem)
 			return -ENOMEM;
 
-		err = xnheap_init(&q->bufpool, poolmem, poolsize, XNHEAP_PAGE_SIZE);
+		err = xnheap_init(&q->bufpool, poolmem, poolsize,
+				  XNHEAP_PAGE_SIZE, "rt_queue: %s", name);
 		if (err) {
 			xnarch_free_host_mem(poolmem, poolsize);
 			return err;
diff --git a/ksrc/skins/posix/shm.c b/ksrc/skins/posix/shm.c
index c92096a..0f0bd1a 100644
--- a/ksrc/skins/posix/shm.c
+++ b/ksrc/skins/posix/shm.c
@@ -539,7 +539,9 @@ int ftruncate(int fd, off_t len)
 			int flags = XNARCH_SHARED_HEAP_FLAGS |
 				((desc_flags & O_DIRECT) ? GFP_DMA : 0);
 
-			err = -xnheap_init_mapped(&shm->heapbase, len, flags);
+			err = -xnheap_init_mapped(&shm->heapbase, len, flags,
+						  "posix shm: %s",
+						  shm->nodebase.name);
 			if (err)
 				goto err_up;
 
diff --git a/ksrc/skins/psos+/rn.c b/ksrc/skins/psos+/rn.c
index 98f4500..3eb3ab9 100644
--- a/ksrc/skins/psos+/rn.c
+++ b/ksrc/skins/psos+/rn.c
@@ -191,7 +191,8 @@ u_long rn_create(const char *name,
 
 		rnsize = xnheap_rounded_size(rnsize, PAGE_SIZE),
 		err = xnheap_init_mapped(&rn->heapbase, rnsize, 
-					 XNARCH_SHARED_HEAP_FLAGS);
+					 XNARCH_SHARED_HEAP_FLAGS,
+					 "psosrn: %s", name);
 
 		if (err)
 			return err;
@@ -206,7 +207,8 @@ u_long rn_create(const char *name,
 		 * Caller must have accounted for overhead and
 		 * alignment since it supplies the memory space.
 		 */
-		if (xnheap_init(&rn->heapbase, rnaddr, rnsize, XNHEAP_PAGE_SIZE) != 0)
+		if (xnheap_init(&rn->heapbase, rnaddr, rnsize,
+				XNHEAP_PAGE_SIZE, "psosrn: %s", name) != 0)
 			return ERR_TINYRN;
 
 	inith(&rn->link);
diff --git a/ksrc/skins/rtai/shm.c b/ksrc/skins/rtai/shm.c
index 21c3b07..0b33a57 100644
--- a/ksrc/skins/rtai/shm.c
+++ b/ksrc/skins/rtai/shm.c
@@ -151,7 +151,8 @@ static xnshm_a_t *create_new_heap(unsigned long name, int heapsize, int suprt)
 	err = xnheap_init_mapped(p->heap,
 				 heapsize,
 				 (suprt == USE_GFP_KERNEL ? GFP_KERNEL : 0)
-				 | XNARCH_SHARED_HEAP_FLAGS);
+				 | XNARCH_SHARED_HEAP_FLAGS,
+				 "rtai heap: 0x%lx", name);
 #else /* !CONFIG_XENO_OPT_PERVASIVE */
 	{
 		void *heapmem;
@@ -164,7 +165,9 @@ static xnshm_a_t *create_new_heap(unsigned long name, int heapsize, int suprt)
 			err = -ENOMEM;
 		} else {
 
-			err = xnheap_init(p->heap, heapmem, heapsize, XNHEAP_PAGE_SIZE);
+			err = xnheap_init(p->heap, heapmem, heapsize,
+					  XNHEAP_PAGE_SIZE,
+					  "rtai heap: 0x%lx", name);
 			if (err) {
 				xnarch_free_host_mem(heapmem, heapsize);
 			}
diff --git a/ksrc/skins/vrtx/heap.c b/ksrc/skins/vrtx/heap.c
index de60792..8f8a1d5 100644
--- a/ksrc/skins/vrtx/heap.c
+++ b/ksrc/skins/vrtx/heap.c
@@ -165,7 +165,8 @@ int sc_hcreate(char *heapaddr, u_long heapsize, unsigned log2psize, int *errp)
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 		heapsize = xnheap_rounded_size(heapsize, PAGE_SIZE);
 		err = xnheap_init_mapped(&heap->sysheap, heapsize, 
-					 XNARCH_SHARED_HEAP_FLAGS);
+					 XNARCH_SHARED_HEAP_FLAGS,
+					 "vrtx sysheap");
 
 		if (err) {
 			*errp = ER_MEM;
@@ -184,7 +185,8 @@ int sc_hcreate(char *heapaddr, u_long heapsize, unsigned log2psize, int *errp)
 		 * Caller must have accounted for overhead and
 		 * alignment since it supplies the memory space.
 		 */
-		err = xnheap_init(&heap->sysheap, heapaddr, heapsize, pagesize);
+		err = xnheap_init(&heap->sysheap, heapaddr, heapsize, pagesize,
+				  "vrtx sysheap");
 
 		if (err) {
 			if (err == -EINVAL)
diff --git a/ksrc/skins/vrtx/syscall.c b/ksrc/skins/vrtx/syscall.c
index 1623066..e3d2e31 100644
--- a/ksrc/skins/vrtx/syscall.c
+++ b/ksrc/skins/vrtx/syscall.c
@@ -1052,7 +1052,8 @@ static int __sc_pcreate(struct pt_regs *regs)
 	/* Block size. */
 	bsize = __xn_reg_arg3(regs);
 
-	err = xnheap_init_mapped(ptheap, ptsize, XNARCH_SHARED_HEAP_FLAGS);
+	err = xnheap_init_mapped(ptheap, ptsize, XNARCH_SHARED_HEAP_FLAGS,
+				 "vrtx ptheap");
 
 	if (err)
 		goto free_heap;


