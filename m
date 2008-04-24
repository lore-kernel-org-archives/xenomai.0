From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.10337.610639.200224@domain.hid>
Date: Thu, 24 Apr 2008 08:27:45 +0200
In-Reply-To: <18448.10221.879356.57696@domain.hid>
References: <18448.9649.956656.531081@domain.hid>
	<18448.9901.799115.445182@domain.hid>
	<18448.9967.355128.570111@domain.hid>
	<18448.10037.181558.14996@domain.hid>
	<18448.10157.853132.856441@domain.hid>
	<18448.10221.879356.57696@domain.hid>
Subject: [Xenomai-core] [6/9] Rework posix skin shared heaps support,
	add per-process shared heap.
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


This patch removes much of the #ifdefery that was in ksrc/skins/posix/shm.c. It
also initializes a global shared heap (for process-shared objects), as well as a
per-process shared heap. These two heaps are mapped in the posix skin library
initialization, using the new get_heap_addr syscall to get their addresses.

Of course, at this chance, we use the XNARCH_SHARED_HEAP_FLAGS macro, as a flag
passed to xnheap_init_mapped.

Several questions here:
- the heaps are created with a size of three pages, hardcoded, maybe we should
  make this size somehow configurable (Kconfig, /proc, whatever). My idea was
  that each mutex will use about 4 bytes in a heap, so 12 Kbytes is plenty.
- if we do not want to waste memory, like the xnthread_t * TSD, I wonder if
  these two heaps should not be allocated by the core event callback,
  unfortunately, this would mean that we would have to associate a per-process
  data with the core skin, which we avoided until now.

---
 ksrc/skins/posix/internal.h |   10 ++++++
 ksrc/skins/posix/module.c   |   41 ++++++++++++++++++++++++++
 ksrc/skins/posix/shm.c      |   44 ++++------------------------
 src/skins/posix/init.c      |   68 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 37 deletions(-)

Index: ksrc/skins/posix/internal.h
===================================================================
--- ksrc/skins/posix/internal.h	(revision 3718)
+++ ksrc/skins/posix/internal.h	(working copy)
@@ -71,6 +71,7 @@ typedef struct {
 	xnqueue_t semq;
 	xnqueue_t threadq;
 	xnqueue_t timerq;
+	xnheap_t shm_heap;
 } pse51_kqueues_t;
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
@@ -202,4 +203,13 @@ static inline int clock_flag(int flag, c
 int pse51_mq_select_bind(mqd_t fd, struct xnselector *selector,
 			 unsigned type, unsigned index);
 
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+#define pse51_shm_heap_init(h, l, f) xnheap_init_mapped(h, l, f)
+#define pse51_shm_heap_destroy(h) xnheap_destroy_mapped(h)
+#else /* !CONFIG_XENO_OPT_PERVASIVE */
+int pse51_shm_heap_init(xnheap_t *heap, unsigned len, int flags);
+
+void pse51_shm_heap_destroy(xnheap_t *heap);
+#endif /* !CONFIG_XENO_OPT_PERVASIVE */
+
 #endif /* !_POSIX_INTERNAL_H */
Index: ksrc/skins/posix/module.c
===================================================================
--- ksrc/skins/posix/module.c	(revision 3718)
+++ ksrc/skins/posix/module.c	(working copy)
@@ -78,6 +78,36 @@ MODULE_PARM_DESC(time_slice, "Default ti
 
 xntbase_t *pse51_tbase;
 
+#ifndef CONFIG_XENO_OPT_PERVASIVE
+static void pse51_free_heap_extent(xnheap_t *heap,
+				   void *extent, u_long size, void *cookie)
+{
+	xnarch_free_host_mem(extent, size);
+}
+
+int pse51_shm_heap_init(xnheap_t *heap, unsigned len, int flags)
+{
+	void *heapaddr = xnarch_alloc_host_mem(len);
+	int err;
+
+	if (heapaddr) {
+		err = xnheap_init(&shm->heapbase,
+				  heapaddr, len, XNCORE_PAGE_SIZE);
+		if (err)
+			xnarch_free_host_mem(heapaddr, len);
+
+		return err;
+	}
+
+	return -ENOMEM;
+}
+
+void pse51_shm_heap_destroy(xnheap_t *heap)
+{
+	xnheap_destroy(heap, &pse51_free_heap_extent, NULL);
+}
+#endif /* !CONFIG_XENO_OPT_PERVASIVE */
+
 static void pse51_shutdown(int xtype)
 {
 	pse51_thread_pkg_cleanup();
@@ -98,6 +128,7 @@ static void pse51_shutdown(int xtype)
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	pse51_syscall_cleanup();
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
+	pse51_shm_heap_destroy(&pse51_global_kqueues.shm_heap);
 #ifdef __KERNEL__
 	pse51_apc_pkg_cleanup();
 #endif /* __KERNEL__ */
@@ -127,11 +158,21 @@ int SKIN_INIT(posix)
 		goto fail_free_tbase;
 #endif /* __KERNEL__ */
 
+	err = pse51_shm_heap_init(&pse51_global_kqueues.shm_heap, 3 * PAGE_SIZE,
+				  (XNARCH_SHARED_HEAP_FLAGS ?: GFP_USER));
+	if (err)
+		goto fail_cleanup_apc;
+	
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	err = pse51_syscall_init();
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 	if (err != 0) {
+		pse51_shm_heap_destroy(&pse51_global_kqueues.shm_heap);
+	  fail_cleanup_apc:
+#ifdef __KERNEL__
+		pse51_apc_pkg_cleanup();
 	  fail_free_tbase:
+#endif /* __KERNEL__ */
 		xntbase_free(pse51_tbase);
 	fail_shutdown_pod:
 		xnpod_shutdown(err);
Index: ksrc/skins/posix/shm.c
===================================================================
--- ksrc/skins/posix/shm.c	(revision 3718)
+++ ksrc/skins/posix/shm.c	(working copy)
@@ -90,14 +90,6 @@ static void pse51_shm_init(pse51_shm_t *
 	appendq(&pse51_shmq, &shm->link);
 }
 
-#ifndef CONFIG_XENO_OPT_PERVASIVE
-static void pse51_free_heap_extent(xnheap_t *heap,
-				   void *extent, u_long size, void *cookie)
-{
-	xnarch_free_host_mem(extent, size);
-}
-#endif /* !CONFIG_XENO_OPT_PERVASIVE */
-
 /* Must be called nklock locked, irq off. */
 static void pse51_shm_destroy(pse51_shm_t * shm, int force)
 {
@@ -111,11 +103,7 @@ static void pse51_shm_destroy(pse51_shm_
 	if (shm->addr) {
 		xnheap_free(&shm->heapbase, shm->addr);
 
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-		xnheap_destroy_mapped(&shm->heapbase);
-#else /* !CONFIG_XENO_OPT_PERVASIVE. */
-		xnheap_destroy(&shm->heapbase, &pse51_free_heap_extent, NULL);
-#endif /* !CONFIG_XENO_OPT_PERVASIVE. */
+		pse51_shm_heap_destroy(&shm->heapbase);
 
 		shm->addr = NULL;
 		shm->size = 0;
@@ -534,37 +522,19 @@ int ftruncate(int fd, off_t len)
 			memcpy(addr, shm->addr, size);
 
 			xnheap_free(&shm->heapbase, shm->addr);
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-			xnheap_destroy_mapped(&shm->heapbase);
-#else /* !CONFIG_XENO_OPT_PERVASIVE. */
-			xnheap_destroy(&shm->heapbase, &pse51_free_heap_extent,
-				       NULL);
-#endif /* !CONFIG_XENO_OPT_PERVASIVE. */
+			pse51_shm_heap_destroy(&shm->heapbase);
 
 			shm->addr = NULL;
 			shm->size = 0;
 		}
 
 		if (len) {
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-			int flags = len <= 128 * 1024 ? GFP_USER : 0;
-			err = -xnheap_init_mapped(&shm->heapbase, len, flags);
-#else /* !CONFIG_XENO_OPT_PERVASIVE. */
-			{
-				void *heapaddr = xnarch_alloc_host_mem(len);
-
-				if (heapaddr)
-					err =
-					    -xnheap_init(&shm->heapbase,
-							 heapaddr, len,
-							 XNCORE_PAGE_SIZE);
-				else
-					err = ENOMEM;
+			int flags = (XNARCH_SHARED_HEAP_FLAGS ?:
+				     len <= 128 * 1024 ? GFP_USER : 0);
 
-				if (err)
-					goto err_up;
-			}
-#endif /* !CONFIG_XENO_OPT_PERVASIVE. */
+			err = -pse51_shm_heap_init(&shm->heapbase, len, flags);
+			if (err)
+				goto err_up;
 
 			shm->size = xnheap_max_contiguous(&shm->heapbase);
 			shm->addr = xnheap_alloc(&shm->heapbase, shm->size);
Index: src/skins/posix/init.c
===================================================================
--- src/skins/posix/init.c	(revision 3718)
+++ src/skins/posix/init.c	(working copy)
@@ -33,10 +33,49 @@ int __pse51_muxid = -1;
 int __rtdm_muxid = -1;
 int __rtdm_fd_start = INT_MAX;
 static int fork_handler_registered;
+pthread_key_t pse51_cur_key;
+unsigned long pse51_shared_map[2] = {0, 0};
 
 int __wrap_pthread_setschedparam(pthread_t, int, const struct sched_param *);
 void pse51_clock_init(int);
 
+static void *map_shared_heap(unsigned shared)
+{
+	void *heap_addr;
+	int fd, err;
+
+	fd = __real_open("/dev/rtheap", O_RDWR, 0);
+	if (fd < 0) {
+		fprintf(stderr, "open: %m\n");
+		return MAP_FAILED;
+	}
+
+	err = XENOMAI_SKINCALL2(__pse51_muxid,
+				__pse51_get_heap_addr, &heap_addr, shared);
+	if (err < 0) {
+		fprintf(stderr, "get_heap_addr: %m\n");
+		return MAP_FAILED;
+	}
+
+	err = __real_ioctl(fd, 0, heap_addr);
+	if (err < 0) {
+		fprintf(stderr, "ioctl: %m\n");
+		return MAP_FAILED;
+	}
+
+	heap_addr = __real_mmap(NULL, 3 * getpagesize(),
+				PROT_READ | PROT_WRITE,
+				MAP_SHARED, fd, 0);
+	close(fd);
+
+	return heap_addr;
+}
+
+static void unmap_shared_heap(unsigned long heap_addr)
+{
+	__real_munmap((void *) heap_addr, 3 * getpagesize());
+}
+
 static __attribute__ ((constructor))
 void __init_posix_interface(void)
 {
@@ -83,7 +122,35 @@ void __init_posix_interface(void)
 	}
 #endif /* !CONFIG_XENO_POSIX_AUTO_MLOCKALL */
 
+	if (pse51_shared_map[0])
+		/* We have forked, so, let us recreate the private mapping */
+		unmap_shared_heap(pse51_shared_map[0]);
+	pse51_shared_map[0] = (unsigned long) map_shared_heap(0);
+	if (pse51_shared_map[0] == (unsigned long) MAP_FAILED) {
+		perror("Xenomai Posix skin init: mmap(local heap)");
+		exit(EXIT_FAILURE);
+	}
+
+	fprintf(stderr, "sizeof(pthread_mutex_t): %d,"
+		" sizeof(shadow_mutex): %d\n",
+		sizeof(pthread_mutex_t), sizeof(struct __shadow_mutex));
+	if (sizeof(struct __shadow_mutex) > sizeof(pthread_mutex_t))
+		exit(EXIT_FAILURE);
+	
 	if (!fork_handler_registered) {
+		err = pthread_key_create(&pse51_cur_key, NULL);
+		if (err) {
+			fprintf(stderr, "Xenomai Posix skin init:"
+				" pthread_key_create: %s\n", strerror(err));
+			exit(EXIT_FAILURE);
+		}
+
+		pse51_shared_map[1] = (unsigned long) map_shared_heap(1);
+		if (pse51_shared_map[1] == (unsigned long) MAP_FAILED) {
+			perror("Xenomai Posix skin init: mmap(global heap)");
+			exit(EXIT_FAILURE);
+		}
+	
 		err = pthread_atfork(NULL, NULL, &__init_posix_interface);
 		if (err) {
 			fprintf(stderr, "Xenomai Posix skin init: "
@@ -93,3 +160,4 @@ void __init_posix_interface(void)
 		fork_handler_registered = 1;
 	}
 }
+


-- 


					    Gilles.

