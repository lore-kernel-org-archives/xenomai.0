Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <9305b0f8a1e72466ac65.1481034395@devws148.be.alcatel-lucent.com>
Date: Tue, 06 Dec 2016 15:26:35 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH] copperplate: Limit memory usage tlsf-heap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Before this patch the system memory pool's (tlsf variant) behavior was
to grow in case allocations were done when depleted. This is a
contradiction with the expected behavior (see mem-pool-size tunable
documentation). When the pool is depleted, an error should be retuned
instead of growing the pool.

This patch solves this bug.
To be backwards compatible an option has been introduced that allows the
configuration of the pool's growing capability. The default is
'growing is done' and it can be disabled to providing a tunable from
the appliction code or by passing a command line parameter.

Tunable:
set_config_tunable(no_grow_pool, 1);

Command line option:
--no-mem-pool-grow

diff --git a/include/copperplate/tunables.h b/include/copperplate/tunables.h
--- a/include/copperplate/tunables.h
+++ b/include/copperplate/tunables.h
@@ -27,6 +27,7 @@ struct copperplate_setup_data {
 	int no_registry;
 	int shared_registry;
 	size_t mem_pool;
+	int no_grow_pool;
 	gid_t session_gid;
 };
 
@@ -84,6 +85,16 @@ static inline read_config_tunable(mem_po
 	return __copperplate_setup_data.mem_pool;
 }
 
+static inline define_config_tunable(no_grow_pool, int, flag)
+{
+	__copperplate_setup_data.no_grow_pool = flag;
+}
+
+static inline read_config_tunable(no_grow_pool, int)
+{
+	return __copperplate_setup_data.no_grow_pool;
+}
+
 static inline define_config_tunable(session_gid, gid_t, gid)
 {
 	__copperplate_setup_data.session_gid = gid;
diff --git a/lib/boilerplate/tlsf/tlsf.c b/lib/boilerplate/tlsf/tlsf.c
--- a/lib/boilerplate/tlsf/tlsf.c
+++ b/lib/boilerplate/tlsf/tlsf.c
@@ -452,6 +452,12 @@ static __inline__ bhdr_t *process_area(v
 /******************************************************************/
 
 static char *mp;         /* Default memory pool. */
+static int grow_mp;
+
+void tlsf_grow_common_pool(int grow)
+{
+	grow_mp = grow;
+}
 
 /******************************************************************/
 size_t init_memory_pool(size_t mem_pool_size, void *mem_pool)
@@ -625,6 +631,7 @@ void *tlsf_malloc(size_t size)
 	void *area;
 
 	area_size = sizeof(tlsf_t) + BHDR_OVERHEAD * 8; /* Just a safety constant */
+	area_size += size;
 	area_size = (area_size > DEFAULT_AREA_SIZE) ? area_size : DEFAULT_AREA_SIZE;
 	area = get_new_area(&area_size);
 	if (area == ((void *) ~0))
@@ -710,7 +717,7 @@ void *malloc_ex(size_t size, void *mem_p
        so they are not longer valid when the function fails */
     b = FIND_SUITABLE_BLOCK(tlsf, &fl, &sl);
 #if USE_MMAP || USE_SBRK
-    if (!b && mem_pool == mp) {	/* Don't grow private pools */
+    if (!b && (mem_pool == mp) && grow_mp) {	/* Don't grow private pools */
 	size_t area_size;
 	void *area;
 	/* Growing the pool size when needed */
diff --git a/lib/boilerplate/tlsf/tlsf.h b/lib/boilerplate/tlsf/tlsf.h
--- a/lib/boilerplate/tlsf/tlsf.h
+++ b/lib/boilerplate/tlsf/tlsf.h
@@ -37,4 +37,6 @@ extern void *tlsf_realloc(void *ptr, siz
 extern void *tlsf_calloc(size_t nelem, size_t elem_size);
 size_t malloc_usable_size_ex(void *ptr, void *pool);
 
+extern void tlsf_grow_common_pool(int grow);
+
 #endif
diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
--- a/lib/copperplate/heapobj-tlsf.c
+++ b/lib/copperplate/heapobj-tlsf.c
@@ -89,6 +89,11 @@ int heapobj_pkg_init_private(void)
 	 * per-block overhead for an undefined number of individual
 	 * allocation requests. Ugly.
 	 */
+	if (__copperplate_setup_data.no_grow_pool == 0)
+		tlsf_grow_common_pool(1);
+	else
+		tlsf_grow_common_pool(0);
+
 	mem = tlsf_malloc(__copperplate_setup_data.mem_pool);
 	size = init_memory_pool(__copperplate_setup_data.mem_pool, mem);
 	if (size == (size_t)-1)
diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
--- a/lib/copperplate/init.c
+++ b/lib/copperplate/init.c
@@ -36,6 +36,7 @@
 
 struct copperplate_setup_data __copperplate_setup_data = {
 	.mem_pool = 1024 * 1024, /* Default, 1Mb. */
+	.no_grow_pool = 0,
 	.no_registry = 0,
 	.registry_root = DEFAULT_REGISTRY_ROOT,
 	.session_label = NULL,
@@ -78,10 +79,17 @@ static const struct option copperplate_o
 		.val = 1,
 	},
 	{
-#define sched_max_prio	5
+#define sched_max_prio		5
 		.name = "sched-max-prio",
 		.has_arg = required_argument,
 	},
+	{
+#define no_mempool_grow_opt	6
+		.name = "no-mem-pool-grow",
+		.has_arg = no_argument,
+		.flag = &__copperplate_setup_data.no_grow_pool,
+		.val = 1,
+	},
 	{ /* Sentinel */ }
 };
 
@@ -277,6 +285,7 @@ static int copperplate_parse_option(int 
 		break;
 	case shared_registry_opt:
 	case no_registry_opt:
+	case no_mempool_grow_opt:
 		break;
 	default:
 		/* Paranoid, can't happen. */
@@ -289,6 +298,7 @@ static int copperplate_parse_option(int 
 static void copperplate_help(void)
 {
 	fprintf(stderr, "--mem-pool-size=<size[K|M|G]> 	size of the main heap\n");
+	fprintf(stderr, "--no-mem-pool-grow	 	suppress auto-grow main heap\n");
         fprintf(stderr, "--no-registry			suppress object registration\n");
         fprintf(stderr, "--shared-registry		enable public access to registry\n");
         fprintf(stderr, "--registry-root=<path>		root path of registry\n");

