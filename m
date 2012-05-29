Message-ID: <4FC478AF.6020905@bbn.com>
Date: Tue, 29 May 2012 03:20:15 -0400
From: Mitchell Tasman <tasman@bbn.com>
MIME-Version: 1.0
References: <4FBADE7D.5030609@bbn.com> <4FBB4951.5070803@xenomai.org>
	<4FBC0383.3020608@bbn.com> <4FBC0582.2060707@xenomai.org>
	<4FBF4E69.1010200@bbn.com> <4FBF78FE.3020300@xenomai.org>
In-Reply-To: <4FBF78FE.3020300@xenomai.org>
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

Gilles,

On 05/25/2012 08:20 AM, Gilles Chanteperdrix wrote:
> On 05/25/2012 11:18 AM, Mitchell Tasman wrote:

>> Thank you once again for your excellent support, and I very much look
>> forward to the updated I-Pipe for ARM 2.6.38.8 patch set.
>
> You are welcome. The patch should be done during the week-end.

Hi.  I noticed that you made some commits on the for-ipipe-2.6.38-arm 
branch of your ipipe-gch.git repository, and decided to take a quick 
look, leading to a question.

In arch/arm/plat-omap/gpio.c, I found that you reverted-out some changes 
relating to earlier fixes to handling of GPIO interrupts, bringing the 
source closer to the vanilla linux 2.6.38.8 version.

One change that had been made along the way on the for-ipipe-2.6.38-arm 
branch was to add a gpio_mask_ack_irq() function, and invoke it like so 
from gpio_irq_handler(), instead of invoking gpio_ack_irq():

#ifndef CONFIG_IPIPE
       desc->irq_data.chip->irq_ack(&desc->irq_data);
#else /* CONFIG_IPIPE */
       desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
#endif /* CONFIG_IPIPE */

With the latest commits, the gpio_mask_ack_irq() function remains, but 
it is no longer invoked, with gpio_ack_irq() being called 
unconditionally instead, as with the vanilla 2.6.38.8 source.

Looking at I-Pipe support for 3.0.13, I found that the inline function 
chained_irq_enter() is called at the equivalent place in 
gpio_irq_handler(), and that function appears to invoke 
gpio_mask_ack_irq() when available (which it is for OMAP in your tree), 
and otherwise calls gpio_ack_irq().

I just wanted to double-check with you that the vanilla 2.6.38.8 source 
is indeed correct (or at least harmless) in its unconditional calling of 
gpio_ack_irq() from gpio_irq_handler(), and that the apparent difference 
in behavior between the 3.0.13 and 2.6.38.8 I-Pipe patch sets is fine as 
well.

Thank you very much for updating I-Pipe support for ARM 2.6.38.8.

Best Regards,
Mitch







