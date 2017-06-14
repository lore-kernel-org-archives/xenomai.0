References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>
 <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
 <1496226896420.15161@kth.se>
 <78c2df60-f9d8-ff4e-a53d-1b64e4af5c4a@xenomai.org>
 <1497222185664.65276@kth.se> <1497265336521.90775@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <af63a95f-4cb0-508c-7939-eea5b2f3c62d@xenomai.org>
Date: Wed, 14 Jun 2017 10:27:26 +0200
MIME-Version: 1.0
In-Reply-To: <1497265336521.90775@kth.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem with gpio interrupts for xenomai3 on Intel
 joule
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/12/2017 01:02 PM, Nitin Kulkarni wrote:
> Hi Philippe,
> Correcting the subject of this thread and adding it to the mailing list.
> Thanks for those precise code suggestions. There are two issues.
> 
> 1. I found that the ipipe_irq_cascade handler is called but the problem is that
> there are 5 pinctrl devices on this soc and all of them share the same irq line. Hence I see that the intel_gpio_probe()
> runs for all the 5 pin controllers during kernel initialization and overwrites the irq descriptor with respective pinctrl data each time the probe runs.
> When the interrupt is triggered ipipe_irq_cascade invoked with the irq desc, I always see that the pinctrl data retrieved from
> irq_desc using  irq_desc_get_handler_data is always the last pinctrl. Hence I do not read the right pinctrl to call intel_gpio_irq() and read the right interrupt enable reg for the gpio pin I enabled as interrupt.
> 
> 2. When I forced it to read the right pinctrl data by storing that information when intel_gpio_irq_enable is executed.
> The rtdm handller from my module is executed but the ack call intel_gpio_irq_ack is not called. Hence the irq flags were never cleared and the mmc driver also starts complaining about interrupts not being received. The whole system slows down and virtually hangs.
> 
> *I tried some fixes*
> -> I changed the flow handler type from handle_simple_irq to handle_edge_irq  while calling  gpiochip_irqchip_add()
>   in intel_gpio_probe.
> -> I called the ack function in ipipe_irq_cascade using the irq_desc which it has.
> It seems to work perfectly with this fix but this is a raw and a hackish way of doing. I am not sure if this has any consequences.
> Can you suggest me whats wrong with the ack not being called and how to deal with multiple pinctrl devices sharing the same irq.
> 

Please send a patch including your changes; it should be easier to
review and comment.

-- 
Philippe.

