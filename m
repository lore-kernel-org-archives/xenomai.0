Message-ID: <4842D7FB.9020400@domain.hid>
Date: Sun, 01 Jun 2008 19:10:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <483D6466.5080207@domain.hid>
In-Reply-To: <483D6466.5080207@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai 2.4.x user space build problem with
	uint64_t
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hello,
> 
> the following patch fixes a problem building the Xenomai user
> space applications for the MPC5200 using the ELDK 4.2. It can't 
> find the type uint64_t:
> 
> Index: include/asm-powerpc/fptest.h
> ===================================================================
> --- include/asm-powerpc/fptest.h	(revision 3891)
> +++ include/asm-powerpc/fptest.h	(working copy)
> @@ -5,6 +5,7 @@
>  #include <linux/module.h>
>  #else /* !__KERNEL__ */
>  #include <stdio.h>
> +#include <stdint.h>
>  #define printk printf
>  #endif /* !__KERNEL__ */
>  

Merged, thanks.

> TIA,
> 
> Wolfgang.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

