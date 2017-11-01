References: <CAHoW4hF15haWApb+tY6cgyZrZ2ZX4Ls2CHUK5J-NchWvAeBMNA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9e406692-f2d1-465b-0c67-dc408d6a366a@xenomai.org>
Date: Wed, 1 Nov 2017 21:58:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAHoW4hF15haWApb+tY6cgyZrZ2ZX4Ls2CHUK5J-NchWvAeBMNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Call to heapobj_pkg_init_private() in
 copperplate_init() locks unneeded pages into memory when
 CONFIG_XENO_PSHARED is set
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>, xenomai@xenomai.org

On 11/01/2017 12:42 PM, Charles Kiorpes wrote:
> Hello,
> I was noticing that my Xenomai 3.0.5 processes were consuming an
> unusually large amount of physical memory space.
> 
> It appears that the call to heapobj_pkg_init_private() that occurs in
> copperplate_init() is temporarily allocating a private heap of size
> mem_pool_size in order to populate a static variable in
> heapobj-tlsf.c, and then immediately deallocating this heap.  However,
> this temporary allocation occurs after the call to mlockall() in
> low_init(), so the pages remain locked in physical memory.  Because I
> am using CONFIG_XENO_PSHARED, the memory pool is instead allocated out
> of Linux shared memory, so these extra locked pages are never used.
> 
>>From my readthrough of the code, it appears that the call to
> heapobj_pkg_init_private() doesn't need to do anything if
> CONFIG_XENO_PSHARED is set, but I may be missing something.  Putting
> in the following hack appears to fix the problem for me, and cause no
> other problems in my particular use case:
> 
> diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
> index e24db15..8990936 100644
> --- a/lib/copperplate/heapobj-tlsf.c
> +++ b/lib/copperplate/heapobj-tlsf.c

Good catch. However, some APIs may need to create private heaps along with a shared main heap, so we can't disable the init entirely. We can reduce the impact of creating the temporary heap in the shared case though. Could you try this alternative approach and let me know if that works for you?

diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
index e24db15..35999ae 100644
--- a/lib/copperplate/heapobj-tlsf.c
+++ b/lib/copperplate/heapobj-tlsf.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdint.h>
+#include <unistd.h>
 #include "boilerplate/tlsf/tlsf.h"
 #include "copperplate/heapobj.h"
 #include "copperplate/debug.h"
@@ -76,7 +77,11 @@ int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 
 int heapobj_pkg_init_private(void)
 {
-	size_t size;
+#ifdef CONFIG_XENO_PSHARED
+	size_t size = sysconf(_SC_PAGE_SIZE);
+#else
+	size_t size = __copperplate_setup_data.mem_pool;
+#endif
 	void *mem;
 
 	/*
@@ -88,8 +93,15 @@ int heapobj_pkg_init_private(void)
 	 * We include 1k of additional memory to cope with the
 	 * per-block overhead for an undefined number of individual
 	 * allocation requests. Ugly.
+	 *
+	 * CAUTION: in pshared mode, private heaps are subsidiary
+	 * storage pools, so no need to pre-commit as much memory as
+	 * we will be preallocating for the main shared pool,
+	 * especially with memory locking in effect. In that case,
+	 * creating a temporary single-page pool is enough to figure
+	 * out the allocation overhead.
 	 */
-	mem = tlsf_malloc(__copperplate_setup_data.mem_pool);
+	mem = tlsf_malloc(size);
 	size = init_memory_pool(__copperplate_setup_data.mem_pool, mem);
 	if (size == (size_t)-1)
 		panic("cannot initialize TLSF memory manager");

-- 
Philippe.

