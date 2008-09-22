Message-ID: <48D75663.8000402@domain.hid>
Date: Mon, 22 Sep 2008 10:25:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48D6A80F.1080206@domain.hid>
In-Reply-To: <48D6A80F.1080206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Handle SIGILL when kernel compiled without
	Xenomai.
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Hi,
> 
> on some (all ?) platforms, we get a SIGILL when trying to emit the first 
> Xenomai syscall, instead of the -ENOSYS return value. This patches 
> handles the SIGILL by printing an error message and exiting.
> 

This is an issue for archs that encode the syscall number into the trap opcode
like ARM using the OABI, others will get -ENOSYS as expected, so this should
move to the arch-specific code.

> Index: include/asm-generic/bits/bind.h
> ===================================================================
> --- include/asm-generic/bits/bind.h	(revision 4175)
> +++ include/asm-generic/bits/bind.h	(working copy)
> @@ -9,6 +9,7 @@
>  #include <signal.h>
>  #include <pthread.h>
>  #include <fcntl.h>
> +#include <setjmp.h>

Oh dear... Yeah, this should really be buried into the ARM support code.

>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <asm/xenomai/syscall.h>
> @@ -17,6 +18,8 @@ __attribute__ ((weak))
>  pthread_key_t xeno_current_key;
>  __attribute__ ((weak))
>  pthread_once_t xeno_init_current_key_once = PTHREAD_ONCE_INIT;
> +__attribute__ ((weak))
> +jmp_buf xeno_sigill_jmpbuf;
>  
>  __attribute__ ((weak))
>  void xeno_set_current(void)
> @@ -99,13 +102,28 @@ static void unmap_sem_heap(unsigned long
>  }
>  #endif /* CONFIG_XENO_FASTSEM */
>  
> +void __attribute__((weak)) xeno_sigill_handler(int sig)
> +{
> +	siglongjmp(xeno_sigill_jmpbuf, 1);
> +}
> +
>  static inline int
>  xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module)
>  {
> +	sighandler_t old_sigill_handler;
>  	struct sigaction sa;
>  	xnfeatinfo_t finfo;
>  	int muxid;
>  
> +	old_sigill_handler = signal(SIGILL, xeno_sigill_handler);
> +	if (old_sigill_handler == SIG_ERR) {
> +		perror("signal(SIGILL)");
> +		exit(1);
> +	}
> +
> +	if (sigsetjmp(xeno_sigill_jmpbuf, 1))
> +		goto enosys;
> +
>  	muxid = XENOMAI_SYSBIND(skin_magic,
>  				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
>  	switch (muxid) {
> @@ -126,7 +144,7 @@ xeno_bind_skin(unsigned skin_magic, cons
>  
>  	case -ENOSYS:
>  	case -ESRCH:
> -
> +	enosys:
>  		fprintf(stderr,
>  			"Xenomai: %s skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n"
>  			"(modprobe %s?)\n", skin, module);
> @@ -139,6 +157,8 @@ xeno_bind_skin(unsigned skin_magic, cons
>  		exit(1);
>  	}
>  
> +	signal(SIGILL, old_sigill_handler);
> +
>  #ifdef xeno_arch_features_check
>  	xeno_arch_features_check();
>  #endif /* xeno_arch_features_check */
> @@ -180,9 +200,19 @@ xeno_bind_skin(unsigned skin_magic, cons
>  static inline int
>  xeno_bind_skin_opt(unsigned skin_magic, const char *skin, const char *module)
>  {
> +	sighandler_t old_sigill_handler;
>  	xnfeatinfo_t finfo;
>  	int muxid;
>  
> +	old_sigill_handler = signal(SIGILL, xeno_sigill_handler);
> +	if (old_sigill_handler == SIG_ERR) {
> +		perror("signal(SIGILL)");
> +		exit(1);
> +	}
> +
> +	if (sigsetjmp(xeno_sigill_jmpbuf, 1))
> +		goto enosys;
> +
>  	muxid = XENOMAI_SYSBIND(skin_magic,
>  				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
>  	switch (muxid) {
> @@ -203,7 +233,7 @@ xeno_bind_skin_opt(unsigned skin_magic, 
>  
>  	case -ENOSYS:
>  	case -ESRCH:
> -
> +	enosys:
>  		return -1;
>  	}
>  
> @@ -213,6 +243,8 @@ xeno_bind_skin_opt(unsigned skin_magic, 
>  		exit(1);
>  	}
>  
> +	signal(SIGILL, old_sigill_handler);
> +
>  #ifdef xeno_arch_features_check
>  	xeno_arch_features_check();
>  #endif /* xeno_arch_features_check */
> 
> 
> 


-- 
Philippe.


