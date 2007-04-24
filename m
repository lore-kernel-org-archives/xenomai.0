From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <462CCC9E.1040500@domain.hid>
References: <462CCC9E.1040500@domain.hid>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 10:18:10 +0200
Message-Id: <1177402690.20763.31.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix ffnz for 64-bit hosts
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

On Mon, 2007-04-23 at 17:11 +0200, Jan Kiszka wrote:
> I'm just not sure if "#define _GNU_SOURCE" is the preferred way to go.
> 

It's already there when compiling the skins in simulation mode.

> 
> Index: xenomai/include/asm-sim/system.h
> ===================================================================
> --- xenomai.orig/include/asm-sim/system.h
> +++ xenomai/include/asm-sim/system.h
> @@ -24,6 +24,7 @@
>  
>  #include <asm/param.h>
>  #include <errno.h>
> +#define _GNU_SOURCE
>  #include <string.h>
>  #include <malloc.h>
>  #include <stdlib.h>
> @@ -172,7 +173,7 @@ static inline unsigned long long xnarch_
>  
>  static inline unsigned long ffnz (unsigned long word)
>  {
> -    return ffs((int)word) - 1;
> +    return ffsl(word) - 1;
>  }
>  

Merged, thanks.

>  #define xnarch_stack_size(tcb)    0
> Index: xenomai/ChangeLog
> ===================================================================
> --- xenomai.orig/ChangeLog
> +++ xenomai/ChangeLog
> @@ -5,6 +5,8 @@
>  
>  	* include/nucleus/system.h: Remove unused (and bogus) ffnz wrapper.
>  
> +	* include/asm-sim/system.h: Fix ffnz for 64-bit hosts.
> +
>  2007-04-19  Philippe Gerum  <rpm@xenomai.org>
>  
>  	* ksrc/skins/vrtx/module.c, ksrc/nucleus/pipe.c,
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



