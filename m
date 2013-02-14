Message-ID: <511D3DA1.1040209@xenomai.org>
Date: Thu, 14 Feb 2013 20:40:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPeEhaoXWQy_w3AvZPg7DTKWebiTh9p3zOaDEGkkcUe56ftPdA@mail.gmail.com>
In-Reply-To: <CAPeEhaoXWQy_w3AvZPg7DTKWebiTh9p3zOaDEGkkcUe56ftPdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] #INCLUDE for __ipipe_tsc_register()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: uMinded Strikes Again <iceblu3710@gmail.com>
Cc: xenomai@xenomai.org

On 02/14/2013 07:16 PM, uMinded Strikes Again wrote:

> I had a read through http://xenomai.org/index.php/I-pipe-core:ArmPorting but
> my 3.0.36 kernel does not use this style of ipipe functions. I took a look
> at the mach-omap2 implementation of ipipe and just copied it in my arch.
> 
> I have written functions and exported whats needed for everything `I HOPE`
> but I get an erro when linking:
> undefined reference to `__ipipe_tsc_register'
> 
> My snippit of code in my timer init function:
> #if defined(CONFIG_IPIPE)
>   tsc_info.type = IPIPE_TSC_TYPE_FREERUNNING,
>   tsc_info.freq = TIMER2_HPET_CLOCK_EVENT_HZ;
>   tsc_info.counter_vaddr = TMR_REG_o_TMR2_CUR;
>   tsc_info.u.counter_paddr = TMR_REG_o_TMR2_CUR;
>   tsc_info.u.mask = 0xffffffff;
>   __ipipe_tsc_register(&tsc_info);
> #endif /* CONFIG_IPIPE */
> 
> The only places I find the register function is in:
> /arch/arm/include/asm/ipipe.h
> /arch/arm/kernel/ipipe_tsc.c
> 
> but including either of those files does not solve the reference. Any idea
> what include I need for this __ipipe_tsc_register function?


That is explained at the very beginning of the TSC part of the porting 
guide, with an example given for the SPEAR processor:
http://xenomai.org/index.php/I-pipe-core:ArmPorting#High_resolution_counter

Namely, you have to add:
	select IPIPE_ARM_KUSER_TSC if IPIPE
somewhere in the Kconfig for the processor you are porting the I-pipe to.

-- 
                                                                Gilles.

