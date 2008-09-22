Message-ID: <48D76206.1050609@domain.hid>
Date: Mon, 22 Sep 2008 11:14:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48D6A80F.1080206@domain.hid>
In-Reply-To: <48D6A80F.1080206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Handle SIGILL when kernel compiled without
	Xenomai.
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

I don't see this on x86, though.

> Xenomai syscall, instead of the -ENOSYS return value. This patches 
> handles the SIGILL by printing an error message and exiting.
> 
> Index: include/asm-generic/bits/bind.h
> ===================================================================
> --- include/asm-generic/bits/bind.h	(revision 4175)
> +++ include/asm-generic/bits/bind.h	(working copy)
> @@ -9,6 +9,7 @@
>  #include <signal.h>
>  #include <pthread.h>
>  #include <fcntl.h>
> +#include <setjmp.h>
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

Just one question: Can we safely assume that sigsetjmp&siglongjump are
always available, also in uclibc environments e.g.?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

