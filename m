Message-ID: <48305BE4.3040503@domain.hid>
Date: Sun, 18 May 2008 18:40:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <18459.38249.462320.715909@domain.hid>	<18459.38430.835407.942336@domain.hid>	<18459.38500.720338.652195@domain.hid>	<18459.38558.684426.240775@domain.hid>	<18459.38644.699369.801548@domain.hid>
	<18459.38704.252719.734650@domain.hid>
In-Reply-To: <18459.38704.252719.734650@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Patch 5/7] Define new syscalls for the system
 skin
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> The two syscalls defined in the posix skin now moved to the sys skin, they are
> used in user-space by include/asm-generic/bits/bind.h and the new header
> include/asm-generic/bits/current.h. The global and process-specific shared heaps
> are now part of this patch.
>

Is there any reason why the nucleus should not implement a full-fledged "RT
futex" support, instead of a toolbox to build them? I'm concerned by skins
reinventing their own wheel uselessly to get to the same point at the end of the
day; e.g. cb_lock ops seem to me fairly generic when it comes to handling
futexes, so I would move them upstream one level more.

In that respect, talking about "semaphore heaps" at nucleus level looks a bit of
a misnomer: if we mostly bring a service to map non-cacheable memory to
user-space, then we don't actually provide semaphore support.

> ---
>  include/asm-generic/bits/Makefile.am |    1
>  include/asm-generic/bits/bind.h      |  121 +++++++++++++++++++++++++++++++++++
>  include/asm-generic/bits/current.h   |   14 ++++
>  include/asm-generic/syscall.h        |    2
>  include/nucleus/Makefile.am          |    1
>  include/nucleus/sys_ppd.h            |   37 ++++++++++
>  include/posix/syscall.h              |    1
>  ksrc/nucleus/Kconfig                 |   25 +++++++
>  ksrc/nucleus/module.c                |   19 ++++-
>  ksrc/nucleus/shadow.c                |  103 ++++++++++++++++++++++++++++-
>  src/skins/posix/thread.c             |    4 +
>  11 files changed, 323 insertions(+), 5 deletions(-)
> 
> Index: include/asm-generic/syscall.h
> ===================================================================
> --- include/asm-generic/syscall.h	(revision 3738)
> +++ include/asm-generic/syscall.h	(working copy)
> @@ -30,6 +30,8 @@
>  #define __xn_sys_info       4	/* xnshadow_get_info(muxid,&info) */
>  #define __xn_sys_arch       5	/* r = xnarch_local_syscall(args) */
>  #define __xn_sys_trace      6	/* r = xntrace_xxx(...) */
> +#define __xn_sys_sem_heap   7
> +#define __xn_sys_current    8
>  
>  #define XENOMAI_LINUX_DOMAIN  0
>  #define XENOMAI_XENO_DOMAIN   1
> Index: ksrc/nucleus/Kconfig
> ===================================================================
> --- ksrc/nucleus/Kconfig	(revision 3738)
> +++ ksrc/nucleus/Kconfig	(working copy)
> @@ -158,6 +158,31 @@ config XENO_OPT_SYS_STACKPOOLSZ
>  	default 0
>  endif	
>  
> +config XENO_OPT_SEM_HEAPSZ
> +	int "Size of private semaphores heap (Kb)"
> +	default 12
> +	help
> +
> +	Xenomai implementation of user-space semaphores relies on heaps 
> +	shared between kernel and user-space. This configuration entry
> +	allow to set the size of the heap used for private semaphores.
> +
> +	Note that each semaphore will allocate 4 or 8 bytes of memory,

It would be nice to tell the folks why such difference (32/64bit arch?)

> +	so, the default of 12 Kb allows creating many semaphores.
> +
> +config XENO_OPT_GLOBAL_SEM_HEAPSZ
> +	int "Size of global semaphores heap (Kb)"
> +	default 12
> +	help
> +
> +	Xenomai implementation of user-space semaphores relies on heaps 
> +	shared between kernel and user-space. This configuration entry
> +	allow to set the size of the heap used for semaphores shared 
> +	between several processes.
> +
> +	Note that each semaphore will allocate 4 or 8 bytes of memory,
> +	so, the default of 12 Kb allows creating many semaphores.
> +
>  config XENO_OPT_STATS
>  	bool "Statistics collection"
>  	depends on PROC_FS
> Index: ksrc/nucleus/module.c
> ===================================================================
> --- ksrc/nucleus/module.c	(revision 3738)
> +++ ksrc/nucleus/module.c	(working copy)
> @@ -28,6 +28,7 @@
>  #include <nucleus/timer.h>
>  #include <nucleus/heap.h>
>  #include <nucleus/version.h>
> +#include <nucleus/sys_ppd.h>
>  #ifdef CONFIG_XENO_OPT_PIPE
>  #include <nucleus/pipe.h>
>  #endif /* CONFIG_XENO_OPT_PIPE */
> @@ -50,6 +51,8 @@ u_long xnmod_sysheap_size;
>  
>  int xeno_nucleus_status = -EINVAL;
>  
> +struct xnsys_ppd __xnsys_global_ppd;
> +
>  void xnmod_alloc_glinks(xnqueue_t *freehq)
>  {
>  	xngholder_t *sholder, *eholder;
> @@ -1156,6 +1159,14 @@ int __init __xeno_sys_init(void)
>  	if (err)
>  		goto fail;
>  
> +	err = xnheap_init_mapped(&__xnsys_global_ppd.sem_heap,
> +				 CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ * 1024,
> +				 XNARCH_SHARED_HEAP_FLAGS ?:
> +				 (CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ <= 128
> +				  ? GFP_USER : 0));
> +	if (err)
> +		goto cleanup_arch;
> +	
>  #ifdef __KERNEL__
>  #ifdef CONFIG_PROC_FS
>  	xnpod_init_proc();
> @@ -1167,7 +1178,7 @@ int __init __xeno_sys_init(void)
>  	err = xnpipe_mount();
>  
>  	if (err)
> -		goto cleanup_arch;
> +		goto cleanup_proc;
>  #endif /* CONFIG_XENO_OPT_PIPE */
>  
>  #ifdef CONFIG_XENO_OPT_PERVASIVE
> @@ -1207,7 +1218,7 @@ int __init __xeno_sys_init(void)
>  #ifdef CONFIG_XENO_OPT_PIPE
>  	xnpipe_umount();
>  
> -      cleanup_arch:
> +      cleanup_proc:
>  
>  #endif /* CONFIG_XENO_OPT_PIPE */
>  
> @@ -1215,6 +1226,8 @@ int __init __xeno_sys_init(void)
>  	xnpod_delete_proc();
>  #endif /* CONFIG_PROC_FS */
>  
> +      cleanup_arch:
> +
>  	xnarch_exit();
>  
>  #endif /* __KERNEL__ */
> @@ -1254,6 +1267,8 @@ void __exit __xeno_sys_exit(void)
>  #endif /* CONFIG_XENO_OPT_PIPE */
>  #endif /* __KERNEL__ */
>  
> +	xnheap_destroy_mapped(&__xnsys_global_ppd.sem_heap);
> +
>  	if (nkmsgbuf)
>  		xnarch_free_host_mem(nkmsgbuf, XNPOD_FATAL_BUFSZ);
>  
> Index: ksrc/nucleus/shadow.c
> ===================================================================
> --- ksrc/nucleus/shadow.c	(revision 3738)
> +++ ksrc/nucleus/shadow.c	(working copy)
> @@ -51,6 +51,7 @@
>  #include <nucleus/ppd.h>
>  #include <nucleus/trace.h>
>  #include <nucleus/stat.h>
> +#include <nucleus/sys_ppd.h>
>  #include <asm/xenomai/features.h>
>  #include <asm/xenomai/syscall.h>
>  #include <asm/xenomai/bits/shadow.h>
> @@ -1558,11 +1559,11 @@ static void stringify_feature_set(u_long
>  
>  static int xnshadow_sys_bind(struct pt_regs *regs)
>  {
> +	xnshadow_ppd_t *ppd = NULL, *sys_ppd = NULL;
>  	unsigned magic = __xn_reg_arg1(regs);
>  	u_long featdep = __xn_reg_arg2(regs);
>  	u_long abirev = __xn_reg_arg3(regs);
>  	u_long infarg = __xn_reg_arg4(regs);
> -	xnshadow_ppd_t *ppd = NULL;
>  	xnfeatinfo_t finfo;
>  	u_long featmis;
>  	int muxid, err;
> @@ -1636,6 +1637,36 @@ static int xnshadow_sys_bind(struct pt_r
>  	   earlier than that, do not refer to nkpod until the latter had a
>  	   chance to call xnpod_init(). */
>  
> +	xnlock_get_irqsave(&nklock, s);
> +	sys_ppd = ppd_lookup(0, current->mm);
> +	xnlock_put_irqrestore(&nklock, s);
> +
> +	if (sys_ppd)
> +		goto muxid_eventcb;
> +
> +	sys_ppd = (xnshadow_ppd_t *) muxtable[0].props->eventcb(XNSHADOW_CLIENT_ATTACH,
> +								 current);
> +
> +	if (IS_ERR(sys_ppd)) {
> +		err = PTR_ERR(sys_ppd);
> +		goto fail;
> +	}
> +
> +	if (!sys_ppd)
> +		goto muxid_eventcb;
> +
> +
> +	sys_ppd->key.muxid = 0;
> +	sys_ppd->key.mm = current->mm;
> +
> +	if (ppd_insert(sys_ppd) == -EBUSY) {
> +		/* In case of concurrent binding (which can not happen with
> +		   Xenomai libraries), detach right away the second ppd. */
> +		muxtable[0].props->eventcb(XNSHADOW_CLIENT_DETACH, sys_ppd);
> +		sys_ppd = NULL;
> +	}
> +
> +  muxid_eventcb:
>  	if (!muxtable[muxid].props->eventcb)
>  		goto eventcb_done;
>  
> @@ -1652,7 +1683,7 @@ static int xnshadow_sys_bind(struct pt_r
>  
>  	if (IS_ERR(ppd)) {
>  		err = PTR_ERR(ppd);
> -		goto fail;
> +		goto fail_destroy_sys_ppd;
>  	}
>  
>  	if (!ppd)
> @@ -1689,6 +1720,11 @@ static int xnshadow_sys_bind(struct pt_r
>  
>  		err = -ENOSYS;
>  
> +	  fail_destroy_sys_ppd:
> +		if (sys_ppd) {
> +			ppd_remove(sys_ppd);
> +			muxtable[0].props->eventcb(XNSHADOW_CLIENT_DETACH, sys_ppd);
> +		}
>  	      fail:
>  		if (!xnarch_atomic_get(&muxtable[muxid].refcnt))
>  			xnarch_atomic_dec(&muxtable[muxid].refcnt);
> @@ -1856,6 +1892,32 @@ static int xnshadow_sys_trace(struct pt_
>  	return err;
>  }
>  
> +struct heap_info {
> +	xnheap_t *addr;
> +	unsigned size;
> +};
> +
> +static int xnshadow_sys_sem_heap(struct pt_regs *regs)
> +{
> +	struct heap_info hinfo, __user *us_hinfo;
> +	unsigned global;
> +
> +	global = __xn_reg_arg2(regs);
> +	us_hinfo = (struct heap_info __user *) __xn_reg_arg1(regs);
> +	hinfo.addr = &xnsys_ppd_get(global)->sem_heap;
> +	hinfo.size = xnheap_extentsize(hinfo.addr);
> +
> +	return __xn_safe_copy_to_user(us_hinfo, &hinfo, sizeof(*us_hinfo));
> +}
> +
> +static int xnshadow_sys_current(struct pt_regs *regs)
> +{
> +	xnthread_t * __user *us_current, *cur = xnshadow_thread(current);
> +	us_current = (xnthread_t *__user *) __xn_reg_arg1(regs);
> +
> +	return __xn_safe_copy_to_user(us_current, &cur, sizeof(*us_current));
> +}
> +
>  static xnsysent_t __systab[] = {
>  	[__xn_sys_migrate] = {&xnshadow_sys_migrate, __xn_exec_current},
>  	[__xn_sys_arch] = {&xnshadow_sys_arch, __xn_exec_any},
> @@ -1864,15 +1926,50 @@ static xnsysent_t __systab[] = {
>  	[__xn_sys_completion] = {&xnshadow_sys_completion, __xn_exec_lostage},
>  	[__xn_sys_barrier] = {&xnshadow_sys_barrier, __xn_exec_lostage},
>  	[__xn_sys_trace] = {&xnshadow_sys_trace, __xn_exec_any},
> +	[__xn_sys_sem_heap] = {&xnshadow_sys_sem_heap, __xn_exec_any},
> +	[__xn_sys_current] = {&xnshadow_sys_current, __xn_exec_any},
>  };
>  
> +static void *xnshadow_sys_event(int event, void *data)
> +{
> +	struct xnsys_ppd *p;
> +	int err;
> +
> +	switch(event) {
> +	case XNSHADOW_CLIENT_ATTACH:
> +		p = (struct xnsys_ppd *) xnarch_alloc_host_mem(sizeof(*p));
> +		if (!p)
> +			return ERR_PTR(-ENOMEM);
> +
> +		err = xnheap_init_mapped(&p->sem_heap,
> +					 CONFIG_XENO_OPT_SEM_HEAPSZ * 1024,
> +					 XNARCH_SHARED_HEAP_FLAGS ?:
> +					 (CONFIG_XENO_OPT_SEM_HEAPSZ <= 128
> +					  ? GFP_USER : 0));
> +		if (err) {
> +			xnarch_free_host_mem(p, sizeof(*p));
> +			return ERR_PTR(err);
> +		}
> +
> +		return &p->ppd;
> +
> +	case XNSHADOW_CLIENT_DETACH:
> +		p = ppd2sys((xnshadow_ppd_t *) data);
> +
> +		xnheap_destroy_mapped(&p->sem_heap);
> +
> +		return NULL;
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
>  
>  static struct xnskin_props __props = {
>  	.name = "sys",
>  	.magic = 0x434F5245,
>  	.nrcalls = sizeof(__systab) / sizeof(__systab[0]),
>  	.systab = __systab,
> -	.eventcb = NULL,
> +	.eventcb = xnshadow_sys_event,
>  	.timebasep = NULL,
>  	.module = NULL
>  };
> Index: include/posix/syscall.h
> ===================================================================
> --- include/posix/syscall.h	(revision 3738)
> +++ include/posix/syscall.h	(working copy)
> @@ -46,6 +46,7 @@
>  #define __pse51_mutex_lock            20
>  #define __pse51_mutex_timedlock       21
>  #define __pse51_mutex_trylock         22
> +#define __pse51_check_init            __pse51_mutex_trylock
>  #define __pse51_mutex_unlock          23
>  #define __pse51_cond_init             24
>  #define __pse51_cond_destroy          25
> Index: src/skins/posix/thread.c
> ===================================================================
> --- src/skins/posix/thread.c	(revision 3738)
> +++ src/skins/posix/thread.c	(working copy)
> @@ -24,6 +24,7 @@
>  #include <sys/types.h>
>  #include <semaphore.h>
>  #include <posix/syscall.h>
> +#include <asm-generic/bits/current.h>
>  
>  extern int __pse51_muxid;
>  
> @@ -56,6 +57,7 @@ int __wrap_pthread_setschedparam(pthread
>  
>  	if (!err && promoted) {
>  		old_sigharden_handler = signal(SIGHARDEN, &__pthread_sigharden_handler);
> +		xeno_set_current();
>  		if (policy != SCHED_OTHER)
>  			XENOMAI_SYSCALL1(__xn_sys_migrate, XENOMAI_XENO_DOMAIN);
>  	}
> @@ -132,6 +134,8 @@ static void *__pthread_trampoline(void *
>  	start = iargs->start;
>  	cookie = iargs->arg;
>  
> +	xeno_set_current();
> +
>  	__real_sem_post(&iargs->sync);
>  
>  	if (!err) {
> Index: include/asm-generic/bits/current.h
> ===================================================================
> --- include/asm-generic/bits/current.h	(revision 0)
> +++ include/asm-generic/bits/current.h	(revision 0)
> @@ -0,0 +1,14 @@
> +#ifndef _XENO_ASM_GENERIC_CURRENT_H
> +#define _XENO_ASM_GENERIC_CURRENT_H
> +
> +#include <pthread.h>
> +
> +extern pthread_key_t xeno_current_key;
> +
> +extern void xeno_set_current(void);
> +
> +static inline void *xeno_get_current(void)
> +{
> +	return pthread_getspecific(xeno_current_key);
> +}
> +#endif /* _XENO_ASM_GENERIC_CURRENT_H */
> Index: include/asm-generic/bits/Makefile.am
> ===================================================================
> --- include/asm-generic/bits/Makefile.am	(revision 3738)
> +++ include/asm-generic/bits/Makefile.am	(working copy)
> @@ -2,6 +2,7 @@ includesubdir = $(includedir)/asm-generi
>  
>  includesub_HEADERS = \
>  	bind.h \
> +	current.h \
>  	heap.h \
>  	intr.h \
>  	mlock_alert.h \
> Index: include/nucleus/sys_ppd.h
> ===================================================================
> --- include/nucleus/sys_ppd.h	(revision 0)
> +++ include/nucleus/sys_ppd.h	(revision 0)
> @@ -0,0 +1,37 @@
> +#ifndef _XENO_NUCLEUS_SYS_PPD_H
> +#define _XENO_NUCLEUS_SYS_PPD_H
> +
> +#include <nucleus/ppd.h>
> +#include <nucleus/heap.h>
> +
> +struct xnsys_ppd {
> +	xnshadow_ppd_t ppd;
> +	xnheap_t sem_heap;
> +
> +#define ppd2sys(addr) container_of(addr, struct xnsys_ppd, ppd)
> +};
> +
> +extern struct xnsys_ppd __xnsys_global_ppd;
> +
> +#ifdef CONFIG_XENO_OPT_PERVASIVE
> +
> +static inline struct xnsys_ppd *xnsys_ppd_get(int global)
> +{
> +	xnshadow_ppd_t *ppd;
> +
> +	if (global || !(ppd = xnshadow_ppd_get(0)))
> +		return &__xnsys_global_ppd;
> +
> +	return ppd2sys(ppd);
> +}
> +
> +#else /* !CONFIG_XENO_OPT_PERVASIVE */
> +
> +static inline struct xnsys_ppd *xnsys_ppd_get(int global)
> +{
> +	return &__xnsys_global_ppd;
> +}
> +
> +#endif /* !CONFIG_XENO_OPT_PERVASIVE */
> +
> +#endif /* _XENO_NUCLEUS_SYS_PPD_H */
> Index: include/nucleus/Makefile.am
> ===================================================================
> --- include/nucleus/Makefile.am	(revision 3738)
> +++ include/nucleus/Makefile.am	(working copy)
> @@ -20,6 +20,7 @@ includesub_HEADERS = \
>  	stat.h \
>  	synch.h \
>  	system.h \
> +	sys_ppd.h \
>  	thread.h \
>  	timebase.h \
>  	timer.h \
> Index: include/asm-generic/bits/bind.h
> ===================================================================
> --- include/asm-generic/bits/bind.h	(revision 3738)
> +++ include/asm-generic/bits/bind.h	(working copy)
> @@ -6,10 +6,89 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <signal.h>
> +#include <pthread.h>
> +#include <sys/ioctl.h>
>  #include <asm/xenomai/syscall.h>
>  
> +__attribute__ ((weak))
> +pthread_key_t xeno_current_key;
> +__attribute__ ((weak))
> +pthread_once_t xeno_init_current_key_once = PTHREAD_ONCE_INIT;
> +
> +__attribute__ ((weak))
> +void xeno_set_current(void)
> +{
> +	void *kthread_cb;
> +	XENOMAI_SYSCALL1(__xn_sys_current, &kthread_cb);
> +	pthread_setspecific(xeno_current_key, kthread_cb);
> +}
> +
> +static void init_current_key(void)
> +{
> +	int err = pthread_key_create(&xeno_current_key, NULL);
> +	if (err) {
> +		fprintf(stderr, "Xenomai: error creating TSD key: %s\n",
> +			strerror(err));
> +		exit(1);
> +	}
> +}
> +
> +__attribute__ ((weak))
> +unsigned long xeno_sem_heap[2] = { 0, 0 };
> +
>  void xeno_handle_mlock_alert(int sig);
>  
> +static void *map_sem_heap(unsigned shared)
> +{
> +	struct heap_info {
> +		void *addr;
> +		unsigned size;
> +	} hinfo;
> +	int fd, err;
> +
> +	fd = open("/dev/rtheap", O_RDWR, 0);
> +	if (fd < 0) {
> +		fprintf(stderr, "Xenomai: open: %m\n");
> +		return MAP_FAILED;
> +	}
> +
> +	err = XENOMAI_SYSCALL2(__xn_sys_sem_heap, &hinfo, shared);
> +	if (err < 0) {
> +		fprintf(stderr, "Xenomai: sys_sem_heap: %m\n");
> +		return MAP_FAILED;
> +	}
> +
> +	err = ioctl(fd, 0, hinfo.addr);
> +	if (err < 0) {
> +		fprintf(stderr, "Xenomai: ioctl: %m\n");
> +		return MAP_FAILED;
> +	}
> +
> +	hinfo.addr = mmap(NULL, hinfo.size,
> +			  PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	close(fd);
> +
> +	return hinfo.addr;
> +}
> +
> +static void unmap_sem_heap(unsigned long heap_addr, unsigned shared)
> +{
> +	struct heap_info {
> +		void *addr;
> +		unsigned size;
> +	} hinfo;
> +	int err;
> +
> +	err = XENOMAI_SYSCALL2(__xn_sys_sem_heap, &hinfo, shared);
> +	if (err < 0) {
> +		fprintf(stderr, "Xenomai: sys_sem_heap: %m\n");
> +		return;
> +	}
> +
> +	munmap((void *) heap_addr, hinfo.size);
> +}
> +
> +
>  static inline int
>  xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module)
>  {
> @@ -62,6 +141,27 @@ xeno_bind_skin(unsigned skin_magic, cons
>  	sa.sa_flags = 0;
>  	sigaction(SIGXCPU, &sa, NULL);
>  
> +	pthread_once(&xeno_init_current_key_once, &init_current_key);
> +
> +	/* In case we forked, we need to map the new local semaphore heap */
> +	if (xeno_sem_heap[0])
> +		unmap_sem_heap(xeno_sem_heap[0], 0);
> +	xeno_sem_heap[0] = (unsigned long) map_sem_heap(0);
> +	if (xeno_sem_heap[0] == (unsigned long) MAP_FAILED) {
> +		perror("Xenomai: mmap(local sem heap)");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* Even if we forked the global semaphore heap did not change, no need
> +	  to map it anew */
> +	if (!xeno_sem_heap[1]) {
> +		xeno_sem_heap[1] = (unsigned long) map_sem_heap(1);
> +		if (xeno_sem_heap[1] == (unsigned long) MAP_FAILED) {
> +			perror("Xenomai: mmap(global sem heap)");
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
>  	return muxid;
>  }
>  
> @@ -105,6 +205,27 @@ xeno_bind_skin_opt(unsigned skin_magic, 
>  	xeno_arch_features_check();
>  #endif /* xeno_arch_features_check */
>  
> +	pthread_once(&xeno_init_current_key_once, &init_current_key);
> +
> +	/* In case we forked, we need to map the new local semaphore heap */
> +	if (xeno_sem_heap[0])
> +		unmap_sem_heap(xeno_sem_heap[0], 0);
> +	xeno_sem_heap[0] = (unsigned long) map_sem_heap(0);
> +	if (xeno_sem_heap[0] == (unsigned long) MAP_FAILED) {
> +		perror("Xenomai: mmap(local sem heap)");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* Even if we forked the global semaphore heap did not change, no need
> +	  to map it anew */
> +	if (!xeno_sem_heap[1]) {
> +		xeno_sem_heap[1] = (unsigned long) map_sem_heap(1);
> +		if (xeno_sem_heap[1] == (unsigned long) MAP_FAILED) {
> +			perror("Xenomai: mmap(global sem heap)");
> +			exit(EXIT_FAILURE);
> +		}
> +	}
> +
>  	return muxid;
>  }
>  
> 


-- 
Philippe.

