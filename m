Message-ID: <4FC48E49.3050105@bbn.com>
Date: Tue, 29 May 2012 04:52:25 -0400
From: Mitchell Tasman <tasman@bbn.com>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com> <4FBB4951.5070803@xenomai.org>
	<4FBC0383.3020608@bbn.com> <4FBC0582.2060707@xenomai.org>
	<4FBF4E69.1010200@bbn.com> <4FBF78FE.3020300@xenomai.org>
	<4FC478AF.6020905@bbn.com> <4FC48383.6020201@xenomai.org>
In-Reply-To: <4FC48383.6020201@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] A possible mis-interaction between CONFIG_PREEMPT and
 GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 05/29/2012 04:06 AM, Gilles Chanteperdrix wrote:
> On 05/29/2012 09:20 AM, Mitchell Tasman wrote:
>> One change that had been made along the way on the for-ipipe-2.6.38-arm
>> branch was to add a gpio_mask_ack_irq() function, and invoke it like so
>> from gpio_irq_handler(), instead of invoking gpio_ack_irq():
>>
>> #ifndef CONFIG_IPIPE
>>         desc->irq_data.chip->irq_ack(&desc->irq_data);
>> #else /* CONFIG_IPIPE */
>>         desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
>> #endif /* CONFIG_IPIPE */
>>
>> With the latest commits, the gpio_mask_ack_irq() function remains, but
>> it is no longer invoked, with gpio_ack_irq() being called
>> unconditionally instead, as with the vanilla 2.6.38.8 source.

> desc->irq_data.chip->irq_mask_ack is the "mask_ack" method of the parent
> irq, not gpio_mask_ack_irq. gpio_mask_ack_irq is called normally when
> acknowledging the gpio irq.

Sorry about my confusion.  Assuming that I'm looking at the correct 
vector this time, in arch/arm/mach-omap2/irq.c for 2.6.38.8 as patched 
for I-Pipe:

> static struct irq_chip omap_irq_chip = {
>         .name           = "INTC",
>         .irq_ack        = omap_mask_ack_irq,
>         .irq_mask       = omap_mask_irq,
>         .irq_mask_ack   = omap_mask_ack_irq,
>         .irq_unmask     = omap_unmask_irq,
> };

both halves of the former #ifndef block quoted above appear equivalent, 
and the parent irq is indeed masked.  Likewise, for 3.0.13 with 
CONFIG_IPIPE defined, .irq_ack and .irq_mask_ack both appear to mask the 
parent irq.

Regarding your recent commits to ipipe-gch.git, I'm imagining that once 
the dust settles, the next step will be to cut new I-Pipe for ARM patch 
sets and update xenomai-2.6.git accordingly.  I'm planning an additional 
round of testing soon thereafter.

Thanks much,
Mitch






