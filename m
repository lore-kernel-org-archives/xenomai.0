Message-ID: <423E76BA.60001@domain.hid>
Date: Mon, 21 Mar 2005 08:24:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] PATCH: adeos ppc r6c15 oops handling
References: <423E7517.3040304@domain.hid>
In-Reply-To: <423E7517.3040304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Heikki Lindholm <holindho@domain.hid>
Cc: adeos-main@gna.org

Heikki Lindholm wrote:
> Hello,
> 
> Adeos prevents (most) oopses from other domains from printing. The 
> attached patch should fix the behaviour.

Applied, thanks.

> 
> -- Heikki Lindholm
> 
> 
> ------------------------------------------------------------------------
> 
> --- arch/ppc/kernel/traps.c.orig	2005-03-21 09:16:15.783031455 +0200
> +++ arch/ppc/kernel/traps.c	2005-03-21 09:16:22.182984961 +0200
> @@ -78,6 +78,12 @@
>  {
>  	static int die_counter;
>  	int nl = 0;
> +
> +#ifdef CONFIG_ADEOS_CORE
> +	/* lets us see Oopses from other domains, too */
> +	if (adp_current != adp_root)
> +		adeos_set_printk_sync(adp_current);
> +#endif /* CONFIG_ADEOS_CORE */
>  	console_verbose();
>  	spin_lock_irq(&die_lock);
>  #ifdef CONFIG_PMAC_BACKLIGHT


-- 

Philippe.

