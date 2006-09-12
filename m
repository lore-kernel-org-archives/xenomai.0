Subject: Re: [Xenomai-core] [PATCH] resolve naming clash between RTAI and
	native
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45066019.7030302@domain.hid>
References: <45066019.7030302@domain.hid>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 09:42:41 +0200
Message-Id: <1158046962.4978.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2006-09-12 at 09:22 +0200, Jan Kiszka wrote:
> Hi,
> 
> any reason why we shouldn't resolve the naming conflict between the RTAI
> and the native skin not like this? (Would allow me to include RTAI in my
> test builds where native is normally built-in.)
> 

No particular reason. This patch is fine with me. Please check and apply
directly, since you have the proper test case.

> Jan
> plain text document attachment (rtai-naming.patch)
> Index: include/rtai/task.h
> ===================================================================
> --- include/rtai/task.h	(Revision 1589)
> +++ include/rtai/task.h	(Arbeitskopie)
> @@ -77,6 +77,34 @@ int __rtai_task_pkg_init(void);
>  
>  void __rtai_task_pkg_cleanup(void);
>  
> +void __rtai_task_wait_period(void);
> +
> +static inline void rt_task_wait_period(void)
> +{
> +    __rtai_task_wait_period();
> +}
> +
> +int __rtai_task_suspend(RT_TASK *task);
> +
> +static inline int rt_task_suspend(RT_TASK *task)
> +{
> +    return __rtai_task_suspend(task);
> +}
> +
> +int __rtai_task_resume(RT_TASK *task);
> +
> +static inline int rt_task_resume(RT_TASK *task)
> +{
> +    return __rtai_task_resume(task);
> +}
> +
> +int __rtai_task_delete(RT_TASK *task);
> +
> +static inline int rt_task_delete(RT_TASK *task)
> +{
> +    return __rtai_task_delete(task);
> +}
> +
>  #ifdef __cplusplus
>  }
>  #endif
> @@ -89,6 +117,22 @@ void __rtai_task_pkg_cleanup(void);
>  
>  typedef RT_TASK_PLACEHOLDER RT_TASK;
>  
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +void rt_task_wait_period(void);
> +
> +int rt_task_suspend(RT_TASK *task);
> +
> +int rt_task_resume(RT_TASK *task);
> +
> +int rt_task_delete(RT_TASK *task);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif /* __KERNEL__ || __XENO_SIM__ */
>  
>  #ifdef __cplusplus
> @@ -112,13 +156,6 @@ int rt_task_make_periodic(RT_TASK *task,
>  int rt_task_make_periodic_relative_ns(RT_TASK *task,
>  				      RTIME start_delay,
>  				      RTIME period);
> -void rt_task_wait_period(void);
> -
> -int rt_task_suspend(RT_TASK *task);
> -
> -int rt_task_resume(RT_TASK *task);
> -
> -int rt_task_delete(RT_TASK *task);
>  
>  #ifdef __cplusplus
>  }
> Index: include/rtai/sem.h
> ===================================================================
> --- include/rtai/sem.h	(Revision 1589)
> +++ include/rtai/sem.h	(Arbeitskopie)
> @@ -65,6 +65,13 @@ int __rtai_sem_pkg_init(void);
>  
>  void __rtai_sem_pkg_cleanup(void);
>  
> +int __rtai_sem_delete(SEM *sem);
> +
> +static inline int rt_sem_delete(SEM *sem)
> +{
> +    return __rtai_sem_delete(sem);
> +}
> +
>  #ifdef __cplusplus
>  }
>  #endif
> @@ -73,6 +80,16 @@ void __rtai_sem_pkg_cleanup(void);
>  
>  typedef RT_SEM_PLACEHOLDER SEM;
>  
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +int rt_sem_delete(SEM *sem);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif /* __KERNEL__ || __XENO_SIM__ */
>  
>  #ifdef __cplusplus
> @@ -83,8 +100,6 @@ void rt_typed_sem_init(SEM *sem,
>  		       int value,
>  		       int type);
>  
> -int rt_sem_delete(SEM *sem);
> -
>  int rt_sem_signal(SEM *sem);
>  
>  int rt_sem_wait(SEM *sem);
> Index: ChangeLog
> ===================================================================
> --- ChangeLog	(Revision 1589)
> +++ ChangeLog	(Arbeitskopie)
> @@ -1,3 +1,9 @@
> +2006-09-12  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +	* include/rtai/{sem.h,task.h}, ksrc/skins/rtai/{sem.c,task.c},
> +	ksrc/skins/rtai/Kconfig: Resolve naming conflict with native skin
> +	and relax dependencies.
> +
>  2006-09-11  Philippe Gerum  <rpm@xenomai.org>
>  
>  	* ksrc: Define -D__IN_XENOMAI__ when compiling the kernel support.
> Index: ksrc/skins/rtai/Kconfig
> ===================================================================
> --- ksrc/skins/rtai/Kconfig	(Revision 1589)
> +++ ksrc/skins/rtai/Kconfig	(Arbeitskopie)
> @@ -1,5 +1,5 @@
>  config XENO_SKIN_RTAI
> -	depends on XENO_OPT_NUCLEUS && !XENO_SKIN_NATIVE
> +	depends on XENO_OPT_NUCLEUS
>  	tristate "RTAI emulator"
>  	default n
>  	help
> @@ -32,6 +32,3 @@ config XENO_OPT_RTAI_SHM
>  	help
>  	
>  	SHM are Shared Memory objects across RTAI tasks.
> -
> -comment "RTAI emulator unavailable, disable native API or build it as module"
> -        depends on XENO_SKIN_NATIVE = y
> Index: ksrc/skins/rtai/task.c
> ===================================================================
> --- ksrc/skins/rtai/task.c	(Revision 1589)
> +++ ksrc/skins/rtai/task.c	(Arbeitskopie)
> @@ -140,7 +140,7 @@ int rt_task_init(RT_TASK *task,
>  	return err ? -EINVAL : 0;
>  }
>  
> -int rt_task_resume(RT_TASK *task)
> +int __rtai_task_resume(RT_TASK *task)
>  {
>  	int err = 0;
>  	spl_t s;
> @@ -166,7 +166,7 @@ int rt_task_resume(RT_TASK *task)
>  	return err;
>  }
>  
> -int rt_task_suspend(RT_TASK *task)
> +int __rtai_task_suspend(RT_TASK *task)
>  {
>  	int err = 0;
>  	spl_t s;
> @@ -197,7 +197,7 @@ int rt_task_suspend(RT_TASK *task)
>  	return err;
>  }
>  
> -int rt_task_delete(RT_TASK *task)
> +int __rtai_task_delete(RT_TASK *task)
>  {
>  	int err = 0;
>  	spl_t s;
> @@ -289,15 +289,15 @@ int rt_task_make_periodic(RT_TASK *task,
>  	return err;
>  }
>  
> -void rt_task_wait_period(void)
> +void __rtai_task_wait_period(void)
>  {
>  	xnpod_wait_thread_period(NULL);
>  }
>  
>  EXPORT_SYMBOL(rt_task_init);
> -EXPORT_SYMBOL(rt_task_resume);
> -EXPORT_SYMBOL(rt_task_suspend);
> -EXPORT_SYMBOL(rt_task_delete);
> +EXPORT_SYMBOL(__rtai_task_resume);
> +EXPORT_SYMBOL(__rtai_task_suspend);
> +EXPORT_SYMBOL(__rtai_task_delete);
>  EXPORT_SYMBOL(rt_task_make_periodic_relative_ns);
>  EXPORT_SYMBOL(rt_task_make_periodic);
> -EXPORT_SYMBOL(rt_task_wait_period);
> +EXPORT_SYMBOL(__rtai_task_wait_period);
> Index: ksrc/skins/rtai/sem.c
> ===================================================================
> --- ksrc/skins/rtai/sem.c	(Revision 1589)
> +++ ksrc/skins/rtai/sem.c	(Arbeitskopie)
> @@ -45,7 +45,7 @@ void rt_typed_sem_init(SEM * sem, int va
>  	sem->magic = RTAI_SEM_MAGIC;
>  }
>  
> -int rt_sem_delete(SEM * sem)
> +int __rtai_sem_delete(SEM * sem)
>  {
>  	int err = 0, rc;
>  	spl_t s;
> @@ -209,7 +209,7 @@ void __rtai_sem_pkg_cleanup(void)
>  }
>  
>  EXPORT_SYMBOL(rt_typed_sem_init);
> -EXPORT_SYMBOL(rt_sem_delete);
> +EXPORT_SYMBOL(__rtai_sem_delete);
>  EXPORT_SYMBOL(rt_sem_signal);
>  EXPORT_SYMBOL(rt_sem_wait);
>  EXPORT_SYMBOL(rt_sem_wait_if);
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



