MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Nov 2012 18:40:01 +0100
From: WONG Sheng Chao <wong@isir.upmc.fr>
In-Reply-To: <db62a2cc790904728c13fca4beffd559@isir.upmc.fr>
References: <04934a1da80b9542fe5e0375b07d3663@isir.upmc.fr>
	<50AF48DA.9010200@xenomai.org>
	<80c97c7c58b1c913fd0fb2ec83a86b3d@isir.upmc.fr>
	<50AFA44E.4070506@xenomai.org>
	<b5d8fc2c77444a0bf20a3446d6a7edd0@isir.upmc.fr>
	<50AFB64E.4030702@xenomai.org>
	<b6df56ed969c01a5916ff3efc3ce4c87@isir.upmc.fr>
	<50B4FFBE.20204@xenomai.org>
	<db62a2cc790904728c13fca4beffd559@isir.upmc.fr>
Message-ID: <8230f5b2d86c368c49f1ce75ce93d097@isir.upmc.fr>
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: WONG Sheng Chao <wong@isir.upmc.fr>
Cc: xenomai@xenomai.org

On Wed, 28 Nov 2012 16:12:58 +0100, WONG Sheng Chao wrote:
> On Tue, 27 Nov 2012 19:00:30 +0100, Gilles Chanteperdrix wrote:
>> On 11/27/2012 05:40 PM, WONG Sheng Chao wrote:
>>> Hi Gilles
>>>
>>> Following your advice i tracked down the include files which need 
>>> to be
>>> included to remove the error. The kernel now compiles without 
>>> errors. I
>>> followed the instructions in
>>>
>>> http://www.xenomai.org/pipermail/xenomai/2012-July/000481.html
>>>
>>> to change the timer.c and also changing the .handle_irq with
>>> ipipe_handle_multi_irq
>>>
>>>  From the serial terminal i noticed that with CONFIG_IPIPE = ON the
>>> timer is used correctly as in the above post but it hangs at
>>
>> Are you sure the timer is running correctly?
>>
>>
>>> Any advice on how to proceed to debug this problem? I attach the
>>> config files of two cases for your reference.
>>
>> I would put a printk in linux timer irq handler.
>
> How should i come about debugging the timer irq handler?
>
> Looking at the arch/arm/mach-omap2/timer.c i would think the timer
> handler is omap_itimer.irq ? But i am not sure how to verify it.
>
>
> As for the omap_intc_handle_irq in arch/arm/mach-omap2/irq.c here is
> my function which i used from the vender
>
> static inline void omap_intc_handle_irq(void __iomem
> *base_addr,unsigned int no_regs_req, struct pt_regs *regs)
> {
> u32 irqnr = 0;
>
> do {
> 	int i = 0;
>
> 	for (i = 0; i < no_regs_req; i++) {
> 		irqnr = readl_relaxed(base_addr + 0x98 + (0x20 * i));
> 		if (irqnr)
> 			goto out;
> 	}
>
> out:
> 	if (!irqnr)
> 		break;
>
> 	irqnr = readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
> 	irqnr &= ACTIVEIRQ_MASK;
>
> 	if (irqnr)
> 	{
> //			handle_IRQ(irqnr, regs);
> 		ipipe_handle_multi_irq(irqnr, regs); //This is where i added the
> ipipe_handle_multi_irq
> 	}
>
> } while (irqnr);
> }
>
> Is this the right place for it?
>
> -WONG

Refering to this,

http://www.xenomai.org/pipermail/xenomai/2012-May/025838.html

I believe that i should be put a printk in the function 
ipipe_mach_acktimer, as it is called when the linux timer interrupt, but 
I after checking in these files, i still couldn't find it.

./include/ipipe
./include/linux/ipipe_debug.h
./include/linux/ipipe_lock.h
./include/linux/ipipe_base.h
./include/linux/ipipe_tickdev.h
./include/linux/ipipe_trace.h
./include/linux/ipipe_compat.h
./include/linux/ipipe_domain.h
./include/linux/ipipe.h
./include/config/ipipe
./include/config/ipipe.h
./kernel/ipipe
./arch/blackfin/include/asm/ipipe_base.h
./arch/blackfin/include/asm/ipipe.h
./arch/blackfin/kernel/ipipe.c
./arch/arm/include/asm/ipipe_base.h
./arch/arm/include/asm/ipipe_hwirq.h
./arch/arm/include/asm/ipipe.h
./arch/arm/kernel/ipipe_tsc.o
./arch/arm/kernel/ipipe_tsc_asm.o
./arch/arm/kernel/ipipe.c
./arch/arm/kernel/ipipe_tsc.c
./arch/arm/kernel/ipipe_tsc_asm.S
./arch/arm/kernel/ipipe.o

Can someone point me to the right direction?

-WONG



