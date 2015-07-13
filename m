Message-ID: <55A44A33.7010100@sigmatek.at>
Date: Tue, 14 Jul 2015 01:30:59 +0200
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <e5d48b6984cbc1b098062b303b56b0db.squirrel@sourcetrek.com>
 <55A3EE26.5070802@sigmatek.at>
 <7413ead94cb8c4f3a91d1288a27103c9.squirrel@sourcetrek.com>
 <55A3F4B3.1090908@sigmatek.at> <20150713195856.GA1552@hermes.click-hack.org>
 <55A41E26.9020903@sigmatek.at> <20150713203133.GA2022@hermes.click-hack.org>
 <55A4235D.2000601@sigmatek.at> <20150713205412.GC2022@hermes.click-hack.org>
 <55A4346B.9030309@sigmatek.at> <20150713223932.GA1971@hermes.click-hack.org>
In-Reply-To: <20150713223932.GA1971@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] usage of rtdm_task_sleep_abs
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am 14.07.2015 um 00:39 schrieb Gilles Chanteperdrix:
> You mean there is an issue with bus contention? Are there many
> things occupying the bus when the problem happens?
Hi,

both cpu core can access our pci-card.

at this time we only have one pci-card with an fpga(with dpram) and a sram.
the fpga generate our system tick. And have a company internal bus system.
this bus system can configured with the dpram & fpga-config register.
we also must read witch irq come from the fpga, because internal he can have
more than one irq sources. and we must quit this irq. (with reading a 
fpga register)

we see that if one core accessing the pci-bus, the other core have a 
high latency.
core0 = importan & high prior accessing fpga and sram
core1 = linux & visu & some other low prior

if a low prior copy a memblock to/from the sram, the core0 have high 
latency in
our irq handler at reading some data from fpga.
so we add a own pci-blocker task on core1. this task ist started about 
50us before
next tick-irq is coming. now our irq handle can access the fpga without 
waiting.

the old mainboard have pci on the southbridge.
but now we have a new mainboard. the new chipset have no pci bus.
on the mainboard there is now a pci-express to pci bridge chip.

we see that __ipipe_handle_irq is always called correct. but from this 
function to our irq-handler, we have
a high latency and we see, that pci-locker task is not started 50us 
before irq. sometime he started 100us or more
after the hardware irq.

i have orderd more documents about the bridge chip and wiring diagram 
about bridge-chip and apic.

tomorrow i will measure the apic_eoi function time.

regards
   Johann

PS: think we need a PCIexpress card, not a pci-card.
