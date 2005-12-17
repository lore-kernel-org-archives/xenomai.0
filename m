Message-ID: <43A4507A.7020100@domain.hid>
Date: Sat, 17 Dec 2005 18:52:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] fix typos around 16550A driver
References: <43A44BEE.6080800@domain.hid>
In-Reply-To: <43A44BEE.6080800@domain.hid>
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
> Hi,
> 
> these are two typo fixes for the serial driver. One of them should have
> broken kernel 2.4 compilation for this driver, the other is cosmetic
>

Applied, thanks.

> Jan
> 
> 
> PS: What about this splnone in gatekeeper_thread(), BTW. Still needed?
> 

Nope. Fixed.

> --- ksrc/nucleus/shadow.c       (Revision 285)
> +++ ksrc/nucleus/shadow.c       (Arbeitskopie)
> @@ -384,7 +384,6 @@
>         set_current_state(TASK_INTERRUPTIBLE);
>         up(&gk->sync); /* Make the request token available. */
>         schedule();
> -       splnone();
> 
>         if (kthread_should_stop())
>             break;
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/drivers/16550A/16550A.c
> ===================================================================
> --- ksrc/drivers/16550A/16550A.c	(Revision 285)
> +++ ksrc/drivers/16550A/16550A.c	(Arbeitskopie)
> @@ -1025,7 +1025,7 @@
>  
>      device_class:       RTDM_CLASS_SERIAL,
>      device_sub_class:   RTDM_SUBCLASS_16550A,
> -    driver_name:        "rt_16550A",
> +    driver_name:        "xeno_16550A",
>      driver_version:     RTDM_DRIVER_VER(1, 2, 1),
>      peripheral_name:    "UART 16550A",
>      provider_name:      "Jan Kiszka",
> Index: ksrc/drivers/16550A/Makefile
> ===================================================================
> --- ksrc/drivers/16550A/Makefile	(Revision 285)
> +++ ksrc/drivers/16550A/Makefile	(Arbeitskopie)
> @@ -12,7 +12,7 @@
>  
>  O_TARGET := built-in.o
>  
> -obj-$(CONFIG_XENO_SKIN_16550A) := xeno_16550A.o
> +obj-$(CONFIG_XENO_DRIVERS_16550A) := xeno_16550A.o
>  
>  list-multi := xeno_16550A.o
>  
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

