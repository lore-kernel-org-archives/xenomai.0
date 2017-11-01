MIME-Version: 1.0
From: Charles Kiorpes <ckiorpes@gmail.com>
Date: Wed, 1 Nov 2017 07:42:43 -0400
Message-ID: <CAHoW4hF15haWApb+tY6cgyZrZ2ZX4Ls2CHUK5J-NchWvAeBMNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Call to heapobj_pkg_init_private() in copperplate_init()
 locks unneeded pages into memory when CONFIG_XENO_PSHARED is set
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
I was noticing that my Xenomai 3.0.5 processes were consuming an
unusually large amount of physical memory space.

It appears that the call to heapobj_pkg_init_private() that occurs in
copperplate_init() is temporarily allocating a private heap of size
mem_pool_size in order to populate a static variable in
heapobj-tlsf.c, and then immediately deallocating this heap.  However,
this temporary allocation occurs after the call to mlockall() in
low_init(), so the pages remain locked in physical memory.  Because I
am using CONFIG_XENO_PSHARED, the memory pool is instead allocated out
of Linux shared memory, so these extra locked pages are never used.

>From my readthrough of the code, it appears that the call to
heapobj_pkg_init_private() doesn't need to do anything if
CONFIG_XENO_PSHARED is set, but I may be missing something.  Putting
in the following hack appears to fix the problem for me, and cause no
other problems in my particular use case:

diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
index e24db15..8990936 100644
--- a/lib/copperplate/heapobj-tlsf.c
+++ b/lib/copperplate/heapobj-tlsf.c
@@ -74,6 +74,12 @@ int heapobj_init_array_private(struct heapobj
*hobj, const char *name,
        return __bt(__heapobj_init_private(hobj, name, poolsz, NULL));
 }

+#ifdef CONFIG_XENO_PSHARED
+int heapobj_pkg_init_private(void)
+{
+       return 0;
+}
+#else
 int heapobj_pkg_init_private(void)
 {
        size_t size;
@@ -101,3 +107,4 @@ int heapobj_pkg_init_private(void)

        return 0;
 }
+#endif

I am running the latest "next" branch.

My config:
CONFIG_MMU=1
CONFIG_XENO_BUILD_ARGS=" 'CFLAGS=-march=armv7-a -mfpu=vfp3'
'LDFLAGS=-march=armv7-a -mfpu=vfp3' '--with-core=cobalt'
'--enable-pshared' '--host=arm-linux-gnueabihf' '-disable-debug'
'host_alias=arm-linux-gnueabihf'"
CONFIG_XENO_BUILD_STRING="x86_64-pc-linux-gnu"
CONFIG_XENO_COBALT=1
CONFIG_XENO_COMPILER="gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11) "
CONFIG_XENO_DEFAULT_PERIOD=1000000
CONFIG_XENO_FORTIFY=1
CONFIG_XENO_HOST_STRING="arm-unknown-linux-gnueabihf"
CONFIG_XENO_LORES_CLOCK_DISABLED=1
CONFIG_XENO_PREFIX="/usr/xenomai"
CONFIG_XENO_PSHARED=1
CONFIG_XENO_RAW_CLOCK_ENABLED=1
CONFIG_XENO_REVISION_LEVEL=90
CONFIG_XENO_SANITY=1
CONFIG_XENO_TLSF=1
CONFIG_XENO_TLS_MODEL="initial-exec"
CONFIG_XENO_UAPI_LEVEL=15
CONFIG_XENO_VALGRIND_API=1
CONFIG_XENO_VERSION_MAJOR=3
CONFIG_XENO_VERSION_MINOR=0
CONFIG_XENO_VERSION_NAME="Xenomai -next"
CONFIG_XENO_VERSION_STRING="3.1-devel"
---
CONFIG_SMP is OFF
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LAZY_SETSCHED is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_REGISTRY is OFF
CONFIG_XENO_REGISTRY_ROOT is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
CONFIG_XENO_X86_VSYSCALL is OFF
---
PTHREAD_STACK_DEFAULT=65536
AUTOMATIC_BOOTSTRAP=1


Am I correct in my assessment that heapobj_pkg_init_private() doesn't
need to do anything when CONFIG_XENO_PSHARED is set, or are there
other code paths in which it would get called that my hack would
break?

Thank you in advance,
Charles Kiorpes

