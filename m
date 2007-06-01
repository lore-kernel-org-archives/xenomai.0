Message-ID: <46601378.1080703@domain.hid>
Date: Fri, 01 Jun 2007 14:39:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1180693122.465ff282c0093@domain.hid>
In-Reply-To: <1180693122.465ff282c0093@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] __ipipe_mach_demux_irq issue.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: garryt <garryt@domain.hid>
Cc: adeos-main@gna.org

garryt wrote:
> Hello,
> 
> I am in working on the port of adeos ipipe on my board which is basically an
> IMX1 ARM 920 architecture with 2.6.20 linux kernel.  This board is quite simple
> and first results seems good.
> 
> I had a look to the document "Adapting ARM I-Pipe patch to a new board"
> 
> But i encountered a problem with the __ipipe_mach_demux_irq function.
> multiplexed ITs are GPIOA B C and D which generate respectively IRQs 11, 12 13
> and 62.
> The only GPIO i used currently is the interrupt from DM9000 module. First time i
> put interface up it loops in the handler since it does not seem to be acked
> correctly ...
> I use:
> 
> kernel 2.6.20-12
> adeos patch adeos-ipipe-2.6.20-arm-1.7-02.patch
> 
> Here is the code i added:
> 
> #ifdef CONFIG_IPIPE
> void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
> {
>         struct irq_desc *desc_unused = irq_desc + irq;
>         unsigned irq_unused = irq;
>         unsigned int i, mask;
> 
>         /* GPPIOA, GPIOB, GPIOC, GPIOD are INT 11,12,13 and 62 */
>         i=((irq&7)-3);
> 
>         /* Get all multiplexed ITs from given GPIO */
>         mask=ISR(i);
>         irq=(i<<5)+IMX_IRQS;
>         do {
>         if (mask & 1 )
>                 {__ipipe_handle_irq(irq, regs);
>                  // Ack multiplexed IT from given GPIO
>                  ISR(i)=1<<(irq&0x1f);
>                  }
>            mask >>=1;
>            irq++;
>            } while (mask);
> 
>         desc_unused->chip->unmask(irq_unused);
> }
> #endif /* CONFIG_IPIPE */
> 
> 
> 
> I then changed the type of interrupt with set_irq_type from TRIGGER_LOW to
> FALLING and everything's ok now, interface working good now.
> 
> My question is what about TRIGGER_LOW interrupt, i though __ipipe_handle_irq
> looked for all registered domains and called the hanbler and ack functions for
> these domains.
> So since the DM9000 module was working good when i used the kernel whitout
> CONFIG_IPIPE, I though the linux domain acked the interrupt correctly with
> TRIGGER_LOW...
> At most it should be acked by writing to ISR.
> 
> Any help will be greatly appreciated...

To solve this issue, try to know what happens when running Linux which
does not happen with the I-pipe. Maybe what is missing is just a
desc_unused->chip->ack(irq_unused) at the beginning of
__ipipe_mach_demux_irq, at91 has it (but the original function had it too).

-- 
                                                 Gilles Chanteperdrix

