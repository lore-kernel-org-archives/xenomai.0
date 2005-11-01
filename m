Message-ID: <4366F6FE.6000107@domain.hid>
Date: Tue, 01 Nov 2005 06:02:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] overcome kernel headers in userspace
References: <43666F8E.4030902@domain.hid>
In-Reply-To: <43666F8E.4030902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> I started some first proof-of-concept to get rid of all kernel header
> inclusions in user space. Here is a patch which so far only addresses
> asm-inclusion and the i386 architecture. It may have side effects, I
> didn't tested it (except compilation).
> 
> Anyway, I hope to hear some comments if this direction makes sense. And
> I'm looking for suggestions how to distribute correct LDFLAGS. I hacked
> XENO_ARCH_FLAGS into the makefiles, but I think this is only correct for
> the internal libtool-based linking (which seems to invoke ld via gcc).
> Where to get the input for "xeno-config --xeno-ldflags" from?
>

Ok, I just worked on the same issue too, but as part of the general build system 
revamping, so that we will have a fully split source model with a clear 
separation between kernel space support and user-space libraries very soon. 
Actually, the user-space stuff won't need to be told about any relevant kernel 
to be compiled against, this is going to be a pure ABI thing.

I need a bit more time to solve a few remaining issues that would impact the 
tree architecture, but once those are gone, I'm going to commit the initial 2.1 
dev. branch to SVN exhibiting the split model, and we will restart working on 
this issue from there, since the latter is far too intrusive source-wise to be 
bearable for the 2.0.x series.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: include/nucleus/asm-generic/syscall.h
> ===================================================================
> --- include/nucleus/asm-generic/syscall.h	(Revision 87)
> +++ include/nucleus/asm-generic/syscall.h	(Arbeitskopie)
> @@ -51,6 +51,7 @@ typedef struct xninquiry {
>  #ifdef __KERNEL__
>  
>  #include <linux/types.h>
> +#include <asm/ptrace.h>
>  
>  struct task_struct;
>  
> Index: include/nucleus/asm-i386/syscall.h
> ===================================================================
> --- include/nucleus/asm-i386/syscall.h	(Revision 87)
> +++ include/nucleus/asm-i386/syscall.h	(Arbeitskopie)
> @@ -21,7 +21,6 @@
>  #define _XENO_ASM_I386_SYSCALL_H
>  
>  #include <xeno_config.h>
> -#include <asm/ptrace.h>
>  #include <nucleus/asm-generic/syscall.h>
>  
>  #ifndef __KERNEL__
> Index: include/nucleus/asm-i386/atomic.h
> ===================================================================
> --- include/nucleus/asm-i386/atomic.h	(Revision 87)
> +++ include/nucleus/asm-i386/atomic.h	(Arbeitskopie)
> @@ -20,16 +20,27 @@
>  #ifndef _XENO_ASM_I386_ATOMIC_H
>  #define _XENO_ASM_I386_ATOMIC_H
>  
> -#include <linux/bitops.h>
> +typedef unsigned long atomic_flags_t;
>  
>  #ifdef __KERNEL__
>  
>  #include <asm/atomic.h>
>  #include <asm/system.h>
> +#include <linux/bitops.h>
>  
> -#define atomic_xchg(ptr,v)       xchg(ptr,v)
> -#define atomic_cmpxchg(ptr,o,n)  cmpxchg(ptr,o,n)
> -#define xnarch_memory_barrier()  smp_mb()
> +typedef atomic_t atomic_counter_t;
> +
> +#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
> +#define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
> +#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
> +#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
> +#define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcounter)
> +#define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcounter)
> +#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
> +#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
> +#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,v)
> +#define xnarch_atomic_cmpxchg(ptr,o,n)         cmpxchg(ptr,o,n)
> +#define xnarch_memory_barrier()                smp_mb()
>  
>  #else /* !__KERNEL__ */
>  
> @@ -41,28 +52,80 @@
>  #define unlikely(x)	__builtin_expect(!!(x), 0)
>  #endif /* !likely */
>  
> -#include <asm/atomic.h>
> +typedef struct { volatile int counter; } atomic_counter_t;
>  
>  struct __xeno_xchg_dummy { unsigned long a[100]; };
>  #define __xeno_xg(x) ((struct __xeno_xchg_dummy *)(x))
>  
> -static inline unsigned long atomic_xchg (volatile void *ptr,
> -					 unsigned long x)
> +#define LOCK "lock ; "
> +
> +#define xnarch_atomic_set(v,i)                 (((v)->counter) = (i))
> +
> +#define xnarch_atomic_get(v)                   ((v)->counter)
> +
> +static __inline__ void xnarch_atomic_inc(atomic_counter_t *v)
> +{
> +	__asm__ __volatile__(
> +		LOCK "incl %0"
> +		:"=m" (v->counter)
> +		:"m" (v->counter));
> +}
> +
> +static __inline__ void xnarch_atomic_dec(atomic_counter_t *v)
> +{
> +	__asm__ __volatile__(
> +		LOCK "decl %0"
> +		:"=m" (v->counter)
> +		:"m" (v->counter));
> +}
> +
> +static __inline__ int xnarch_atomic_inc_and_test(atomic_counter_t *v)
>  {
> -    __asm__ __volatile__(LOCK_PREFIX "xchgl %0,%1"
> +	unsigned char c;
> +
> +	__asm__ __volatile__(
> +		LOCK "incl %0; sete %1"
> +		:"=m" (v->counter), "=qm" (c)
> +		:"m" (v->counter) : "memory");
> +	return c != 0;
> +}
> +
> +static __inline__ int xnarch_atomic_dec_and_test(atomic_counter_t *v)
> +{
> +	unsigned char c;
> +
> +	__asm__ __volatile__(
> +		LOCK "decl %0; sete %1"
> +		:"=m" (v->counter), "=qm" (c)
> +		:"m" (v->counter) : "memory");
> +	return c != 0;
> +}
> +
> +#define xnarch_atomic_set_mask(addr,mask) \
> +__asm__ __volatile__(LOCK "orl %0,%1" \
> +: : "r" (mask),"m" (*(addr)) : "memory")
> +
> +#define xnarch_atomic_clear_mask(addr,mask) \
> +__asm__ __volatile__(LOCK "andl %0,%1" \
> +: : "r" (~(mask)),"m" (*addr) : "memory")
> +
> +static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
> +						unsigned long x)
> +{
> +    __asm__ __volatile__(LOCK "xchgl %0,%1"
>  			 :"=r" (x)
>  			 :"m" (*__xeno_xg(ptr)), "0" (x)
>  			 :"memory");
>      return x;
>  }
>  
> -static inline unsigned long atomic_cmpxchg (volatile void *ptr,
> -					    unsigned long o,
> -					    unsigned long n)
> +static inline unsigned long xnarch_atomic_cmpxchg (volatile void *ptr,
> +						   unsigned long o,
> +						   unsigned long n)
>  {
>      unsigned long prev;
>  
> -    __asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
> +    __asm__ __volatile__(LOCK "cmpxchgl %1,%2"
>  			 : "=a"(prev)
>  			 : "q"(n), "m" (*__xeno_xg(ptr)), "0" (o)
>  			 : "memory");
> @@ -77,18 +140,4 @@ static inline unsigned long atomic_cmpxc
>  
>  #endif /* __KERNEL__ */
>  
> -typedef atomic_t atomic_counter_t;
> -typedef unsigned long atomic_flags_t;
> -
> -#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
> -#define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
> -#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
> -#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
> -#define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcounter)
> -#define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcounter)
> -#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
> -#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
> -
> -#define xnarch_atomic_xchg(ptr,x) atomic_xchg(ptr,x)
> -
>  #endif /* !_XENO_ASM_I386_ATOMIC_H */
> Index: include/nucleus/asm-i386/calibration.h
> ===================================================================
> --- include/nucleus/asm-i386/calibration.h	(Revision 87)
> +++ include/nucleus/asm-i386/calibration.h	(Arbeitskopie)
> @@ -21,6 +21,9 @@
>  #define _XENO_ASM_I386_CALIBRATION_H
>  
>  #include <xeno_config.h>
> +#ifndef __KERNEL__
> +# warning Including kernel header from user space!
> +#endif
>  #include <asm/processor.h>
>  
>  #define __bogomips (current_cpu_data.loops_per_jiffy/(500000/HZ))
> Index: configure.in
> ===================================================================
> --- configure.in	(Revision 87)
> +++ configure.in	(Arbeitskopie)
> @@ -1352,12 +1352,7 @@ AC_MSG_RESULT([done])
>  AC_MSG_CHECKING([for target architecture])
>  
>  
> -XENO_USER_CFLAGS="-I$XENO_LINUX_SRCDIR/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
> -if test x"$XENO_LINUX_DIR" != x"$XENO_LINUX_SRCDIR"; then
> -  XENO_USER_CFLAGS="-I$XENO_LINUX_DIR/include2 $XENO_USER_CFLAGS"
> -  XENO_USER_CFLAGS="-I$XENO_LINUX_DIR/include $XENO_USER_CFLAGS"
> -fi
> -XENO_USER_CFLAGS="$XENO_USER_CFLAGS $XENO_ARCH_FLAGS"
> +XENO_USER_CFLAGS="-D_GNU_SOURCE -D_REENTRANT -D__XENO__  $XENO_ARCH_FLAGS"
>  
>  case $XENO_TARGET_ARCH in
>   i386)
> @@ -1442,6 +1437,7 @@ AC_SUBST(XENO_KMOD_CFLAGS)
>  AC_SUBST(XENO_USER_CFLAGS)
>  AC_SUBST(XENO_KMOD_APP_CFLAGS)
>  AC_SUBST(XENO_USER_APP_CFLAGS)
> +AC_SUBST(XENO_ARCH_FLAGS)
>  AC_SUBST(XENO_FP_CFLAGS)
>  AC_SUBST(XENO_LINUX_DIR)
>  AC_SUBST(XENO_LINUX_VERSION)
> Index: skins/posix/lib/GNUmakefile.am
> ===================================================================
> --- skins/posix/lib/GNUmakefile.am	(Revision 87)
> +++ skins/posix/lib/GNUmakefile.am	(Arbeitskopie)
> @@ -2,7 +2,9 @@ includedir = $(prefix)/include/posix
>  
>  lib_LTLIBRARIES = libpthread_rt.la
>  
> -libpthread_rt_la_LDFLAGS = -module -version-info 0:0:0
> +libpthread_rt_la_LDFLAGS = \
> +	-module -version-info 0:0:0 \
> +	@XENO_ARCH_FLAGS@
>  
>  libpthread_rt_la_SOURCES = \
>  	init.c \
> Index: skins/native/lib/GNUmakefile.am
> ===================================================================
> --- skins/native/lib/GNUmakefile.am	(Revision 87)
> +++ skins/native/lib/GNUmakefile.am	(Arbeitskopie)
> @@ -1,6 +1,8 @@
>  lib_LTLIBRARIES = libnative.la
>  
> -libnative_la_LDFLAGS = -module -version-info 0:0:0
> +libnative_la_LDFLAGS = \
> +	-module -version-info 0:0:0 \
> +	@XENO_ARCH_FLAGS@
>  
>  libnative_la_SOURCES = \
>  	init.c \
> Index: skins/rtdm/lib/GNUmakefile.am
> ===================================================================
> --- skins/rtdm/lib/GNUmakefile.am	(Revision 87)
> +++ skins/rtdm/lib/GNUmakefile.am	(Arbeitskopie)
> @@ -1,6 +1,8 @@
>  lib_LTLIBRARIES = librtdm.la
>  
> -librtdm_la_LDFLAGS = -module -version-info 0:0:0
> +librtdm_la_LDFLAGS = \
> +	-module -version-info 0:0:0 \
> +	@XENO_ARCH_FLAGS@
>  
>  librtdm_la_SOURCES = \
>  	core.c \
> Index: skins/rtdm/rtserial.h
> ===================================================================
> --- skins/rtdm/rtserial.h	(Revision 87)
> +++ skins/rtdm/rtserial.h	(Arbeitskopie)
> @@ -77,7 +77,12 @@
>  #ifndef _RTSERIAL_H
>  #define _RTSERIAL_H
>  
> -#include <asm/types.h>
> +#ifdef __KERNEL__
> +# include <asm/types.h>
> +#else
> +# include <sys/types.h>
> +#endif
> +
>  #include <rtdm/rtdm.h>
>  
>  /*!
> @@ -270,13 +275,13 @@ typedef struct rtser_config {
>                                   *   @ref RTSER_xxx_HAND */
>      int     fifo_depth;         /**< reception FIFO interrupt threshold, see
>                                   *   @ref RTSER_FIFO_xxx */
> -    __s64   rx_timeout;         /**< reception timeout in ns, see
> +    int64_t rx_timeout;         /**< reception timeout in ns, see
>                                   *   @ref RTSER_TIMEOUT_xxx for special
>                                   *   values */
> -    __s64   tx_timeout;         /**< transmission timeout in ns, see
> +    int64_t tx_timeout;         /**< transmission timeout in ns, see
>                                   *   @ref RTSER_TIMEOUT_xxx for special
>                                   *   values */
> -    __s64   event_timeout;      /**< event timeout in ns, see
> +    int64_t event_timeout;      /**< event timeout in ns, see
>                                   *   @ref RTSER_TIMEOUT_xxx for special
>                                   *   values */
>      int     timestamp_history;  /**< enable timestamp history, see
> @@ -303,9 +308,9 @@ typedef struct rtser_event {
>      int     events;             /**< signalled events, see
>                                   *   @ref RTSER_EVENT_xxx */
>      int     rx_pending;         /**< number of pending input characters */
> -    __u64   last_timestamp;     /**< last interrupt timestamp (absolute time
> +    uint64_t last_timestamp;    /**< last interrupt timestamp (absolute time
>                                   *   in ns) */
> -    __u64   rxpend_timestamp;   /**< reception timestamp (absolute time in ns)
> +    uint64_t rxpend_timestamp;  /**< reception timestamp (absolute time in ns)
>                                   *   of oldest character in input queue */
>  } rtser_event_t;
>  
> Index: skins/uvm/lib/GNUmakefile.am
> ===================================================================
> --- skins/uvm/lib/GNUmakefile.am	(Revision 87)
> +++ skins/uvm/lib/GNUmakefile.am	(Arbeitskopie)
> @@ -1,6 +1,8 @@
>  lib_LTLIBRARIES = libuvm.la
>  
> -libuvm_la_LDFLAGS = -module -version-info 0:0:0
> +libuvm_la_LDFLAGS = \
> +	-module -version-info 0:0:0 \
> +	@XENO_ARCH_FLAGS@
>  
>  libuvm_la_SOURCES = \
>  	init.c \
> Index: testsuite/latency/GNUmakefile.am
> ===================================================================
> --- testsuite/latency/GNUmakefile.am	(Revision 87)
> +++ testsuite/latency/GNUmakefile.am	(Arbeitskopie)
> @@ -10,6 +10,8 @@ latency_CPPFLAGS = \
>  	-I$(top_srcdir)/skins \
>  	-I../../include
>  
> +latency_LDFLAGS = @XENO_ARCH_FLAGS@
> +
>  latency_LDADD = \
>  	../../skins/native/lib/libnative.la \
>  	-lpthread -lm
> Index: testsuite/switch/GNUmakefile.am
> ===================================================================
> --- testsuite/switch/GNUmakefile.am	(Revision 87)
> +++ testsuite/switch/GNUmakefile.am	(Arbeitskopie)
> @@ -10,6 +10,8 @@ switch_CPPFLAGS = \
>  	-I$(top_srcdir)/skins \
>  	-I../../include
>  
> +switch_LDFLAGS = @XENO_ARCH_FLAGS@
> +
>  switch_LDADD = \
>  	../../skins/native/lib/libnative.la \
>  	-lpthread
> Index: testsuite/cruncher/GNUmakefile.am
> ===================================================================
> --- testsuite/cruncher/GNUmakefile.am	(Revision 87)
> +++ testsuite/cruncher/GNUmakefile.am	(Arbeitskopie)
> @@ -17,7 +17,7 @@ cruncher_CFLAGS = \
>  	@XENO_USER_CFLAGS@ \
>  	-funroll-loops
>  
> -cruncher_LDFLAGS = $(posix_wrappers)
> +cruncher_LDFLAGS = $(posix_wrappers) @XENO_ARCH_FLAGS@
>  
>  cruncher_LDADD = \
>  	../../skins/posix/lib/libpthread_rt.la \
> Index: testsuite/klatency/GNUmakefile.am
> ===================================================================
> --- testsuite/klatency/GNUmakefile.am	(Revision 87)
> +++ testsuite/klatency/GNUmakefile.am	(Arbeitskopie)
> @@ -28,6 +28,8 @@ latency_CPPFLAGS = \
>  	-I$(top_srcdir)/skins \
>  	-I../../include
>  
> +latency_LDFLAGS = @XENO_ARCH_FLAGS@
> +
>  latency_LDADD = \
>  	-lpthread -lm
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

