Message-ID: <445F73B8.3050504@domain.hid>
Date: Mon, 08 May 2006 18:37:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] kconfig help questions
References: <445EB95C.6050302@domain.hid>
In-Reply-To: <445EB95C.6050302@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
> 
> Going thru xenomai Kconfig again, some observations/uncertainties came up.
> I'll make a patch, given feedback.
> 
> XENO_OPT_TIMING_PERIODIC
> 
> "Aperiodic mode provides for non-constant delays between timer ticks,"
> 
> the wording here (non-constant delays) left me momentarily wondering
> if _APERIODIC was bad (this, despite the use of 'provides'). Maybe 
> "sub-tick delays" makes some sense ..
> 

The fundamental issue is that aperiodic mode is tick-less, in the sense 
that it does not define any constant period value; in this respect, 
introducing the sub-tick notion would not make much sense. What about 
"arbitrary delays" instead?

> XENO_OPT_SHIRQ_LEVEL
> 
> Are there any decent estimates or examples of the latency / jitter 
> increases
> if this is enabled ?  Is it highly cpu or chipset dependent ?

More cache misses since we need to scan the entire chain of handlers, 
and obviously more processing from the various handlers.

> I presume /proc/interrupts is the place to look to see if you might need 
> it,
> iff any of the devices of interest are shared.
> my laptop shows sharing, my soekris does not
> 
>  3:          5          XT-PIC  ehci_hcd:usb1, ohci1394
>  4:          0          XT-PIC  uhci_hcd:usb6
>  7:     708975          XT-PIC  ipw2200, ehci_hcd:usb2, uhci_hcd:usb7
>  8:          1          XT-PIC  rtc
>  9:     437509          XT-PIC  acpi, Intel 82801DB-ICH4, Intel 
> 82801DB-ICH4 Modem, ohci_hcd:usb3, ohci_hcd:usb4, uhci_hcd:usb5, yenta, 
> eth0
> 
> # cat /proc/interrupts
>           CPU0
>  0:   13148086          XT-PIC  timer
>  2:          0          XT-PIC  cascade
>  4:      33084          XT-PIC  serial
>  8:          4          XT-PIC  rtc
> 10:     337134          XT-PIC  eth0
> 11:     926639          XT-PIC  ndiswrapper
> 14:         11          XT-PIC  ide0
> NMI:          0
> 

It's more a sharing in the RT sense, so you likely would not have to 
share the IRQs with the non-RT Linux side altogether, since this adds 
more complexity to the picture (specifically: how to share the ack/eoi 
cycle between the RT and non-RT sides).

> 
> XENO_OPT_SHIRQ_EDGE
> 
> does this only apply to ISA bus ?
> 

Not exclusively. x86-wise, the IO-APIC is both capable of handling edge 
and level interrupts.

> XENO_SKIN_NATIVE
> 
> will add module name
> 
> XENO_OPT_NATIVE_INTR
> 
> Note that the preferred
> way of implementing generic drivers usable across all Xenomai
> interfaces is defined by the Real-Time Driver Model (RTDM).
> 
> It doesnt say theyre (in)?compatible, should it ?
> 

They are not. The native interrupt support is providing basic access to 
the core interrupt layer RTDM does use for its own purpose too.

> 
> SUMMARY
> 
> Id like to see estimates of the latency costs associated with each choice,
> where its practical to do so (given the current unknowables, like 
> variations across
> cpus, chipsets etc).  I recognize that such numbers are the hoped-for
> end result of the xenomai-data ML, and perhaps nothing real can be said
> yet (or ever) in Kconfig, except in (overly?) broad statements.
> 

IMO, it seems rather difficult to state something sensible regarding the 
latency introduced by IRQ sharing in the Kconfig help strings, since it 
would basically depend on what the shared IRQ handlers are doing in the 
first place.

> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

