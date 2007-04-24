From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <462CCB4C.8040900@domain.hid>
References: <462CCB4C.8040900@domain.hid>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 10:17:13 +0200
Message-Id: <1177402633.20763.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] cleanup ffnz from nucleus/system.h
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

On Mon, 2007-04-23 at 17:05 +0200, Jan Kiszka wrote:
> Index: xenomai/ChangeLog
> ===================================================================
> --- xenomai.orig/ChangeLog
> +++ xenomai/ChangeLog
> @@ -3,6 +3,8 @@
>  	* include/asm-x86_64/hal.h (ffnz): Fix typo that inverted the search
>  	direction.
>  
> +	* include/nucleus/system.h: Remove unused (and bogus) ffnz wrapper.
> +

Merged, thanks.

>  2007-04-19  Philippe Gerum  <rpm@xenomai.org>
>  
>  	* ksrc/skins/vrtx/module.c, ksrc/nucleus/pipe.c,
> Index: xenomai/include/nucleus/system.h
> ===================================================================
> --- xenomai.orig/include/nucleus/system.h
> +++ xenomai/include/nucleus/system.h
> @@ -24,11 +24,6 @@
>  #include <string.h>
>  #include <asm/param.h>
>  
> -static inline unsigned long ffnz (unsigned long ul)
> -{
> -    return ffs((int)ul) - 1;
> -}
> -
>  #include <asm/xenomai/atomic.h>
>  #include <nucleus/core.h>
>  #include <nucleus/trace.h>
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



