Message-ID: <45AF306E.4070606@domain.hid>
Date: Thu, 18 Jan 2007 09:31:42 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PPC405: DMA-Problem with OCM (interrupt-example)
References: <200701172333.25574.niklaus.giger@domain.hid>
In-Reply-To: <200701172333.25574.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> I tried to simply an example program how to use interrupts
> with Xenomai (see attached Makefile & dma_4xx_int_module.c).
> 
> The interrupt part of the example works, but the DMA transfer (memory to
> memory) using the OnChipMemory fails. I think I must somewhere specify that 
> the src/dst adressed should not be cached, but I do not know how to do it.

consistant_alloc() should help. It's used in the kernel in various 
places, e.g. in "drivers/net/ibm_emac".

> (I tried to use virt_to_phys and virt_to_bus but failed miserably.)
> The OCM is initialised in my board specific __init by calling:
>>         io_block_mapping(mfdcr(DCRN_OCMDSARC), mfdcr(DCRN_OCMDSARC),
>> 4*1024, _PAGE_IO);
> 
> A simple insmod/rmmod cycle gives me the following output:
> 
>>                      init_module: SRC f4000000 DST f4000103
>>                      init_module: residue 111 status 0xa00f100
>>              xenomai_irq_handler: IRQ  8 uipr 0xffffff87 uier 0x003f0000
>> uisr 0xc0809807 xenomai_irq_handler: residue 0 status 0x1a00f000
>> src at f4000000 is Could we use a DMA + interrupt to copy a string?
>> dst at f4000103 is Should be overwritten.
>>                   cleanup_module: dma_ch.control 0x0 0
>>                   cleanup_module: IRQ  8 uipr 0xffffff87 uier 0x003f0000
>> uisr 0xc0009807 cleanup_module: residue 0 status 0x1a00f000
>> src at f4000000 is Could we use a DMA + interrupt to copy a string?
>> dst at f4000103 is Should be overwritten.
> 
> Does anybody have a clue?
> 
> If this question is off topic, which mailing list would you reccomend?
> (http://ozlabs.org/pipermail/linuxppc-embedded/ ??)

linuxppc-embedded is OK.

> Is the example code otherwise good enough to be accepted as an example how to 
> attach a interrupt?

Wolfgang.

