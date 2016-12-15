Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <872929e77371636418cf.1481802320@devws148.be.alcatel-lucent.com>
Date: Thu, 15 Dec 2016 12:45:20 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH v2] boilerplate: Limit memory usage tlsf-heap
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

diff --git a/lib/boilerplate/tlsf/tlsf.c b/lib/boilerplate/tlsf/tlsf.c
--- a/lib/boilerplate/tlsf/tlsf.c
+++ b/lib/boilerplate/tlsf/tlsf.c
@@ -625,6 +625,7 @@ void *tlsf_malloc(size_t size)
 	void *area;
 
 	area_size = sizeof(tlsf_t) + BHDR_OVERHEAD * 8; /* Just a safety constant */
+	area_size += size;
 	area_size = (area_size > DEFAULT_AREA_SIZE) ? area_size : DEFAULT_AREA_SIZE;
 	area = get_new_area(&area_size);
 	if (area == ((void *) ~0))
@@ -709,23 +710,6 @@ void *malloc_ex(size_t size, void *mem_p
     /* Searching a free block, recall that this function changes the values of fl and sl,
        so they are not longer valid when the function fails */
     b = FIND_SUITABLE_BLOCK(tlsf, &fl, &sl);
-#if USE_MMAP || USE_SBRK
-    if (!b && mem_pool == mp) {	/* Don't grow private pools */
-	size_t area_size;
-	void *area;
-	/* Growing the pool size when needed */
-	area_size = size + BHDR_OVERHEAD * 8;   /* size plus enough room for the requered headers. */
-	area_size = (area_size > DEFAULT_AREA_SIZE) ? area_size : DEFAULT_AREA_SIZE;
-	area = get_new_area(&area_size);        /* Call sbrk or mmap */
-	if (area == ((void *) ~0))
-	    return NULL;        /* Not enough system memory */
-	add_new_area(area, area_size, mem_pool);
-	/* Rounding up the requested size and calculating fl and sl */
-	MAPPING_SEARCH(&size, &fl, &sl);
-	/* Searching a free block */
-	b = FIND_SUITABLE_BLOCK(tlsf, &fl, &sl);
-    }
-#endif
     if (!b)
 	return NULL;            /* Not found */
 

