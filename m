Message-ID: <465BC709.2080000@domain.hid>
Date: Tue, 29 May 2007 08:24:09 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4656C2D0.7000705@domain.hid> <1180170634.15146.0.camel@domain.hid>
In-Reply-To: <1180170634.15146.0.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with interrupt enabling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid

Philippe Gerum wrote:
> Does this help?
> --- arch/ppc/syslib/open_pic.c~	2006-11-17 15:55:24.000000000 +0100
> +++ arch/ppc/syslib/open_pic.c	2007-05-26 11:09:03.000000000 +0200
> @@ -833,7 +833,7 @@
>  {
>  #if defined(__SLOW_VERSION__) || defined(CONFIG_IPIPE)
>  	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
> -	    && irq_desc[irq_nr].action)
> +	    && (!ipipe_root_domain_p || irq_desc[irq_nr].action))
>  		openpic_enable_irq(irq_nr);
>  #else
>  	if ((irq_desc[irq_nr].status & IRQ_LEVEL) != 0)
>
>   
This does indeed fix the problem. Thanks!

Kind regards,
    Johan Borkhuis


