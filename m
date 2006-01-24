From: Alexis Berlemont <berlemont.hauw@domain.hid>
Subject: Re: [Adeos-main] wake_up_interruptible ?
Date: Tue, 24 Jan 2006 21:46:34 +0100
References: <43D2B94C.3000202@domain.hid> <43D65F27.7000908@domain.hid>
	<43D67ECD.5020309@domain.hid>
In-Reply-To: <43D67ECD.5020309@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601242146.35114.berlemont.hauw@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

Sorry for the silly things I said earlier, forgot the most important step : 
the soft irq... 

>
> Something like this ?
>
> inter_domain_irq = ipipe_alloc_virq();
> ret = request_irq(inter_domain_irq, linux_handler, SA_INTERRUPT,
> "virtualIRQ", NULL); enable_irq(inter_domain_irq);
>
> void ipipe_handler(unsigned irq) {
> 	[...]
> 	ipipe_trigger_irq(inter_domain_irq);
> 	[...]
> }
>
> void linux_handler(void) {
> 	wake_up_interruptible(&skeleton_wait);
> }

I think you should not use request_irq() but ipipe_virtualize_irq() :

inter_domain_irq = ipipe_alloc_virq();
-ret=request_irq(inter_domain_irq,linux_handler,SA_INTERRUPT,"virtualIRQ",NULL); 
+ ret = ipipe_virtualize_irq(ipipe_root_domain, 
				inter_domain_irq, 
				&ipipe_handler,
				NULL, NULL,
				IPIPE_HANDLE_MASK);
-enable_irq(inter_domain_irq);

Your function linux_handler will be called in the root domain (Linux) any time 
you use the function ipipe_trigger_irq(...inter_domain_irq...) in a non Linux 
domain.

If you want a good example, you can have a look at the function rthal_init() 
(in xenomai/ksrc/arch/generic/hal.c) 

I think you should also double-check what I am saying ;) I am bit tired and .. 
silly.

Thanks Gilles.

Alexis.


