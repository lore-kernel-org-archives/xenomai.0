From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CAMk6uB=6aJmndwmU14zu3S9QBH=tFy0xrub7kznUyZBqsTTdiQ@mail.gmail.com>
References: <CAMk6uB=6aJmndwmU14zu3S9QBH=tFy0xrub7kznUyZBqsTTdiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Aug 2011 12:07:21 +0200
Message-ID: <1314698841.22036.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Adeos-main] gpio irq always set to level
 sensitive with Xenomai on Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: realmz6 <realmz6@domain.hid>
Cc: xenomai@xenomai.org, adeos-main@gna.org, uclinux-dist-devel@domain.hid

On Tue, 2011-08-30 at 16:40 +0800, realmz6 wrote:
> Hi Guys,
> 
> in adeos patch bfin_set_irq_handler(), this will set irq handle to
> handle_level_irq even it is a edge gpio irq, is it true?
> 
>  #ifdef CONFIG_IPIPE
> -       _set_irq_handler(irq, handle_level_irq);
> -#else
> -       struct irq_desc *desc = irq_desc + irq;
> +       handle = __fixup_irq_handler(desc, handle_level_irq, 0);
> +#endif
> 
> should it like the follows, it just fixup original handle and will not
> always set it to handle_level_irq.

No, this code is correct Adeos-wise. See there for an explanation, and a
pending fix for a related issue:
https://mail.gna.org/public/xenomai-help/2011-08/msg00081.html

> 
> #ifdef CONFIG_IPIPE
> -       _set_irq_handler(irq, handle_level_irq);
> -#else
> -       struct irq_desc *desc = irq_desc + irq;
> +       handle = __fixup_irq_handler(desc, handle, 0);
> +#endif
> 
> -steven
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main

-- 
Philippe.



