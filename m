Message-ID: <47450B49.2060907@domain.hid>
Date: Wed, 21 Nov 2007 20:53:29 -0800
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0711210140x39088655idf0339a49522fa73@domain.hid>	
	<822923.79799.qm@domain.hid>
	<fd6a47a90711211544q437ea186mcfbab54fd0a257cc@domain.hid>
In-Reply-To: <fd6a47a90711211544q437ea186mcfbab54fd0a257cc@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled. Disable
 IRQ line.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

Hi Jeroen,

Thanks for the information.

The Xenomai disabled the interrupt when it saw the sharing. The message 
log from dmesg was:
xenomai: xnintr_shirq_handler: IRQ11 not handled. Disabling IRQ line.

The NICs worked normally with 8139too.ko and 8139cp.ko drivers.

I have three difference types of PCs: pentium III 650 Mhz, Core2, and 
AMD athlon 2Ghz. on different mother boards.  All of them have conflict 
IRQs with xenomai and RTnet.  I swapped the slots but it did not 
changed.  I'm thinking of giving the NICs  fixed IRQ but I don't know how.

Anyone have any ideas?

Thanks,
Dennis



Jeroen Van den Keybus wrote:
>
>     Yes, I have problem with sharing the IRQ 11.
>     my questions are:
>     How can I set the rteth0 to a known not sharing IRQ in the system? 
>
>  
> - You already said you don't have BIOS options.
> - If you have multiple PCI slots, try swapping the cards. Usually, 
> adjacent slots have different interrupt lines. But you might end up 
> sharing with something else.
> - Avoid the use of the sharing device (possible with audio, some USB, ...)
> - Check if ACPI configures the interrupt lines for you (bypassing the 
> BIOS). I don't know for sure, but I think you can use the acpi_irq_pci 
> kernel parameter to somehow influence the mapping of the 
> physical interrupt lines to logical IRQ lines (numbers).
> - You could also try to share the same IRQ for both cards (again by 
> replacing them in the PCI slots).
>  
> But, in all fairness, I think your problem lies elsewhere, because 
> both IRQ10 and 11 are affected and disabling only occurs after a lot 
> (1000 or so) of unhandled requests have happened.
>
>  
>
>     How can I pass a known IRQ from RTnet to the Xenomai
>     xnintr_shirq_handler?
>
>  
> The PCI interrupts are fixed after BIOS (or ACPI) has done its job. If 
> you change the number of the IRQ line by moving it or using the 
> BIOS/ACPI, it should also change correctly.
>  
>  
> What does the dmesg log say ? Perhaps you can turn on debugging for 
> the rtnet driver and get more info.
>  
> Last but not least: do the cards work correctly in parallel using the 
> standard Linux driver (8139too) ?
>  
>  
> Jeroen.

