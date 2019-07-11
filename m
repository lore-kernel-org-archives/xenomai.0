Subject: Re: ipipe 4.19: spurious APIC interrupt when setting rt_igp to up
References: <VI1PR05MB5917761A9138FE1E9EC30710F6FA0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <9ebf71d7-6a49-3eeb-d5a6-89d122136999@siemens.com>
 <788b682a-4845-31af-df17-f1008d143068@siemens.com>
 <ab6862a6-de5c-2c37-50a1-86e509768ecf@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <00b30eb9-a3fa-4467-d60e-88759fbc05ad@xenomai.org>
Date: Thu, 11 Jul 2019 16:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <ab6862a6-de5c-2c37-50a1-86e509768ecf@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 7/5/19 9:38 AM, Jan Kiszka wrote:

> This addresses it on x86 for me:
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 6c279e065879..d503b875f086 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1099,7 +1099,8 @@ void ipipe_enable_irq(unsigned int irq)
>  		ipipe_root_only();
>  
>  		raw_spin_lock_irqsave(&desc->lock, flags);
> -		if (desc->istate & IPIPE_IRQS_NEEDS_STARTUP) {
> +		if (desc->istate & IPIPE_IRQS_NEEDS_STARTUP &&
> +		    !WARN_ON(irq_activate(desc))) {
>  			desc->istate &= ~IPIPE_IRQS_NEEDS_STARTUP;
>  			chip->irq_startup(&desc->irq_data);
>  		}
> 
> Probably upstream commit c942cee46bba (genirq: Separate activation and
> startup) makes this necessary.
> 
> Philippe, I suppose this is either not essential on arm, or external
> interrupts weren't tested yet, like I missed on x86. Fine to make this a
> noarch patch?

No issue. I've not been working on/with the I-pipe but Dovetail instead
in the past weeks, so testing of 4.19 is still very limited on my end. I
have several full-fledged real world ARM*-based application systems to
improve this, just need to find a way to squeeze this work in.

-- 
Philippe.

