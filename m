Message-ID: <474ED223.9040009@domain.hid>
Date: Thu, 29 Nov 2007 06:52:19 -0800
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
References: <2ff1a98a0711210140x39088655idf0339a49522fa73@domain.hid>	
	<822923.79799.qm@domain.hid>	
	<fd6a47a90711211544q437ea186mcfbab54fd0a257cc@domain.hid>	
	<47450B49.2060907@domain.hid>	
	<fd6a47a90711220342y119217aei841a2b7bce90acb0@domain.hid>	
	<47459517.20003@domain.hid> <47459716.50508@domain.hid>
	<fd6a47a90711221100t6baff4bej3d42e4440c2d452f@domain.hid>
In-Reply-To: <fd6a47a90711221100t6baff4bej3d42e4440c2d452f@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xnintr_shirq_handler: IRQ11 not handled.
 Disabling IRQ line.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>, rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org

Jeroen, Roland,

I'm sorry for replying late.  my interrupt conflicts could be solved by 
using only one NIC or upgrade to Linux 2.6.23.9.  Interestingly I 
noticed that the kernel 2.6.23.9 assigned different IRQ for each PCI device.
My solution is using Linux i386 2.6.23.9 and xenomai 2.4-rc7.
Thanks for your help,
Dennis

Jeroen Van den Keybus wrote:
>
>     post the output of
>
>     lspci -v
>
>  
> And while you're at it, please also show the results of
>  
> cat /proc/interrupts
> cat /proc/xenomai/irq
>  
> both just before loading the driver and right after the 'Disabling 
> IRQ.' message.
>  
>  
> Jeroen.
>  
>
>  
>
>
>  
>
>     Roland
>
>     Dennis Nguyen wrote:
>     > Most of the times the RTnet/Xenomai disabled the IRQ right away.
>     few
>     > time it ran for a while.
>     > It doesn't matter the system has single or 2 cards, it still have
>     > conflict IRQ.  I tried to change the slot but it did not help.
>     > Thanks,
>     > Dennis
>     >
>     > Jeroen Van den Keybus wrote:
>     >>     The Xenomai disabled the interrupt when it saw the sharing.
>     >>
>     >>
>     >> I may have mislooked, but doesn't xnintr_shirq_handler only
>     disable
>     >> the line after XNINTR_MAX_UNHANDLED problematic IRQs (which is by
>     >> default set to 1000) ? If you get the error immediately after
>     loading
>     >> the driver, it looks like either the interrupt doesn't get
>     properly
>     >> acknowledged in the I-pipe (after which the driver gets pounded
>     by 999
>     >> stray interrupts, causing it to return 'unhandled') or the driver
>     >> fails to acknowledge it on the card.
>     >>
>     >>
>     >>     The NICs worked normally with 8139too.ko and 8139cp.ko drivers.
>     >>
>     >>
>     >> Ok. I think that means that at least no weird things happen in the
>     >> I-pipe or that the cards are defective (or poorly inserted in
>     slot).
>     >>
>     >>
>     >>     I have three difference types of PCs: pentium III 650 Mhz,
>     Core2, and
>     >>     AMD athlon 2Ghz. on different mother boards.  All of them have
>     >>     conflict
>     >>     IRQs with xenomai and RTnet.  I swapped the slots but it
>     did not
>     >>     changed.  I'm thinking of giving the NICs  fixed IRQ but I
>     don't
>     >>     know how.
>     >>
>     >>
>     >> As said before, you can only practically do that in the BIOS or
>     using
>     >> ACPI.
>     >>
>     >> Does the rtnet driver work correctly with only one card ?
>     >>
>     >>
>     >> Jeroen.
>     >>
>     >
>     > _______________________________________________
>     > Xenomai-help mailing list
>     > Xenomai-help@domain.hid <mailto:Xenomai-help@domain.hid>
>     > https://mail.gna.org/listinfo/xenomai-help
>     >
>
>

