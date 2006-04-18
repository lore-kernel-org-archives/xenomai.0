Message-ID: <4444FF94.7050209@domain.hid>
Date: Tue, 18 Apr 2006 17:02:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Check for NPTL and factor user-space skins
	initialization.
References: <17476.64062.107556.216362@domain.hid>
In-Reply-To: <17476.64062.107556.216362@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> For review...
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: include/asm-i386/features.h
> ===================================================================
> --- include/asm-i386/features.h	(revision 941)
> +++ include/asm-i386/features.h	(working copy)
> @@ -76,4 +76,35 @@
>      }
>  }
>  
> +#ifndef __KERNEL__
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +static inline void xeno_x86_features_check(void)
> +{
> +#ifdef CONFIG_XENO_X86_SEP
> +  size_t n = confstr(_CS_GNU_LIBPTHREAD_VERSION, NULL, 0);
> +  if (n > 0)
> +      {
> +      char *buf = malloc(n);
> +      int isnptl;
> +      
> +      confstr (_CS_GNU_LIBPTHREAD_VERSION, buf, n);
> +      isnptl = strstr (buf, "NPTL") != NULL;
> +      free(buf);
> +
> +      if (isnptl)
> +          return;
> +      }
> +
> +  fprintf(stderr, "Xenomai: SEP instruction needs NPTL and NPTL was not detected"
> +          "\nplease install NPTL or recompile Xenomai without enabling SEP.\n");

-          "\nplease install NPTL or recompile Xenomai without enabling 
SEP.\n");
+          "\nplease install NPTL or rebuild the user-space support 
passing --disable-x86-sep.\n");


<snip>

> +static inline void xeno_mlock_alert_end(void)
> +{
> +    struct sigaction sa;
> +
> +    sigaction(SIGXCPU, NULL, &sa);
> +    if (sa.sa_handler == &xeno_handle_mlock_alert)
> +        {
> +        sa.sa_handler = SIG_DFL;
> +        sigaction(SIGXCPU, &sa, NULL);
> +        }
> +}
> +

-ENOPARSE here. Which code is expected to call xeno_mlock_alert_end()?

<snip>

-- 

Philippe.

