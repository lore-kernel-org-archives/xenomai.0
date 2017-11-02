MIME-Version: 1.0
In-Reply-To: <9e406692-f2d1-465b-0c67-dc408d6a366a@xenomai.org>
References: <CAHoW4hF15haWApb+tY6cgyZrZ2ZX4Ls2CHUK5J-NchWvAeBMNA@mail.gmail.com>
 <9e406692-f2d1-465b-0c67-dc408d6a366a@xenomai.org>
From: Charles Kiorpes <ckiorpes@gmail.com>
Date: Thu, 2 Nov 2017 09:10:22 -0400
Message-ID: <CAHoW4hH+W3anUTgsTf8cdjo=BHeXztD5JD-O3j1WcPcYMNGA5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Nov 1, 2017 at 4:58 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> Good catch. However, some APIs may need to create private heaps along wit=
h a shared main heap, so we can't disable the init entirely. We can reduce =
the impact of creating the temporary heap in the shared case though. Could =
you try this alternative approach and let me know if that works for you?

Ah, ok.  Reducing the impact makes sense.

I did some testing with the provided patch.  I was seeing a segfault
in init_memory_pool(), because heapobj_pkg_init_private() passes
__copperplate_setup_data.mem_pool into init_memory_pool(), and also
uses that value to calculate the tlsf_pool_overhead.  Changing these
operations to use the reduced pool size eliminated the segfault.
Here's a modified version that makes sure that the variable pool size
is propagated throughout the function:

diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.=
c
index e24db15..3709852 100644
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
@@ -76,7 +77,12 @@ int heapobj_init_array_private(struct heapobj
*hobj, const char *name,

 int heapobj_pkg_init_private(void)
 {
- size_t size;
+ #ifdef CONFIG_XENO_PSHARED
+ size_t alloc_size =3D sysconf(_SC_PAGE_SIZE);
+ #else
+ size_t alloc_size =3D __copperplate_setup_data.mem_pool;
+ #endif
+ size_t available_size;
  void *mem;

  /*
@@ -88,14 +94,21 @@ int heapobj_pkg_init_private(void)
  * We include 1k of additional memory to cope with the
  * per-block overhead for an undefined number of individual
  * allocation requests. Ugly.
+ *
+ * CAUTION: in pshared mode, private heaps are subsidiary
+ * storage pools, so no need to pre-commit as much memory as
+ * we will be preallocating for the main shared pool,
+ * especially with memory locking in effect. In that case,
+ * creating a temporary single-page pool is enough to figure
+ * out the allocation overhead.
  */
- mem =3D tlsf_malloc(__copperplate_setup_data.mem_pool);
- size =3D init_memory_pool(__copperplate_setup_data.mem_pool, mem);
- if (size =3D=3D (size_t)-1)
+ mem =3D tlsf_malloc(alloc_size);
+ available_size =3D init_memory_pool(alloc_size, mem);
+ if (available_size =3D=3D (size_t)-1)
  panic("cannot initialize TLSF memory manager");

  destroy_memory_pool(mem);
- tlsf_pool_overhead =3D __copperplate_setup_data.mem_pool - size;
+ tlsf_pool_overhead =3D alloc_size - available_size;
  tlsf_pool_overhead =3D (tlsf_pool_overhead + 1024) & ~15;
  tlsf_free(mem);


With these changes, my process-shared use case works fine, and the
actual memory usage matches my expectations.  I don't have test cases
for private heaps, so I can't speak to whether that functionality is
affected.

Thanks,
Charles Kiorpes

