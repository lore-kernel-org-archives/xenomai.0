Date: Fri, 17 Jul 2015 07:25:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150717052516.GB2684@hermes.click-hack.org>
References: <20150713203133.GA2022@hermes.click-hack.org>
 <55A4235D.2000601@sigmatek.at>
 <20150713205412.GC2022@hermes.click-hack.org>
 <55A4346B.9030309@sigmatek.at>
 <20150713223932.GA1971@hermes.click-hack.org>
 <55A44A33.7010100@sigmatek.at>
 <20150714000232.GB1971@hermes.click-hack.org>
 <55A6CA07.1030005@sigmatek.at>
 <20150716063019.GA13809@hermes.click-hack.org>
 <55A79980.9050305@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55A79980.9050305@sigmatek.at>
Subject: Re: [Xenomai] usage of rtdm_task_sleep_abs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: xenomai@xenomai.org

On Thu, Jul 16, 2015 at 01:46:08PM +0200, Johann Obermayr wrote:
> Am 16.07.2015 um 08:30 schrieb Gilles Chanteperdrix:
> >On Wed, Jul 15, 2015 at 11:00:55PM +0200, Johann Obermayr wrote:
> >>Am 14.07.2015 um 02:02 schrieb Gilles Chanteperdrix:
> >>>On Tue, Jul 14, 2015 at 01:30:59AM +0200, Johann Obermayr wrote:
> >>>>Am 14.07.2015 um 00:39 schrieb Gilles Chanteperdrix:
> >>>>>You mean there is an issue with bus contention? Are there many
> >>>>>things occupying the bus when the problem happens?
> >>>>Hi,
> >>>>
> >>>>both cpu core can access our pci-card.
> >>>>
> >>>>at this time we only have one pci-card with an fpga(with dpram) and a sram.
> >>>>the fpga generate our system tick. And have a company internal bus system.
> >>>>this bus system can configured with the dpram & fpga-config register.
> >>>>we also must read witch irq come from the fpga, because internal he can have
> >>>>more than one irq sources. and we must quit this irq. (with reading a fpga
> >>>>register)
> >>>>
> >>>>we see that if one core accessing the pci-bus, the other core have a high
> >>>>latency.
> >>>>core0 = importan & high prior accessing fpga and sram
> >>>>core1 = linux & visu & some other low prior
> >>>>
> >>>>if a low prior copy a memblock to/from the sram, the core0 have high latency
> >>>>in
> >>>>our irq handler at reading some data from fpga.
> >>>>so we add a own pci-blocker task on core1. this task ist started about 50us
> >>>>before
> >>>>next tick-irq is coming. now our irq handle can access the fpga without
> >>>>waiting.
> >>>Well, normally, a PCI bus controller has parameters controlling the
> >>>duration of the longest burst, adequately named "PCI latency". You
> >>>should also look at whether caching is enabled. A PCI bridge will
> >>>normally prefetch from a PCI bar (provided that the FPGA indicates
> >>>in the configuration bytes that the memory is prefetchable) to avoid
> >>>CPU wait states. Using what was once called MTRR, but has a new name
> >>>in new processor, you can cause the procesdor to buffer data before
> >>>sending large bursts on the PCI bus. I think what you need to have a
> >>>look at is the documentation of the PCIe to PCI bridge, to see if
> >>>you can not improve the situation by better configuring it. Also,
> >>>reading or writing to FPGA is RAM looks pretty strange, since I
> >>>would guess an FPGA could be master on the PCI bus and do DMA
> >>>itself, thereby relieving the CPU.
> >>>
> >>Hello,
> >>
> >>how can i check, if the TSC on both core are run syncron ?
> >>Dual Core Celeron, no Hyperthreading.
> >Quite frankly, I think it is pretty clear what the problem is now:
> >you are accessing your SRAM in uncached mode, which causes large
> >wait states in your processor and cause it to misbehave somehow. Try
> >to fix that, enable pre-fetching on the PCI bridge as well, I
> >believe everything else are red herrings.
> >
> >Regards.
> >
> Hello,
> 
> this is our PCI-card
> 
> 02:04.0 ACCESS Bus: Device 5112:2200
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 32
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at f6800000 (32-bit, non-prefetchable) FPGA & SRAM
>         Region 1: Memory at f7000000 (32-bit, non-prefetchable) DPRAM
>         Kernel driver in use: Sigmatek PCI
> 
> SRAM is a part of the FPGA space. for FPGA we must use non-prefetchable.
> i will talk , if there is a way to add a own region for SRAM, that is
> prefetchable.
> for the bridge chip, i does not found about prefetchable.

The DPRAM should probably be made prefetchable as well. Everything
which is memory and not registers should be prefetchable. 

> 
> Why can sometime Core1 SRAM access not interrupted by the
> timer/schedule ?

It depends on the processor architecture, and I am not an x86
specialist, but maybe when the processor is accessing the SRAM
space, when it is waiting for the FPGA to answer, the interrupt
handling is postponed until the wait is finished. And maybe when it
is in that state, the other core will block for any operation trying
to access the bus.

-- 
					    Gilles.
https://click-hack.org

