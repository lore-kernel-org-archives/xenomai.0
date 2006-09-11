From: Matthias Fuchs <matthias.fuchs@domain.hid>
Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
Date: Mon, 11 Sep 2006 14:02:12 +0200
References: <4503EB88.2040309@domain.hid>
	<200609111058.44417.matthias.fuchs@domain.hid>
	<1157970027.4934.6.camel@domain.hid>
In-Reply-To: <1157970027.4934.6.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111402.12493.matthias.fuchs@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello Philippe,

that helps. I will do some further testing.

Matthias


On Monday 11 September 2006 12:20, Philippe Gerum wrote:
> It's likely an Adeos issue. Could you try this patch? TIA,
> 
> --- arch/ppc/syslib/ppc4xx_pic.c~	2005-10-28 02:02:08.000000000 +0200
> +++ arch/ppc/syslib/ppc4xx_pic.c	2006-09-11 12:18:14.000000000 +0200
> @@ -72,7 +72,8 @@
>  		mtdcr(DCRN_UIC_SR(UIC##n), mask);			\
>  		ACK_UIC##n##_PARENT					\
>  	}								\
> -	if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {		\
> +	if (!ipipe_root_domain_p ||					\
> +	    !(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {		\
>  		ppc_cached_irq_mask[n] |= mask;				\
>  		mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);	\
>  	}								\

