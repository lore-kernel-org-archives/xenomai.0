Date: Tue, 14 Jul 2015 02:02:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150714000232.GB1971@hermes.click-hack.org>
References: <7413ead94cb8c4f3a91d1288a27103c9.squirrel@sourcetrek.com>
 <55A3F4B3.1090908@sigmatek.at>
 <20150713195856.GA1552@hermes.click-hack.org>
 <55A41E26.9020903@sigmatek.at>
 <20150713203133.GA2022@hermes.click-hack.org>
 <55A4235D.2000601@sigmatek.at>
 <20150713205412.GC2022@hermes.click-hack.org>
 <55A4346B.9030309@sigmatek.at>
 <20150713223932.GA1971@hermes.click-hack.org>
 <55A44A33.7010100@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55A44A33.7010100@sigmatek.at>
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

On Tue, Jul 14, 2015 at 01:30:59AM +0200, Johann Obermayr wrote:
> Am 14.07.2015 um 00:39 schrieb Gilles Chanteperdrix:
> >You mean there is an issue with bus contention? Are there many
> >things occupying the bus when the problem happens?
> Hi,
> 
> both cpu core can access our pci-card.
> 
> at this time we only have one pci-card with an fpga(with dpram) and a sram.
> the fpga generate our system tick. And have a company internal bus system.
> this bus system can configured with the dpram & fpga-config register.
> we also must read witch irq come from the fpga, because internal he can have
> more than one irq sources. and we must quit this irq. (with reading a fpga
> register)
> 
> we see that if one core accessing the pci-bus, the other core have a high
> latency.
> core0 = importan & high prior accessing fpga and sram
> core1 = linux & visu & some other low prior
> 
> if a low prior copy a memblock to/from the sram, the core0 have high latency
> in
> our irq handler at reading some data from fpga.
> so we add a own pci-blocker task on core1. this task ist started about 50us
> before
> next tick-irq is coming. now our irq handle can access the fpga without
> waiting.

Well, normally, a PCI bus controller has parameters controlling the
duration of the longest burst, adequately named "PCI latency". You
should also look at whether caching is enabled. A PCI bridge will
normally prefetch from a PCI bar (provided that the FPGA indicates
in the configuration bytes that the memory is prefetchable) to avoid
CPU wait states. Using what was once called MTRR, but has a new name
in new processor, you can cause the procesdor to buffer data before
sending large bursts on the PCI bus. I think what you need to have a
look at is the documentation of the PCIe to PCI bridge, to see if
you can not improve the situation by better configuring it. Also,
reading or writing to FPGA is RAM looks pretty strange, since I
would guess an FPGA could be master on the PCI bus and do DMA
itself, thereby relieving the CPU.

-- 
					    Gilles.
https://click-hack.org

