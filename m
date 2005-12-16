Message-ID: <43A350A1.9030604@domain.hid>
Date: Sat, 17 Dec 2005 00:41:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] fix posix userspace headers
References: <4398B430.5000706@domain.hid>
In-Reply-To: <4398B430.5000706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Good evening,
> 
> this patch is required to compile some posix userspace program against
> 2.1 SVN.
> 
> Jan
> 

Applied, thanks.

> 
> ------------------------------------------------------------------------
> 
> Index: include/posix/signal.h
> ===================================================================
> --- include/posix/signal.h	(Revision 245)
> +++ include/posix/signal.h	(Arbeitskopie)
> @@ -20,6 +20,12 @@
>  #ifndef _POSIX_SIGNAL_H
>  #define _POSIX_SIGNAL_H
>  
> +#ifndef __KERNEL__
> +
> +#include_next <signal.h>
> +
> +#else /* __KERNEL__ */
> +
>  #include <xenomai/posix/thread.h>
>  
>  #define SIGACTION_FLAGS (SA_ONESHOT|SA_NOMASK|SA_SIGINFO)
> @@ -46,4 +52,6 @@
>  
>  void pse51_signal_pkg_cleanup(void);
>  
> +#endif /* !__KERNEL__ */
> +
>  #endif /* !_POSIX_SIGNAL_H */
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

