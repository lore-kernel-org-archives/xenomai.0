From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <462CC82D.4010900@domain.hid>
References: <462CC82D.4010900@domain.hid>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 10:16:51 +0200
Message-Id: <1177402611.20763.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Fix typo in x86_64 ffnz
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

On Mon, 2007-04-23 at 16:52 +0200, Jan Kiszka wrote:
> Grrr...
> 

Fixed. Mglmgmmm...

> Index: include/asm-x86_64/hal.h
> ===================================================================
> --- include/asm-x86_64/hal.h	(Revision 2402)
> +++ include/asm-x86_64/hal.h	(Arbeitskopie)
> @@ -30,7 +30,7 @@ typedef unsigned long rthal_time_t;
>  
>  static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
>  {
> -	__asm__("bsrq %1, %0":"=r"(ul):"rm"(ul));
> +	__asm__("bsfq %1, %0":"=r"(ul):"rm"(ul));
>  	return ul;
>  }
>  
> Index: ChangeLog
> ===================================================================
> --- ChangeLog	(Revision 2402)
> +++ ChangeLog	(Arbeitskopie)
> @@ -1,3 +1,8 @@
> +2007-04-23  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +	* include/asm-x86_64/hal.h (ffnz): Fix typo that inverted the search
> +	direction.
> +
>  2007-04-19  Philippe Gerum  <rpm@xenomai.org>
>  
>  	* ksrc/skins/vrtx/module.c, ksrc/nucleus/pipe.c,
> 
-- 
Philippe.



