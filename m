MIME-Version: 1.0
In-Reply-To: <mailman.12801.1288293682.12503.xenomai@xenomai.org>
References: <mailman.12801.1288293682.12503.xenomai@xenomai.org>
Date: Thu, 28 Oct 2010 16:30:25 -0700
Message-ID: <AANLkTimaq3_Lmgt_tcN-kqwG=0NfKqT-=02KmJj=K1RK@mail.gmail.com>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/mixed; boundary=0016363b86f0fd94eb0493b5b9d8
Subject: Re: [Xenomai-help] Xenomai-help Digest, Vol 61, Issue 58
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016363b86f0fd94eb0493b5b9d8
Content-Type: multipart/alternative; boundary=0016363b86f0fd94d80493b5b9d6

--0016363b86f0fd94d80493b5b9d6
Content-Type: text/plain; charset=ISO-8859-1

Hey there,

I followed the suggestions from the error message (which seems to be the
reason for the hard disc slow down)

[44806.726625] irq 16: nobody cared (try booting with the "irqpoll" option)

and added the "irqpoll" option to the kernel parameters. As of now, the
problem did not occur anymore.

We managed to reproduce the event (somehow deterministically) by starting
the rt-task that communicates on the can bus at a high rate. However, after
adding the irqpoll parameter, the problematic event does not occur anymore.
We found that the irqpoll option may "significantly impact system
performance", however, we are wondering in how much this influences our
performance in xenomai.

[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-2.6.31.4-ipipe-2.5.4
root=UUID=70377358-b8ed-4696-a5f2-d7d5ded856e9 ro
xeno_nucleus.xenomai_gid=1002 quiet splash irqpoll
[    0.000000] Misrouted IRQ fixup and polling support enabled
[    0.000000] This may significantly impact system performance

It seems that the problem is (also) triggered when a heavy load on the usb
device is applied. We are controlling some motors through usb (in
non-real-time).

Thanks,
 peter



On Thu, Oct 28, 2010 at 12:21 PM, <xenomai-help-request@domain.hid> wrote:

> Send Xenomai-help mailing list submissions to
>        xenomai@xenomai.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        https://mail.gna.org/listinfo/xenomai-help
> or, via email, send a message with subject or body 'help' to
>        xenomai-help-request@domain.hid
>
> You can reach the person managing the list at
>        xenomai-help-owner@domain.hid
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai-help digest..."
>
>
> Today's Topics:
>
>   1. BeagleBoard-XM (Michel He)
>   2. Re: Slow hard drive access in xenomai (Peter Pastor)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 28 Oct 2010 16:37:05 +0200
> From: Michel He <michel.he@domain.hid>
> Subject: [Xenomai-help] BeagleBoard-XM
> To: xenomai@xenomai.org
> Message-ID: <20101028163705.18211an5ytg9yv1c@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1; DelSp="Yes";
>        format="flowed"
>
> hello all,
>
>    I wonder whether anybody have ever tested Xenomai on the
> BeagleBoard-XM (OMAP DM3730) or the no XM version (OMAP 3530). Are the
> dsplink and examples fully working ?
>
>
> thanks
>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 28 Oct 2010 12:20:41 -0700
> From: Peter Pastor <peter.pastor@domain.hid>
> Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
> To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>,
>        xenomai@xenomai.org
> Message-ID:
>        <AANLkTi=5YF3QnvK9iGpBs8enuA+=MHz7gKjE1p_3whM+@mail.gmail.com<MHz7gKjE1p_3whM%2B@mail.gmail.com>
> >
> Content-Type: text/plain; charset="iso-8859-1"
>
> Hey Gilles,
>
> >> dmesg_fine is not fine at all. The SATA drives attached to the "ioc" SAS
> >> controller, seem to experience continuous errors. And since this
> >> interrupt line is shared with the HDA driver, there is something
> >> suspicious here. You can know which one of the two drivers has issues by
> >> disabling one of them.
> I agree with you in that the SATA drives may cause the problem, since they
> are attached to the "ioc" SAS controller which has IRQ 16 assigned.
> However, apparently according to
>
>
> http://www.mail-archive.com/debian-bugs-dist@domain.hid
>
> the error message in the log is not a problem. In fact, when running kernel
> 2.6.35 the error message does not get displayed anymore. However, when
> running 2.6.35 we get an error message during booting (see
> dmesg_2.6.35-ipipe).
> ...
> [    2.047634] pci_root PNP0A03:00: address space collision: host bridge
> window [mem 0xd7f00000-0xe0000000] conflicts with PCI Bus 0000:00 [mem
> 0xe0000000-0xf7ffffff]
> ...
> [    3.118005] pci 0000:20:03.0: address space collision: [io
> 0xe000-0xefff] conflicts with PCI Bus 0000:00 [io  0xd000-0xffff]
> [    3.118007] pci 0000:20:09.0: address space collision: [io
> 0xd000-0xdfff] conflicts with PCI Bus 0000:00 [io  0xd000-0xffff]
> ...
>
> The devices in conflict are... not sure whether this is the cause of the
> slow hard disc access though. (see attached lspci.txt)
> 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port
> [8086:3406] (rev 13)
> 20:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI
> Express Root Port 3 [8086:340a] (rev 13)
> 20:09.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI
> Express Root Port 9 [8086:3410] (rev 13)
>
> >> Also, Linux seems to complain that it sees 32 cpus whereas you limited
> >> the number of cpus to 8.
> I set it back to 64 and recompiled the kernel, let's see whether this makes
> a difference.
> [    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:32
> nr_node_ids:1
> [    0.000000] early_res array is doubled to 128 at [2b800 - 2c7ff]
> ...
>
> I would like to switch of either of the two devices that are attached to
> IRQ
> 16, the problem however is, I need both. I am not sure whether disabling
> the
> USB controller in the BIOS is a good idea, since the computer does not have
> any other ways to attach a keyboard (and mouse) in case I want to enable it
> in the BIOS again.
>
> Also, to test whether the problem is related to the PCI can bus card, I
> removed the can bus card from the computer and see whether the "event"
> occurs again.
>
> Thanks for any help with this,
>  peter
>
>
>
> On Mon, Oct 25, 2010 at 10:22 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
> > Peter Pastor wrote:
> > > Hey Gilles,
> > >
> > > Thanks for you prompt response !
> > >
> > > I noticed that the problem of slow hard disc access does happen after
> > > a certain event. Right after booting xenomai "hdparam -t" gives me
> > > 120MB/s which is what I get when running the non-real-time kernel.
> > > Even when I run my real-time tasks everything seems to be fine.
> > > However, I just had the case that I tried to play a sound (just for
> > > testing) which triggered some output in the dmesg (see attached
> > > xenomai_problem.txt). The output of dmesg up to this point is
> > > contained in xenomai_fine.txt and the dmesg log of the non-real-time
> > > linux kernel is in dmesg_linux.txt.
> > >
> > > I disabled the audio card again and as of now, I haven't seen that
> > > problem. I can't really make sense out of what dmesg spit out. Would
> > > be great if someone could shine some light on this. It would be great
> > > if someone could let me know whether disabling the sound card solved
> > > the problem.
> > >
> > >>> Do you really need things like NUMA, SPARSEMEM, SECCOMP,
> AUDITSYSCALL,
> > >>> KPROBES, FTRACE, SELINUX?
> > > I am actually not sure what all these options mean, I also haven't
> > > spend time to figure things out. What impact could disabling these
> > > options have ? Do they decrease latency? address the problem above?
> > > other things?
> >
> > dmesg_fine is not fine at all. The SATA drives attached to the "ioc" SAS
> > controller, seem to experience continuous errors. And since this
> > interrupt line is shared with the HDA driver, there is something
> > suspicious here. You can know which one of the two drivers has issues by
> > disabling one of them.
> >
> > Also, Linux seems to complain that it sees 32 cpus whereas you limited
> > the number of cpus to 8.
> >
> > --
> >                                                                 Gilles.
> >
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: /public/xenomai-help/attachments/20101028/73105990/attachment.htm
> -------------- next part --------------
> 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port
> [8086:3406] (rev 13)
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Interrupt: pin A routed to IRQ 11
>        Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit-
> Queue=0/1 Enable-
>                Address: 00000000  Data: 0000
>                Masking: 00000000  Pending: 00000000
>        Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency
> L0 <512ns, L1 <4us
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [e0] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [150] Access Controls <?>
>        Capabilities: [160] Vendor Specific Information <?>
>
> 00:01.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI
> Express Root Port 1 [8086:3408] (rev 13)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: f3d00000-f3dfffff
>        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Subsystem: Dell Device [1028:026d]
>        Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit-
> Queue=0/1 Enable-
>                Address: 00000000  Data: 0000
>                Masking: 00000000  Pending: 00000000
>        Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Latency
> L0 <512ns, L1 <4us
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [e0] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [150] Access Controls <?>
>        Capabilities: [160] Vendor Specific Information <?>
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
> 00:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI
> Express Root Port 3 [8086:340a] (rev 13)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>        I/O behind bridge: 0000b000-0000bfff
>        Memory behind bridge: f4000000-f7efffff
>        Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Subsystem: Dell Device [1028:026d]
>        Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit-
> Queue=0/1 Enable-
>                Address: 00000000  Data: 0000
>                Masking: 00000000  Pending: 00000000
>        Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1,
> Latency L0 <512ns, L1 <4us
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+
> DLActive+ BWMgmt+ ABWMgmt-
>                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surpise-
>                        Slot #  2, PowerLimit 242.000000; Interlock-
> NoCompl-
>                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
>                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>                        Changed: MRL- PresDet+ LinkState+
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [e0] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [150] Access Controls <?>
>        Capabilities: [160] Vendor Specific Information <?>
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
> 00:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI
> Express Root Port 7 [8086:340e] (rev 13)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>        I/O behind bridge: 0000a000-0000afff
>        Memory behind bridge: f3e00000-f3ffffff
>        Prefetchable memory behind bridge: 00000000f0000000-00000000f00fffff
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Subsystem: Dell Device [1028:026d]
>        Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit-
> Queue=0/1 Enable-
>                Address: 00000000  Data: 0000
>                Masking: 00000000  Pending: 00000000
>        Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 256 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1,
> Latency L0 <512ns, L1 <4us
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surpise-
>                        Slot #  4, PowerLimit 225.000000; Interlock-
> NoCompl-
>                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
>                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>                        Changed: MRL- PresDet+ LinkState+
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [e0] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [150] Access Controls <?>
>        Capabilities: [160] Vendor Specific Information <?>
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
> 00:14.0 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub System
> Management Registers [8086:342e] (rev 13)
>        Subsystem: Device [0028:006d]
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint,
> MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed unknown, Width x0, ASPM L0s, Latency
> L0 unlimited, L1 unlimited
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>
> 00:14.1 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub GPIO and
> Scratch Pad Registers [8086:3422] (rev 13)
>        Subsystem: Device [0028:006d]
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint,
> MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed unknown, Width x0, ASPM L0s, Latency
> L0 unlimited, L1 unlimited
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>
> 00:14.2 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Control Status
> and RAS Registers [8086:3423] (rev 13)
>        Subsystem: Device [0028:006d]
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint,
> MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed unknown, Width x0, ASPM L0s, Latency
> L0 unlimited, L1 unlimited
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>
> 00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB
> UHCI Controller #4 [8086:3a37]
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 16
>        Region 4: I/O ports at 1f20 [size=32]
>        Capabilities: [50] PCIe advanced features <?>
>        Kernel driver in use: uhci_hcd
>
> 00:1a.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB
> UHCI Controller #5 [8086:3a38]
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin B routed to IRQ 17
>        Region 4: I/O ports at 1f00 [size=32]
>        Capabilities: [50] PCIe advanced features <?>
>        Kernel driver in use: uhci_hcd
>
> 00:1a.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB
> UHCI Controller #6 [8086:3a39]
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin C routed to IRQ 22
>        Region 4: I/O ports at 1c00 [size=32]
>        Capabilities: [50] PCIe advanced features <?>
>        Kernel driver in use: uhci_hcd
>
> 00:1a.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)
> USB2 EHCI Controller #2 [8086:3a3c] (prog-if 20)
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin C routed to IRQ 22
>        Region 0: Memory at f7ffe000 (32-bit, non-prefetchable) [size=1K]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [58] Debug port: BAR=1 offset=00a0
>        Capabilities: [98] PCIe advanced features <?>
>        Kernel driver in use: ehci_hcd
>
> 00:1c.0 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI
> Express Port 1 [8086:3a40]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>        I/O behind bridge: 00009000-00009fff
>        Memory behind bridge: f3b00000-f3cfffff
>        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                LnkCap: Port #1, Speed 2.5GT/s, Width x4, ASPM unknown,
> Latency L0 <256ns, L1 <4us
>                        ClockPM- Suprise- LLActRep+ BwNot-
>                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
> Queue=0/0 Enable-
>                Address: 00000000  Data: 0000
>        Capabilities: [90] Subsystem: Dell Device [1028:026d]
>        Capabilities: [a0] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Virtual Channel <?>
>        Capabilities: [180] Root Complex Link <?>
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
> 00:1c.5 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI
> Express Port 6 [8086:3a4a]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: f3a00000-f3afffff
>        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                LnkCap: Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> Latency L0 <256ns, L1 <4us
>                        ClockPM- Suprise- LLActRep+ BwNot-
>                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
> Queue=0/0 Enable-
>                Address: 00000000  Data: 0000
>        Capabilities: [90] Subsystem: Dell Device [1028:026d]
>        Capabilities: [a0] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Virtual Channel <?>
>        Capabilities: [180] Root Complex Link <?>
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
> 00:1d.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB
> UHCI Controller #1 [8086:3a34]
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 23
>        Region 4: I/O ports at 1f80 [size=32]
>        Capabilities: [50] PCIe advanced features <?>
>        Kernel driver in use: uhci_hcd
>
> 00:1d.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB
> UHCI Controller #2 [8086:3a35]
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin B routed to IRQ 17
>        Region 4: I/O ports at 1f60 [size=32]
>        Capabilities: [50] PCIe advanced features <?>
>        Kernel driver in use: uhci_hcd
>
> 00:1d.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB
> UHCI Controller #3 [8086:3a36]
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin C routed to IRQ 18
>        Region 4: I/O ports at 1f40 [size=32]
>        Capabilities: [50] PCIe advanced features <?>
>        Kernel driver in use: uhci_hcd
>
> 00:1d.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)
> USB2 EHCI Controller #1 [8086:3a3a] (prog-if 20)
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 23
>        Region 0: Memory at ff980000 (32-bit, non-prefetchable) [size=1K]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [58] Debug port: BAR=1 offset=00a0
>        Capabilities: [98] PCIe advanced features <?>
>        Kernel driver in use: ehci_hcd
>
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e]
> (rev 90) (prog-if 01)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: fff00000-000fffff
>        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [50] Subsystem: Dell Device [1028:026d]
>
> 00:1f.0 ISA bridge [0601]: Intel Corporation 82801JIR (ICH10R) LPC
> Interface Controller [8086:3a16]
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Capabilities: [e0] Vendor Specific Information <?>
>        Kernel modules: iTCO_wdt
>
> 00:1f.2 SATA controller [0106]: Intel Corporation 82801JI (ICH10 Family)
> SATA AHCI Controller [8086:3a22] (prog-if 01)
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin C routed to IRQ 20
>        Region 0: I/O ports at 1e00 [size=8]
>        Region 1: I/O ports at 1e10 [size=4]
>        Region 2: I/O ports at 1e20 [size=8]
>        Region 3: I/O ports at 1e30 [size=4]
>        Region 4: I/O ports at 1ec0 [size=32]
>        Region 5: Memory at f0100000 (32-bit, non-prefetchable) [size=2K]
>        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
> Queue=0/4 Enable-
>                Address: 00000000  Data: 0000
>        Capabilities: [70] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [a8] SATA HBA <?>
>        Capabilities: [b0] PCIe advanced features <?>
>        Kernel driver in use: ahci
>
> 00:1f.3 SMBus [0c05]: Intel Corporation 82801JI (ICH10 Family) SMBus
> Controller [8086:3a30]
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Interrupt: pin C routed to IRQ 3
>        Region 0: Memory at f7fff000 (64-bit, non-prefetchable) [size=256]
>        Region 4: I/O ports at cce0 [size=32]
>        Kernel modules: i2c-i801
>
> 01:00.0 PCI bridge [0604]: Pericom Semiconductor PCI Express to
> PCI-XPI7C9X130 PCI-X Bridge [12d8:e130] (rev 04)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: fff00000-000fffff
>        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [80] PCI-X bridge device
>                Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD-
> Freq=100MHz
>                Status: Dev=01:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
>                Upstream: Capacity=16 CommitmentLimit=16
>                Downstream: Capacity=16 CommitmentLimit=16
>        Capabilities: [90] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [a8] Subsystem: Gammagraphx, Inc. (or missing ID)
> Device [0000:0000]
>        Capabilities: [b0] Express (v1) PCI/PCI-X Bridge, MSI 00
>                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> BrConfRtry-
>                        MaxPayload 128 bytes, MaxReadReq 512 bytes
>                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1,
> Latency L0 <512ns, L1 <1us
>                        ClockPM- Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>        Capabilities: [f0] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [150] Virtual Channel <?>
>        Kernel modules: shpchp
>
> 03:00.0 VGA compatible controller [0300]: nVidia Corporation GT200GL
> [Quadro FX 4800] [10de:05fe] (rev a1)
>        Subsystem: nVidia Corporation Device [10de:0594]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 24
>        Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
>        Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
>        Region 3: Memory at f4000000 (64-bit, non-prefetchable) [size=32M]
>        Region 5: I/O ports at bc80 [size=128]
>        [virtual] Expansion ROM at f7e00000 [disabled] [size=512K]
>        Capabilities: [60] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [78] Express (v2) Endpoint, MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <4us
>                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+
> Unsupported-
>                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                        MaxPayload 128 bytes, MaxReadReq 512 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1,
> Latency L0 <256ns, L1 <1us
>                        ClockPM- Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk-
> DLActive- BWMgmt- ABWMgmt-
>        Capabilities: [100] Virtual Channel <?>
>        Capabilities: [128] Power Budgeting <?>
>        Capabilities: [600] Vendor Specific Information <?>
>        Kernel driver in use: nvidia
>        Kernel modules: nvidia, nvidiafb
>
> 04:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit
> Ethernet Controller [8086:105e] (rev 06)
>        Subsystem: Intel Corporation Device [8086:115e]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Interrupt: pin A routed to IRQ 30
>        Region 0: Memory at f3e80000 (32-bit, non-prefetchable) [size=128K]
>        Region 1: Memory at f3ea0000 (32-bit, non-prefetchable) [size=128K]
>        Region 2: I/O ports at acc0 [size=32]
>        Expansion ROM at f3f00000 [disabled] [size=128K]
>        Capabilities: [c8] Power Management version 2
>                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [e0] Express (v1) Endpoint, MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                        MaxPayload 256 bytes, MaxReadReq 512 bytes
>                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency
> L0 <4us, L1 <64us
>                        ClockPM- Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [140] Device Serial Number 56-49-ea-ff-ff-17-15-00
>        Kernel driver in use: e1000e
>        Kernel modules: e1000e
>
> 04:00.1 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit
> Ethernet Controller [8086:105e] (rev 06)
>        Subsystem: Intel Corporation Device [8086:115e]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Interrupt: pin B routed to IRQ 37
>        Region 0: Memory at f3ec0000 (32-bit, non-prefetchable) [size=128K]
>        Region 1: Memory at f3ee0000 (32-bit, non-prefetchable) [size=128K]
>        Region 2: I/O ports at ace0 [size=32]
>        Expansion ROM at f0000000 [disabled] [size=128K]
>        Capabilities: [c8] Power Management version 2
>                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [e0] Express (v1) Endpoint, MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                        MaxPayload 256 bytes, MaxReadReq 512 bytes
>                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency
> L0 <4us, L1 <64us
>                        ClockPM- Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [140] Device Serial Number 56-49-ea-ff-ff-17-15-00
>        Kernel driver in use: e1000e
>        Kernel modules: e1000e
>
> 05:00.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic SAS1068E
> PCI-Express Fusion-MPT SAS [1000:0058] (rev 08)
>        Subsystem: Dell Device [1028:021d]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Interrupt: pin A routed to IRQ 16
>        Region 0: I/O ports at 9c00 [size=256]
>        Region 1: Memory at f3bec000 (64-bit, non-prefetchable) [size=16K]
>        Region 3: Memory at f3bf0000 (64-bit, non-prefetchable) [size=64K]
>        Expansion ROM at f3c00000 [disabled] [size=1M]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [68] Express (v1) Endpoint, MSI 00
>                DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+
> Unsupported-
>                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                        MaxPayload 128 bytes, MaxReadReq 512 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1,
> Latency L0 <64ns, L1 <1us
>                        ClockPM- Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk-
> DLActive- BWMgmt- ABWMgmt-
>        Capabilities: [98] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [b0] MSI-X: Enable- Mask- TabSize=1
>                Vector table: BAR=1 offset=00002000
>                PBA: BAR=1 offset=00003000
>        Capabilities: [100] Advanced Error Reporting <?>
>        Kernel driver in use: mptsas
>        Kernel modules: mptsas
>
> 06:00.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme BCM5761
> Gigabit Ethernet PCIe [14e4:1681] (rev 10)
>        Subsystem: Dell Device [1028:026d]
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Interrupt: pin A routed to IRQ 17
>        Region 0: Memory at f3ae0000 (64-bit, non-prefetchable) [size=64K]
>        Region 2: Memory at f3af0000 (64-bit, non-prefetchable) [size=64K]
>        Capabilities: [48] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>        Capabilities: [40] Vital Product Data <?>
>        Capabilities: [60] Vendor Specific Information <?>
>        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>                Address: adedd895b6eff7d4  Data: fef6
>        Capabilities: [cc] Express (v2) Endpoint, MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us,
> L1 unlimited
>                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
>                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> Latency L0 <1us, L1 <64us
>                        ClockPM+ Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [13c] Virtual Channel <?>
>        Capabilities: [160] Device Serial Number 96-28-38-fe-ff-6f-ac-b8
>        Capabilities: [16c] Power Budgeting <?>
>        Kernel driver in use: tg3
>        Kernel modules: tg3
>
> 20:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI
> Express Root Port 3 [8086:340a] (rev 13)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=20, secondary=22, subordinate=22, sec-latency=0
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: dfe00000-dfffffff
>        Prefetchable memory behind bridge: 00000000df000000-00000000df0fffff
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Subsystem: Dell Device [1028:026d]
>        Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit-
> Queue=0/1 Enable-
>                Address: 00000000  Data: 0000
>                Masking: 00000000  Pending: 00000000
>        Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 256 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Latency
> L0 <512ns, L1 <64us
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surpise-
>                        Slot #  6, PowerLimit 25.000000; Interlock- NoCompl-
>                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
>                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>                        Changed: MRL- PresDet+ LinkState+
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [e0] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [150] Access Controls <?>
>        Capabilities: [160] Vendor Specific Information <?>
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
> 20:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI
> Express Root Port 7 [8086:340e] (rev 13)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=20, secondary=23, subordinate=23, sec-latency=0
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: dfd00000-dfdfffff
>        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Subsystem: Dell Device [1028:026d]
>        Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit-
> Queue=0/1 Enable-
>                Address: 00000000  Data: 0000
>                Masking: 00000000  Pending: 00000000
>        Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Latency
> L0 <512ns, L1 <64us
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surpise-
>                        Slot #  3, PowerLimit 40.000000; Interlock- NoCompl-
>                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
>                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
> Interlock-
>                        Changed: MRL- PresDet+ LinkState-
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [e0] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [150] Access Controls <?>
>        Capabilities: [160] Vendor Specific Information <?>
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
> 20:09.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI
> Express Root Port 9 [8086:3410] (rev 13)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Bus: primary=20, secondary=24, subordinate=24, sec-latency=0
>        I/O behind bridge: 0000f000-00000fff
>        Memory behind bridge: dfc00000-dfcfffff
>        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>        Capabilities: [40] Subsystem: Dell Device [1028:026d]
>        Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit-
> Queue=0/1 Enable-
>                Address: 00000000  Data: 0000
>                Masking: 00000000  Pending: 00000000
>        Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Latency
> L0 <512ns, L1 <64us
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt- ABWMgmt-
>                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surpise-
>                        Slot #  1, PowerLimit 40.000000; Interlock- NoCompl-
>                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
>                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>                        Changed: MRL- PresDet+ LinkState+
>                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                RootCap: CRSVisible-
>                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>        Capabilities: [e0] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [150] Access Controls <?>
>        Kernel driver in use: pcieport
>        Kernel modules: shpchp
>
> 20:14.0 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub System
> Management Registers [8086:342e] (rev 13)
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint,
> MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed unknown, Width x0, ASPM L0s, Latency
> L0 unlimited, L1 unlimited
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>
> 20:14.1 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub GPIO and
> Scratch Pad Registers [8086:3422] (rev 13)
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint,
> MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed unknown, Width x0, ASPM L0s, Latency
> L0 unlimited, L1 unlimited
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>
> 20:14.2 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Control Status
> and RAS Registers [8086:3423] (rev 13)
>        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint,
> MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                LnkCap: Port #0, Speed unknown, Width x0, ASPM L0s, Latency
> L0 unlimited, L1 unlimited
>                        ClockPM- Suprise+ LLActRep+ BwNot+
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>
> 22:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit
> Ethernet Controller [8086:105e] (rev 06)
>        Subsystem: Intel Corporation Device [8086:115e]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Interrupt: pin A routed to IRQ 48
>        Region 0: Memory at dfe80000 (32-bit, non-prefetchable) [size=128K]
>        Region 1: Memory at dfea0000 (32-bit, non-prefetchable) [size=128K]
>        Region 2: I/O ports at <ignored>
>        Expansion ROM at dff00000 [disabled] [size=128K]
>        Capabilities: [c8] Power Management version 2
>                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [e0] Express (v1) Endpoint, MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                        MaxPayload 256 bytes, MaxReadReq 512 bytes
>                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency
> L0 <4us, L1 <64us
>                        ClockPM- Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [140] Device Serial Number d6-48-ea-ff-ff-17-15-00
>        Kernel driver in use: e1000e
>        Kernel modules: e1000e
>
> 22:00.1 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit
> Ethernet Controller [8086:105e] (rev 06)
>        Subsystem: Intel Corporation Device [8086:115e]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Interrupt: pin B routed to IRQ 58
>        Region 0: Memory at dfec0000 (32-bit, non-prefetchable) [size=128K]
>        Region 1: Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
>        Region 2: I/O ports at <ignored>
>        Expansion ROM at df000000 [disabled] [size=128K]
>        Capabilities: [c8] Power Management version 2
>                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [e0] Express (v1) Endpoint, MSI 00
>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 <64us
>                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
>                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                        MaxPayload 256 bytes, MaxReadReq 512 bytes
>                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Latency
> L0 <4us, L1 <64us
>                        ClockPM- Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [140] Device Serial Number d6-48-ea-ff-ff-17-15-00
>        Kernel driver in use: e1000e
>        Kernel modules: e1000e
>
> 24:00.0 FireWire (IEEE 1394) [0c00]: VIA Technologies, Inc. VT6315 Series
> Firewire Controller [1106:3403] (prog-if 10)
>        Subsystem: VIA Technologies, Inc. VT6315 Series Firewire Controller
> [1106:3403]
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Interrupt: pin A routed to IRQ 56
>        Region 0: Memory at dfcff000 (64-bit, non-prefetchable) [size=2K]
>        Region 2: I/O ports at <ignored>
>        Capabilities: [50] Power Management version 3
>                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2+,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [80] Message Signalled Interrupts: Mask+ 64bit+
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>                Masking: 00000000  Pending: 00000000
>        Capabilities: [98] Express (v1) Endpoint, MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+
> Unsupported-
>                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                        MaxPayload 128 bytes, MaxReadReq 512 bytes
>                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
> Latency L0 <1us, L1 <64us
>                        ClockPM+ Suprise- LLActRep- BwNot-
>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
> CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk-
> DLActive- BWMgmt- ABWMgmt-
>        Capabilities: [100] Advanced Error Reporting <?>
>        Capabilities: [130] Device Serial Number 09-07-00-ff-ff-06-11-00
>        Kernel driver in use: ohci1394
>        Kernel modules: firewire-ohci, ohci1394
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: dmesg_2.6.35-ipipe
> Type: application/octet-stream
> Size: 64639 bytes
> Desc: not available
> Url : /public/xenomai-help/attachments/20101028/73105990/attachment.obj
>
> ------------------------------
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>
> End of Xenomai-help Digest, Vol 61, Issue 58
> ********************************************
>

--0016363b86f0fd94d80493b5b9d6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey there,<br><br>I followed the suggestions from the error message (which =
seems to be the reason for the hard disc slow down)<br><br>[44806.726625] i=
rq 16: nobody cared (try booting with the &quot;irqpoll&quot; option)<br>
<br>and added the &quot;irqpoll&quot; option to the kernel parameters. As o=
f now, the problem did not occur anymore. <br><br>We managed to reproduce t=
he event (somehow deterministically) by starting the rt-task that communica=
tes on the can bus at a high rate. However, after adding the irqpoll parame=
ter, the problematic event does not occur anymore.<br>
We found that the irqpoll option may &quot;significantly impact system perf=
ormance&quot;, however, we are wondering in how much this influences our pe=
rformance in xenomai.<br><br>[=A0=A0=A0 0.000000] Kernel command line: BOOT=
_IMAGE=3D/boot/vmlinuz-2.6.31.4-ipipe-2.5.4 root=3DUUID=3D70377358-b8ed-469=
6-a5f2-d7d5ded856e9 ro xeno_nucleus.xenomai_gid=3D1002 quiet splash irqpoll=
<br>
[=A0=A0=A0 0.000000] Misrouted IRQ fixup and polling support enabled<br>[=
=A0=A0=A0 0.000000] This may significantly impact system performance<br><br=
>It seems that the problem is (also) triggered when a heavy load on the usb=
 device is applied. We are controlling some motors through usb (in non-real=
-time).<br>
<br>Thanks,<br>=A0peter<br><br><br><br><div class=3D"gmail_quote">On Thu, O=
ct 28, 2010 at 12:21 PM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:xenomai-h=
elp-request@domain.hid" target=3D"_blank">xenomai-help-request@domain.hid</a>&gt;=
</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Send Xenomai-help=
 mailing list submissions to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:xenomai@xenomai.org" target=3D"_blank">x=
enomai-help@domain.hid</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
 =A0 =A0 =A0 =A0<a href=3D"https://mail.gna.org/listinfo/xenomai-help" targ=
et=3D"_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:xenomai-help-request@domain.hid" target=3D"_=
blank">xenomai-help-request@domain.hid</a><br>
<br>
You can reach the person managing the list at<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:xenomai-help-owner@domain.hid" target=3D"_bl=
ank">xenomai-help-owner@domain.hid</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of Xenomai-help digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
 =A0 1. BeagleBoard-XM (Michel He)<br>
 =A0 2. Re: Slow hard drive access in xenomai (Peter Pastor)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Thu, 28 Oct 2010 16:37:05 +0200<br>
From: Michel He &lt;<a href=3D"mailto:michel.he@domain.hid" target=3D"_blan=
k">michel.he@domain.hid</a>&gt;<br>
Subject: [Xenomai-help] BeagleBoard-XM<br>
To: <a href=3D"mailto:xenomai@xenomai.org" target=3D"_blank">xenomai-help@=
gna.org</a><br>
Message-ID: &lt;<a href=3D"mailto:20101028163705.18211an5ytg9yv1c@domain.hid=
tc.fr" target=3D"_blank">20101028163705.18211an5ytg9yv1c@domain.hid</a>=
&gt;<br>
Content-Type: text/plain; charset=3DISO-8859-1; DelSp=3D&quot;Yes&quot;;<br=
>
 =A0 =A0 =A0 =A0format=3D&quot;flowed&quot;<br>
<br>
hello all,<br>
<br>
 =A0 =A0I wonder whether anybody have ever tested Xenomai on the<br>
BeagleBoard-XM (OMAP DM3730) or the no XM version (OMAP 3530). Are the<br>
dsplink and examples fully working ?<br>
<br>
<br>
thanks<br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Thu, 28 Oct 2010 12:20:41 -0700<br>
From: Peter Pastor &lt;<a href=3D"mailto:peter.pastor@domain.hid" target=3D"=
_blank">peter.pastor@domain.hid</a>&gt;<br>
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai<br>
To: Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.org" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;,<br>
 =A0 =A0 =A0 =A0<a href=3D"mailto:xenomai@xenomai.org" target=3D"_blank">x=
enomai-help@domain.hid</a><br>
Message-ID:<br>
 =A0 =A0 =A0 =A0&lt;AANLkTi=3D5YF3QnvK9iGpBs8enuA+=3D<a href=3D"mailto:MHz7=
gKjE1p_3whM%2B@mail.gmail.com" target=3D"_blank">MHz7gKjE1p_3whM+@mail.gmai=
l.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;iso-8859-1&quot;<br>
<br>
Hey Gilles,<br>
<br>
&gt;&gt; dmesg_fine is not fine at all. The SATA drives attached to the &qu=
ot;ioc&quot; SAS<br>
&gt;&gt; controller, seem to experience continuous errors. And since this<b=
r>
&gt;&gt; interrupt line is shared with the HDA driver, there is something<b=
r>
&gt;&gt; suspicious here. You can know which one of the two drivers has iss=
ues by<br>
&gt;&gt; disabling one of them.<br>
I agree with you in that the SATA drives may cause the problem, since they<=
br>
are attached to the &quot;ioc&quot; SAS controller which has IRQ 16 assigne=
d.<br>
However, apparently according to<br>
<br>
<a href=3D"http://www.mail-archive.com/debian-bugs-dist@domain.hid=
g773045.html" target=3D"_blank">http://www.mail-archive.com/debian-bugs-dis=
t@domain.hid</a><br>
<br>
the error message in the log is not a problem. In fact, when running kernel=
<br>
2.6.35 the error message does not get displayed anymore. However, when<br>
running 2.6.35 we get an error message during booting (see<br>
dmesg_2.6.35-ipipe).<br>
...<br>
[ =A0 =A02.047634] pci_root PNP0A03:00: address space collision: host bridg=
e<br>
window [mem 0xd7f00000-0xe0000000] conflicts with PCI Bus 0000:00 [mem<br>
0xe0000000-0xf7ffffff]<br>
...<br>
[ =A0 =A03.118005] pci 0000:20:03.0: address space collision: [io<br>
0xe000-0xefff] conflicts with PCI Bus 0000:00 [io =A00xd000-0xffff]<br>
[ =A0 =A03.118007] pci 0000:20:09.0: address space collision: [io<br>
0xd000-0xdfff] conflicts with PCI Bus 0000:00 [io =A00xd000-0xffff]<br>
...<br>
<br>
The devices in conflict are... not sure whether this is the cause of the<br=
>
slow hard disc access though. (see attached lspci.txt)<br>
00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port<br>
[8086:3406] (rev 13)<br>
20:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI<br>
Express Root Port 3 [8086:340a] (rev 13)<br>
20:09.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI<br>
Express Root Port 9 [8086:3410] (rev 13)<br>
<br>
&gt;&gt; Also, Linux seems to complain that it sees 32 cpus whereas you lim=
ited<br>
&gt;&gt; the number of cpus to 8.<br>
I set it back to 64 and recompiled the kernel, let&#39;s see whether this m=
akes<br>
a difference.<br>
[ =A0 =A00.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:3=
2<br>
nr_node_ids:1<br>
[ =A0 =A00.000000] early_res array is doubled to 128 at [2b800 - 2c7ff]<br>
...<br>
<br>
I would like to switch of either of the two devices that are attached to IR=
Q<br>
16, the problem however is, I need both. I am not sure whether disabling th=
e<br>
USB controller in the BIOS is a good idea, since the computer does not have=
<br>
any other ways to attach a keyboard (and mouse) in case I want to enable it=
<br>
in the BIOS again.<br>
<br>
Also, to test whether the problem is related to the PCI can bus card, I<br>
removed the can bus card from the computer and see whether the &quot;event&=
quot;<br>
occurs again.<br>
<br>
Thanks for any help with this,<br>
=A0peter<br>
<br>
<br>
<br>
On Mon, Oct 25, 2010 at 10:22 PM, Gilles Chanteperdrix &lt;<br>
<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_blank">gille=
s.chanteperdrix@domain.hid</a>&gt; wrote:<br>
<br>
&gt; Peter Pastor wrote:<br>
&gt; &gt; Hey Gilles,<br>
&gt; &gt;<br>
&gt; &gt; Thanks for you prompt response !<br>
&gt; &gt;<br>
&gt; &gt; I noticed that the problem of slow hard disc access does happen a=
fter<br>
&gt; &gt; a certain event. Right after booting xenomai &quot;hdparam -t&quo=
t; gives me<br>
&gt; &gt; 120MB/s which is what I get when running the non-real-time kernel=
.<br>
&gt; &gt; Even when I run my real-time tasks everything seems to be fine.<b=
r>
&gt; &gt; However, I just had the case that I tried to play a sound (just f=
or<br>
&gt; &gt; testing) which triggered some output in the dmesg (see attached<b=
r>
&gt; &gt; xenomai_problem.txt). The output of dmesg up to this point is<br>
&gt; &gt; contained in xenomai_fine.txt and the dmesg log of the non-real-t=
ime<br>
&gt; &gt; linux kernel is in dmesg_linux.txt.<br>
&gt; &gt;<br>
&gt; &gt; I disabled the audio card again and as of now, I haven&#39;t seen=
 that<br>
&gt; &gt; problem. I can&#39;t really make sense out of what dmesg spit out=
. Would<br>
&gt; &gt; be great if someone could shine some light on this. It would be g=
reat<br>
&gt; &gt; if someone could let me know whether disabling the sound card sol=
ved<br>
&gt; &gt; the problem.<br>
&gt; &gt;<br>
&gt; &gt;&gt;&gt; Do you really need things like NUMA, SPARSEMEM, SECCOMP, =
AUDITSYSCALL,<br>
&gt; &gt;&gt;&gt; KPROBES, FTRACE, SELINUX?<br>
&gt; &gt; I am actually not sure what all these options mean, I also haven&=
#39;t<br>
&gt; &gt; spend time to figure things out. What impact could disabling thes=
e<br>
&gt; &gt; options have ? Do they decrease latency? address the problem abov=
e?<br>
&gt; &gt; other things?<br>
&gt;<br>
&gt; dmesg_fine is not fine at all. The SATA drives attached to the &quot;i=
oc&quot; SAS<br>
&gt; controller, seem to experience continuous errors. And since this<br>
&gt; interrupt line is shared with the HDA driver, there is something<br>
&gt; suspicious here. You can know which one of the two drivers has issues =
by<br>
&gt; disabling one of them.<br>
&gt;<br>
&gt; Also, Linux seems to complain that it sees 32 cpus whereas you limited=
<br>
&gt; the number of cpus to 8.<br>
&gt;<br>
&gt; --<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.<br>
&gt;<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
URL: /public/xenomai-help/attachments/20101028/73105990/attachment.htm<br>
-------------- next part --------------<br>
00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port [808=
6:3406] (rev 13)<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 11<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Message Signalled Interrupts: Mask+ 64bi=
t- Queue=3D0/1 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x4, A=
SPM L0s, Latency L0 &lt;512ns, L1 &lt;4us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive+ BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [150] Access Controls &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [160] Vendor Specific Information &lt;?&gt;<b=
r>
<br>
00:01.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Expr=
ess Root Port 1 [8086:3408] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D00, secondary=3D01, subordinate=3D02, sec-la=
tency=3D0<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000f000-00000fff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: f3d00000-f3dfffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000fff00000-0000000=
0000fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Message Signalled Interrupts: Mask+ 64bi=
t- Queue=3D0/1 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Express (v2) Root Port (Slot-), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 5GT/s, Width x4, ASP=
M L0s L1, Latency L0 &lt;512ns, L1 &lt;4us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive+ BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [150] Access Controls &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [160] Vendor Specific Information &lt;?&gt;<b=
r>
 =A0 =A0 =A0 =A0Kernel driver in use: pcieport<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
00:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Expr=
ess Root Port 3 [8086:340a] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-la=
tency=3D0<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000b000-0000bfff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: f4000000-f7efffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000e0000000-0000000=
0efffffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Message Signalled Interrupts: Mask+ 64bi=
t- Queue=3D0/1 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr+ UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 5GT/s, Width x16, AS=
PM L0s L1, Latency L0 &lt;512ns, L1 &lt;4us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 5GT/s, Width x16, TrErr- Trai=
n- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- Pwr=
Ind- HotPlug- Surpise-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Slot # =A02, PowerLimit 242=
.000000; Interlock- NoCompl-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresD=
et- CmdCplt- HPIrq- LinkChg-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Control: AttnInd Off, PwrIn=
d Off, Power- Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltSta: Status: AttnBtn- PowerFlt- MRL- Cmd=
Cplt- PresDet+ Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Changed: MRL- PresDet+ Link=
State+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [150] Access Controls &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [160] Vendor Specific Information &lt;?&gt;<b=
r>
 =A0 =A0 =A0 =A0Kernel driver in use: pcieport<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
00:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Expr=
ess Root Port 7 [8086:340e] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-la=
tency=3D0<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000a000-0000afff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: f3e00000-f3ffffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000f0000000-0000000=
0f00fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Message Signalled Interrupts: Mask+ 64bi=
t- Queue=3D0/1 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 256 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 5GT/s, Width x16, AS=
PM L0s L1, Latency L0 &lt;512ns, L1 &lt;4us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive+ BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- Pwr=
Ind- HotPlug- Surpise-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Slot # =A04, PowerLimit 225=
.000000; Interlock- NoCompl-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresD=
et- CmdCplt- HPIrq- LinkChg-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Control: AttnInd Off, PwrIn=
d Off, Power- Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltSta: Status: AttnBtn- PowerFlt- MRL- Cmd=
Cplt- PresDet+ Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Changed: MRL- PresDet+ Link=
State+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [150] Access Controls &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [160] Vendor Specific Information &lt;?&gt;<b=
r>
 =A0 =A0 =A0 =A0Kernel driver in use: pcieport<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
00:14.0 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub System Manageme=
nt Registers [8086:342e] (rev 13)<br>
 =A0 =A0 =A0 =A0Subsystem: Device [0028:006d]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Express (v2) Root Complex Integrated End=
point, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed unknown, Width x0, A=
SPM L0s, Latency L0 unlimited, L1 unlimited<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; Disabled- Retrain- C=
ommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed unknown, Width x0, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
<br>
00:14.1 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub GPIO and Scratc=
h Pad Registers [8086:3422] (rev 13)<br>
 =A0 =A0 =A0 =A0Subsystem: Device [0028:006d]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Express (v2) Root Complex Integrated End=
point, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed unknown, Width x0, A=
SPM L0s, Latency L0 unlimited, L1 unlimited<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; Disabled- Retrain- C=
ommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed unknown, Width x0, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
<br>
00:14.2 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Control Status =
and RAS Registers [8086:3423] (rev 13)<br>
 =A0 =A0 =A0 =A0Subsystem: Device [0028:006d]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Express (v2) Root Complex Integrated End=
point, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed unknown, Width x0, A=
SPM L0s, Latency L0 unlimited, L1 unlimited<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; Disabled- Retrain- C=
ommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed unknown, Width x0, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
<br>
00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB=
 UHCI Controller #4 [8086:3a37]<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 16<br>
 =A0 =A0 =A0 =A0Region 4: I/O ports at 1f20 [size=3D32]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: uhci_hcd<br>
<br>
00:1a.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB=
 UHCI Controller #5 [8086:3a38]<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin B routed to IRQ 17<br>
 =A0 =A0 =A0 =A0Region 4: I/O ports at 1f00 [size=3D32]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: uhci_hcd<br>
<br>
00:1a.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB=
 UHCI Controller #6 [8086:3a39]<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin C routed to IRQ 22<br>
 =A0 =A0 =A0 =A0Region 4: I/O ports at 1c00 [size=3D32]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: uhci_hcd<br>
<br>
00:1a.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB=
2 EHCI Controller #2 [8086:3a3c] (prog-if 20)<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin C routed to IRQ 22<br>
 =A0 =A0 =A0 =A0Region 0: Memory at f7ffe000 (32-bit, non-prefetchable) [si=
ze=3D1K]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D37=
5mA PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0<br>
 =A0 =A0 =A0 =A0Capabilities: [98] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: ehci_hcd<br>
<br>
00:1c.0 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI Exp=
ress Port 1 [8086:3a40]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-la=
tency=3D0<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 00009000-00009fff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: f3b00000-f3cfffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000fff00000-0000000=
0000fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #1, Speed 2.5GT/s, Width x4, A=
SPM unknown, Latency L0 &lt;256ns, L1 &lt;4us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep+=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disab=
led- Retrain- CommClk+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive+ BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [80] Message Signalled Interrupts: Mask- 64bi=
t- Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Capabilities: [a0] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Virtual Channel &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [180] Root Complex Link &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: pcieport<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
00:1c.5 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI Exp=
ress Port 6 [8086:3a4a]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-la=
tency=3D0<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000f000-00000fff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: f3a00000-f3afffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000fff00000-0000000=
0000fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #6, Speed 2.5GT/s, Width x1, A=
SPM L0s L1, Latency L0 &lt;256ns, L1 &lt;4us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep+=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes D=
isabled- Retrain- CommClk+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x1, TrErr- Tra=
in- SlotClk+ DLActive+ BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [80] Message Signalled Interrupts: Mask- 64bi=
t- Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Capabilities: [a0] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Virtual Channel &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [180] Root Complex Link &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: pcieport<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
00:1d.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB=
 UHCI Controller #1 [8086:3a34]<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 23<br>
 =A0 =A0 =A0 =A0Region 4: I/O ports at 1f80 [size=3D32]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: uhci_hcd<br>
<br>
00:1d.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB=
 UHCI Controller #2 [8086:3a35]<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin B routed to IRQ 17<br>
 =A0 =A0 =A0 =A0Region 4: I/O ports at 1f60 [size=3D32]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: uhci_hcd<br>
<br>
00:1d.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB=
 UHCI Controller #3 [8086:3a36]<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin C routed to IRQ 18<br>
 =A0 =A0 =A0 =A0Region 4: I/O ports at 1f40 [size=3D32]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: uhci_hcd<br>
<br>
00:1d.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family) USB=
2 EHCI Controller #1 [8086:3a3a] (prog-if 20)<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 23<br>
 =A0 =A0 =A0 =A0Region 0: Memory at ff980000 (32-bit, non-prefetchable) [si=
ze=3D1K]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D37=
5mA PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0<br>
 =A0 =A0 =A0 =A0Capabilities: [98] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: ehci_hcd<br>
<br>
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e] (=
rev 90) (prog-if 01)<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Bus: primary=3D00, secondary=3D07, subordinate=3D07, sec-la=
tency=3D32<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000f000-00000fff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: fff00000-000fffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000fff00000-0000000=
0000fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [50] Subsystem: Dell Device [1028:026d]<br>
<br>
00:1f.0 ISA bridge [0601]: Intel Corporation 82801JIR (ICH10R) LPC Interfac=
e Controller [8086:3a16]<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Vendor Specific Information &lt;?&gt;<br=
>
 =A0 =A0 =A0 =A0Kernel modules: iTCO_wdt<br>
<br>
00:1f.2 SATA controller [0106]: Intel Corporation 82801JI (ICH10 Family) SA=
TA AHCI Controller [8086:3a22] (prog-if 01)<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin C routed to IRQ 20<br>
 =A0 =A0 =A0 =A0Region 0: I/O ports at 1e00 [size=3D8]<br>
 =A0 =A0 =A0 =A0Region 1: I/O ports at 1e10 [size=3D4]<br>
 =A0 =A0 =A0 =A0Region 2: I/O ports at 1e20 [size=3D8]<br>
 =A0 =A0 =A0 =A0Region 3: I/O ports at 1e30 [size=3D4]<br>
 =A0 =A0 =A0 =A0Region 4: I/O ports at 1ec0 [size=3D32]<br>
 =A0 =A0 =A0 =A0Region 5: Memory at f0100000 (32-bit, non-prefetchable) [si=
ze=3D2K]<br>
 =A0 =A0 =A0 =A0Capabilities: [80] Message Signalled Interrupts: Mask- 64bi=
t- Queue=3D0/4 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [70] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0-,D1-,D2-,D3hot+,D3cold-)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [a8] SATA HBA &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [b0] PCIe advanced features &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: ahci<br>
<br>
00:1f.3 SMBus [0c05]: Intel Corporation 82801JI (ICH10 Family) SMBus Contro=
ller [8086:3a30]<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Interrupt: pin C routed to IRQ 3<br>
 =A0 =A0 =A0 =A0Region 0: Memory at f7fff000 (64-bit, non-prefetchable) [si=
ze=3D256]<br>
 =A0 =A0 =A0 =A0Region 4: I/O ports at cce0 [size=3D32]<br>
 =A0 =A0 =A0 =A0Kernel modules: i2c-i801<br>
<br>
01:00.0 PCI bridge [0604]: Pericom Semiconductor PCI Express to PCI-XPI7C9X=
130 PCI-X Bridge [12d8:e130] (rev 04)<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D01, secondary=3D02, subordinate=3D02, sec-la=
tency=3D64<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000f000-00000fff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: fff00000-000fffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000fff00000-0000000=
0000fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium &=
gt;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [80] PCI-X bridge device<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Secondary Status: 64bit+ 133MHz+ SCD- USC- =
SCO- SRD- Freq=3D100MHz<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: Dev=3D01:00.0 64bit- 133MHz- SCD- U=
SC- SCO- SRD-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Upstream: Capacity=3D16 CommitmentLimit=3D1=
6<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Downstream: Capacity=3D16 CommitmentLimit=
=3D16<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55=
mA PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [a8] Subsystem: Gammagraphx, Inc. (or missing=
 ID) Device [0000:0000]<br>
 =A0 =A0 =A0 =A0Capabilities: [b0] Express (v1) PCI/PCI-X Bridge, MSI 00<br=
>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 512 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ AttnBtn- AttnInd- P=
wrInd- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop- BrConfRtry-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 512 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr+ FatalErr- Unsup=
pReq- AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x4, A=
SPM L0s L1, Latency L0 &lt;512ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; Disabled- Retrain- C=
ommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive+ BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [f0] Message Signalled Interrupts: Mask- 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [150] Virtual Channel &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
03:00.0 VGA compatible controller [0300]: nVidia Corporation GT200GL [Quadr=
o FX 4800] [10de:05fe] (rev a1)<br>
 =A0 =A0 =A0 =A0Subsystem: nVidia Corporation Device [10de:0594]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 24<br>
 =A0 =A0 =A0 =A0Region 0: Memory at f6000000 (32-bit, non-prefetchable) [si=
ze=3D16M]<br>
 =A0 =A0 =A0 =A0Region 1: Memory at e0000000 (64-bit, prefetchable) [size=
=3D256M]<br>
 =A0 =A0 =A0 =A0Region 3: Memory at f4000000 (64-bit, non-prefetchable) [si=
ze=3D32M]<br>
 =A0 =A0 =A0 =A0Region 5: I/O ports at bc80 [size=3D128]<br>
 =A0 =A0 =A0 =A0[virtual] Expansion ROM at f7e00000 [disabled] [size=3D512K=
]<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0-,D1-,D2-,D3hot-,D3cold-)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [68] Message Signalled Interrupts: Mask- 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [78] Express (v2) Endpoint, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;512ns, L1 &lt;4us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ AttnBtn- AttnInd- P=
wrInd- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al+ Fatal+ Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd+ ExtTag+ PhantFunc-=
 AuxPwr- NoSnoop+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 512 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 5GT/s, Width x16, AS=
PM L0s L1, Latency L0 &lt;256ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 5GT/s, Width x16, TrErr- Trai=
n- SlotClk- DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Virtual Channel &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [128] Power Budgeting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [600] Vendor Specific Information &lt;?&gt;<b=
r>
 =A0 =A0 =A0 =A0Kernel driver in use: nvidia<br>
 =A0 =A0 =A0 =A0Kernel modules: nvidia, nvidiafb<br>
<br>
04:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit Ether=
net Controller [8086:105e] (rev 06)<br>
 =A0 =A0 =A0 =A0Subsystem: Intel Corporation Device [8086:115e]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 30<br>
 =A0 =A0 =A0 =A0Region 0: Memory at f3e80000 (32-bit, non-prefetchable) [si=
ze=3D128K]<br>
 =A0 =A0 =A0 =A0Region 1: Memory at f3ea0000 (32-bit, non-prefetchable) [si=
ze=3D128K]<br>
 =A0 =A0 =A0 =A0Region 2: I/O ports at acc0 [size=3D32]<br>
 =A0 =A0 =A0 =A0Expansion ROM at f3f00000 [disabled] [size=3D128K]<br>
 =A0 =A0 =A0 =A0Capabilities: [c8] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D1 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [d0] Message Signalled Interrupts: Mask- 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Express (v1) Endpoint, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;512ns, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- AttnBtn- AttnInd- P=
wrInd- RBE- FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable+ Non-Fat=
al+ Fatal+ Unsupported+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd+ ExtTag- PhantFunc-=
 AuxPwr- NoSnoop+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 256 bytes, MaxRe=
adReq 512 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr+ FatalErr- Unsup=
pReq+ AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x4, A=
SPM L0s, Latency L0 &lt;4us, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [140] Device Serial Number 56-49-ea-ff-ff-17-=
15-00<br>
 =A0 =A0 =A0 =A0Kernel driver in use: e1000e<br>
 =A0 =A0 =A0 =A0Kernel modules: e1000e<br>
<br>
04:00.1 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit Ether=
net Controller [8086:105e] (rev 06)<br>
 =A0 =A0 =A0 =A0Subsystem: Intel Corporation Device [8086:115e]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Interrupt: pin B routed to IRQ 37<br>
 =A0 =A0 =A0 =A0Region 0: Memory at f3ec0000 (32-bit, non-prefetchable) [si=
ze=3D128K]<br>
 =A0 =A0 =A0 =A0Region 1: Memory at f3ee0000 (32-bit, non-prefetchable) [si=
ze=3D128K]<br>
 =A0 =A0 =A0 =A0Region 2: I/O ports at ace0 [size=3D32]<br>
 =A0 =A0 =A0 =A0Expansion ROM at f0000000 [disabled] [size=3D128K]<br>
 =A0 =A0 =A0 =A0Capabilities: [c8] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D1 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [d0] Message Signalled Interrupts: Mask- 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Express (v1) Endpoint, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;512ns, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- AttnBtn- AttnInd- P=
wrInd- RBE- FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable+ Non-Fat=
al+ Fatal+ Unsupported+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd+ ExtTag- PhantFunc-=
 AuxPwr- NoSnoop+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 256 bytes, MaxRe=
adReq 512 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr+ FatalErr- Unsup=
pReq+ AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x4, A=
SPM L0s, Latency L0 &lt;4us, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [140] Device Serial Number 56-49-ea-ff-ff-17-=
15-00<br>
 =A0 =A0 =A0 =A0Kernel driver in use: e1000e<br>
 =A0 =A0 =A0 =A0Kernel modules: e1000e<br>
<br>
05:00.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic SAS1068E =
PCI-Express Fusion-MPT SAS [1000:0058] (rev 08)<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:021d]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 16<br>
 =A0 =A0 =A0 =A0Region 0: I/O ports at 9c00 [size=3D256]<br>
 =A0 =A0 =A0 =A0Region 1: Memory at f3bec000 (64-bit, non-prefetchable) [si=
ze=3D16K]<br>
 =A0 =A0 =A0 =A0Region 3: Memory at f3bf0000 (64-bit, non-prefetchable) [si=
ze=3D64K]<br>
 =A0 =A0 =A0 =A0Expansion ROM at f3c00000 [disabled] [size=3D1M]<br>
 =A0 =A0 =A0 =A0Capabilities: [50] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0m=
A PME(D0-,D1-,D2-,D3hot-,D3cold-)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [68] Express (v1) Endpoint, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 4096 bytes, PhantFunc 0,=
 Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ AttnBtn- AttnInd- P=
wrInd- RBE- FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al+ Fatal+ Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd+ ExtTag- PhantFunc-=
 AuxPwr- NoSnoop+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 512 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x8, A=
SPM L0s L1, Latency L0 &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disab=
led- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk- DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [98] Message Signalled Interrupts: Mask- 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [b0] MSI-X: Enable- Mask- TabSize=3D1<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Vector table: BAR=3D1 offset=3D00002000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PBA: BAR=3D1 offset=3D00003000<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: mptsas<br>
 =A0 =A0 =A0 =A0Kernel modules: mptsas<br>
<br>
06:00.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme BCM5761 =
Gigabit Ethernet PCIe [14e4:1681] (rev 10)<br>
 =A0 =A0 =A0 =A0Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 17<br>
 =A0 =A0 =A0 =A0Region 0: Memory at f3ae0000 (64-bit, non-prefetchable) [si=
ze=3D64K]<br>
 =A0 =A0 =A0 =A0Region 2: Memory at f3af0000 (64-bit, non-prefetchable) [si=
ze=3D64K]<br>
 =A0 =A0 =A0 =A0Capabilities: [48] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0-,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D1 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Vital Product Data &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Vendor Specific Information &lt;?&gt;<br=
>
 =A0 =A0 =A0 =A0Capabilities: [50] Message Signalled Interrupts: Mask- 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: adedd895b6eff7d4 =A0Data: fef6<br>
 =A0 =A0 =A0 =A0Capabilities: [cc] Express (v2) Endpoint, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;4us, L1 unlimited<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ AttnBtn- AttnInd- P=
wrInd- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al+ Fatal+ Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 4096 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr+ UncorrErr- FatalErr- Unsup=
pReq- AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x1, A=
SPM L0s L1, Latency L0 &lt;1us, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM+ Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes D=
isabled- Retrain- CommClk+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x1, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [13c] Virtual Channel &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [160] Device Serial Number 96-28-38-fe-ff-6f-=
ac-b8<br>
 =A0 =A0 =A0 =A0Capabilities: [16c] Power Budgeting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: tg3<br>
 =A0 =A0 =A0 =A0Kernel modules: tg3<br>
<br>
20:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Expr=
ess Root Port 3 [8086:340a] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D20, secondary=3D22, subordinate=3D22, sec-la=
tency=3D0<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000f000-00000fff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: dfe00000-dfffffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000df000000-0000000=
0df0fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Message Signalled Interrupts: Mask+ 64bi=
t- Queue=3D0/1 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 256 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 5GT/s, Width x4, ASP=
M L0s L1, Latency L0 &lt;512ns, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive+ BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- Pwr=
Ind- HotPlug- Surpise-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Slot # =A06, PowerLimit 25.=
000000; Interlock- NoCompl-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresD=
et- CmdCplt- HPIrq- LinkChg-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Control: AttnInd Off, PwrIn=
d Off, Power- Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltSta: Status: AttnBtn- PowerFlt- MRL- Cmd=
Cplt- PresDet+ Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Changed: MRL- PresDet+ Link=
State+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [150] Access Controls &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [160] Vendor Specific Information &lt;?&gt;<b=
r>
 =A0 =A0 =A0 =A0Kernel driver in use: pcieport<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
20:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Expr=
ess Root Port 7 [8086:340e] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D20, secondary=3D23, subordinate=3D23, sec-la=
tency=3D0<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000f000-00000fff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: dfd00000-dfdfffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000fff00000-0000000=
0000fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Message Signalled Interrupts: Mask+ 64bi=
t- Queue=3D0/1 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 5GT/s, Width x4, ASP=
M L0s L1, Latency L0 &lt;512ns, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x0, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- Pwr=
Ind- HotPlug- Surpise-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Slot # =A03, PowerLimit 40.=
000000; Interlock- NoCompl-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresD=
et- CmdCplt- HPIrq- LinkChg-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Control: AttnInd Off, PwrIn=
d Off, Power- Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltSta: Status: AttnBtn- PowerFlt- MRL- Cmd=
Cplt- PresDet- Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Changed: MRL- PresDet+ Link=
State-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [150] Access Controls &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [160] Vendor Specific Information &lt;?&gt;<b=
r>
 =A0 =A0 =A0 =A0Kernel driver in use: pcieport<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
20:09.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Expr=
ess Root Port 9 [8086:3410] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR+ FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Bus: primary=3D20, secondary=3D24, subordinate=3D24, sec-la=
tency=3D0<br>
 =A0 =A0 =A0 =A0I/O behind bridge: 0000f000-00000fff<br>
 =A0 =A0 =A0 =A0Memory behind bridge: dfc00000-dfcfffff<br>
 =A0 =A0 =A0 =A0Prefetchable memory behind bridge: 00000000fff00000-0000000=
0000fffff<br>
 =A0 =A0 =A0 =A0Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &lt;SERR- &lt;PERR-<br>
 =A0 =A0 =A0 =A0BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- &gt;Reset- Fas=
tB2B-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTm=
rSERREn-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Subsystem: Dell Device [1028:026d]<br>
 =A0 =A0 =A0 =A0Capabilities: [60] Message Signalled Interrupts: Mask+ 64bi=
t- Queue=3D0/1 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 00000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000<br>
 =A0 =A0 =A0 =A0Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag+ RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 5GT/s, Width x4, ASP=
M L0s L1, Latency L0 &lt;512ns, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x1, TrErr- Tra=
in- SlotClk+ DLActive+ BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- Pwr=
Ind- HotPlug- Surpise-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Slot # =A01, PowerLimit 40.=
000000; Interlock- NoCompl-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresD=
et- CmdCplt- HPIrq- LinkChg-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Control: AttnInd Off, PwrIn=
d Off, Power- Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SltSta: Status: AttnBtn- PowerFlt- MRL- Cmd=
Cplt- PresDet+ Interlock-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Changed: MRL- PresDet+ Link=
State+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCtl: ErrCorrectable- ErrNon-Fatal- ErrF=
atal- PMEIntEna- CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootCap: CRSVisible-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RootSta: PME ReqID 0000, PMEStatus- PMEPend=
ing-<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [150] Access Controls &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Kernel driver in use: pcieport<br>
 =A0 =A0 =A0 =A0Kernel modules: shpchp<br>
<br>
20:14.0 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub System Manageme=
nt Registers [8086:342e] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Express (v2) Root Complex Integrated End=
point, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed unknown, Width x0, A=
SPM L0s, Latency L0 unlimited, L1 unlimited<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; Disabled- Retrain- C=
ommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed unknown, Width x0, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
<br>
20:14.1 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub GPIO and Scratc=
h Pad Registers [8086:3422] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Express (v2) Root Complex Integrated End=
point, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed unknown, Width x0, A=
SPM L0s, Latency L0 unlimited, L1 unlimited<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; Disabled- Retrain- C=
ommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed unknown, Width x0, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
<br>
20:14.2 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Control Status =
and RAS Registers [8086:3423] (rev 13)<br>
 =A0 =A0 =A0 =A0Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Capabilities: [40] Express (v2) Root Complex Integrated End=
point, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 128 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr- TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed unknown, Width x0, A=
SPM L0s, Latency L0 unlimited, L1 unlimited<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise+ LLActRep+=
 BwNot+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; Disabled- Retrain- C=
ommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed unknown, Width x0, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
<br>
22:00.0 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit Ether=
net Controller [8086:105e] (rev 06)<br>
 =A0 =A0 =A0 =A0Subsystem: Intel Corporation Device [8086:115e]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 48<br>
 =A0 =A0 =A0 =A0Region 0: Memory at dfe80000 (32-bit, non-prefetchable) [si=
ze=3D128K]<br>
 =A0 =A0 =A0 =A0Region 1: Memory at dfea0000 (32-bit, non-prefetchable) [si=
ze=3D128K]<br>
 =A0 =A0 =A0 =A0Region 2: I/O ports at &lt;ignored&gt;<br>
 =A0 =A0 =A0 =A0Expansion ROM at dff00000 [disabled] [size=3D128K]<br>
 =A0 =A0 =A0 =A0Capabilities: [c8] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D1 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [d0] Message Signalled Interrupts: Mask- 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Express (v1) Endpoint, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;512ns, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- AttnBtn- AttnInd- P=
wrInd- RBE- FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable+ Non-Fat=
al+ Fatal+ Unsupported+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd+ ExtTag- PhantFunc-=
 AuxPwr- NoSnoop+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 256 bytes, MaxRe=
adReq 512 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr+ FatalErr- Unsup=
pReq+ AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x4, A=
SPM L0s, Latency L0 &lt;4us, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [140] Device Serial Number d6-48-ea-ff-ff-17-=
15-00<br>
 =A0 =A0 =A0 =A0Kernel driver in use: e1000e<br>
 =A0 =A0 =A0 =A0Kernel modules: e1000e<br>
<br>
22:00.1 Ethernet controller [0200]: Intel Corporation 82571EB Gigabit Ether=
net Controller [8086:105e] (rev 06)<br>
 =A0 =A0 =A0 =A0Subsystem: Intel Corporation Device [8086:115e]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Interrupt: pin B routed to IRQ 58<br>
 =A0 =A0 =A0 =A0Region 0: Memory at dfec0000 (32-bit, non-prefetchable) [si=
ze=3D128K]<br>
 =A0 =A0 =A0 =A0Region 1: Memory at dfee0000 (32-bit, non-prefetchable) [si=
ze=3D128K]<br>
 =A0 =A0 =A0 =A0Region 2: I/O ports at &lt;ignored&gt;<br>
 =A0 =A0 =A0 =A0Expansion ROM at df000000 [disabled] [size=3D128K]<br>
 =A0 =A0 =A0 =A0Capabilities: [c8] Power Management version 2<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0m=
A PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D1 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [d0] Message Signalled Interrupts: Mask- 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0Capabilities: [e0] Express (v1) Endpoint, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 256 bytes, PhantFunc 0, =
Latency L0s &lt;512ns, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- AttnBtn- AttnInd- P=
wrInd- RBE- FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable+ Non-Fat=
al+ Fatal+ Unsupported+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd+ ExtTag- PhantFunc-=
 AuxPwr- NoSnoop+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 256 bytes, MaxRe=
adReq 512 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr+ FatalErr- Unsup=
pReq+ AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x4, A=
SPM L0s, Latency L0 &lt;4us, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM- Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk+<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x4, TrErr- Tra=
in- SlotClk+ DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [140] Device Serial Number d6-48-ea-ff-ff-17-=
15-00<br>
 =A0 =A0 =A0 =A0Kernel driver in use: e1000e<br>
 =A0 =A0 =A0 =A0Kernel modules: e1000e<br>
<br>
24:00.0 FireWire (IEEE 1394) [0c00]: VIA Technologies, Inc. VT6315 Series F=
irewire Controller [1106:3403] (prog-if 10)<br>
 =A0 =A0 =A0 =A0Subsystem: VIA Technologies, Inc. VT6315 Series Firewire Co=
ntroller [1106:3403]<br>
 =A0 =A0 =A0 =A0Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt=
;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
 =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 64 bytes<br>
 =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 56<br>
 =A0 =A0 =A0 =A0Region 0: Memory at dfcff000 (64-bit, non-prefetchable) [si=
ze=3D2K]<br>
 =A0 =A0 =A0 =A0Region 2: I/O ports at &lt;ignored&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [50] Power Management version 3<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0m=
A PME(D0-,D1-,D2+,D3hot+,D3cold+)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-<br>
 =A0 =A0 =A0 =A0Capabilities: [80] Message Signalled Interrupts: Mask+ 64bi=
t+ Queue=3D0/0 Enable-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000<br>
 =A0 =A0 =A0 =A0Capabilities: [98] Express (v1) Endpoint, MSI 00<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s &lt;64ns, L1 &lt;1us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtTag- AttnBtn- AttnInd- P=
wrInd- RBE+ FLReset-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevCtl: Report errors: Correctable- Non-Fat=
al+ Fatal+ Unsupported-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RlxdOrd- ExtTag- PhantFunc-=
 AuxPwr- NoSnoop-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MaxPayload 128 bytes, MaxRe=
adReq 512 bytes<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DevSta: CorrErr- UncorrErr- FatalErr- Unsup=
pReq- AuxPwr+ TransPend-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCap: Port #0, Speed 2.5GT/s, Width x1, A=
SPM L0s L1, Latency L0 &lt;1us, L1 &lt;64us<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ClockPM+ Suprise- LLActRep-=
 BwNot-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkCtl: ASPM Disabled; RCB 64 bytes Disable=
d- Retrain- CommClk-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0LnkSta: Speed 2.5GT/s, Width x1, TrErr- Tra=
in- SlotClk- DLActive- BWMgmt- ABWMgmt-<br>
 =A0 =A0 =A0 =A0Capabilities: [100] Advanced Error Reporting &lt;?&gt;<br>
 =A0 =A0 =A0 =A0Capabilities: [130] Device Serial Number 09-07-00-ff-ff-06-=
11-00<br>
 =A0 =A0 =A0 =A0Kernel driver in use: ohci1394<br>
 =A0 =A0 =A0 =A0Kernel modules: firewire-ohci, ohci1394<br>
-------------- next part --------------<br>
A non-text attachment was scrubbed...<br>
Name: dmesg_2.6.35-ipipe<br>
Type: application/octet-stream<br>
Size: 64639 bytes<br>
Desc: not available<br>
Url : /public/xenomai-help/attachments/20101028/73105990/attachment.obj<br>
<br>
------------------------------<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid" target=3D"_blank">Xenomai-help@domain.hid.=
org</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
<br>
End of Xenomai-help Digest, Vol 61, Issue 58<br>
********************************************<br>
</blockquote></div><br>

--0016363b86f0fd94d80493b5b9d6--

--0016363b86f0fd94eb0493b5b9d8
Content-Type: text/plain; charset=US-ASCII; name="dmesg_irqpoll.txt"
Content-Disposition: attachment; filename="dmesg_irqpoll.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfu9jrx41

WyAgICAwLjAwMDAwMF0gSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMgY3B1c2V0ClsgICAgMC4w
MDAwMDBdIExpbnV4IHZlcnNpb24gMi42LjMxLjQtaXBpcGUtMi41LjQgKHJvb3RAbWFuZHkpIChn
Y2MgdmVyc2lvbiA0LjQuMSAoVWJ1bnR1IDQuNC4xLTR1YnVudHU5KSApICMyIFNNUCBQUkVFTVBU
IEZyaSBPY3QgMTUgMTM6MDk6MzkgUERUIDIwMTAgKCkKWyAgICAwLjAwMDAwMF0gQ29tbWFuZCBs
aW5lOiBCT09UX0lNQUdFPS9ib290L3ZtbGludXotMi42LjMxLjQtaXBpcGUtMi41LjQgcm9vdD1V
VUlEPTcwMzc3MzU4LWI4ZWQtNDY5Ni1hNWYyLWQ3ZDVkZWQ4NTZlOSBybyB4ZW5vX251Y2xldXMu
eGVub21haV9naWQ9MTAwMiBxdWlldCBzcGxhc2ggaXJxcG9sbApbICAgIDAuMDAwMDAwXSBLRVJO
RUwgc3VwcG9ydGVkIGNwdXM6ClsgICAgMC4wMDAwMDBdICAgSW50ZWwgR2VudWluZUludGVsClsg
ICAgMC4wMDAwMDBdICAgQU1EIEF1dGhlbnRpY0FNRApbICAgIDAuMDAwMDAwXSAgIENlbnRhdXIg
Q2VudGF1ckhhdWxzClsgICAgMC4wMDAwMDBdIEJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1h
cDoKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDAwMDAwMCAtIDAwMDAwMDAw
MDAwOWRjMDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDBm
MDAwMCAtIDAwMDAwMDAwMDAxMDAwMDAgKHJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSAgQklPUy1l
ODIwOiAwMDAwMDAwMDAwMTAwMDAwIC0gMDAwMDAwMDBkN2RmOWMwMCAodXNhYmxlKQpbICAgIDAu
MDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMGQ3ZGY5YzAwIC0gMDAwMDAwMDBkN2U0YmMwMCAo
QUNQSSBOVlMpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwZDdlNGJjMDAgLSAw
MDAwMDAwMGQ3ZTRkYzAwIChBQ1BJIGRhdGEpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAw
MDAwMDAwZDdlNGRjMDAgLSAwMDAwMDAwMGQ4MDAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAw
MF0gIEJJT1MtZTgyMDogMDAwMDAwMDBmODAwMDAwMCAtIDAwMDAwMDAwZmQwMDAwMDAgKHJlc2Vy
dmVkKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMGZlMDAwMDAwIC0gMDAwMDAw
MDBmZWQwMDQwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAw
ZmVlMDAwMDAgLSAwMDAwMDAwMGZlZjAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJ
T1MtZTgyMDogMDAwMDAwMDBmZmIwMDAwMCAtIDAwMDAwMDAxMDAwMDAwMDAgKHJlc2VydmVkKQpb
ICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMTAwMDAwMDAwIC0gMDAwMDAwMDYyODAw
MDAwMCAodXNhYmxlKQpbICAgIDAuMDAwMDAwXSBETUkgMi41IHByZXNlbnQuClsgICAgMC4wMDAw
MDBdIGxhc3RfcGZuID0gMHg2MjgwMDAgbWF4X2FyY2hfcGZuID0gMHg0MDAwMDAwMDAKWyAgICAw
LjAwMDAwMF0gTVRSUiBkZWZhdWx0IHR5cGU6IHdyaXRlLWJhY2sKWyAgICAwLjAwMDAwMF0gTVRS
UiBmaXhlZCByYW5nZXMgZW5hYmxlZDoKWyAgICAwLjAwMDAwMF0gICAwMDAwMC05RkZGRiB3cml0
ZS1iYWNrClsgICAgMC4wMDAwMDBdICAgQTAwMDAtQkZGRkYgdW5jYWNoYWJsZQpbICAgIDAuMDAw
MDAwXSAgIEMwMDAwLURCRkZGIHdyaXRlLXByb3RlY3QKWyAgICAwLjAwMDAwMF0gICBEQzAwMC1F
RkZGRiB1bmNhY2hhYmxlClsgICAgMC4wMDAwMDBdICAgRjAwMDAtRkZGRkYgd3JpdGUtcHJvdGVj
dApbICAgIDAuMDAwMDAwXSBNVFJSIHZhcmlhYmxlIHJhbmdlcyBlbmFibGVkOgpbICAgIDAuMDAw
MDAwXSAgIDAgYmFzZSAwMEQ3RjAwMDAwIG1hc2sgRkZGRkYwMDAwMCB1bmNhY2hhYmxlClsgICAg
MC4wMDAwMDBdICAgMSBiYXNlIDAwRDgwMDAwMDAgbWFzayBGRkY4MDAwMDAwIHVuY2FjaGFibGUK
WyAgICAwLjAwMDAwMF0gICAyIGJhc2UgMDBFMDAwMDAwMCBtYXNrIEZGRTAwMDAwMDAgdW5jYWNo
YWJsZQpbICAgIDAuMDAwMDAwXSAgIDMgZGlzYWJsZWQKWyAgICAwLjAwMDAwMF0gICA0IGRpc2Fi
bGVkClsgICAgMC4wMDAwMDBdICAgNSBkaXNhYmxlZApbICAgIDAuMDAwMDAwXSAgIDYgZGlzYWJs
ZWQKWyAgICAwLjAwMDAwMF0gICA3IGRpc2FibGVkClsgICAgMC4wMDAwMDBdIHg4NiBQQVQgZW5h
YmxlZDogY3B1IDAsIG9sZCAweDcwNDA2MDAwNzA0MDYsIG5ldyAweDcwMTA2MDAwNzAxMDYKWyAg
ICAwLjAwMDAwMF0gbGFzdF9wZm4gPSAweGQ3ZGY5IG1heF9hcmNoX3BmbiA9IDB4NDAwMDAwMDAw
ClsgICAgMC4wMDAwMDBdIGU4MjAgdXBkYXRlIHJhbmdlOiAwMDAwMDAwMDAwMDAxMDAwIC0gMDAw
MDAwMDAwMDAwNjAwMCAodXNhYmxlKSA9PT4gKHJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSBTY2Fu
bmluZyAxIGFyZWFzIGZvciBsb3cgbWVtb3J5IGNvcnJ1cHRpb24KWyAgICAwLjAwMDAwMF0gbW9k
aWZpZWQgcGh5c2ljYWwgUkFNIG1hcDoKWyAgICAwLjAwMDAwMF0gIG1vZGlmaWVkOiAwMDAwMDAw
MDAwMDAwMDAwIC0gMDAwMDAwMDAwMDAwMTAwMCAodXNhYmxlKQpbICAgIDAuMDAwMDAwXSAgbW9k
aWZpZWQ6IDAwMDAwMDAwMDAwMDEwMDAgLSAwMDAwMDAwMDAwMDA2MDAwIChyZXNlcnZlZCkKWyAg
ICAwLjAwMDAwMF0gIG1vZGlmaWVkOiAwMDAwMDAwMDAwMDA2MDAwIC0gMDAwMDAwMDAwMDA5ZGMw
MCAodXNhYmxlKQpbICAgIDAuMDAwMDAwXSAgbW9kaWZpZWQ6IDAwMDAwMDAwMDAwZjAwMDAgLSAw
MDAwMDAwMDAwMTAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIG1vZGlmaWVkOiAwMDAw
MDAwMDAwMTAwMDAwIC0gMDAwMDAwMDBkN2RmOWMwMCAodXNhYmxlKQpbICAgIDAuMDAwMDAwXSAg
bW9kaWZpZWQ6IDAwMDAwMDAwZDdkZjljMDAgLSAwMDAwMDAwMGQ3ZTRiYzAwIChBQ1BJIE5WUykK
WyAgICAwLjAwMDAwMF0gIG1vZGlmaWVkOiAwMDAwMDAwMGQ3ZTRiYzAwIC0gMDAwMDAwMDBkN2U0
ZGMwMCAoQUNQSSBkYXRhKQpbICAgIDAuMDAwMDAwXSAgbW9kaWZpZWQ6IDAwMDAwMDAwZDdlNGRj
MDAgLSAwMDAwMDAwMGQ4MDAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIG1vZGlmaWVk
OiAwMDAwMDAwMGY4MDAwMDAwIC0gMDAwMDAwMDBmZDAwMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4w
MDAwMDBdICBtb2RpZmllZDogMDAwMDAwMDBmZTAwMDAwMCAtIDAwMDAwMDAwZmVkMDA0MDAgKHJl
c2VydmVkKQpbICAgIDAuMDAwMDAwXSAgbW9kaWZpZWQ6IDAwMDAwMDAwZmVlMDAwMDAgLSAwMDAw
MDAwMGZlZjAwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIG1vZGlmaWVkOiAwMDAwMDAw
MGZmYjAwMDAwIC0gMDAwMDAwMDEwMDAwMDAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBt
b2RpZmllZDogMDAwMDAwMDEwMDAwMDAwMCAtIDAwMDAwMDA2MjgwMDAwMDAgKHVzYWJsZSkKWyAg
ICAwLjAwMDAwMF0gaW5pdGlhbCBtZW1vcnkgbWFwcGVkIDogMCAtIDIwMDAwMDAwClsgICAgMC4w
MDAwMDBdIGluaXRfbWVtb3J5X21hcHBpbmc6IDAwMDAwMDAwMDAwMDAwMDAtMDAwMDAwMDBkN2Rm
OTAwMApbICAgIDAuMDAwMDAwXSBVc2luZyB4ODYgc2VnbWVudCBsaW1pdHMgdG8gYXBwcm94aW1h
dGUgTlggcHJvdGVjdGlvbgpbICAgIDAuMDAwMDAwXSAgMDAwMDAwMDAwMCAtIDAwZDdjMDAwMDAg
cGFnZSAyTQpbICAgIDAuMDAwMDAwXSAgMDBkN2MwMDAwMCAtIDAwZDdkZjkwMDAgcGFnZSA0awpb
ICAgIDAuMDAwMDAwXSBrZXJuZWwgZGlyZWN0IG1hcHBpbmcgdGFibGVzIHVwIHRvIGQ3ZGY5MDAw
IEAgODAwMC1lMDAwClsgICAgMC4wMDAwMDBdIGluaXRfbWVtb3J5X21hcHBpbmc6IDAwMDAwMDAx
MDAwMDAwMDAtMDAwMDAwMDYyODAwMDAwMApbICAgIDAuMDAwMDAwXSBVc2luZyB4ODYgc2VnbWVu
dCBsaW1pdHMgdG8gYXBwcm94aW1hdGUgTlggcHJvdGVjdGlvbgpbICAgIDAuMDAwMDAwXSAgMDEw
MDAwMDAwMCAtIDA2MjgwMDAwMDAgcGFnZSAyTQpbICAgIDAuMDAwMDAwXSBrZXJuZWwgZGlyZWN0
IG1hcHBpbmcgdGFibGVzIHVwIHRvIDYyODAwMDAwMCBAIGMwMDAtMjYwMDAKWyAgICAwLjAwMDAw
MF0gUkFNRElTSzogMzc4OTAwMDAgLSAzN2ZlZjM5OApbICAgIDAuMDAwMDAwXSBBQ1BJOiBSU0RQ
IDAwMDAwMDAwMDAwZmVjMzAgMDAwMjQgKHYwMiBERUxMICApClsgICAgMC4wMDAwMDBdIEFDUEk6
IFhTRFQgMDAwMDAwMDAwMDBmY2JlYSAwMDA4NCAodjAxIERFTEwgICAgQjEwSyAgICAwMDAwMDAx
NSBBU0wgIDAwMDAwMDYxKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBGQUNQIDAwMDAwMDAwMDAwZmNj
ZTIgMDAwRjQgKHYwMyBERUxMICAgIEIxMEsgICAgMDAwMDAwMTUgQVNMICAwMDAwMDA2MSkKWyAg
ICAwLjAwMDAwMF0gQUNQSTogRFNEVCAwMDAwMDAwMGZmZTllYWQzIDA1NzMyICh2MDEgICBERUxM
ICAgIGR0X2V4IDAwMDAxMDAwIElOVEwgMjAwNTA2MjQpClsgICAgMC4wMDAwMDBdIEFDUEk6IEZB
Q1MgMDAwMDAwMDBkN2RmOWMwMCAwMDA0MApbICAgIDAuMDAwMDAwXSBBQ1BJOiBTU0RUIDAwMDAw
MDAwZmZlYTQzMTYgMDAwOUMgKHYwMSAgIERFTEwgICAgc3RfZXggMDAwMDEwMDAgSU5UTCAyMDA1
MDYyNCkKWyAgICAwLjAwMDAwMF0gQUNQSTogQVBJQyAwMDAwMDAwMDAwMGZjZGQ2IDAwMTZBICh2
MDEgREVMTCAgICBCMTBLICAgIDAwMDAwMDE1IEFTTCAgMDAwMDAwNjEpClsgICAgMC4wMDAwMDBd
IEFDUEk6IEJPT1QgMDAwMDAwMDAwMDBmY2Y0MCAwMDAyOCAodjAxIERFTEwgICAgQjEwSyAgICAw
MDAwMDAxNSBBU0wgIDAwMDAwMDYxKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBBU0YhIDAwMDAwMDAw
MDAwZmNmNjggMDAwOTYgKHYzMiBERUxMICAgIEIxMEsgICAgMDAwMDAwMTUgQVNMICAwMDAwMDA2
MSkKWyAgICAwLjAwMDAwMF0gQUNQSTogTUNGRyAwMDAwMDAwMDAwMGZjZmZlIDAwMDNDICh2MDEg
REVMTCAgICBCMTBLICAgIDAwMDAwMDE1IEFTTCAgMDAwMDAwNjEpClsgICAgMC4wMDAwMDBdIEFD
UEk6IEhQRVQgMDAwMDAwMDAwMDBmZDAzYSAwMDAzOCAodjAxIERFTEwgICAgQjEwSyAgICAwMDAw
MDAxNSBBU0wgIDAwMDAwMDYxKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBUQ1BBIDAwMDAwMDAwMDAw
ZmQyOTYgMDAwMzIgKHYwMSBERUxMICAgIEIxMEsgICAgMDAwMDAwMTUgQVNMICAwMDAwMDA2MSkK
WyAgICAwLjAwMDAwMF0gQUNQSTogX19fXyAwMDAwMDAwMDAwMGZkMmM4IDAwMDMwICh2MDEgREVM
TCAgICBCMTBLICAgIDAwMDAwMDE1IEFTTCAgMDAwMDAwNjEpClsgICAgMC4wMDAwMDBdIEFDUEk6
IF9SQVQgMDAwMDAwMDAwMDBmZGVjYSAwMDAzMCAodjAxIERFTEwgICAgQjEwSyAgICAwMDAwMDAx
NSBBU0wgIDAwMDAwMDYxKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBTTElDIDAwMDAwMDAwMDAwZmQw
NzIgMDAxNzYgKHYwMSBERUxMICAgIEIxMEsgICAgMDAwMDAwMTUgQVNMICAwMDAwMDA2MSkKWyAg
ICAwLjAwMDAwMF0gQUNQSTogU1NEVCAwMDAwMDAwMGQ3ZTRkYzAwIDAxNUM0ICh2MDEgIElOVEVM
IFBQTSBSQ00gIDgwMDAwMDAxIElOVEwgMjAwNjExMDkpClsgICAgMC4wMDAwMDBdIEFDUEk6IExv
Y2FsIEFQSUMgYWRkcmVzcyAweGZlZTAwMDAwClsgICAgMC4wMDAwMDBdIE5vIE5VTUEgY29uZmln
dXJhdGlvbiBmb3VuZApbICAgIDAuMDAwMDAwXSBGYWtpbmcgYSBub2RlIGF0IDAwMDAwMDAwMDAw
MDAwMDAtMDAwMDAwMDYyODAwMDAwMApbICAgIDAuMDAwMDAwXSBCb290bWVtIHNldHVwIG5vZGUg
MCAwMDAwMDAwMDAwMDAwMDAwLTAwMDAwMDA2MjgwMDAwMDAKWyAgICAwLjAwMDAwMF0gICBOT0RF
X0RBVEEgWzAwMDAwMDAwMDAwMjEwMDAgLSAwMDAwMDAwMDAwMDJiZmZmXQpbICAgIDAuMDAwMDAw
XSAgIGJvb3RtYXAgWzAwMDAwMDAwMDAxMDAwMDAgLSAgMDAwMDAwMDAwMDFjNGZmZl0gcGFnZXMg
YzUKWyAgICAwLjAwMDAwMF0gKDggZWFybHkgcmVzZXJ2YXRpb25zKSA9PT4gYm9vdG1lbSBbMDAw
MDAwMDAwMCAtIDA2MjgwMDAwMDBdClsgICAgMC4wMDAwMDBdICAgIzAgWzAwMDAwMDAwMDAgLSAw
MDAwMDAxMDAwXSAgIEJJT1MgZGF0YSBwYWdlID09PiBbMDAwMDAwMDAwMCAtIDAwMDAwMDEwMDBd
ClsgICAgMC4wMDAwMDBdICAgIzEgWzAwMDAwMDYwMDAgLSAwMDAwMDA4MDAwXSAgICAgICBUUkFN
UE9MSU5FID09PiBbMDAwMDAwNjAwMCAtIDAwMDAwMDgwMDBdClsgICAgMC4wMDAwMDBdICAgIzIg
WzAwMDEwMDAwMDAgLSAwMDAxYTMyZDRjXSAgICBURVhUIERBVEEgQlNTID09PiBbMDAwMTAwMDAw
MCAtIDAwMDFhMzJkNGNdClsgICAgMC4wMDAwMDBdICAgIzMgWzAwMzc4OTAwMDAgLSAwMDM3ZmVm
Mzk4XSAgICAgICAgICBSQU1ESVNLID09PiBbMDAzNzg5MDAwMCAtIDAwMzdmZWYzOThdClsgICAg
MC4wMDAwMDBdICAgIzQgWzAwMDAwOWRjMDAgLSAwMDAwMTAwMDAwXSAgICBCSU9TIHJlc2VydmVk
ID09PiBbMDAwMDA5ZGMwMCAtIDAwMDAxMDAwMDBdClsgICAgMC4wMDAwMDBdICAgIzUgWzAwMDFh
MzMwMDAgLSAwMDAxYTMzMTg0XSAgICAgICAgICAgICAgQlJLID09PiBbMDAwMWEzMzAwMCAtIDAw
MDFhMzMxODRdClsgICAgMC4wMDAwMDBdICAgIzYgWzAwMDAwMDgwMDAgLSAwMDAwMDBjMDAwXSAg
ICAgICAgICBQR1RBQkxFID09PiBbMDAwMDAwODAwMCAtIDAwMDAwMGMwMDBdClsgICAgMC4wMDAw
MDBdICAgIzcgWzAwMDAwMGMwMDAgLSAwMDAwMDIxMDAwXSAgICAgICAgICBQR1RBQkxFID09PiBb
MDAwMDAwYzAwMCAtIDAwMDAwMjEwMDBdClsgICAgMC4wMDAwMDBdICBbZmZmZmVhMDAwMDAwMDAw
MC1mZmZmZWEwMDBmOWZmZmZmXSBQTUQgLT4gW2ZmZmY4ODAwMjg2MDAwMDAtZmZmZjg4MDAzNzdm
ZmZmZl0gb24gbm9kZSAwClsgICAgMC4wMDAwMDBdICBbZmZmZmVhMDAwZmEwMDAwMC1mZmZmZWEw
MDE1OWZmZmZmXSBQTUQgLT4gW2ZmZmY4ODAwMzgwMDAwMDAtZmZmZjg4MDAzZGZmZmZmZl0gb24g
bm9kZSAwClsgICAgMC4wMDAwMDBdIFpvbmUgUEZOIHJhbmdlczoKWyAgICAwLjAwMDAwMF0gICBE
TUEgICAgICAweDAwMDAwMDAwIC0+IDB4MDAwMDEwMDAKWyAgICAwLjAwMDAwMF0gICBETUEzMiAg
ICAweDAwMDAxMDAwIC0+IDB4MDAxMDAwMDAKWyAgICAwLjAwMDAwMF0gICBOb3JtYWwgICAweDAw
MTAwMDAwIC0+IDB4MDA2MjgwMDAKWyAgICAwLjAwMDAwMF0gTW92YWJsZSB6b25lIHN0YXJ0IFBG
TiBmb3IgZWFjaCBub2RlClsgICAgMC4wMDAwMDBdIGVhcmx5X25vZGVfbWFwWzRdIGFjdGl2ZSBQ
Rk4gcmFuZ2VzClsgICAgMC4wMDAwMDBdICAgICAwOiAweDAwMDAwMDAwIC0+IDB4MDAwMDAwMDEK
WyAgICAwLjAwMDAwMF0gICAgIDA6IDB4MDAwMDAwMDYgLT4gMHgwMDAwMDA5ZApbICAgIDAuMDAw
MDAwXSAgICAgMDogMHgwMDAwMDEwMCAtPiAweDAwMGQ3ZGY5ClsgICAgMC4wMDAwMDBdICAgICAw
OiAweDAwMTAwMDAwIC0+IDB4MDA2MjgwMDAKWyAgICAwLjAwMDAwMF0gT24gbm9kZSAwIHRvdGFs
cGFnZXM6IDYyOTA4MzMKWyAgICAwLjAwMDAwMF0gICBETUEgem9uZTogNTYgcGFnZXMgdXNlZCBm
b3IgbWVtbWFwClsgICAgMC4wMDAwMDBdICAgRE1BIHpvbmU6IDEyNiBwYWdlcyByZXNlcnZlZApb
ICAgIDAuMDAwMDAwXSAgIERNQSB6b25lOiAzODEwIHBhZ2VzLCBMSUZPIGJhdGNoOjAKWyAgICAw
LjAwMDAwMF0gICBETUEzMiB6b25lOiAxNDI4MCBwYWdlcyB1c2VkIGZvciBtZW1tYXAKWyAgICAw
LjAwMDAwMF0gICBETUEzMiB6b25lOiA4NjU4NDEgcGFnZXMsIExJRk8gYmF0Y2g6MzEKWyAgICAw
LjAwMDAwMF0gICBOb3JtYWwgem9uZTogNzM5MjAgcGFnZXMgdXNlZCBmb3IgbWVtbWFwClsgICAg
MC4wMDAwMDBdICAgTm9ybWFsIHpvbmU6IDUzMzI4MDAgcGFnZXMsIExJRk8gYmF0Y2g6MzEKWyAg
ICAwLjAwMDAwMF0gQUNQSTogUE0tVGltZXIgSU8gUG9ydDogMHg4MDgKWyAgICAwLjAwMDAwMF0g
QUNQSTogTG9jYWwgQVBJQyBhZGRyZXNzIDB4ZmVlMDAwMDAKWyAgICAwLjAwMDAwMF0gQUNQSTog
TEFQSUMgKGFjcGlfaWRbMHgwMV0gbGFwaWNfaWRbMHgxMF0gZW5hYmxlZCkKWyAgICAwLjAwMDAw
MF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwMl0gbGFwaWNfaWRbMHgxMl0gZW5hYmxlZCkKWyAg
ICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwM10gbGFwaWNfaWRbMHgxNF0gZW5h
YmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwNF0gbGFwaWNfaWRb
MHgxNl0gZW5hYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwNV0g
bGFwaWNfaWRbMHgwMF0gZW5hYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlf
aWRbMHgwNl0gbGFwaWNfaWRbMHgwMl0gZW5hYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQ
SUMgKGFjcGlfaWRbMHgwN10gbGFwaWNfaWRbMHgwNF0gZW5hYmxlZCkKWyAgICAwLjAwMDAwMF0g
QUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwOF0gbGFwaWNfaWRbMHgwNl0gZW5hYmxlZCkKWyAgICAw
LjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwOV0gbGFwaWNfaWRbMHgwMF0gZGlzYWJs
ZWQpClsgICAgMC4wMDAwMDBdIEFDUEk6IExBUElDIChhY3BpX2lkWzB4MGFdIGxhcGljX2lkWzB4
MDBdIGRpc2FibGVkKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDBiXSBs
YXBpY19pZFsweDAwXSBkaXNhYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlf
aWRbMHgwY10gbGFwaWNfaWRbMHgwMF0gZGlzYWJsZWQpClsgICAgMC4wMDAwMDBdIEFDUEk6IExB
UElDIChhY3BpX2lkWzB4MGRdIGxhcGljX2lkWzB4MDBdIGRpc2FibGVkKQpbICAgIDAuMDAwMDAw
XSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDBlXSBsYXBpY19pZFsweDAwXSBkaXNhYmxlZCkKWyAg
ICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwZl0gbGFwaWNfaWRbMHgwMF0gZGlz
YWJsZWQpClsgICAgMC4wMDAwMDBdIEFDUEk6IExBUElDIChhY3BpX2lkWzB4MTBdIGxhcGljX2lk
WzB4MDBdIGRpc2FibGVkKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDEx
XSBsYXBpY19pZFsweDAwXSBkaXNhYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFj
cGlfaWRbMHgxMl0gbGFwaWNfaWRbMHgwMF0gZGlzYWJsZWQpClsgICAgMC4wMDAwMDBdIEFDUEk6
IExBUElDIChhY3BpX2lkWzB4MTNdIGxhcGljX2lkWzB4MDBdIGRpc2FibGVkKQpbICAgIDAuMDAw
MDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDE0XSBsYXBpY19pZFsweDAwXSBkaXNhYmxlZCkK
WyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgxNV0gbGFwaWNfaWRbMHgwMF0g
ZGlzYWJsZWQpClsgICAgMC4wMDAwMDBdIEFDUEk6IExBUElDIChhY3BpX2lkWzB4MTZdIGxhcGlj
X2lkWzB4MDBdIGRpc2FibGVkKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsw
eDE3XSBsYXBpY19pZFsweDAwXSBkaXNhYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMg
KGFjcGlfaWRbMHgxOF0gbGFwaWNfaWRbMHgwMF0gZGlzYWJsZWQpClsgICAgMC4wMDAwMDBdIEFD
UEk6IExBUElDIChhY3BpX2lkWzB4MTldIGxhcGljX2lkWzB4MDBdIGRpc2FibGVkKQpbICAgIDAu
MDAwMDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDFhXSBsYXBpY19pZFsweDAwXSBkaXNhYmxl
ZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgxYl0gbGFwaWNfaWRbMHgw
MF0gZGlzYWJsZWQpClsgICAgMC4wMDAwMDBdIEFDUEk6IExBUElDIChhY3BpX2lkWzB4MWNdIGxh
cGljX2lkWzB4MDBdIGRpc2FibGVkKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9p
ZFsweDFkXSBsYXBpY19pZFsweDAwXSBkaXNhYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQ
SUMgKGFjcGlfaWRbMHgxZV0gbGFwaWNfaWRbMHgwMF0gZGlzYWJsZWQpClsgICAgMC4wMDAwMDBd
IEFDUEk6IExBUElDIChhY3BpX2lkWzB4MWZdIGxhcGljX2lkWzB4MDBdIGRpc2FibGVkKQpbICAg
IDAuMDAwMDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDIwXSBsYXBpY19pZFsweDAwXSBkaXNh
YmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4ZmZdIGhpZ2gg
bGV2ZWwgbGludFsweDFdKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBJT0FQSUMgKGlkWzB4MDhdIGFk
ZHJlc3NbMHhmZWMwMDAwMF0gZ3NpX2Jhc2VbMF0pClsgICAgMC4wMDAwMDBdIElPQVBJQ1swXTog
YXBpY19pZCA4LCB2ZXJzaW9uIDMyLCBhZGRyZXNzIDB4ZmVjMDAwMDAsIEdTSSAwLTIzClsgICAg
MC4wMDAwMDBdIEFDUEk6IElPQVBJQyAoaWRbMHgwOV0gYWRkcmVzc1sweGZlYzgwMDAwXSBnc2lf
YmFzZVsyNF0pClsgICAgMC4wMDAwMDBdIElPQVBJQ1sxXTogYXBpY19pZCA5LCB2ZXJzaW9uIDMy
LCBhZGRyZXNzIDB4ZmVjODAwMDAsIEdTSSAyNC00NwpbICAgIDAuMDAwMDAwXSBBQ1BJOiBJT0FQ
SUMgKGlkWzB4MGFdIGFkZHJlc3NbMHhmZWM4ODAwMF0gZ3NpX2Jhc2VbNDhdKQpbICAgIDAuMDAw
MDAwXSBJT0FQSUNbMl06IGFwaWNfaWQgMTAsIHZlcnNpb24gMzIsIGFkZHJlc3MgMHhmZWM4ODAw
MCwgR1NJIDQ4LTcxClsgICAgMC4wMDAwMDBdIEFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNf
aXJxIDAgZ2xvYmFsX2lycSAyIGRmbCBkZmwpClsgICAgMC4wMDAwMDBdIEFDUEk6IElOVF9TUkNf
T1ZSIChidXMgMCBidXNfaXJxIDkgZ2xvYmFsX2lycSA5IGhpZ2ggbGV2ZWwpClsgICAgMC4wMDAw
MDBdIEFDUEk6IElSUTAgdXNlZCBieSBvdmVycmlkZS4KWyAgICAwLjAwMDAwMF0gQUNQSTogSVJR
MiB1c2VkIGJ5IG92ZXJyaWRlLgpbICAgIDAuMDAwMDAwXSBBQ1BJOiBJUlE5IHVzZWQgYnkgb3Zl
cnJpZGUuClsgICAgMC4wMDAwMDBdIFVzaW5nIEFDUEkgKE1BRFQpIGZvciBTTVAgY29uZmlndXJh
dGlvbiBpbmZvcm1hdGlvbgpbICAgIDAuMDAwMDAwXSBBQ1BJOiBIUEVUIGlkOiAweDgwODZhMzAx
IGJhc2U6IDB4ZmVkMDAwMDAKWyAgICAwLjAwMDAwMF0gMzIgUHJvY2Vzc29ycyBleGNlZWRzIE5S
X0NQVVMgbGltaXQgb2YgOApbICAgIDAuMDAwMDAwXSBTTVA6IEFsbG93aW5nIDggQ1BVcywgMCBo
b3RwbHVnIENQVXMKWyAgICAwLjAwMDAwMF0gbnJfaXJxc19nc2k6IDcyClsgICAgMC4wMDAwMDBd
IEFsbG9jYXRpbmcgUENJIHJlc291cmNlcyBzdGFydGluZyBhdCBkODAwMDAwMCAoZ2FwOiBkODAw
MDAwMDoyMDAwMDAwMCkKWyAgICAwLjAwMDAwMF0gTlJfQ1BVUzo4IG5yX2NwdW1hc2tfYml0czo4
IG5yX2NwdV9pZHM6OCBucl9ub2RlX2lkczoxClsgICAgMC4wMDAwMDBdIFBFUkNQVTogRW1iZWRk
ZWQgMzMgcGFnZXMgYXQgZmZmZjg4MDAyODAzNTAwMCwgc3RhdGljIGRhdGEgMTA0NDE2IGJ5dGVz
ClsgICAgMC4wMDAwMDBdIEJ1aWx0IDEgem9uZWxpc3RzIGluIFpvbmUgb3JkZXIsIG1vYmlsaXR5
IGdyb3VwaW5nIG9uLiAgVG90YWwgcGFnZXM6IDYyMDI0NTEKWyAgICAwLjAwMDAwMF0gUG9saWN5
IHpvbmU6IE5vcm1hbApbICAgIDAuMDAwMDAwXSBLZXJuZWwgY29tbWFuZCBsaW5lOiBCT09UX0lN
QUdFPS9ib290L3ZtbGludXotMi42LjMxLjQtaXBpcGUtMi41LjQgcm9vdD1VVUlEPTcwMzc3MzU4
LWI4ZWQtNDY5Ni1hNWYyLWQ3ZDVkZWQ4NTZlOSBybyB4ZW5vX251Y2xldXMueGVub21haV9naWQ9
MTAwMiBxdWlldCBzcGxhc2ggaXJxcG9sbApbICAgIDAuMDAwMDAwXSBNaXNyb3V0ZWQgSVJRIGZp
eHVwIGFuZCBwb2xsaW5nIHN1cHBvcnQgZW5hYmxlZApbICAgIDAuMDAwMDAwXSBUaGlzIG1heSBz
aWduaWZpY2FudGx5IGltcGFjdCBzeXN0ZW0gcGVyZm9ybWFuY2UKWyAgICAwLjAwMDAwMF0gUElE
IGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3JkZXI6IDEyLCAzMjc2OCBieXRlcykKWyAgICAw
LjAwMDAwMF0gSW5pdGlhbGl6aW5nIENQVSMwClsgICAgMC4wMDAwMDBdIENoZWNraW5nIGFwZXJ0
dXJlLi4uClsgICAgMC4wMDAwMDBdIE5vIEFHUCBicmlkZ2UgZm91bmQKWyAgICAwLjAwMDAwMF0g
Q2FsZ2FyeTogZGV0ZWN0aW5nIENhbGdhcnkgdmlhIEJJT1MgRUJEQSBhcmVhClsgICAgMC4wMDAw
MDBdIENhbGdhcnk6IFVuYWJsZSB0byBsb2NhdGUgUmlvIEdyYW5kZSB0YWJsZSBpbiBFQkRBIC0g
YmFpbGluZyEKWyAgICAwLjAwMDAwMF0gUENJLURNQTogVXNpbmcgc29mdHdhcmUgYm91bmNlIGJ1
ZmZlcmluZyBmb3IgSU8gKFNXSU9UTEIpClsgICAgMC4wMDAwMDBdIFBsYWNpbmcgNjRNQiBzb2Z0
d2FyZSBJTyBUTEIgYmV0d2VlbiBmZmZmODgwMDIwMDAwMDAwIC0gZmZmZjg4MDAyNDAwMDAwMApb
ICAgIDAuMDAwMDAwXSBzb2Z0d2FyZSBJTyBUTEIgYXQgcGh5cyAweDIwMDAwMDAwIC0gMHgyNDAw
MDAwMApbICAgIDAuMDAwMDAwXSBNZW1vcnk6IDI0NzMxNzg4ay8yNTgyMTE4NGsgYXZhaWxhYmxl
ICg1MzY0ayBrZXJuZWwgY29kZSwgNjU3ODUyayBhYnNlbnQsIDQzMTU0NGsgcmVzZXJ2ZWQsIDI4
NzlrIGRhdGEsIDg2OGsgaW5pdCkKWyAgICAwLjAwMDAwMF0gU0xVQjogR2Vuc2xhYnM9MTQsIEhX
YWxpZ249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0cz0wLCBDUFVzPTgsIE5vZGVzPTEKWyAgICAw
LjAwMDAwMF0gSGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4KWyAgICAwLjAwMDAwMF0g
TlJfSVJRUzo1MTIKWyAgICAwLjAwMDAwMF0gRmFzdCBUU0MgY2FsaWJyYXRpb24gdXNpbmcgUElU
ClsgICAgMC4wMDAwMDBdIERldGVjdGVkIDMzMjUuNDM3IE1IeiBwcm9jZXNzb3IuClsgICAgMC4w
MDAwMjddIEktcGlwZSAyLjQtMDk6IHBpcGVsaW5lIGVuYWJsZWQuClsgICAgMC4wMDIwMDZdIENv
bnNvbGU6IGNvbG91ciBWR0ErIDgweDI1ClsgICAgMC4wMDIwMDddIGNvbnNvbGUgW3R0eTBdIGVu
YWJsZWQKWyAgICAwLjA1NTg2MV0gYWxsb2NhdGVkIDI1MTY1ODI0MCBieXRlcyBvZiBwYWdlX2Nn
cm91cApbICAgIDAuMDU1ODYzXSBwbGVhc2UgdHJ5ICdjZ3JvdXBfZGlzYWJsZT1tZW1vcnknIG9w
dGlvbiBpZiB5b3UgZG9uJ3Qgd2FudCBtZW1vcnkgY2dyb3VwcwpbICAgIDAuMDU1OTc0XSBocGV0
IGNsb2NrZXZlbnQgcmVnaXN0ZXJlZApbICAgIDAuMDU1OTc5XSBDYWxpYnJhdGluZyBkZWxheSBs
b29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1lciBmcmVxdWVuY3kuLiA2
NjUwLjg3IEJvZ29NSVBTIChscGo9MzMyNTQzNzApClsgICAgMC4wNTU5OTldIFNlY3VyaXR5IEZy
YW1ld29yayBpbml0aWFsaXplZApbICAgIDAuMDU2MDAzXSBTRUxpbnV4OiAgRGlzYWJsZWQgYXQg
Ym9vdC4KWyAgICAwLjA1NzUwNV0gRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNDE5
NDMwNCAob3JkZXI6IDEzLCAzMzU1NDQzMiBieXRlcykKWyAgICAwLjA2MzAxN10gSW5vZGUtY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAyMDk3MTUyIChvcmRlcjogMTIsIDE2Nzc3MjE2IGJ5dGVz
KQpbICAgIDAuMDY1Mzg5XSBNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDI1NgpbICAg
IDAuMDY1NTA1XSBJbml0aWFsaXppbmcgY2dyb3VwIHN1YnN5cyBucwpbICAgIDAuMDY1NTA3XSBJ
bml0aWFsaXppbmcgY2dyb3VwIHN1YnN5cyBjcHVhY2N0ClsgICAgMC4wNjU1MDldIEluaXRpYWxp
emluZyBjZ3JvdXAgc3Vic3lzIG1lbW9yeQpbICAgIDAuMDY1NTE0XSBJbml0aWFsaXppbmcgY2dy
b3VwIHN1YnN5cyBkZXZpY2VzClsgICAgMC4wNjU1MTVdIEluaXRpYWxpemluZyBjZ3JvdXAgc3Vi
c3lzIGZyZWV6ZXIKWyAgICAwLjA2NTUxN10gSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMgbmV0
X2NscwpbICAgIDAuMDY1NTI1XSBDUFU6IFBoeXNpY2FsIFByb2Nlc3NvciBJRDogMQpbICAgIDAu
MDY1NTI2XSBDUFU6IFByb2Nlc3NvciBDb3JlIElEOiAwClsgICAgMC4wNjU1MjhdIENQVTogTDEg
SSBjYWNoZTogMzJLLCBMMSBEIGNhY2hlOiAzMksKWyAgICAwLjA2NTUyOV0gQ1BVOiBMMiBjYWNo
ZTogMjU2SwpbICAgIDAuMDY1NTMwXSBDUFU6IEwzIGNhY2hlOiA4MTkySwpbICAgIDAuMDY1NTMx
XSBDUFUgMC8weDEwIC0+IE5vZGUgMApbICAgIDAuMDY1NTM0XSBtY2U6IENQVSBzdXBwb3J0cyA5
IE1DRSBiYW5rcwpbICAgIDAuMDY1NTQ0XSBDUFUwOiBUaGVybWFsIG1vbml0b3JpbmcgZW5hYmxl
ZCAoVE0xKQpbICAgIDAuMDY1NTQ2XSBDUFUgMCBNQ0EgYmFua3MgQ01DSToyIENNQ0k6MyBDTUNJ
OjUgQ01DSTo2IFNIRDo4ClsgICAgMC4wNjU1NTJdIFBlcmZvcm1hbmNlIENvdW50ZXJzOiBOZWhh
bGVtL0NvcmVpNyBldmVudHMsIEludGVsIFBNVSBkcml2ZXIuClsgICAgMC4wNjU1NTZdIC4uLiB2
ZXJzaW9uOiAgICAgICAgICAgICAgICAgMwpbICAgIDAuMDY1NTU3XSAuLi4gYml0IHdpZHRoOiAg
ICAgICAgICAgICAgIDQ4ClsgICAgMC4wNjU1NTddIC4uLiBnZW5lcmljIGNvdW50ZXJzOiAgICAg
ICAgNApbICAgIDAuMDY1NTU4XSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAgIDAwMDBmZmZm
ZmZmZmZmZmYKWyAgICAwLjA2NTU1OV0gLi4uIG1heCBwZXJpb2Q6ICAgICAgICAgICAgICAwMDAw
MDAwMDdmZmZmZmZmClsgICAgMC4wNjU1NjBdIC4uLiBmaXhlZC1wdXJwb3NlIGNvdW50ZXJzOiAg
MwpbICAgIDAuMDY1NTYxXSAuLi4gY291bnRlciBtYXNrOiAgICAgICAgICAgIDAwMDAwMDA3MDAw
MDAwMGYKWyAgICAwLjA2NTU3NV0gQUNQSTogQ29yZSByZXZpc2lvbiAyMDA5MDUyMQpbICAgIDAu
MzI0OTk0XSBTZXR0aW5nIEFQSUMgcm91dGluZyB0byBwaHlzaWNhbCBmbGF0ClsgICAgMC4zMjU2
MTddIC4uVElNRVI6IHZlY3Rvcj0weDMwIGFwaWMxPTAgcGluMT0yIGFwaWMyPS0xIHBpbjI9LTEK
WyAgICAwLjQyNTMyNV0gLi5NUC1CSU9TIGJ1ZzogODI1NCB0aW1lciBub3QgY29ubmVjdGVkIHRv
IElPLUFQSUMKWyAgICAwLjQyNTMyNV0gLi4udHJ5aW5nIHRvIHNldCB1cCB0aW1lciAoSVJRMCkg
dGhyb3VnaCB0aGUgODI1OUEgLi4uClsgICAgMC40MjUzMjZdIC4uLi4uIChmb3VuZCBhcGljIDAg
cGluIDIpIC4uLgpbICAgIDAuNTI1MDU3XSAuLi4uLi4uIHdvcmtzLgpbICAgIDAuNTI1MDU4XSBD
UFUwOiBJbnRlbChSKSBYZW9uKFIpIENQVSAgICAgICAgICAgVzU1OTAgIEAgMy4zM0dIeiBzdGVw
cGluZyAwNQpbICAgIDAuNjQ0MjMzXSBCb290aW5nIHByb2Nlc3NvciAxIEFQSUMgMHgxMiBpcCAw
eDYwMDAKWyAgICAwLjY1NDYwOF0gSW5pdGlhbGl6aW5nIENQVSMxClsgICAgMC44MDM2MzZdIENh
bGlicmF0aW5nIGRlbGF5IHVzaW5nIHRpbWVyIHNwZWNpZmljIHJvdXRpbmUuLiA2NjQ5Ljg3IEJv
Z29NSVBTIChscGo9MzMyNDkzNjIpClsgICAgMC44MDM2NDJdIENQVTogUGh5c2ljYWwgUHJvY2Vz
c29yIElEOiAxClsgICAgMC44MDM2NDNdIENQVTogUHJvY2Vzc29yIENvcmUgSUQ6IDEKWyAgICAw
LjgwMzY0NF0gQ1BVOiBMMSBJIGNhY2hlOiAzMkssIEwxIEQgY2FjaGU6IDMySwpbICAgIDAuODAz
NjQ1XSBDUFU6IEwyIGNhY2hlOiAyNTZLClsgICAgMC44MDM2NDZdIENQVTogTDMgY2FjaGU6IDgx
OTJLClsgICAgMC44MDM2NDhdIENQVSAxLzB4MTIgLT4gTm9kZSAwClsgICAgMC44MDM2NTBdIG1j
ZTogQ1BVIHN1cHBvcnRzIDkgTUNFIGJhbmtzClsgICAgMC44MDM2NTddIENQVTE6IFRoZXJtYWwg
bW9uaXRvcmluZyBlbmFibGVkIChUTTEpClsgICAgMC44MDM2NTldIENQVSAxIE1DQSBiYW5rcyBD
TUNJOjIgQ01DSTozIENNQ0k6NSBTSEQ6NiBTSEQ6OApbICAgIDAuODA0MjUxXSB4ODYgUEFUIGVu
YWJsZWQ6IGNwdSAxLCBvbGQgMHg3MDQwNjAwMDcwNDA2LCBuZXcgMHg3MDEwNjAwMDcwMTA2Clsg
ICAgMC44MDQ5MzNdIENQVTE6IEludGVsKFIpIFhlb24oUikgQ1BVICAgICAgICAgICBXNTU5MCAg
QCAzLjMzR0h6IHN0ZXBwaW5nIDA1ClsgICAgMC44MDQ5NDBdIFNraXBwaW5nIHN5bmNocm9uaXph
dGlvbiBjaGVja3MgYXMgVFNDIGlzIHJlbGlhYmxlLgpbICAgIDAuODA1MDEzXSBCb290aW5nIHBy
b2Nlc3NvciAyIEFQSUMgMHgxNCBpcCAweDYwMDAKWyAgICAwLjgxNTI5Nl0gSW5pdGlhbGl6aW5n
IENQVSMyClsgICAgMC45NjMxMjldIENhbGlicmF0aW5nIGRlbGF5IHVzaW5nIHRpbWVyIHNwZWNp
ZmljIHJvdXRpbmUuLiA2NjQ5Ljg2IEJvZ29NSVBTIChscGo9MzMyNDkzMDkpClsgICAgMC45NjMx
MzRdIENQVTogUGh5c2ljYWwgUHJvY2Vzc29yIElEOiAxClsgICAgMC45NjMxMzVdIENQVTogUHJv
Y2Vzc29yIENvcmUgSUQ6IDIKWyAgICAwLjk2MzEzN10gQ1BVOiBMMSBJIGNhY2hlOiAzMkssIEwx
IEQgY2FjaGU6IDMySwpbICAgIDAuOTYzMTM4XSBDUFU6IEwyIGNhY2hlOiAyNTZLClsgICAgMC45
NjMxMzhdIENQVTogTDMgY2FjaGU6IDgxOTJLClsgICAgMC45NjMxNDBdIENQVSAyLzB4MTQgLT4g
Tm9kZSAwClsgICAgMC45NjMxNDJdIG1jZTogQ1BVIHN1cHBvcnRzIDkgTUNFIGJhbmtzClsgICAg
MC45NjMxNDldIENQVTI6IFRoZXJtYWwgbW9uaXRvcmluZyBlbmFibGVkIChUTTEpClsgICAgMC45
NjMxNTFdIENQVSAyIE1DQSBiYW5rcyBDTUNJOjIgQ01DSTozIENNQ0k6NSBTSEQ6NiBTSEQ6OApb
ICAgIDAuOTYzNzQ0XSB4ODYgUEFUIGVuYWJsZWQ6IGNwdSAyLCBvbGQgMHg3MDQwNjAwMDcwNDA2
LCBuZXcgMHg3MDEwNjAwMDcwMTA2ClsgICAgMC45NjQ0MDVdIENQVTI6IEludGVsKFIpIFhlb24o
UikgQ1BVICAgICAgICAgICBXNTU5MCAgQCAzLjMzR0h6IHN0ZXBwaW5nIDA1ClsgICAgMC45NjQ0
MTNdIFNraXBwaW5nIHN5bmNocm9uaXphdGlvbiBjaGVja3MgYXMgVFNDIGlzIHJlbGlhYmxlLgpb
ICAgIDAuOTY0NDg4XSBCb290aW5nIHByb2Nlc3NvciAzIEFQSUMgMHgxNiBpcCAweDYwMDAKWyAg
ICAwLjk3NDc3MF0gSW5pdGlhbGl6aW5nIENQVSMzClsgICAgMS4xMjI2MjFdIENhbGlicmF0aW5n
IGRlbGF5IHVzaW5nIHRpbWVyIHNwZWNpZmljIHJvdXRpbmUuLiA2NjQ5Ljg2IEJvZ29NSVBTIChs
cGo9MzMyNDkzMzgpClsgICAgMS4xMjI2MjZdIENQVTogUGh5c2ljYWwgUHJvY2Vzc29yIElEOiAx
ClsgICAgMS4xMjI2MjddIENQVTogUHJvY2Vzc29yIENvcmUgSUQ6IDMKWyAgICAxLjEyMjYyOV0g
Q1BVOiBMMSBJIGNhY2hlOiAzMkssIEwxIEQgY2FjaGU6IDMySwpbICAgIDEuMTIyNjMwXSBDUFU6
IEwyIGNhY2hlOiAyNTZLClsgICAgMS4xMjI2MzFdIENQVTogTDMgY2FjaGU6IDgxOTJLClsgICAg
MS4xMjI2MzJdIENQVSAzLzB4MTYgLT4gTm9kZSAwClsgICAgMS4xMjI2MzRdIG1jZTogQ1BVIHN1
cHBvcnRzIDkgTUNFIGJhbmtzClsgICAgMS4xMjI2NDFdIENQVTM6IFRoZXJtYWwgbW9uaXRvcmlu
ZyBlbmFibGVkIChUTTEpClsgICAgMS4xMjI2NDRdIENQVSAzIE1DQSBiYW5rcyBDTUNJOjIgQ01D
STozIENNQ0k6NSBTSEQ6NiBTSEQ6OApbICAgIDEuMTIzMjM3XSB4ODYgUEFUIGVuYWJsZWQ6IGNw
dSAzLCBvbGQgMHg3MDQwNjAwMDcwNDA2LCBuZXcgMHg3MDEwNjAwMDcwMTA2ClsgICAgMS4xMjM5
NzhdIENQVTM6IEludGVsKFIpIFhlb24oUikgQ1BVICAgICAgICAgICBXNTU5MCAgQCAzLjMzR0h6
IHN0ZXBwaW5nIDA1ClsgICAgMS4xMjM5ODZdIFNraXBwaW5nIHN5bmNocm9uaXphdGlvbiBjaGVj
a3MgYXMgVFNDIGlzIHJlbGlhYmxlLgpbICAgIDEuMTI0MDYyXSBCb290aW5nIHByb2Nlc3NvciA0
IEFQSUMgMHgwIGlwIDB4NjAwMApbICAgIDEuMTM0MzQxXSBJbml0aWFsaXppbmcgQ1BVIzQKWyAg
ICAxLjI4MjExM10gQ2FsaWJyYXRpbmcgZGVsYXkgdXNpbmcgdGltZXIgc3BlY2lmaWMgcm91dGlu
ZS4uIDY2NDkuOTIgQm9nb01JUFMgKGxwaj0zMzI0OTYyMikKWyAgICAxLjI4MjExOV0gQ1BVOiBQ
aHlzaWNhbCBQcm9jZXNzb3IgSUQ6IDAKWyAgICAxLjI4MjExOV0gQ1BVOiBQcm9jZXNzb3IgQ29y
ZSBJRDogMApbICAgIDEuMjgyMTIxXSBDUFU6IEwxIEkgY2FjaGU6IDMySywgTDEgRCBjYWNoZTog
MzJLClsgICAgMS4yODIxMjJdIENQVTogTDIgY2FjaGU6IDI1NksKWyAgICAxLjI4MjEyM10gQ1BV
OiBMMyBjYWNoZTogODE5MksKWyAgICAxLjI4MjEyNF0gQ1BVIDQvMHgwIC0+IE5vZGUgMApbICAg
IDEuMjgyMTI2XSBtY2U6IENQVSBzdXBwb3J0cyA5IE1DRSBiYW5rcwpbICAgIDEuMjgyMTMzXSBD
UFU0OiBUaGVybWFsIG1vbml0b3JpbmcgZW5hYmxlZCAoVE0xKQpbICAgIDEuMjgyMTM2XSBDUFUg
NCBNQ0EgYmFua3MgQ01DSToyIENNQ0k6MyBDTUNJOjUgQ01DSTo2IFNIRDo4ClsgICAgMS4yODI3
MDRdIHg4NiBQQVQgZW5hYmxlZDogY3B1IDQsIG9sZCAweDcwNDA2MDAwNzA0MDYsIG5ldyAweDcw
MTA2MDAwNzAxMDYKWyAgICAxLjI4MzM3N10gQ1BVNDogSW50ZWwoUikgWGVvbihSKSBDUFUgICAg
ICAgICAgIFc1NTkwICBAIDMuMzNHSHogc3RlcHBpbmcgMDUKWyAgICAxLjI4MzM4M10gU2tpcHBp
bmcgc3luY2hyb25pemF0aW9uIGNoZWNrcyBhcyBUU0MgaXMgcmVsaWFibGUuClsgICAgMS4yODM0
MjNdIEJvb3RpbmcgcHJvY2Vzc29yIDUgQVBJQyAweDIgaXAgMHg2MDAwClsgICAgMS4yOTM3MDJd
IEluaXRpYWxpemluZyBDUFUjNQpbICAgIDEuNDQxNjA2XSBDYWxpYnJhdGluZyBkZWxheSB1c2lu
ZyB0aW1lciBzcGVjaWZpYyByb3V0aW5lLi4gNjY0OS44OSBCb2dvTUlQUyAobHBqPTMzMjQ5NDgx
KQpbICAgIDEuNDQxNjExXSBDUFU6IFBoeXNpY2FsIFByb2Nlc3NvciBJRDogMApbICAgIDEuNDQx
NjEyXSBDUFU6IFByb2Nlc3NvciBDb3JlIElEOiAxClsgICAgMS40NDE2MTNdIENQVTogTDEgSSBj
YWNoZTogMzJLLCBMMSBEIGNhY2hlOiAzMksKWyAgICAxLjQ0MTYxNF0gQ1BVOiBMMiBjYWNoZTog
MjU2SwpbICAgIDEuNDQxNjE1XSBDUFU6IEwzIGNhY2hlOiA4MTkySwpbICAgIDEuNDQxNjE2XSBD
UFUgNS8weDIgLT4gTm9kZSAwClsgICAgMS40NDE2MThdIG1jZTogQ1BVIHN1cHBvcnRzIDkgTUNF
IGJhbmtzClsgICAgMS40NDE2MjVdIENQVTU6IFRoZXJtYWwgbW9uaXRvcmluZyBlbmFibGVkIChU
TTEpClsgICAgMS40NDE2MjhdIENQVSA1IE1DQSBiYW5rcyBDTUNJOjIgQ01DSTozIENNQ0k6NSBT
SEQ6NiBTSEQ6OApbICAgIDEuNDQyMTk4XSB4ODYgUEFUIGVuYWJsZWQ6IGNwdSA1LCBvbGQgMHg3
MDQwNjAwMDcwNDA2LCBuZXcgMHg3MDEwNjAwMDcwMTA2ClsgICAgMS40NDI4NDNdIENQVTU6IElu
dGVsKFIpIFhlb24oUikgQ1BVICAgICAgICAgICBXNTU5MCAgQCAzLjMzR0h6IHN0ZXBwaW5nIDA1
ClsgICAgMS40NDI4NDldIFNraXBwaW5nIHN5bmNocm9uaXphdGlvbiBjaGVja3MgYXMgVFNDIGlz
IHJlbGlhYmxlLgpbICAgIDEuNDQyODg5XSBCb290aW5nIHByb2Nlc3NvciA2IEFQSUMgMHg0IGlw
IDB4NjAwMApbICAgIDEuNDUzMTY5XSBJbml0aWFsaXppbmcgQ1BVIzYKWyAgICAxLjYwMTA5OF0g
Q2FsaWJyYXRpbmcgZGVsYXkgdXNpbmcgdGltZXIgc3BlY2lmaWMgcm91dGluZS4uIDY2NDkuODgg
Qm9nb01JUFMgKGxwaj0zMzI0OTQyOSkKWyAgICAxLjYwMTEwM10gQ1BVOiBQaHlzaWNhbCBQcm9j
ZXNzb3IgSUQ6IDAKWyAgICAxLjYwMTEwNF0gQ1BVOiBQcm9jZXNzb3IgQ29yZSBJRDogMgpbICAg
IDEuNjAxMTA2XSBDUFU6IEwxIEkgY2FjaGU6IDMySywgTDEgRCBjYWNoZTogMzJLClsgICAgMS42
MDExMDddIENQVTogTDIgY2FjaGU6IDI1NksKWyAgICAxLjYwMTEwOF0gQ1BVOiBMMyBjYWNoZTog
ODE5MksKWyAgICAxLjYwMTEwOV0gQ1BVIDYvMHg0IC0+IE5vZGUgMApbICAgIDEuNjAxMTExXSBt
Y2U6IENQVSBzdXBwb3J0cyA5IE1DRSBiYW5rcwpbICAgIDEuNjAxMTE4XSBDUFU2OiBUaGVybWFs
IG1vbml0b3JpbmcgZW5hYmxlZCAoVE0xKQpbICAgIDEuNjAxMTIwXSBDUFUgNiBNQ0EgYmFua3Mg
Q01DSToyIENNQ0k6MyBDTUNJOjUgU0hEOjYgU0hEOjgKWyAgICAxLjYwMTY5MF0geDg2IFBBVCBl
bmFibGVkOiBjcHUgNiwgb2xkIDB4NzA0MDYwMDA3MDQwNiwgbmV3IDB4NzAxMDYwMDA3MDEwNgpb
ICAgIDEuNjAyMzc3XSBDUFU2OiBJbnRlbChSKSBYZW9uKFIpIENQVSAgICAgICAgICAgVzU1OTAg
IEAgMy4zM0dIeiBzdGVwcGluZyAwNQpbICAgIDEuNjAyMzgzXSBTa2lwcGluZyBzeW5jaHJvbml6
YXRpb24gY2hlY2tzIGFzIFRTQyBpcyByZWxpYWJsZS4KWyAgICAxLjYwMjQxOV0gQm9vdGluZyBw
cm9jZXNzb3IgNyBBUElDIDB4NiBpcCAweDYwMDAKWyAgICAxLjYxMjY5OV0gSW5pdGlhbGl6aW5n
IENQVSM3ClsgICAgMS43NjA1OTBdIENhbGlicmF0aW5nIGRlbGF5IHVzaW5nIHRpbWVyIHNwZWNp
ZmljIHJvdXRpbmUuLiA2NjQ5LjkyIEJvZ29NSVBTIChscGo9MzMyNDk2MTQpClsgICAgMS43NjA1
OTZdIENQVTogUGh5c2ljYWwgUHJvY2Vzc29yIElEOiAwClsgICAgMS43NjA1OTddIENQVTogUHJv
Y2Vzc29yIENvcmUgSUQ6IDMKWyAgICAxLjc2MDU5OF0gQ1BVOiBMMSBJIGNhY2hlOiAzMkssIEwx
IEQgY2FjaGU6IDMySwpbICAgIDEuNzYwNTk5XSBDUFU6IEwyIGNhY2hlOiAyNTZLClsgICAgMS43
NjA2MDBdIENQVTogTDMgY2FjaGU6IDgxOTJLClsgICAgMS43NjA2MDFdIENQVSA3LzB4NiAtPiBO
b2RlIDAKWyAgICAxLjc2MDYwM10gbWNlOiBDUFUgc3VwcG9ydHMgOSBNQ0UgYmFua3MKWyAgICAx
Ljc2MDYxMV0gQ1BVNzogVGhlcm1hbCBtb25pdG9yaW5nIGVuYWJsZWQgKFRNMSkKWyAgICAxLjc2
MDYxM10gQ1BVIDcgTUNBIGJhbmtzIENNQ0k6MiBDTUNJOjMgQ01DSTo1IFNIRDo2IFNIRDo4Clsg
ICAgMS43NjExODFdIHg4NiBQQVQgZW5hYmxlZDogY3B1IDcsIG9sZCAweDcwNDA2MDAwNzA0MDYs
IG5ldyAweDcwMTA2MDAwNzAxMDYKWyAgICAxLjc2MTkwN10gQ1BVNzogSW50ZWwoUikgWGVvbihS
KSBDUFUgICAgICAgICAgIFc1NTkwICBAIDMuMzNHSHogc3RlcHBpbmcgMDUKWyAgICAxLjc2MTkx
M10gU2tpcHBpbmcgc3luY2hyb25pemF0aW9uIGNoZWNrcyBhcyBUU0MgaXMgcmVsaWFibGUuClsg
ICAgMS43NjE5MTZdIEJyb3VnaHQgdXAgOCBDUFVzClsgICAgMS43NjE5MThdIFRvdGFsIG9mIDgg
cHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDUzMjAwLjEwIEJvZ29NSVBTKS4KWyAgICAxLjc2MTk3Ml0g
Q1BVMCBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgIDEuNzYxOTc0XSAgZG9tYWluIDA6IHNw
YW4gMC0zIGxldmVsIE1DClsgICAgMS43NjE5NzVdICAgZ3JvdXBzOiAwIDEgMiAzClsgICAgMS43
NjE5NzhdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgIDEuNzYxOTgwXSAgICBn
cm91cHM6IDAtMyA0LTcKWyAgICAxLjc2MTk4M10gQ1BVMSBhdHRhY2hpbmcgc2NoZWQtZG9tYWlu
OgpbICAgIDEuNzYxOTg0XSAgZG9tYWluIDA6IHNwYW4gMC0zIGxldmVsIE1DClsgICAgMS43NjE5
ODVdICAgZ3JvdXBzOiAxIDIgMyAwClsgICAgMS43NjE5ODhdICAgZG9tYWluIDE6IHNwYW4gMC03
IGxldmVsIENQVQpbICAgIDEuNzYxOTg5XSAgICBncm91cHM6IDAtMyA0LTcKWyAgICAxLjc2MTk5
Ml0gQ1BVMiBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgIDEuNzYxOTkzXSAgZG9tYWluIDA6
IHNwYW4gMC0zIGxldmVsIE1DClsgICAgMS43NjE5OTRdICAgZ3JvdXBzOiAyIDMgMCAxClsgICAg
MS43NjE5OTZdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgIDEuNzYxOTk4XSAg
ICBncm91cHM6IDAtMyA0LTcKWyAgICAxLjc2MjAwMF0gQ1BVMyBhdHRhY2hpbmcgc2NoZWQtZG9t
YWluOgpbICAgIDEuNzYyMDAxXSAgZG9tYWluIDA6IHNwYW4gMC0zIGxldmVsIE1DClsgICAgMS43
NjIwMDJdICAgZ3JvdXBzOiAzIDAgMSAyClsgICAgMS43NjIwMDVdICAgZG9tYWluIDE6IHNwYW4g
MC03IGxldmVsIENQVQpbICAgIDEuNzYyMDA2XSAgICBncm91cHM6IDAtMyA0LTcKWyAgICAxLjc2
MjAwOV0gQ1BVNCBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgIDEuNzYyMDEwXSAgZG9tYWlu
IDA6IHNwYW4gNC03IGxldmVsIE1DClsgICAgMS43NjIwMTFdICAgZ3JvdXBzOiA0IDUgNiA3Clsg
ICAgMS43NjIwMTRdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgIDEuNzYyMDE1
XSAgICBncm91cHM6IDQtNyAwLTMKWyAgICAxLjc2MjAxN10gQ1BVNSBhdHRhY2hpbmcgc2NoZWQt
ZG9tYWluOgpbICAgIDEuNzYyMDE4XSAgZG9tYWluIDA6IHNwYW4gNC03IGxldmVsIE1DClsgICAg
MS43NjIwMTldICAgZ3JvdXBzOiA1IDYgNyA0ClsgICAgMS43NjIwMjJdICAgZG9tYWluIDE6IHNw
YW4gMC03IGxldmVsIENQVQpbICAgIDEuNzYyMDIzXSAgICBncm91cHM6IDQtNyAwLTMKWyAgICAx
Ljc2MjAyNl0gQ1BVNiBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgIDEuNzYyMDI3XSAgZG9t
YWluIDA6IHNwYW4gNC03IGxldmVsIE1DClsgICAgMS43NjIwMjhdICAgZ3JvdXBzOiA2IDcgNCA1
ClsgICAgMS43NjIwMzFdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgIDEuNzYy
MDMyXSAgICBncm91cHM6IDQtNyAwLTMKWyAgICAxLjc2MjAzNV0gQ1BVNyBhdHRhY2hpbmcgc2No
ZWQtZG9tYWluOgpbICAgIDEuNzYyMDM2XSAgZG9tYWluIDA6IHNwYW4gNC03IGxldmVsIE1DClsg
ICAgMS43NjIwMzddICAgZ3JvdXBzOiA3IDQgNSA2ClsgICAgMS43NjIwNDBdICAgZG9tYWluIDE6
IHNwYW4gMC03IGxldmVsIENQVQpbICAgIDEuNzYyMDQxXSAgICBncm91cHM6IDQtNyAwLTMKWyAg
ICAxLjc2MjU0M10gcmVndWxhdG9yOiBjb3JlIHZlcnNpb24gMC41ClsgICAgMS43NjI1OTBdIE5F
VDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYKWyAgICAxLjc2MjY2NV0gQUNQSSBGQURU
IGRlY2xhcmVzIHRoZSBzeXN0ZW0gZG9lc24ndCBzdXBwb3J0IFBDSWUgQVNQTSwgc28gZGlzYWJs
ZSBpdApbICAgIDEuNzYyNjY3XSBBQ1BJOiBidXMgdHlwZSBwY2kgcmVnaXN0ZXJlZApbICAgIDEu
NzYyNzA0XSBQQ0k6IE1DRkcgY29uZmlndXJhdGlvbiAwOiBiYXNlIGY4MDAwMDAwIHNlZ21lbnQg
MCBidXNlcyAwIC0gNjMKWyAgICAxLjc2MjcwNV0gUENJOiBNQ0ZHIGFyZWEgYXQgZjgwMDAwMDAg
cmVzZXJ2ZWQgaW4gRTgyMApbICAgIDEuNzYzNjA2XSBQQ0k6IFVzaW5nIE1NQ09ORklHIGF0IGY4
MDAwMDAwIC0gZmJmZmZmZmYKWyAgICAxLjc2MzYwN10gUENJOiBVc2luZyBjb25maWd1cmF0aW9u
IHR5cGUgMSBmb3IgYmFzZSBhY2Nlc3MKWyAgICAxLjc2NDE0OV0gYmlvOiBjcmVhdGUgc2xhYiA8
YmlvLTA+IGF0IDAKWyAgICAxLjc2NDcxNV0gQUNQSTogRUM6IExvb2sgdXAgRUMgaW4gRFNEVApb
ICAgIDEuODQxNzExXSBBQ1BJOiBCSU9TIF9PU0koTGludXgpIHF1ZXJ5IGlnbm9yZWQKWyAgICAx
Ljg2MDA5OF0gQUNQSTogSW50ZXJwcmV0ZXIgZW5hYmxlZApbICAgIDEuODYwMTAwXSBBQ1BJOiAo
c3VwcG9ydHMgUzAgUzUpClsgICAgMS44NjAxMDVdIEFDUEk6IFVzaW5nIElPQVBJQyBmb3IgaW50
ZXJydXB0IHJvdXRpbmcKWyAgICAxLjk0ODkxM10gQUNQSTogTm8gZG9jayBkZXZpY2VzIGZvdW5k
LgpbICAgIDEuOTYzMTkyXSBBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW1BDSTBdICgwMDAwOjAwKQpb
ICAgIDEuOTYzMjU5XSBwY2kgMDAwMDowMDowMC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQz
aG90IEQzY29sZApbICAgIDEuOTYzMjYxXSBwY2kgMDAwMDowMDowMC4wOiBQTUUjIGRpc2FibGVk
ClsgICAgMS45NjMzMTZdIHBjaSAwMDAwOjAwOjAxLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAg
RDNob3QgRDNjb2xkClsgICAgMS45NjMzMThdIHBjaSAwMDAwOjAwOjAxLjA6IFBNRSMgZGlzYWJs
ZWQKWyAgICAxLjk2MzM3MF0gcGNpIDAwMDA6MDA6MDMuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBE
MCBEM2hvdCBEM2NvbGQKWyAgICAxLjk2MzM3M10gcGNpIDAwMDA6MDA6MDMuMDogUE1FIyBkaXNh
YmxlZApbICAgIDEuOTYzNDI2XSBwY2kgMDAwMDowMDowNy4wOiBQTUUjIHN1cHBvcnRlZCBmcm9t
IEQwIEQzaG90IEQzY29sZApbICAgIDEuOTYzNDI4XSBwY2kgMDAwMDowMDowNy4wOiBQTUUjIGRp
c2FibGVkClsgICAgMS45NjM2MTJdIHBjaSAwMDAwOjAwOjFhLjA6IHJlZyAyMCBpbyBwb3J0OiBb
MHgxZjIwLTB4MWYzZl0KWyAgICAxLjk2MzY3Nl0gcGNpIDAwMDA6MDA6MWEuMTogcmVnIDIwIGlv
IHBvcnQ6IFsweDFmMDAtMHgxZjFmXQpbICAgIDEuOTYzNzM5XSBwY2kgMDAwMDowMDoxYS4yOiBy
ZWcgMjAgaW8gcG9ydDogWzB4MWMwMC0weDFjMWZdClsgICAgMS45NjM4MDddIHBjaSAwMDAwOjAw
OjFhLjc6IHJlZyAxMCAzMmJpdCBtbWlvOiBbMHhmN2ZmZTAwMC0weGY3ZmZlM2ZmXQpbICAgIDEu
OTYzODU4XSBwY2kgMDAwMDowMDoxYS43OiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQz
Y29sZApbICAgIDEuOTYzODYxXSBwY2kgMDAwMDowMDoxYS43OiBQTUUjIGRpc2FibGVkClsgICAg
MS45NjM5MTVdIHBjaSAwMDAwOjAwOjFjLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3Qg
RDNjb2xkClsgICAgMS45NjM5MThdIHBjaSAwMDAwOjAwOjFjLjA6IFBNRSMgZGlzYWJsZWQKWyAg
ICAxLjk2Mzk3NF0gcGNpIDAwMDA6MDA6MWMuNTogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hv
dCBEM2NvbGQKWyAgICAxLjk2Mzk3N10gcGNpIDAwMDA6MDA6MWMuNTogUE1FIyBkaXNhYmxlZApb
ICAgIDEuOTY0MDI2XSBwY2kgMDAwMDowMDoxZC4wOiByZWcgMjAgaW8gcG9ydDogWzB4MWY4MC0w
eDFmOWZdClsgICAgMS45NjQwODldIHBjaSAwMDAwOjAwOjFkLjE6IHJlZyAyMCBpbyBwb3J0OiBb
MHgxZjYwLTB4MWY3Zl0KWyAgICAxLjk2NDE1M10gcGNpIDAwMDA6MDA6MWQuMjogcmVnIDIwIGlv
IHBvcnQ6IFsweDFmNDAtMHgxZjVmXQpbICAgIDEuOTY0MjIwXSBwY2kgMDAwMDowMDoxZC43OiBy
ZWcgMTAgMzJiaXQgbW1pbzogWzB4ZmY5ODAwMDAtMHhmZjk4MDNmZl0KWyAgICAxLjk2NDI3MV0g
cGNpIDAwMDA6MDA6MWQuNzogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAg
ICAxLjk2NDI3NF0gcGNpIDAwMDA6MDA6MWQuNzogUE1FIyBkaXNhYmxlZApbICAgIDEuOTY0Mzg3
XSBwY2kgMDAwMDowMDoxZi4wOiBxdWlyazogcmVnaW9uIDA4MDAtMDg3ZiBjbGFpbWVkIGJ5IElD
SDYgQUNQSS9HUElPL1RDTwpbICAgIDEuOTY0MzkwXSBwY2kgMDAwMDowMDoxZi4wOiBxdWlyazog
cmVnaW9uIDA4ODAtMDhiZiBjbGFpbWVkIGJ5IElDSDYgR1BJTwpbICAgIDEuOTY0MzkzXSBwY2kg
MDAwMDowMDoxZi4wOiBJQ0g3IExQQyBHZW5lcmljIElPIGRlY29kZSAxIFBJTyBhdCAwYzAwICht
YXNrIDAwN2YpClsgICAgMS45NjQzOTVdIHBjaSAwMDAwOjAwOjFmLjA6IElDSDcgTFBDIEdlbmVy
aWMgSU8gZGVjb2RlIDIgUElPIGF0IDAwZTAgKG1hc2sgMDAwNykKWyAgICAxLjk2NDM5OF0gcGNp
IDAwMDA6MDA6MWYuMDogSUNINyBMUEMgR2VuZXJpYyBJTyBkZWNvZGUgMyBQSU8gYXQgMDkwMCAo
bWFzayAwMDNmKQpbICAgIDEuOTY0NDU2XSBwY2kgMDAwMDowMDoxZi4yOiByZWcgMTAgaW8gcG9y
dDogWzB4MWUwMC0weDFlMDddClsgICAgMS45NjQ0NjFdIHBjaSAwMDAwOjAwOjFmLjI6IHJlZyAx
NCBpbyBwb3J0OiBbMHgxZTEwLTB4MWUxM10KWyAgICAxLjk2NDQ2NV0gcGNpIDAwMDA6MDA6MWYu
MjogcmVnIDE4IGlvIHBvcnQ6IFsweDFlMjAtMHgxZTI3XQpbICAgIDEuOTY0NDcwXSBwY2kgMDAw
MDowMDoxZi4yOiByZWcgMWMgaW8gcG9ydDogWzB4MWUzMC0weDFlMzNdClsgICAgMS45NjQ0NzRd
IHBjaSAwMDAwOjAwOjFmLjI6IHJlZyAyMCBpbyBwb3J0OiBbMHgxZWMwLTB4MWVkZl0KWyAgICAx
Ljk2NDQ3OV0gcGNpIDAwMDA6MDA6MWYuMjogcmVnIDI0IDMyYml0IG1taW86IFsweGZmOTcwMDAw
LTB4ZmY5NzA3ZmZdClsgICAgMS45NjQ1MDhdIHBjaSAwMDAwOjAwOjFmLjI6IFBNRSMgc3VwcG9y
dGVkIGZyb20gRDNob3QKWyAgICAxLjk2NDUxMF0gcGNpIDAwMDA6MDA6MWYuMjogUE1FIyBkaXNh
YmxlZApbICAgIDEuOTY0NTM2XSBwY2kgMDAwMDowMDoxZi4zOiByZWcgMTAgNjRiaXQgbW1pbzog
WzB4ZjdmZmYwMDAtMHhmN2ZmZjBmZl0KWyAgICAxLjk2NDU0N10gcGNpIDAwMDA6MDA6MWYuMzog
cmVnIDIwIGlvIHBvcnQ6IFsweGNjZTAtMHhjY2ZmXQpbICAgIDEuOTY0NjIyXSBwY2kgMDAwMDow
MTowMC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDEuOTY0NjI1
XSBwY2kgMDAwMDowMTowMC4wOiBQTUUjIGRpc2FibGVkClsgICAgMS45NjQ2NTldIHBjaSAwMDAw
OjAwOjAxLjA6IGJyaWRnZSAzMmJpdCBtbWlvOiBbMHhmM2QwMDAwMC0weGYzZGZmZmZmXQpbICAg
IDEuOTY0NjgyXSBwY2kgMDAwMDowMjowMC4wOiByZWcgMTAgMzJiaXQgbW1pbzogWzB4ZjNkZTAw
MDAtMHhmM2RlZmZmZl0KWyAgICAxLjk2NDY4OF0gcGNpIDAwMDA6MDI6MDAuMDogcmVnIDE0IDMy
Yml0IG1taW86IFsweGYzZGYwMDAwLTB4ZjNkZmZmZmZdClsgICAgMS45NjQ3NjldIHBjaSAwMDAw
OjAxOjAwLjA6IGJyaWRnZSAzMmJpdCBtbWlvOiBbMHhmM2QwMDAwMC0weGYzZGZmZmZmXQpbICAg
IDEuOTY0ODAzXSBwY2kgMDAwMDowMzowMC4wOiByZWcgMTAgMzJiaXQgbW1pbzogWzB4ZjYwMDAw
MDAtMHhmNmZmZmZmZl0KWyAgICAxLjk2NDgxMF0gcGNpIDAwMDA6MDM6MDAuMDogcmVnIDE0IDY0
Yml0IG1taW86IFsweGUwMDAwMDAwLTB4ZWZmZmZmZmZdClsgICAgMS45NjQ4MThdIHBjaSAwMDAw
OjAzOjAwLjA6IHJlZyAxYyA2NGJpdCBtbWlvOiBbMHhmNDAwMDAwMC0weGY1ZmZmZmZmXQpbICAg
IDEuOTY0ODIyXSBwY2kgMDAwMDowMzowMC4wOiByZWcgMjQgaW8gcG9ydDogWzB4YmM4MC0weGJj
ZmZdClsgICAgMS45NjQ4MjZdIHBjaSAwMDAwOjAzOjAwLjA6IHJlZyAzMCAzMmJpdCBtbWlvOiBb
MHhmN2UwMDAwMC0weGY3ZTdmZmZmXQpbICAgIDEuOTY0ODcxXSBwY2kgMDAwMDowMDowMy4wOiBi
cmlkZ2UgaW8gcG9ydDogWzB4YjAwMC0weGJmZmZdClsgICAgMS45NjQ4NzNdIHBjaSAwMDAwOjAw
OjAzLjA6IGJyaWRnZSAzMmJpdCBtbWlvOiBbMHhmNDAwMDAwMC0weGY3ZWZmZmZmXQpbICAgIDEu
OTY0ODc3XSBwY2kgMDAwMDowMDowMy4wOiBicmlkZ2UgNjRiaXQgbW1pbyBwcmVmOiBbMHhlMDAw
MDAwMC0weGVmZmZmZmZmXQpbICAgIDEuOTY0OTA5XSBwY2kgMDAwMDowNDowMC4wOiByZWcgMTAg
MzJiaXQgbW1pbzogWzB4ZjNlODAwMDAtMHhmM2U5ZmZmZl0KWyAgICAxLjk2NDkxNF0gcGNpIDAw
MDA6MDQ6MDAuMDogcmVnIDE0IDMyYml0IG1taW86IFsweGYzZWEwMDAwLTB4ZjNlYmZmZmZdClsg
ICAgMS45NjQ5MTldIHBjaSAwMDAwOjA0OjAwLjA6IHJlZyAxOCBpbyBwb3J0OiBbMHhhY2MwLTB4
YWNkZl0KWyAgICAxLjk2NDkzN10gcGNpIDAwMDA6MDQ6MDAuMDogcmVnIDMwIDMyYml0IG1taW86
IFsweGYzZjAwMDAwLTB4ZjNmMWZmZmZdClsgICAgMS45NjQ5NjBdIHBjaSAwMDAwOjA0OjAwLjA6
IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMS45NjQ5NjNdIHBjaSAw
MDAwOjA0OjAwLjA6IFBNRSMgZGlzYWJsZWQKWyAgICAxLjk2NTAwMV0gcGNpIDAwMDA6MDQ6MDAu
MTogcmVnIDEwIDMyYml0IG1taW86IFsweGYzZWMwMDAwLTB4ZjNlZGZmZmZdClsgICAgMS45NjUw
MDZdIHBjaSAwMDAwOjA0OjAwLjE6IHJlZyAxNCAzMmJpdCBtbWlvOiBbMHhmM2VlMDAwMC0weGYz
ZWZmZmZmXQpbICAgIDEuOTY1MDExXSBwY2kgMDAwMDowNDowMC4xOiByZWcgMTggaW8gcG9ydDog
WzB4YWNlMC0weGFjZmZdClsgICAgMS45NjUwMjldIHBjaSAwMDAwOjA0OjAwLjE6IHJlZyAzMCAz
MmJpdCBtbWlvOiBbMHhmM2YwMDAwMC0weGYzZjFmZmZmXQpbICAgIDEuOTY1MDUyXSBwY2kgMDAw
MDowNDowMC4xOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDEuOTY1
MDU1XSBwY2kgMDAwMDowNDowMC4xOiBQTUUjIGRpc2FibGVkClsgICAgMS45NjUwODldIHBjaSAw
MDAwOjAwOjA3LjA6IGJyaWRnZSBpbyBwb3J0OiBbMHhhMDAwLTB4YWZmZl0KWyAgICAxLjk2NTA5
MV0gcGNpIDAwMDA6MDA6MDcuMDogYnJpZGdlIDMyYml0IG1taW86IFsweGYzZTAwMDAwLTB4ZjNm
ZmZmZmZdClsgICAgMS45NjUxMjddIHBjaSAwMDAwOjA1OjAwLjA6IHJlZyAxMCBpbyBwb3J0OiBb
MHg5YzAwLTB4OWNmZl0KWyAgICAxLjk2NTEzOF0gcGNpIDAwMDA6MDU6MDAuMDogcmVnIDE0IDY0
Yml0IG1taW86IFsweGYzYmVjMDAwLTB4ZjNiZWZmZmZdClsgICAgMS45NjUxNDldIHBjaSAwMDAw
OjA1OjAwLjA6IHJlZyAxYyA2NGJpdCBtbWlvOiBbMHhmM2JmMDAwMC0weGYzYmZmZmZmXQpbICAg
IDEuOTY1MTYxXSBwY2kgMDAwMDowNTowMC4wOiByZWcgMzAgMzJiaXQgbW1pbzogWzB4ZjNjMDAw
MDAtMHhmM2NmZmZmZl0KWyAgICAxLjk2NTE4OV0gcGNpIDAwMDA6MDU6MDAuMDogc3VwcG9ydHMg
RDEgRDIKWyAgICAxLjk2NTIzM10gcGNpIDAwMDA6MDA6MWMuMDogYnJpZGdlIGlvIHBvcnQ6IFsw
eDkwMDAtMHg5ZmZmXQpbICAgIDEuOTY1MjM2XSBwY2kgMDAwMDowMDoxYy4wOiBicmlkZ2UgMzJi
aXQgbW1pbzogWzB4ZjNiMDAwMDAtMHhmM2NmZmZmZl0KWyAgICAxLjk2NTMxNl0gcGNpIDAwMDA6
MDY6MDAuMDogcmVnIDEwIDY0Yml0IG1taW86IFsweGYzYWUwMDAwLTB4ZjNhZWZmZmZdClsgICAg
MS45NjUzMzNdIHBjaSAwMDAwOjA2OjAwLjA6IHJlZyAxOCA2NGJpdCBtbWlvOiBbMHhmM2FmMDAw
MC0weGYzYWZmZmZmXQpbICAgIDEuOTY1NDExXSBwY2kgMDAwMDowNjowMC4wOiBQTUUjIHN1cHBv
cnRlZCBmcm9tIEQzaG90IEQzY29sZApbICAgIDEuOTY1NDE3XSBwY2kgMDAwMDowNjowMC4wOiBQ
TUUjIGRpc2FibGVkClsgICAgMS45NjU0NjZdIHBjaSAwMDAwOjAwOjFjLjU6IGJyaWRnZSAzMmJp
dCBtbWlvOiBbMHhmM2EwMDAwMC0weGYzYWZmZmZmXQpbICAgIDEuOTY1NTE0XSBwY2kgMDAwMDow
MDoxZS4wOiB0cmFuc3BhcmVudCBicmlkZ2UKWyAgICAxLjk2NTU0NF0gQUNQSTogUENJIEludGVy
cnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLl9QUlRdClsgICAgMS45NjYyMDddIEFDUEk6
IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJMC5QQ0kxLl9QUlRdClsgICAg
MS45NjY0OTNdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJMC5Q
Q0kyLl9QUlRdClsgICAgMS45NjY3NzZdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJs
ZSBbXF9TQl8uUENJMC5QQ0kzLl9QUlRdClsgICAgMS45NjcwNjRdIEFDUEk6IFBDSSBJbnRlcnJ1
cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJMC5QQ0k0Ll9QUlRdClsgICAgMS45NjczMzJdIEFD
UEk6IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJMC5QQ0k1Ll9QUlRdClsg
ICAgMS45Njc1OTldIEFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJ
MC5QQ0k2Ll9QUlRdClsgICAgMi44OTQwMjldIEFDUEk6IFBDSSBSb290IEJyaWRnZSBbUENJN10g
KDAwMDA6MjApClsgICAgMi44OTQwODZdIHBjaSAwMDAwOjIwOjAzLjA6IFBNRSMgc3VwcG9ydGVk
IGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMi44OTQwODhdIHBjaSAwMDAwOjIwOjAzLjA6IFBN
RSMgZGlzYWJsZWQKWyAgICAyLjg5NDEzM10gcGNpIDAwMDA6MjA6MDcuMDogUE1FIyBzdXBwb3J0
ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAyLjg5NDEzNV0gcGNpIDAwMDA6MjA6MDcuMDog
UE1FIyBkaXNhYmxlZApbICAgIDIuODk0MTc4XSBwY2kgMDAwMDoyMDowOS4wOiBQTUUjIHN1cHBv
cnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDIuODk0MTgwXSBwY2kgMDAwMDoyMDowOS4w
OiBQTUUjIGRpc2FibGVkClsgICAgMi44OTQzMjldIHBjaSAwMDAwOjIyOjAwLjA6IHJlZyAxMCAz
MmJpdCBtbWlvOiBbMHhkZmU4MDAwMC0weGRmZTlmZmZmXQpbICAgIDIuODk0MzM0XSBwY2kgMDAw
MDoyMjowMC4wOiByZWcgMTQgMzJiaXQgbW1pbzogWzB4ZGZlYTAwMDAtMHhkZmViZmZmZl0KWyAg
ICAyLjg5NDMzOV0gcGNpIDAwMDA6MjI6MDAuMDogcmVnIDE4IGlvIHBvcnQ6IFsweGVjYzAtMHhl
Y2RmXQpbICAgIDIuODk0MzU0XSBwY2kgMDAwMDoyMjowMC4wOiByZWcgMzAgMzJiaXQgbW1pbzog
WzB4ZGZmMDAwMDAtMHhkZmYxZmZmZl0KWyAgICAyLjg5NDM3NV0gcGNpIDAwMDA6MjI6MDAuMDog
UE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAyLjg5NDM3OF0gcGNpIDAw
MDA6MjI6MDAuMDogUE1FIyBkaXNhYmxlZApbICAgIDIuODk0NDExXSBwY2kgMDAwMDoyMjowMC4x
OiByZWcgMTAgMzJiaXQgbW1pbzogWzB4ZGZlYzAwMDAtMHhkZmVkZmZmZl0KWyAgICAyLjg5NDQx
Nl0gcGNpIDAwMDA6MjI6MDAuMTogcmVnIDE0IDMyYml0IG1taW86IFsweGRmZWUwMDAwLTB4ZGZl
ZmZmZmZdClsgICAgMi44OTQ0MjFdIHBjaSAwMDAwOjIyOjAwLjE6IHJlZyAxOCBpbyBwb3J0OiBb
MHhlY2UwLTB4ZWNmZl0KWyAgICAyLjg5NDQzN10gcGNpIDAwMDA6MjI6MDAuMTogcmVnIDMwIDMy
Yml0IG1taW86IFsweGRmZjAwMDAwLTB4ZGZmMWZmZmZdClsgICAgMi44OTQ0NTddIHBjaSAwMDAw
OjIyOjAwLjE6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDNob3QgRDNjb2xkClsgICAgMi44OTQ0
NjBdIHBjaSAwMDAwOjIyOjAwLjE6IFBNRSMgZGlzYWJsZWQKWyAgICAyLjg5NDQ4OF0gcGNpIDAw
MDA6MjA6MDMuMDogYnJpZGdlIGlvIHBvcnQ6IFsweGUwMDAtMHhlZmZmXQpbICAgIDIuODk0NDkw
XSBwY2kgMDAwMDoyMDowMy4wOiBicmlkZ2UgMzJiaXQgbW1pbzogWzB4ZGZlMDAwMDAtMHhkZmZm
ZmZmZl0KWyAgICAyLjg5NDUxMl0gcGNpIDAwMDA6MjA6MDcuMDogYnJpZGdlIDMyYml0IG1taW86
IFsweGRmZDAwMDAwLTB4ZGZkZmZmZmZdClsgICAgMi44OTQ1NDldIHBjaSAwMDAwOjI0OjAwLjA6
IHJlZyAxMCA2NGJpdCBtbWlvOiBbMHhkZmNmZjAwMC0weGRmY2ZmN2ZmXQpbICAgIDIuODk0NTU0
XSBwY2kgMDAwMDoyNDowMC4wOiByZWcgMTggaW8gcG9ydDogWzB4ZGMwMC0weGRjZmZdClsgICAg
Mi44OTQ1OTNdIHBjaSAwMDAwOjI0OjAwLjA6IHN1cHBvcnRzIEQyClsgICAgMi44OTQ1OTRdIHBj
aSAwMDAwOjI0OjAwLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDIgRDNob3QgRDNjb2xkClsgICAg
Mi44OTQ1OTddIHBjaSAwMDAwOjI0OjAwLjA6IFBNRSMgZGlzYWJsZWQKWyAgICAyLjg5NDYyMV0g
cGNpIDAwMDA6MjA6MDkuMDogYnJpZGdlIGlvIHBvcnQ6IFsweGQwMDAtMHhkZmZmXQpbICAgIDIu
ODk0NjI0XSBwY2kgMDAwMDoyMDowOS4wOiBicmlkZ2UgMzJiaXQgbW1pbzogWzB4ZGZjMDAwMDAt
MHhkZmNmZmZmZl0KWyAgICAyLjg5NDYzN10gQUNQSTogUENJIEludGVycnVwdCBSb3V0aW5nIFRh
YmxlIFtcX1NCXy5QQ0k3Ll9QUlRdClsgICAgMi44OTUyMjZdIEFDUEk6IFBDSSBJbnRlcnJ1cHQg
Um91dGluZyBUYWJsZSBbXF9TQl8uUENJNy5QQ0k5Ll9QUlRdClsgICAgMi44OTU1MTJdIEFDUEk6
IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJNy5QQ0lBLl9QUlRdClsgICAg
Mi44OTU3OTRdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJNy5Q
Q0lCLl9QUlRdClsgICAgMi45OTc1MjRdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQV0g
KElSUXMgMyA0IDUgNiA3IDkgMTAgKjExIDEyIDE1KQpbICAgIDIuOTk4MzA1XSBBQ1BJOiBQQ0kg
SW50ZXJydXB0IExpbmsgW0xOS0JdIChJUlFzIDMgNCA1IDYgNyA5ICoxMCAxMSAxMiAxNSkKWyAg
ICAyLjk5OTA4OF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktDXSAoSVJRcyAzICo0IDUg
NiA3IDkgMTAgMTEgMTIgMTUpClsgICAgMi45OTk4NjhdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGlu
ayBbTE5LRF0gKElSUXMgMyA0IDUgNiA3IDkgMTAgMTEgMTIgMTUpICowLCBkaXNhYmxlZC4KWyAg
ICAzLjAwMDY1Nl0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktFXSAoSVJRcyAqMyA0IDUg
NiA3IDkgMTAgMTEgMTIgMTUpClsgICAgMy4wMDE0MzFdIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGlu
ayBbTE5LRl0gKElSUXMgMyA0IDUgNiA3IDkgMTAgMTEgMTIgMTUpICowLCBkaXNhYmxlZC4KWyAg
ICAzLjAwMjIxNF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktHXSAoSVJRcyAzIDQgNSA2
IDcgKjkgMTAgMTEgMTIgMTUpClsgICAgMy4wMDI5OTldIEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGlu
ayBbTE5LSF0gKElSUXMgMyA0ICo1IDYgNyA5IDEwIDExIDEyIDE1KQpbICAgIDMuMDAzMjcwXSBT
Q1NJIHN1YnN5c3RlbSBpbml0aWFsaXplZApbICAgIDMuMDAzNDIzXSBsaWJhdGEgdmVyc2lvbiAz
LjAwIGxvYWRlZC4KWyAgICAzLjAwMzQ4M10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJm
YWNlIGRyaXZlciB1c2JmcwpbICAgIDMuMDAzNDk1XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBp
bnRlcmZhY2UgZHJpdmVyIGh1YgpbICAgIDMuMDAzNTE0XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5l
dyBkZXZpY2UgZHJpdmVyIHVzYgpbICAgIDMuMDAzNTk5XSBQQ0k6IFVzaW5nIEFDUEkgZm9yIElS
USByb3V0aW5nClsgICAgMy4wMjY2MTddIEJsdWV0b290aDogQ29yZSB2ZXIgMi4xNQpbICAgIDMu
MDI2NjUwXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDMxClsgICAgMy4wMjY2NTJd
IEJsdWV0b290aDogSENJIGRldmljZSBhbmQgY29ubmVjdGlvbiBtYW5hZ2VyIGluaXRpYWxpemVk
ClsgICAgMy4wMjY2NTVdIEJsdWV0b290aDogSENJIHNvY2tldCBsYXllciBpbml0aWFsaXplZApb
ICAgIDMuMDI2NjU3XSBOZXRMYWJlbDogSW5pdGlhbGl6aW5nClsgICAgMy4wMjY2NTldIE5ldExh
YmVsOiAgZG9tYWluIGhhc2ggc2l6ZSA9IDEyOApbICAgIDMuMDI2NjYxXSBOZXRMYWJlbDogIHBy
b3RvY29scyA9IFVOTEFCRUxFRCBDSVBTT3Y0ClsgICAgMy4wMjY2NzVdIE5ldExhYmVsOiAgdW5s
YWJlbGVkIHRyYWZmaWMgYWxsb3dlZCBieSBkZWZhdWx0ClsgICAgMy4wMjY3MzBdIGhwZXQwOiBh
dCBNTUlPIDB4ZmVkMDAwMDAsIElSUXMgMiwgOCwgMCwgMApbICAgIDMuMDI2NzMzXSBocGV0MDog
NCBjb21wYXJhdG9ycywgNjQtYml0IDE0LjMxODE4MCBNSHogY291bnRlcgpbICAgIDMuMDM2NTkx
XSBTd2l0Y2hlZCB0byBoaWdoIHJlc29sdXRpb24gbW9kZSBvbiBDUFUgMApbICAgIDMuMDM3ODYw
XSBTd2l0Y2hlZCB0byBoaWdoIHJlc29sdXRpb24gbW9kZSBvbiBDUFUgMQpbICAgIDMuMDM3ODY1
XSBTd2l0Y2hlZCB0byBoaWdoIHJlc29sdXRpb24gbW9kZSBvbiBDUFUgMgpbICAgIDMuMDM3ODcx
XSBTd2l0Y2hlZCB0byBoaWdoIHJlc29sdXRpb24gbW9kZSBvbiBDUFUgMwpbICAgIDMuMDQ0MjY4
XSBTd2l0Y2hlZCB0byBoaWdoIHJlc29sdXRpb24gbW9kZSBvbiBDUFUgNwpbICAgIDMuMDQ0Mjgw
XSBTd2l0Y2hlZCB0byBoaWdoIHJlc29sdXRpb24gbW9kZSBvbiBDUFUgNQpbICAgIDMuMDQ0Mjgy
XSBTd2l0Y2hlZCB0byBoaWdoIHJlc29sdXRpb24gbW9kZSBvbiBDUFUgNApbICAgIDMuMDQ0Mjg1
XSBTd2l0Y2hlZCB0byBoaWdoIHJlc29sdXRpb24gbW9kZSBvbiBDUFUgNgpbICAgIDMuMDY2NTAy
XSBwbnA6IFBuUCBBQ1BJIGluaXQKWyAgICAzLjA2NjUxMl0gQUNQSTogYnVzIHR5cGUgcG5wIHJl
Z2lzdGVyZWQKWyAgICAzLjA4MzQ2M10gcG5wIDAwOjAxOiBpbyByZXNvdXJjZSAoMHg4MDAtMHg4
NWYpIG92ZXJsYXBzIDAwMDA6MDA6MWYuMCBCQVIgNyAoMHg4MDAtMHg4N2YpLCBkaXNhYmxpbmcK
WyAgICAzLjA4MzQ2NV0gcG5wIDAwOjAxOiBpbyByZXNvdXJjZSAoMHg4NjAtMHg4ZmYpIG92ZXJs
YXBzIDAwMDA6MDA6MWYuMCBCQVIgNyAoMHg4MDAtMHg4N2YpLCBkaXNhYmxpbmcKWyAgICAzLjEx
MzQ1M10gcG5wOiBQblAgQUNQSTogZm91bmQgOCBkZXZpY2VzClsgICAgMy4xMTM0NTVdIEFDUEk6
IEFDUEkgYnVzIHR5cGUgcG5wIHVucmVnaXN0ZXJlZApbICAgIDMuMTEzNDYwXSBzeXN0ZW0gMDA6
MDE6IGlvcG9ydCByYW5nZSAweGMwMC0weGM3ZiBoYXMgYmVlbiByZXNlcnZlZApbICAgIDMuMTE4
MDQ4XSBwY2kgMDAwMDowNDowMC4xOiBCQVIgNjogYWRkcmVzcyBzcGFjZSBjb2xsaXNpb24gb24g
b2YgZGV2aWNlIFsweGYzZjAwMDAwLTB4ZjNmMWZmZmZdClsgICAgMy4xMTgwNTNdIHBjaSAwMDAw
OjIyOjAwLjE6IEJBUiA2OiBhZGRyZXNzIHNwYWNlIGNvbGxpc2lvbiBvbiBvZiBkZXZpY2UgWzB4
ZGZmMDAwMDAtMHhkZmYxZmZmZl0KWyAgICAzLjExODEwN10gcGNpIDAwMDA6MDE6MDAuMDogUENJ
IGJyaWRnZSwgc2Vjb25kYXJ5IGJ1cyAwMDAwOjAyClsgICAgMy4xMTgxMDhdIHBjaSAwMDAwOjAx
OjAwLjA6ICAgSU8gd2luZG93OiBkaXNhYmxlZApbICAgIDMuMTE4MTEzXSBwY2kgMDAwMDowMTow
MC4wOiAgIE1FTSB3aW5kb3c6IDB4ZjNkMDAwMDAtMHhmM2RmZmZmZgpbICAgIDMuMTE4MTE1XSBw
Y2kgMDAwMDowMTowMC4wOiAgIFBSRUZFVENIIHdpbmRvdzogZGlzYWJsZWQKWyAgICAzLjExODEx
OF0gcGNpIDAwMDA6MDA6MDEuMDogUENJIGJyaWRnZSwgc2Vjb25kYXJ5IGJ1cyAwMDAwOjAxClsg
ICAgMy4xMTgxMTldIHBjaSAwMDAwOjAwOjAxLjA6ICAgSU8gd2luZG93OiBkaXNhYmxlZApbICAg
IDMuMTE4MTIyXSBwY2kgMDAwMDowMDowMS4wOiAgIE1FTSB3aW5kb3c6IDB4ZjNkMDAwMDAtMHhm
M2RmZmZmZgpbICAgIDMuMTE4MTI1XSBwY2kgMDAwMDowMDowMS4wOiAgIFBSRUZFVENIIHdpbmRv
dzogZGlzYWJsZWQKWyAgICAzLjExODEyN10gcGNpIDAwMDA6MDA6MDMuMDogUENJIGJyaWRnZSwg
c2Vjb25kYXJ5IGJ1cyAwMDAwOjAzClsgICAgMy4xMTgxMjldIHBjaSAwMDAwOjAwOjAzLjA6ICAg
SU8gd2luZG93OiAweGIwMDAtMHhiZmZmClsgICAgMy4xMTgxMzJdIHBjaSAwMDAwOjAwOjAzLjA6
ICAgTUVNIHdpbmRvdzogMHhmNDAwMDAwMC0weGY3ZWZmZmZmClsgICAgMy4xMTgxMzVdIHBjaSAw
MDAwOjAwOjAzLjA6ICAgUFJFRkVUQ0ggd2luZG93OiAweDAwMDAwMGUwMDAwMDAwLTB4MDAwMDAw
ZWZmZmZmZmYKWyAgICAzLjExODEzOV0gcGNpIDAwMDA6MDA6MDcuMDogUENJIGJyaWRnZSwgc2Vj
b25kYXJ5IGJ1cyAwMDAwOjA0ClsgICAgMy4xMTgxNDFdIHBjaSAwMDAwOjAwOjA3LjA6ICAgSU8g
d2luZG93OiAweGEwMDAtMHhhZmZmClsgICAgMy4xMTgxNDRdIHBjaSAwMDAwOjAwOjA3LjA6ICAg
TUVNIHdpbmRvdzogMHhmM2UwMDAwMC0weGYzZmZmZmZmClsgICAgMy4xMTgxNDddIHBjaSAwMDAw
OjAwOjA3LjA6ICAgUFJFRkVUQ0ggd2luZG93OiAweGQ4MDAwMDAwLTB4ZDgwZmZmZmYKWyAgICAz
LjExODE0OV0gcGNpIDAwMDA6MDA6MWMuMDogUENJIGJyaWRnZSwgc2Vjb25kYXJ5IGJ1cyAwMDAw
OjA1ClsgICAgMy4xMTgxNTFdIHBjaSAwMDAwOjAwOjFjLjA6ICAgSU8gd2luZG93OiAweDkwMDAt
MHg5ZmZmClsgICAgMy4xMTgxNTVdIHBjaSAwMDAwOjAwOjFjLjA6ICAgTUVNIHdpbmRvdzogMHhm
M2IwMDAwMC0weGYzY2ZmZmZmClsgICAgMy4xMTgxNThdIHBjaSAwMDAwOjAwOjFjLjA6ICAgUFJF
RkVUQ0ggd2luZG93OiBkaXNhYmxlZApbICAgIDMuMTE4MTYwXSBwY2kgMDAwMDowMDoxYy41OiBQ
Q0kgYnJpZGdlLCBzZWNvbmRhcnkgYnVzIDAwMDA6MDYKWyAgICAzLjExODE2MV0gcGNpIDAwMDA6
MDA6MWMuNTogICBJTyB3aW5kb3c6IGRpc2FibGVkClsgICAgMy4xMTgxNjVdIHBjaSAwMDAwOjAw
OjFjLjU6ICAgTUVNIHdpbmRvdzogMHhmM2EwMDAwMC0weGYzYWZmZmZmClsgICAgMy4xMTgxNjhd
IHBjaSAwMDAwOjAwOjFjLjU6ICAgUFJFRkVUQ0ggd2luZG93OiBkaXNhYmxlZApbICAgIDMuMTE4
MTcwXSBwY2kgMDAwMDowMDoxZS4wOiBQQ0kgYnJpZGdlLCBzZWNvbmRhcnkgYnVzIDAwMDA6MDcK
WyAgICAzLjExODE3MV0gcGNpIDAwMDA6MDA6MWUuMDogICBJTyB3aW5kb3c6IGRpc2FibGVkClsg
ICAgMy4xMTgxNzVdIHBjaSAwMDAwOjAwOjFlLjA6ICAgTUVNIHdpbmRvdzogZGlzYWJsZWQKWyAg
ICAzLjExODE3N10gcGNpIDAwMDA6MDA6MWUuMDogICBQUkVGRVRDSCB3aW5kb3c6IGRpc2FibGVk
ClsgICAgMy4xMTgxODddIHBjaSAwMDAwOjAwOjAxLjA6IFBDSSBJTlQgQSAtPiBHU0kgMTYgKGxl
dmVsLCBsb3cpIC0+IElSUSAxNgpbICAgIDMuMTE4MTkwXSBwY2kgMDAwMDowMDowMS4wOiBzZXR0
aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgICAzLjExODE5OF0gcGNpIDAwMDA6MDE6MDAuMDog
UENJIElOVCBBIC0+IEdTSSAyOCAobGV2ZWwsIGxvdykgLT4gSVJRIDI4ClsgICAgMy4xMTgyMDFd
IHBjaSAwMDAwOjAxOjAwLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApbICAgIDMuMTE4
MjA1XSBwY2kgMDAwMDowMDowMy4wOiBQQ0kgSU5UIEEgLT4gR1NJIDE2IChsZXZlbCwgbG93KSAt
PiBJUlEgMTYKWyAgICAzLjExODIwOF0gcGNpIDAwMDA6MDA6MDMuMDogc2V0dGluZyBsYXRlbmN5
IHRpbWVyIHRvIDY0ClsgICAgMy4xMTgyMTJdIHBjaSAwMDAwOjAwOjA3LjA6IFBDSSBJTlQgQSAt
PiBHU0kgMTYgKGxldmVsLCBsb3cpIC0+IElSUSAxNgpbICAgIDMuMTE4MjE0XSBwY2kgMDAwMDow
MDowNy4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgICAzLjExODIxOV0gcGNpIDAw
MDA6MDA6MWMuMDogUENJIElOVCBBIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykgLT4gSVJRIDE2Clsg
ICAgMy4xMTgyMjJdIHBjaSAwMDAwOjAwOjFjLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2
NApbICAgIDMuMTE4MjI5XSBwY2kgMDAwMDowMDoxYy41OiBQQ0kgSU5UIEIgLT4gR1NJIDE3IChs
ZXZlbCwgbG93KSAtPiBJUlEgMTcKWyAgICAzLjExODIzMV0gcGNpIDAwMDA6MDA6MWMuNTogc2V0
dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgMy4xMTgyMzZdIHBjaSAwMDAwOjAwOjFlLjA6
IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApbICAgIDMuMTE4MjQxXSBwY2kgMDAwMDoyMDow
My4wOiBQQ0kgYnJpZGdlLCBzZWNvbmRhcnkgYnVzIDAwMDA6MjIKWyAgICAzLjExODI0Ml0gcGNp
IDAwMDA6MjA6MDMuMDogICBJTyB3aW5kb3c6IDB4ZTAwMC0weGVmZmYKWyAgICAzLjExODI0NV0g
cGNpIDAwMDA6MjA6MDMuMDogICBNRU0gd2luZG93OiAweGRmZTAwMDAwLTB4ZGZmZmZmZmYKWyAg
ICAzLjExODI0OF0gcGNpIDAwMDA6MjA6MDMuMDogICBQUkVGRVRDSCB3aW5kb3c6IDB4ZDgxMDAw
MDAtMHhkODFmZmZmZgpbICAgIDMuMTE4MjUwXSBwY2kgMDAwMDoyMDowNy4wOiBQQ0kgYnJpZGdl
LCBzZWNvbmRhcnkgYnVzIDAwMDA6MjMKWyAgICAzLjExODI1MV0gcGNpIDAwMDA6MjA6MDcuMDog
ICBJTyB3aW5kb3c6IGRpc2FibGVkClsgICAgMy4xMTgyNTRdIHBjaSAwMDAwOjIwOjA3LjA6ICAg
TUVNIHdpbmRvdzogMHhkZmQwMDAwMC0weGRmZGZmZmZmClsgICAgMy4xMTgyNTZdIHBjaSAwMDAw
OjIwOjA3LjA6ICAgUFJFRkVUQ0ggd2luZG93OiBkaXNhYmxlZApbICAgIDMuMTE4MjU4XSBwY2kg
MDAwMDoyMDowOS4wOiBQQ0kgYnJpZGdlLCBzZWNvbmRhcnkgYnVzIDAwMDA6MjQKWyAgICAzLjEx
ODI2MF0gcGNpIDAwMDA6MjA6MDkuMDogICBJTyB3aW5kb3c6IDB4ZDAwMC0weGRmZmYKWyAgICAz
LjExODI2Ml0gcGNpIDAwMDA6MjA6MDkuMDogICBNRU0gd2luZG93OiAweGRmYzAwMDAwLTB4ZGZj
ZmZmZmYKWyAgICAzLjExODI2NF0gcGNpIDAwMDA6MjA6MDkuMDogICBQUkVGRVRDSCB3aW5kb3c6
IGRpc2FibGVkClsgICAgMy4xMTgyNjldIHBjaSAwMDAwOjIwOjAzLjA6IFBDSSBJTlQgQSAtPiBH
U0kgMTYgKGxldmVsLCBsb3cpIC0+IElSUSAxNgpbICAgIDMuMTE4MjcxXSBwY2kgMDAwMDoyMDow
My4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgICAzLjExODI3NV0gcGNpIDAwMDA6
MjA6MDcuMDogUENJIElOVCBBIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykgLT4gSVJRIDE2ClsgICAg
My4xMTgyNzhdIHBjaSAwMDAwOjIwOjA3LjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApb
ICAgIDMuMTE4MjgyXSBwY2kgMDAwMDoyMDowOS4wOiBQQ0kgSU5UIEEgLT4gR1NJIDE2IChsZXZl
bCwgbG93KSAtPiBJUlEgMTYKWyAgICAzLjExODI4NF0gcGNpIDAwMDA6MjA6MDkuMDogc2V0dGlu
ZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgMy4xMTgyODZdIHBjaV9idXMgMDAwMDowMDogcmVz
b3VyY2UgMCBpbzogIFsweDAwLTB4ZmZmZl0KWyAgICAzLjExODI4N10gcGNpX2J1cyAwMDAwOjAw
OiByZXNvdXJjZSAxIG1lbTogWzB4MDAwMDAwLTB4ZmZmZmZmZmZmZmZmZmZmZl0KWyAgICAzLjEx
ODI4OV0gcGNpX2J1cyAwMDAwOjAxOiByZXNvdXJjZSAxIG1lbTogWzB4ZjNkMDAwMDAtMHhmM2Rm
ZmZmZl0KWyAgICAzLjExODI5MF0gcGNpX2J1cyAwMDAwOjAyOiByZXNvdXJjZSAxIG1lbTogWzB4
ZjNkMDAwMDAtMHhmM2RmZmZmZl0KWyAgICAzLjExODI5MV0gcGNpX2J1cyAwMDAwOjAzOiByZXNv
dXJjZSAwIGlvOiAgWzB4YjAwMC0weGJmZmZdClsgICAgMy4xMTgyOTJdIHBjaV9idXMgMDAwMDow
MzogcmVzb3VyY2UgMSBtZW06IFsweGY0MDAwMDAwLTB4ZjdlZmZmZmZdClsgICAgMy4xMTgyOTRd
IHBjaV9idXMgMDAwMDowMzogcmVzb3VyY2UgMiBwcmVmIG1lbSBbMHhlMDAwMDAwMC0weGVmZmZm
ZmZmXQpbICAgIDMuMTE4Mjk1XSBwY2lfYnVzIDAwMDA6MDQ6IHJlc291cmNlIDAgaW86ICBbMHhh
MDAwLTB4YWZmZl0KWyAgICAzLjExODI5Nl0gcGNpX2J1cyAwMDAwOjA0OiByZXNvdXJjZSAxIG1l
bTogWzB4ZjNlMDAwMDAtMHhmM2ZmZmZmZl0KWyAgICAzLjExODI5N10gcGNpX2J1cyAwMDAwOjA0
OiByZXNvdXJjZSAyIHByZWYgbWVtIFsweGQ4MDAwMDAwLTB4ZDgwZmZmZmZdClsgICAgMy4xMTgy
OThdIHBjaV9idXMgMDAwMDowNTogcmVzb3VyY2UgMCBpbzogIFsweDkwMDAtMHg5ZmZmXQpbICAg
IDMuMTE4MzAwXSBwY2lfYnVzIDAwMDA6MDU6IHJlc291cmNlIDEgbWVtOiBbMHhmM2IwMDAwMC0w
eGYzY2ZmZmZmXQpbICAgIDMuMTE4MzAxXSBwY2lfYnVzIDAwMDA6MDY6IHJlc291cmNlIDEgbWVt
OiBbMHhmM2EwMDAwMC0weGYzYWZmZmZmXQpbICAgIDMuMTE4MzAyXSBwY2lfYnVzIDAwMDA6MDc6
IHJlc291cmNlIDMgaW86ICBbMHgwMC0weGZmZmZdClsgICAgMy4xMTgzMDNdIHBjaV9idXMgMDAw
MDowNzogcmVzb3VyY2UgNCBtZW06IFsweDAwMDAwMC0weGZmZmZmZmZmZmZmZmZmZmZdClsgICAg
My4xMTgzMDVdIHBjaV9idXMgMDAwMDoyMDogcmVzb3VyY2UgMCBpbzogIFsweDAwLTB4ZmZmZl0K
WyAgICAzLjExODMwNl0gcGNpX2J1cyAwMDAwOjIwOiByZXNvdXJjZSAxIG1lbTogWzB4MDAwMDAw
LTB4ZmZmZmZmZmZmZmZmZmZmZl0KWyAgICAzLjExODMwN10gcGNpX2J1cyAwMDAwOjIyOiByZXNv
dXJjZSAwIGlvOiAgWzB4ZTAwMC0weGVmZmZdClsgICAgMy4xMTgzMDhdIHBjaV9idXMgMDAwMDoy
MjogcmVzb3VyY2UgMSBtZW06IFsweGRmZTAwMDAwLTB4ZGZmZmZmZmZdClsgICAgMy4xMTgzMTBd
IHBjaV9idXMgMDAwMDoyMjogcmVzb3VyY2UgMiBwcmVmIG1lbSBbMHhkODEwMDAwMC0weGQ4MWZm
ZmZmXQpbICAgIDMuMTE4MzExXSBwY2lfYnVzIDAwMDA6MjM6IHJlc291cmNlIDEgbWVtOiBbMHhk
ZmQwMDAwMC0weGRmZGZmZmZmXQpbICAgIDMuMTE4MzEyXSBwY2lfYnVzIDAwMDA6MjQ6IHJlc291
cmNlIDAgaW86ICBbMHhkMDAwLTB4ZGZmZl0KWyAgICAzLjExODMxM10gcGNpX2J1cyAwMDAwOjI0
OiByZXNvdXJjZSAxIG1lbTogWzB4ZGZjMDAwMDAtMHhkZmNmZmZmZl0KWyAgICAzLjExODMzMV0g
TkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyClsgICAgMy4xMTg1NzldIElQIHJvdXRl
IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTI0Mjg4IChvcmRlcjogMTAsIDQxOTQzMDQgYnl0
ZXMpClsgICAgMy4xMTk1NDRdIFRDUCBlc3RhYmxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDUy
NDI4OCAob3JkZXI6IDExLCA4Mzg4NjA4IGJ5dGVzKQpbICAgIDMuMTIwODc2XSBUQ1AgYmluZCBo
YXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogOCwgMTA0ODU3NiBieXRlcykKWyAgICAz
LjEyMTAzMl0gVENQOiBIYXNoIHRhYmxlcyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCA1MjQyODgg
YmluZCA2NTUzNikKWyAgICAzLjEyMTAzNF0gVENQIHJlbm8gcmVnaXN0ZXJlZApbICAgIDMuMTIx
MTE4XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEKWyAgICAzLjEyMTE2Ml0gVHJ5
aW5nIHRvIHVucGFjayByb290ZnMgaW1hZ2UgYXMgaW5pdHJhbWZzLi4uClsgICAgMy4yMTkyMTNd
IEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogNzU0OGsgZnJlZWQKWyAgICAzLjIyMDUwN10gU2ltcGxl
IEJvb3QgRmxhZyBhdCAweDdhIHNldCB0byAweDEKWyAgICAzLjIyMDg0NV0gU2Nhbm5pbmcgZm9y
IGxvdyBtZW1vcnkgY29ycnVwdGlvbiBldmVyeSA2MCBzZWNvbmRzClsgICAgMy4yMjA5MjFdIGF1
ZGl0OiBpbml0aWFsaXppbmcgbmV0bGluayBzb2NrZXQgKGRpc2FibGVkKQpbICAgIDMuMjIwOTMw
XSB0eXBlPTIwMDAgYXVkaXQoMTI4ODMwMzgxOS45NjA6MSk6IGluaXRpYWxpemVkClsgICAgMy4y
MjMyNzddIEktcGlwZTogRG9tYWluIFhlbm9tYWkgcmVnaXN0ZXJlZC4KWyAgICAzLjIyMzQyMF0g
WGVub21haTogaGFsL3g4Nl82NCBzdGFydGVkLgpbICAgIDMuMjIzNDM0XSBYZW5vbWFpOiBzY2hl
ZHVsaW5nIGNsYXNzIGlkbGUgcmVnaXN0ZXJlZC4KWyAgICAzLjIyMzQzNV0gWGVub21haTogc2No
ZWR1bGluZyBjbGFzcyBydCByZWdpc3RlcmVkLgpbICAgIDMuMjIzOTk4XSBYZW5vbWFpOiByZWFs
LXRpbWUgbnVjbGV1cyB2Mi41LjQgKFNsZWVwIFdhbGspIGxvYWRlZC4KWyAgICAzLjIyNDYzNF0g
WGVub21haTogU01JLWVuYWJsZWQgY2hpcHNldCBmb3VuZCwgYnV0IFNNSSB3b3JrYXJvdW5kIGRp
c2FibGVkClsgICAgMy4yMjQ2MzVdICAgICAgICAgIChjaGVjayBDT05GSUdfWEVOT19IV19TTUlf
V09SS0FST1VORCkuIFlvdSBtYXkgZW5jb3VudGVyClsgICAgMy4yMjQ2MzZdICAgICAgICAgIGhp
Z2ggaW50ZXJydXB0IGxhdGVuY2llcyEKWyAgICAzLjIyNDczMV0gWGVub21haTogc3RhcnRpbmcg
bmF0aXZlIEFQSSBzZXJ2aWNlcy4KWyAgICAzLjIyNDczMl0gWGVub21haTogc3RhcnRpbmcgUE9T
SVggc2VydmljZXMuClsgICAgMy4yMjQ3NTJdIFhlbm9tYWk6IHN0YXJ0aW5nIFJURE0gc2Vydmlj
ZXMuClsgICAgMy4yMjYzNDNdIEh1Z2VUTEIgcmVnaXN0ZXJlZCAyIE1CIHBhZ2Ugc2l6ZSwgcHJl
LWFsbG9jYXRlZCAwIHBhZ2VzClsgICAgMy4yMjcyNzVdIFZGUzogRGlzayBxdW90YXMgZHF1b3Rf
Ni41LjIKWyAgICAzLjIyNzMwNV0gRHF1b3QtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIg
KG9yZGVyIDAsIDQwOTYgYnl0ZXMpClsgICAgMy4yMjc2ODldIGZ1c2UgaW5pdCAoQVBJIHZlcnNp
b24gNy4xMikKWyAgICAzLjIyNzc0Nl0gbXNnbW5pIGhhcyBiZWVuIHNldCB0byAzMjc2OApbICAg
IDMuMjI4MDI5XSBhbGc6IE5vIHRlc3QgZm9yIHN0ZHJuZyAoa3JuZykKWyAgICAzLjIyODAzOV0g
aW8gc2NoZWR1bGVyIG5vb3AgcmVnaXN0ZXJlZApbICAgIDMuMjI4MDQwXSBpbyBzY2hlZHVsZXIg
YW50aWNpcGF0b3J5IHJlZ2lzdGVyZWQKWyAgICAzLjIyODA0MV0gaW8gc2NoZWR1bGVyIGRlYWRs
aW5lIHJlZ2lzdGVyZWQKWyAgICAzLjIyODA2N10gaW8gc2NoZWR1bGVyIGNmcSByZWdpc3RlcmVk
IChkZWZhdWx0KQpbICAgIDMuMjI4MjAxXSBwY2kgMDAwMDowMzowMC4wOiBCb290IHZpZGVvIGRl
dmljZQpbICAgIDMuMjI4MzA3XSBwY2llcG9ydC1kcml2ZXIgMDAwMDowMDowMS4wOiBzZXR0aW5n
IGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgICAzLjIyODQwN10gcGNpZXBvcnQtZHJpdmVyIDAwMDA6
MDA6MDMuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgMy4yMjg0OTldIHBjaWVw
b3J0LWRyaXZlciAwMDAwOjAwOjA3LjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApbICAg
IDMuMjI4NTc2XSBwY2llcG9ydC1kcml2ZXIgMDAwMDowMDoxYy4wOiBzZXR0aW5nIGxhdGVuY3kg
dGltZXIgdG8gNjQKWyAgICAzLjIyODY2MV0gcGNpZXBvcnQtZHJpdmVyIDAwMDA6MDA6MWMuNTog
c2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgMy4yMjg3OTVdIHBjaWVwb3J0LWRyaXZl
ciAwMDAwOjIwOjAzLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApbICAgIDMuMjI4ODgx
XSBwY2llcG9ydC1kcml2ZXIgMDAwMDoyMDowNy4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8g
NjQKWyAgICAzLjIyODk1OV0gcGNpZXBvcnQtZHJpdmVyIDAwMDA6MjA6MDkuMDogc2V0dGluZyBs
YXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgMy4yMjkwMTJdIGFlciAwMDAwOjAwOjAxLjA6cGNpZTAy
OiBBRVIgc2VydmljZSBjb3VsZG4ndCBpbml0IGRldmljZTogbm8gX09TQyBzdXBwb3J0ClsgICAg
My4yMjkwMTZdIGFlciAwMDAwOjAwOjAzLjA6cGNpZTAyOiBBRVIgc2VydmljZSBjb3VsZG4ndCBp
bml0IGRldmljZTogbm8gX09TQyBzdXBwb3J0ClsgICAgMy4yMjkwMTldIGFlciAwMDAwOjAwOjA3
LjA6cGNpZTAyOiBBRVIgc2VydmljZSBjb3VsZG4ndCBpbml0IGRldmljZTogbm8gX09TQyBzdXBw
b3J0ClsgICAgMy4yMjkwMjNdIGFlciAwMDAwOjIwOjAzLjA6cGNpZTAyOiBBRVIgc2VydmljZSBj
b3VsZG4ndCBpbml0IGRldmljZTogbm8gX09TQyBzdXBwb3J0ClsgICAgMy4yMjkwMjZdIGFlciAw
MDAwOjIwOjA3LjA6cGNpZTAyOiBBRVIgc2VydmljZSBjb3VsZG4ndCBpbml0IGRldmljZTogbm8g
X09TQyBzdXBwb3J0ClsgICAgMy4yMjkwMjhdIGFlciAwMDAwOjIwOjA5LjA6cGNpZTAyOiBBRVIg
c2VydmljZSBjb3VsZG4ndCBpbml0IGRldmljZTogbm8gX09TQyBzdXBwb3J0ClsgICAgMy4yMjkw
MzNdIHBjaV9ob3RwbHVnOiBQQ0kgSG90IFBsdWcgUENJIENvcmUgdmVyc2lvbjogMC41ClsgICAg
My4yMjkwNDhdIHBjaWVocDogUENJIEV4cHJlc3MgSG90IFBsdWcgQ29udHJvbGxlciBEcml2ZXIg
dmVyc2lvbjogMC40ClsgICAgMy4yMjkxMTFdIGlucHV0OiBQb3dlciBCdXR0b24gYXMgL2Rldmlj
ZXMvTE5YU1lTVE06MDAvTE5YUFdSQk46MDAvaW5wdXQvaW5wdXQwClsgICAgMy4yMjkxMTNdIEFD
UEk6IFBvd2VyIEJ1dHRvbiBbUFdSRl0KWyAgICAzLjIyOTE0NF0gaW5wdXQ6IFBvd2VyIEJ1dHRv
biBhcyAvZGV2aWNlcy9MTlhTWVNUTTowMC9kZXZpY2U6MDAvUE5QMEMwQzowMC9pbnB1dC9pbnB1
dDEKWyAgICAzLjIyOTE0OF0gQUNQSTogUG93ZXIgQnV0dG9uIFtWQlROXQpbICAgIDMuMjI5OTY2
XSBMaW51eCBhZ3BnYXJ0IGludGVyZmFjZSB2MC4xMDMKWyAgICAzLjIyOTk3M10gU2VyaWFsOiA4
MjUwLzE2NTUwIGRyaXZlciwgNCBwb3J0cywgSVJRIHNoYXJpbmcgZW5hYmxlZApbICAgIDMuMjMw
NTk4XSBicmQ6IG1vZHVsZSBsb2FkZWQKWyAgICAzLjIzMDgzNF0gbG9vcDogbW9kdWxlIGxvYWRl
ZApbICAgIDMuMjMwODc4XSBpbnB1dDogTWFjaW50b3NoIG1vdXNlIGJ1dHRvbiBlbXVsYXRpb24g
YXMgL2RldmljZXMvdmlydHVhbC9pbnB1dC9pbnB1dDIKWyAgICAzLjIzMDkzNl0gYWhjaSAwMDAw
OjAwOjFmLjI6IHZlcnNpb24gMy4wClsgICAgMy4yMzA5NDldIGFoY2kgMDAwMDowMDoxZi4yOiBQ
Q0kgSU5UIEMgLT4gR1NJIDIwIChsZXZlbCwgbG93KSAtPiBJUlEgMjAKWyAgICAzLjIzMTAyMV0g
YWhjaSAwMDAwOjAwOjFmLjI6IEFIQ0kgMDAwMS4wMjAwIDMyIHNsb3RzIDYgcG9ydHMgMyBHYnBz
IDB4MjcgaW1wbCBTQVRBIG1vZGUKWyAgICAzLjIzMTAyM10gYWhjaSAwMDAwOjAwOjFmLjI6IGZs
YWdzOiA2NGJpdCBuY3Egc250ZiBsZWQgY2xvIHBpbyBlbXMgClsgICAgMy4yMzEwMjZdIGFoY2kg
MDAwMDowMDoxZi4yOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgICAzLjI4NTkyMl0g
c2NzaTAgOiBhaGNpClsgICAgMy4yODU5NzRdIHNjc2kxIDogYWhjaQpbICAgIDMuMjg2MDI3XSBz
Y3NpMiA6IGFoY2kKWyAgICAzLjI4NjA1N10gc2NzaTMgOiBhaGNpClsgICAgMy4yODYwOTFdIHNj
c2k0IDogYWhjaQpbICAgIDMuMjg2MTQxXSBzY3NpNSA6IGFoY2kKWyAgICAzLjI4NjE2MF0gYXRh
MTogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtMjA0OEAweGZmOTcwMDAwIHBvcnQgMHhmZjk3MDEw
MCBpcnEgMjAKWyAgICAzLjI4NjE2Ml0gYXRhMjogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtMjA0
OEAweGZmOTcwMDAwIHBvcnQgMHhmZjk3MDE4MCBpcnEgMjAKWyAgICAzLjI4NjE2NF0gYXRhMzog
U0FUQSBtYXggVURNQS8xMzMgYWJhciBtMjA0OEAweGZmOTcwMDAwIHBvcnQgMHhmZjk3MDIwMCBp
cnEgMjAKWyAgICAzLjI4NjE2NV0gYXRhNDogRFVNTVkKWyAgICAzLjI4NjE2Nl0gYXRhNTogRFVN
TVkKWyAgICAzLjI4NjE2N10gYXRhNjogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtMjA0OEAweGZm
OTcwMDAwIHBvcnQgMHhmZjk3MDM4MCBpcnEgMjAKWyAgICAzLjI4NjYxMl0gRml4ZWQgTURJTyBC
dXM6IHByb2JlZApbICAgIDMuMjg2NjI4XSBQUFAgZ2VuZXJpYyBkcml2ZXIgdmVyc2lvbiAyLjQu
MgpbICAgIDMuMjg2NjY5XSBlaGNpX2hjZDogVVNCIDIuMCAnRW5oYW5jZWQnIEhvc3QgQ29udHJv
bGxlciAoRUhDSSkgRHJpdmVyClsgICAgMy4yODY3MDhdIGVoY2lfaGNkIDAwMDA6MDA6MWEuNzog
UENJIElOVCBDIC0+IEdTSSAyMiAobGV2ZWwsIGxvdykgLT4gSVJRIDIyClsgICAgMy4yODY3MTZd
IGVoY2lfaGNkIDAwMDA6MDA6MWEuNzogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAg
My4yODY3MTldIGVoY2lfaGNkIDAwMDA6MDA6MWEuNzogRUhDSSBIb3N0IENvbnRyb2xsZXIKWyAg
ICAzLjI4Njc0MV0gZWhjaV9oY2QgMDAwMDowMDoxYS43OiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVk
LCBhc3NpZ25lZCBidXMgbnVtYmVyIDEKWyAgICAzLjI5MDYxOF0gZWhjaV9oY2QgMDAwMDowMDox
YS43OiBkZWJ1ZyBwb3J0IDEKWyAgICAzLjI5MDYyMl0gZWhjaV9oY2QgMDAwMDowMDoxYS43OiBj
YWNoZSBsaW5lIHNpemUgb2YgMzIgaXMgbm90IHN1cHBvcnRlZApbICAgIDMuMjkwNjMxXSBlaGNp
X2hjZCAwMDAwOjAwOjFhLjc6IGlycSAyMiwgaW8gbWVtIDB4ZjdmZmUwMDAKWyAgICAzLjMwNTc3
N10gZWhjaV9oY2QgMDAwMDowMDoxYS43OiBVU0IgMi4wIHN0YXJ0ZWQsIEVIQ0kgMS4wMApbICAg
IDMuMzA1ODYyXSB1c2IgdXNiMTogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2lj
ZQpbICAgIDMuMzA1ODgwXSBodWIgMS0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDMuMzA1ODg3
XSBodWIgMS0wOjEuMDogNiBwb3J0cyBkZXRlY3RlZApbICAgIDMuMzA1OTUwXSBlaGNpX2hjZCAw
MDAwOjAwOjFkLjc6IFBDSSBJTlQgQSAtPiBHU0kgMjMgKGxldmVsLCBsb3cpIC0+IElSUSAyMwpb
ICAgIDMuMzA1OTU3XSBlaGNpX2hjZCAwMDAwOjAwOjFkLjc6IHNldHRpbmcgbGF0ZW5jeSB0aW1l
ciB0byA2NApbICAgIDMuMzA1OTYwXSBlaGNpX2hjZCAwMDAwOjAwOjFkLjc6IEVIQ0kgSG9zdCBD
b250cm9sbGVyClsgICAgMy4zMDU5NzZdIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogbmV3IFVTQiBi
dXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAyClsgICAgMy4zMDk4NzNdIGVoY2lf
aGNkIDAwMDA6MDA6MWQuNzogZGVidWcgcG9ydCAxClsgICAgMy4zMDk4NzddIGVoY2lfaGNkIDAw
MDA6MDA6MWQuNzogY2FjaGUgbGluZSBzaXplIG9mIDMyIGlzIG5vdCBzdXBwb3J0ZWQKWyAgICAz
LjMwOTg4Nl0gZWhjaV9oY2QgMDAwMDowMDoxZC43OiBpcnEgMjMsIGlvIG1lbSAweGZmOTgwMDAw
ClsgICAgMy4zMjU3MTldIGVoY2lfaGNkIDAwMDA6MDA6MWQuNzogVVNCIDIuMCBzdGFydGVkLCBF
SENJIDEuMDAKWyAgICAzLjMyNTc5NV0gdXNiIHVzYjI6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2Vu
IGZyb20gMSBjaG9pY2UKWyAgICAzLjMyNTgxMl0gaHViIDItMDoxLjA6IFVTQiBodWIgZm91bmQK
WyAgICAzLjMyNTgxNV0gaHViIDItMDoxLjA6IDYgcG9ydHMgZGV0ZWN0ZWQKWyAgICAzLjMyNTg1
Nl0gb2hjaV9oY2Q6IFVTQiAxLjEgJ09wZW4nIEhvc3QgQ29udHJvbGxlciAoT0hDSSkgRHJpdmVy
ClsgICAgMy4zMjU4NjRdIHVoY2lfaGNkOiBVU0IgVW5pdmVyc2FsIEhvc3QgQ29udHJvbGxlciBJ
bnRlcmZhY2UgZHJpdmVyClsgICAgMy4zMjU5MTVdIHVoY2lfaGNkIDAwMDA6MDA6MWEuMDogUENJ
IElOVCBBIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykgLT4gSVJRIDE2ClsgICAgMy4zMjU5MjFdIHVo
Y2lfaGNkIDAwMDA6MDA6MWEuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgMy4z
MjU5MjVdIHVoY2lfaGNkIDAwMDA6MDA6MWEuMDogVUhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICAz
LjMyNTk0OV0gdWhjaV9oY2QgMDAwMDowMDoxYS4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBh
c3NpZ25lZCBidXMgbnVtYmVyIDMKWyAgICAzLjMyNTk3Nl0gdWhjaV9oY2QgMDAwMDowMDoxYS4w
OiBpcnEgMTYsIGlvIGJhc2UgMHgwMDAwMWYyMApbICAgIDMuMzI2MDIwXSB1c2IgdXNiMzogY29u
ZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQpbICAgIDMuMzI2MDM1XSBodWIgMy0w
OjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDMuMzI2MDM5XSBodWIgMy0wOjEuMDogMiBwb3J0cyBk
ZXRlY3RlZApbICAgIDMuMzI2MDg1XSB1aGNpX2hjZCAwMDAwOjAwOjFhLjE6IFBDSSBJTlQgQiAt
PiBHU0kgMTcgKGxldmVsLCBsb3cpIC0+IElSUSAxNwpbICAgIDMuMzI2MDkzXSB1aGNpX2hjZCAw
MDAwOjAwOjFhLjE6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApbICAgIDMuMzI2MDk3XSB1
aGNpX2hjZCAwMDAwOjAwOjFhLjE6IFVIQ0kgSG9zdCBDb250cm9sbGVyClsgICAgMy4zMjYxMzNd
IHVoY2lfaGNkIDAwMDA6MDA6MWEuMTogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQg
YnVzIG51bWJlciA0ClsgICAgMy4zMjYxNjBdIHVoY2lfaGNkIDAwMDA6MDA6MWEuMTogaXJxIDE3
LCBpbyBiYXNlIDB4MDAwMDFmMDAKWyAgICAzLjMyNjIwMF0gdXNiIHVzYjQ6IGNvbmZpZ3VyYXRp
b24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKWyAgICAzLjMyNjIxNF0gaHViIDQtMDoxLjA6IFVT
QiBodWIgZm91bmQKWyAgICAzLjMyNjIxN10gaHViIDQtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQK
WyAgICAzLjMyNjI2NF0gdWhjaV9oY2QgMDAwMDowMDoxYS4yOiBQQ0kgSU5UIEMgLT4gR1NJIDIy
IChsZXZlbCwgbG93KSAtPiBJUlEgMjIKWyAgICAzLjMyNjI2OF0gdWhjaV9oY2QgMDAwMDowMDox
YS4yOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgICAzLjMyNjI3MF0gdWhjaV9oY2Qg
MDAwMDowMDoxYS4yOiBVSENJIEhvc3QgQ29udHJvbGxlcgpbICAgIDMuMzI2Mjg4XSB1aGNpX2hj
ZCAwMDAwOjAwOjFhLjI6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1i
ZXIgNQpbICAgIDMuMzI2MzA4XSB1aGNpX2hjZCAwMDAwOjAwOjFhLjI6IGlycSAyMiwgaW8gYmFz
ZSAweDAwMDAxYzAwClsgICAgMy4zMjYzNDhdIHVzYiB1c2I1OiBjb25maWd1cmF0aW9uICMxIGNo
b3NlbiBmcm9tIDEgY2hvaWNlClsgICAgMy4zMjYzNjBdIGh1YiA1LTA6MS4wOiBVU0IgaHViIGZv
dW5kClsgICAgMy4zMjYzNjVdIGh1YiA1LTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkClsgICAgMy4z
MjY0MTNdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMDogUENJIElOVCBBIC0+IEdTSSAyMyAobGV2ZWws
IGxvdykgLT4gSVJRIDIzClsgICAgMy4zMjY0MTddIHVoY2lfaGNkIDAwMDA6MDA6MWQuMDogc2V0
dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgMy4zMjY0MTldIHVoY2lfaGNkIDAwMDA6MDA6
MWQuMDogVUhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICAzLjMyNjQzNV0gdWhjaV9oY2QgMDAwMDow
MDoxZC4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDYKWyAg
ICAzLjMyNjQ1NV0gdWhjaV9oY2QgMDAwMDowMDoxZC4wOiBpcnEgMjMsIGlvIGJhc2UgMHgwMDAw
MWY4MApbICAgIDMuMzI2NDk1XSB1c2IgdXNiNjogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJv
bSAxIGNob2ljZQpbICAgIDMuMzI2NTA3XSBodWIgNi0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAg
IDMuMzI2NTEwXSBodWIgNi0wOjEuMDogMiBwb3J0cyBkZXRlY3RlZApbICAgIDMuMzI2NTU4XSB1
aGNpX2hjZCAwMDAwOjAwOjFkLjE6IFBDSSBJTlQgQiAtPiBHU0kgMTcgKGxldmVsLCBsb3cpIC0+
IElSUSAxNwpbICAgIDMuMzI2NTYxXSB1aGNpX2hjZCAwMDAwOjAwOjFkLjE6IHNldHRpbmcgbGF0
ZW5jeSB0aW1lciB0byA2NApbICAgIDMuMzI2NTY0XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjE6IFVI
Q0kgSG9zdCBDb250cm9sbGVyClsgICAgMy4zMjY1ODNdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMTog
bmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciA3ClsgICAgMy4zMjY2
MDNdIHVoY2lfaGNkIDAwMDA6MDA6MWQuMTogaXJxIDE3LCBpbyBiYXNlIDB4MDAwMDFmNjAKWyAg
ICAzLjMyNjY0M10gdXNiIHVzYjc6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9p
Y2UKWyAgICAzLjMyNjY1NV0gaHViIDctMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgICAzLjMyNjY1
OV0gaHViIDctMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKWyAgICAzLjMyNjcxMV0gdWhjaV9oY2Qg
MDAwMDowMDoxZC4yOiBQQ0kgSU5UIEMgLT4gR1NJIDE4IChsZXZlbCwgbG93KSAtPiBJUlEgMTgK
WyAgICAzLjMyNjcxOF0gdWhjaV9oY2QgMDAwMDowMDoxZC4yOiBzZXR0aW5nIGxhdGVuY3kgdGlt
ZXIgdG8gNjQKWyAgICAzLjMyNjcyMV0gdWhjaV9oY2QgMDAwMDowMDoxZC4yOiBVSENJIEhvc3Qg
Q29udHJvbGxlcgpbICAgIDMuMzI2NzQ4XSB1aGNpX2hjZCAwMDAwOjAwOjFkLjI6IG5ldyBVU0Ig
YnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgOApbICAgIDMuMzI2Nzc2XSB1aGNp
X2hjZCAwMDAwOjAwOjFkLjI6IGlycSAxOCwgaW8gYmFzZSAweDAwMDAxZjQwClsgICAgMy4zMjY4
MTZdIHVzYiB1c2I4OiBjb25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlClsgICAg
My4zMjY4MzBdIGh1YiA4LTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgMy4zMjY4MzVdIGh1YiA4
LTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkClsgICAgMy4zMjY4ODRdIFBOUDogTm8gUFMvMiBjb250
cm9sbGVyIGZvdW5kLiBQcm9iaW5nIHBvcnRzIGRpcmVjdGx5LgpbICAgIDMuMzI5MzEyXSBzZXJp
bzogaTgwNDIgS0JEIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxClsgICAgMy4zMjkzMTZdIHNlcmlv
OiBpODA0MiBBVVggcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEyClsgICAgMy4zMjkzNThdIG1pY2U6
IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UKWyAgICAzLjMyOTQxOF0gcnRj
X2Ntb3MgMDA6MDU6IFJUQyBjYW4gd2FrZSBmcm9tIFM0ClsgICAgMy4zMjk0MzddIHJ0Y19jbW9z
IDAwOjA1OiBydGMgY29yZTogcmVnaXN0ZXJlZCBydGNfY21vcyBhcyBydGMwClsgICAgMy4zMjk0
NjFdIHJ0YzA6IGFsYXJtcyB1cCB0byBvbmUgZGF5LCAyNDIgYnl0ZXMgbnZyYW0sIGhwZXQgaXJx
cwpbICAgIDMuMzI5NTIwXSBkZXZpY2UtbWFwcGVyOiB1ZXZlbnQ6IHZlcnNpb24gMS4wLjMKWyAg
ICAzLjMyOTU4OV0gZGV2aWNlLW1hcHBlcjogaW9jdGw6IDQuMTUuMC1pb2N0bCAoMjAwOS0wNC0w
MSkgaW5pdGlhbGlzZWQ6IGRtLWRldmVsQHJlZGhhdC5jb20KWyAgICAzLjMyOTcxOF0gZGV2aWNl
LW1hcHBlcjogbXVsdGlwYXRoOiB2ZXJzaW9uIDEuMS4wIGxvYWRlZApbICAgIDMuMzI5NzIwXSBk
ZXZpY2UtbWFwcGVyOiBtdWx0aXBhdGggcm91bmQtcm9iaW46IHZlcnNpb24gMS4wLjAgbG9hZGVk
ClsgICAgMy4zMjk3NzJdIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIGxhZGRlcgpbICAgIDMuMzI5
Nzc0XSBjcHVpZGxlOiB1c2luZyBnb3Zlcm5vciBtZW51ClsgICAgMy4zMjk5ODZdIFRDUCBjdWJp
YyByZWdpc3RlcmVkClsgICAgMy4zMzAwNjBdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1p
bHkgMTAKWyAgICAzLjMzMDMxOV0gbG86IERpc2FibGVkIFByaXZhY3kgRXh0ZW5zaW9ucwpbICAg
IDMuMzMwNDc5XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3ClsgICAgMy4zMzA0
ODldIEJsdWV0b290aDogTDJDQVAgdmVyIDIuMTMKWyAgICAzLjMzMDQ4OV0gQmx1ZXRvb3RoOiBM
MkNBUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgICAzLjMzMDQ5MV0gQmx1ZXRvb3RoOiBT
Q08gKFZvaWNlIExpbmspIHZlciAwLjYKWyAgICAzLjMzMDQ5Ml0gQmx1ZXRvb3RoOiBTQ08gc29j
a2V0IGxheWVyIGluaXRpYWxpemVkClsgICAgMy4zMzA1MTVdIEJsdWV0b290aDogUkZDT01NIFRU
WSBsYXllciBpbml0aWFsaXplZApbICAgIDMuMzMwNTE2XSBCbHVldG9vdGg6IFJGQ09NTSBzb2Nr
ZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgICAzLjMzMDUxN10gQmx1ZXRvb3RoOiBSRkNPTU0gdmVy
IDEuMTEKWyAgICAzLjMzMDU1OF0gcmVnaXN0ZXJlZCB0YXNrc3RhdHMgdmVyc2lvbiAxClsgICAg
My4zMzA2OTFdIHJ0Y19jbW9zIDAwOjA1OiBzZXR0aW5nIHN5c3RlbSBjbG9jayB0byAyMDEwLTEw
LTI4IDIyOjEwOjIwIFVUQyAoMTI4ODMwMzgyMCkKWyAgICAzLjMzMDY5M10gQklPUyBFREQgZmFj
aWxpdHkgdjAuMTYgMjAwNC1KdW4tMjUsIDAgZGV2aWNlcyBmb3VuZApbICAgIDMuMzMwNjk0XSBF
REQgaW5mb3JtYXRpb24gbm90IGF2YWlsYWJsZS4KWyAgICAzLjYyNzkyN10gdXNiIDEtMjogbmV3
IGhpZ2ggc3BlZWQgVVNCIGRldmljZSB1c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyAyClsgICAg
My42Mzc5MDZdIGF0YTE6IFNBVEEgbGluayB1cCAxLjUgR2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRy
b2wgMzAwKQpbICAgIDMuNjM3OTI1XSBhdGEyOiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyA0IFND
b250cm9sIDMwMCkKWyAgICAzLjYzNzk0NF0gYXRhMzogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMg
NCBTQ29udHJvbCAzMDApClsgICAgMy42Mzc5NjFdIGF0YTY6IFNBVEEgbGluayBkb3duIChTU3Rh
dHVzIDQgU0NvbnRyb2wgMzAwKQpbICAgIDMuNjM4NTgwXSBhdGExLjAwOiBBVEFQSTogVFNTVGNv
cnAgRFZEKy8tUlcgVFMtSDY1M0csIERXMTAsIG1heCBVRE1BLzEwMCwgQVRBUEkgQU4KWyAgICAz
LjYzODU5M10gYXRhMS4wMDogYXBwbHlpbmcgYnJpZGdlIGxpbWl0cwpbICAgIDMuNjM5NjcwXSBh
dGExLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEwMApbICAgIDMuNjQwODE3XSBzY3NpIDA6MDow
OjA6IENELVJPTSAgICAgICAgICAgIFRTU1Rjb3JwIERWRCstUlcgVFMtSDY1M0cgRFcxMCBQUTog
MCBBTlNJOiA1ClsgICAgMy42NDI3NDhdIHNyMDogc2NzaTMtbW1jIGRyaXZlOiAxMjV4LzEyNXgg
d3JpdGVyIGR2ZC1yYW0gY2QvcncgeGEvZm9ybTIgY2RkYSB0cmF5ClsgICAgMy42NDI3NTJdIFVu
aWZvcm0gQ0QtUk9NIGRyaXZlciBSZXZpc2lvbjogMy4yMApbICAgIDMuNjQyODIxXSBzciAwOjA6
MDowOiBBdHRhY2hlZCBzY3NpIENELVJPTSBzcjAKWyAgICAzLjY0Mjg1MF0gc3IgMDowOjA6MDog
QXR0YWNoZWQgc2NzaSBnZW5lcmljIHNnMCB0eXBlIDUKWyAgICAzLjY0Mjg5NV0gRnJlZWluZyB1
bnVzZWQga2VybmVsIG1lbW9yeTogODY4ayBmcmVlZApbICAgIDMuNjk1OTk4XSBlMTAwMGU6IElu
dGVsKFIpIFBSTy8xMDAwIE5ldHdvcmsgRHJpdmVyIC0gMS4wLjItazIKWyAgICAzLjY5NjAwMF0g
ZTEwMDBlOiBDb3B5cmlnaHQgKGMpIDE5OTktMjAwOCBJbnRlbCBDb3Jwb3JhdGlvbi4KWyAgICAz
LjY5NjU1M10gZTEwMDBlIDAwMDA6MDQ6MDAuMDogUENJIElOVCBBIC0+IEdTSSAzMCAobGV2ZWws
IGxvdykgLT4gSVJRIDMwClsgICAgMy42OTY1NjldIGUxMDAwZSAwMDAwOjA0OjAwLjA6IHNldHRp
bmcgbGF0ZW5jeSB0aW1lciB0byA2NApbICAgIDMuNjk2NjM2XSAwMDAwOjA0OjAwLjA6IDAwMDA6
MDQ6MDAuMDogRmFpbGVkIHRvIGluaXRpYWxpemUgTVNJIGludGVycnVwdHMuICBGYWxsaW5nIGJh
Y2sgdG8gbGVnYWN5IGludGVycnVwdHMuClsgICAgMy43MDA5NDVdIEZ1c2lvbiBNUFQgYmFzZSBk
cml2ZXIgMy4wNC4xMApbICAgIDMuNzAwOTQ2XSBDb3B5cmlnaHQgKGMpIDE5OTktMjAwOCBMU0kg
Q29ycG9yYXRpb24KWyAgICAzLjcwNjg0Nl0gRnVzaW9uIE1QVCBTQVMgSG9zdCBkcml2ZXIgMy4w
NC4xMApbICAgIDMuNzA3NjE2XSBtcHRzYXMgMDAwMDowNTowMC4wOiBQQ0kgSU5UIEEgLT4gR1NJ
IDE2IChsZXZlbCwgbG93KSAtPiBJUlEgMTYKWyAgICAzLjcwNzY4MV0gbXB0YmFzZTogaW9jMDog
SW5pdGlhdGluZyBicmluZ3VwClsgICAgMy43MTA3MzVdIHRnMy5jOnYzLjk5IChBcHJpbCAyMCwg
MjAwOSkKWyAgICAzLjcxMDc0NV0gdGczIDAwMDA6MDY6MDAuMDogUENJIElOVCBBIC0+IEdTSSAx
NyAobGV2ZWwsIGxvdykgLT4gSVJRIDE3ClsgICAgMy43MTA3NTFdIHRnMyAwMDAwOjA2OjAwLjA6
IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApbICAgIDMuNzE3NzE1XSBvaGNpMTM5NCAwMDAw
OjI0OjAwLjA6IFBDSSBJTlQgQSAtPiBHU0kgNTYgKGxldmVsLCBsb3cpIC0+IElSUSA1NgpbICAg
IDMuNzE3NzE5XSBvaGNpMTM5NCAwMDAwOjI0OjAwLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0
byA2NApbICAgIDMuNzM0NTcxXSB0ZzMgMDAwMDowNjowMC4wOiBQTUUjIGRpc2FibGVkClsgICAg
My43NTg3ODJdIGV0aDA6IFRpZ29uMyBbcGFydG5vKEJDTTk1NzYxKSByZXYgNTc2MTEwMF0gKFBD
SSBFeHByZXNzKSBNQUMgYWRkcmVzcyBiODphYzo2ZjozODoyODo5NgpbICAgIDMuNzU4Nzg1XSBl
dGgwOiBhdHRhY2hlZCBQSFkgaXMgNTc2MSAoMTAvMTAwLzEwMDBCYXNlLVQgRXRoZXJuZXQpIChX
aXJlU3BlZWRbMV0pClsgICAgMy43NTg3ODZdIGV0aDA6IFJYY3N1bXNbMV0gTGlua0NoZ1JFR1sw
XSBNSWlycVswXSBBU0ZbMF0gVFNPY2FwWzFdClsgICAgMy43NTg3ODddIGV0aDA6IGRtYV9yd2N0
cmxbNzYxODAwMDBdIGRtYV9tYXNrWzY0LWJpdF0KWyAgICAzLjc4NjM1NF0gb2hjaTEzOTQ6IGZ3
LWhvc3QwOiBPSENJLTEzOTQgMS4xIChQQ0kpOiBJUlE9WzU2XSAgTU1JTz1bZGZjZmYwMDAtZGZj
ZmY3ZmZdICBNYXggUGFja2V0PVsyMDQ4XSAgSVIvSVQgY29udGV4dHM9WzQvOF0KWyAgICAzLjc5
NTI3N10gdXNiIDEtMjogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQpbICAg
IDMuNzk1NDM5XSBodWIgMS0yOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDMuNzk1NTkxXSBodWIg
MS0yOjEuMDogMiBwb3J0cyBkZXRlY3RlZApbICAgIDMuOTEzOTM2XSB1c2IgMi0yOiBuZXcgaGln
aCBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIGVoY2lfaGNkIGFuZCBhZGRyZXNzIDIKWyAgICAzLjk0
NjYwNl0gMDAwMDowNDowMC4wOiBldGgxOiAoUENJIEV4cHJlc3M6Mi41R0IvczpXaWR0aCB4NCkg
MDA6MTU6MTc6ZWE6NDk6NTYKWyAgICAzLjk0NjYwN10gMDAwMDowNDowMC4wOiBldGgxOiBJbnRl
bChSKSBQUk8vMTAwMCBOZXR3b3JrIENvbm5lY3Rpb24KWyAgICAzLjk0NjY4NF0gMDAwMDowNDow
MC4wOiBldGgxOiBNQUM6IDAsIFBIWTogNCwgUEJBIE5vOiBkNTA4NjgtMDA0ClsgICAgMy45NDY3
NjJdIGUxMDAwZSAwMDAwOjA0OjAwLjE6IFBDSSBJTlQgQiAtPiBHU0kgMzcgKGxldmVsLCBsb3cp
IC0+IElSUSAzNwpbICAgIDMuOTQ2Nzc3XSBlMTAwMGUgMDAwMDowNDowMC4xOiBzZXR0aW5nIGxh
dGVuY3kgdGltZXIgdG8gNjQKWyAgICAzLjk0NjgzNF0gMDAwMDowNDowMC4xOiAwMDAwOjA0OjAw
LjE6IEZhaWxlZCB0byBpbml0aWFsaXplIE1TSSBpbnRlcnJ1cHRzLiAgRmFsbGluZyBiYWNrIHRv
IGxlZ2FjeSBpbnRlcnJ1cHRzLgpbICAgIDQuMDU1NDkyXSB1c2IgMi0yOiBjb25maWd1cmF0aW9u
ICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlClsgICAgNC4wNTkzNTZdIEluaXRpYWxpemluZyBVU0Ig
TWFzcyBTdG9yYWdlIGRyaXZlci4uLgpbICAgIDQuMDU5NDM4XSBzY3NpNiA6IFNDU0kgZW11bGF0
aW9uIGZvciBVU0IgTWFzcyBTdG9yYWdlIGRldmljZXMKWyAgICA0LjA1OTUxM10gdXNiLXN0b3Jh
Z2U6IGRldmljZSBmb3VuZCBhdCAyClsgICAgNC4wNTk1MTZdIHVzYmNvcmU6IHJlZ2lzdGVyZWQg
bmV3IGludGVyZmFjZSBkcml2ZXIgdXNiLXN0b3JhZ2UKWyAgICA0LjA1OTUxOF0gdXNiLXN0b3Jh
Z2U6IHdhaXRpbmcgZm9yIGRldmljZSB0byBzZXR0bGUgYmVmb3JlIHNjYW5uaW5nClsgICAgNC4w
NTk1MjFdIFVTQiBNYXNzIFN0b3JhZ2Ugc3VwcG9ydCByZWdpc3RlcmVkLgpbICAgIDQuMTMzNDA1
XSB1c2IgMS0yLjE6IG5ldyBoaWdoIHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5k
IGFkZHJlc3MgMwpbICAgIDQuMTc1OTI0XSAwMDAwOjA0OjAwLjE6IGV0aDI6IChQQ0kgRXhwcmVz
czoyLjVHQi9zOldpZHRoIHg0KSAwMDoxNToxNzplYTo0OTo1NwpbICAgIDQuMTc1OTI1XSAwMDAw
OjA0OjAwLjE6IGV0aDI6IEludGVsKFIpIFBSTy8xMDAwIE5ldHdvcmsgQ29ubmVjdGlvbgpbICAg
IDQuMTc2MDAyXSAwMDAwOjA0OjAwLjE6IGV0aDI6IE1BQzogMCwgUEhZOiA0LCBQQkEgTm86IGQ1
MDg2OC0wMDQKWyAgICA0LjE3NjEyMF0gZTEwMDBlIDAwMDA6MjI6MDAuMDogUENJIElOVCBBIC0+
IEdTSSA0OCAobGV2ZWwsIGxvdykgLT4gSVJRIDQ4ClsgICAgNC4xNzYxMzldIGUxMDAwZSAwMDAw
OjIyOjAwLjA6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApbICAgIDQuMTc2MjAzXSAwMDAw
OjIyOjAwLjA6IDAwMDA6MjI6MDAuMDogRmFpbGVkIHRvIGluaXRpYWxpemUgTVNJIGludGVycnVw
dHMuICBGYWxsaW5nIGJhY2sgdG8gbGVnYWN5IGludGVycnVwdHMuClsgICAgNC4yNDMzNDldIHVz
YiAxLTIuMTogY29uZmlndXJhdGlvbiAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQpbICAgIDQuMjQz
NTEwXSBodWIgMS0yLjE6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgNC4yNDM2NzJdIGh1YiAxLTIu
MToxLjA6IDQgcG9ydHMgZGV0ZWN0ZWQKWyAgICA0LjMyMjgwMV0gdXNiIDEtMi4yOiBuZXcgbG93
IHNwZWVkIFVTQiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgNApbICAgIDQuNDE1
MTg5XSAwMDAwOjIyOjAwLjA6IGV0aDM6IChQQ0kgRXhwcmVzczoyLjVHQi9zOldpZHRoIHg0KSAw
MDoxNToxNzplYTo0ODpkNgpbICAgIDQuNDE1MTkxXSAwMDAwOjIyOjAwLjA6IGV0aDM6IEludGVs
KFIpIFBSTy8xMDAwIE5ldHdvcmsgQ29ubmVjdGlvbgpbICAgIDQuNDE1MjY2XSAwMDAwOjIyOjAw
LjA6IGV0aDM6IE1BQzogMCwgUEhZOiA0LCBQQkEgTm86IGQ1MDg2OC0wMDQKWyAgICA0LjQxNTMz
MV0gZTEwMDBlIDAwMDA6MjI6MDAuMTogUENJIElOVCBCIC0+IEdTSSA1OCAobGV2ZWwsIGxvdykg
LT4gSVJRIDU4ClsgICAgNC40MTUzNDVdIGUxMDAwZSAwMDAwOjIyOjAwLjE6IHNldHRpbmcgbGF0
ZW5jeSB0aW1lciB0byA2NApbICAgIDQuNDE1Mzg4XSAwMDAwOjIyOjAwLjE6IDAwMDA6MjI6MDAu
MTogRmFpbGVkIHRvIGluaXRpYWxpemUgTVNJIGludGVycnVwdHMuICBGYWxsaW5nIGJhY2sgdG8g
bGVnYWN5IGludGVycnVwdHMuClsgICAgNC40NDgyMDVdIHVzYiAxLTIuMjogY29uZmlndXJhdGlv
biAjMSBjaG9zZW4gZnJvbSAxIGNob2ljZQpbICAgIDQuNDUxNjI3XSB1c2Jjb3JlOiByZWdpc3Rl
cmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGhpZGRldgpbICAgIDQuNDUzMjU0XSBpbnB1dDogRGVs
bCBEZWxsIFVTQiBPcHRpY2FsIE1vdXNlIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDox
YS43L3VzYjEvMS0yLzEtMi4yLzEtMi4yOjEuMC9pbnB1dC9pbnB1dDMKWyAgICA0LjQ1MzI5MV0g
Z2VuZXJpYy11c2IgMDAwMzo0MTNDOjMwMTIuMDAwMTogaW5wdXQsaGlkcmF3MDogVVNCIEhJRCB2
MS4xMSBNb3VzZSBbRGVsbCBEZWxsIFVTQiBPcHRpY2FsIE1vdXNlXSBvbiB1c2ItMDAwMDowMDox
YS43LTIuMi9pbnB1dDAKWyAgICA0LjQ1MzI5N10gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgaW50
ZXJmYWNlIGRyaXZlciB1c2JoaWQKWyAgICA0LjQ1MzI5OF0gdXNiaGlkOiB2Mi42OlVTQiBISUQg
Y29yZSBkcml2ZXIKWyAgICA0LjUzMjE0Nl0gdXNiIDEtMi4xLjE6IG5ldyBoaWdoIHNwZWVkIFVT
QiBkZXZpY2UgdXNpbmcgZWhjaV9oY2QgYW5kIGFkZHJlc3MgNQpbICAgIDQuNjY0NDUwXSAwMDAw
OjIyOjAwLjE6IGV0aDQ6IChQQ0kgRXhwcmVzczoyLjVHQi9zOldpZHRoIHg0KSAwMDoxNToxNzpl
YTo0ODpkNwpbICAgIDQuNjY0NDUyXSAwMDAwOjIyOjAwLjE6IGV0aDQ6IEludGVsKFIpIFBSTy8x
MDAwIE5ldHdvcmsgQ29ubmVjdGlvbgpbICAgIDQuNjY0NTI3XSAwMDAwOjIyOjAwLjE6IGV0aDQ6
IE1BQzogMCwgUEhZOiA0LCBQQkEgTm86IGQ1MDg2OC0wMDQKWyAgICA0LjcxODQ3N10gdXNiIDEt
Mi4xLjE6IGNvbmZpZ3VyYXRpb24gIzEgY2hvc2VuIGZyb20gMSBjaG9pY2UKWyAgICA0LjcxODY2
M10gc2NzaTcgOiBTQ1NJIGVtdWxhdGlvbiBmb3IgVVNCIE1hc3MgU3RvcmFnZSBkZXZpY2VzClsg
ICAgNC43MTg3MTZdIHVzYi1zdG9yYWdlOiBkZXZpY2UgZm91bmQgYXQgNQpbICAgIDQuNzE4NzE3
XSB1c2Itc3RvcmFnZTogd2FpdGluZyBmb3IgZGV2aWNlIHRvIHNldHRsZSBiZWZvcmUgc2Nhbm5p
bmcKWyAgICA0LjgwMTQyMV0gdXNiIDEtMi4xLjI6IG5ldyBsb3cgc3BlZWQgVVNCIGRldmljZSB1
c2luZyBlaGNpX2hjZCBhbmQgYWRkcmVzcyA2ClsgICAgNC45MjYxOTZdIHVzYiAxLTIuMS4yOiBj
b25maWd1cmF0aW9uICMxIGNob3NlbiBmcm9tIDEgY2hvaWNlClsgICAgNC45Mjg4ODhdIGlucHV0
OiBERUxMIERlbGwgUXVpZXRLZXkgS2V5Ym9hcmQgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAw
OjAwOjFhLjcvdXNiMS8xLTIvMS0yLjEvMS0yLjEuMi8xLTIuMS4yOjEuMC9pbnB1dC9pbnB1dDQK
WyAgICA0LjkyODkyMl0gZ2VuZXJpYy11c2IgMDAwMzo0MTNDOjIxMDYuMDAwMjogaW5wdXQsaGlk
cmF3MTogVVNCIEhJRCB2MS4xMCBLZXlib2FyZCBbREVMTCBEZWxsIFF1aWV0S2V5IEtleWJvYXJk
XSBvbiB1c2ItMDAwMDowMDoxYS43LTIuMS4yL2lucHV0MApbICAgIDUuMTE2MTUwXSBpZWVlMTM5
NDogTm9kZSBhZGRlZDogSUQ6QlVTWzAtMDA6MTAyM10gIEdVSURbMDBiMDlkMDEwMDk5YTgwM10K
WyAgICA1LjExNjMzOF0gaWVlZTEzOTQ6IEhvc3QgYWRkZWQ6IElEOkJVU1swLTAxOjEwMjNdICBH
VUlEWzAwMTEwNjY2MDAwMDA3MDldClsgICAgNS4yNjk4MzBdIGlvYzA6IExTSVNBUzEwNjhFIEIz
OiBDYXBhYmlsaXRpZXM9e0luaXRpYXRvcn0KWyAgICA1LjI2OTg0M10gbXB0c2FzIDAwMDA6MDU6
MDAuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgOS4wMzg2MTldIHVzYi1zdG9y
YWdlOiBkZXZpY2Ugc2NhbiBjb21wbGV0ZQpbICAgIDkuMDM5MTE0XSBzY3NpIDY6MDowOjA6IERp
cmVjdC1BY2Nlc3MgICAgIEdlbmVyaWMtIFNEL01NQyAgICAgICAgICAgMS4wMCBQUTogMCBBTlNJ
OiAwClsgICAgOS4wMzk2MDRdIHNjc2kgNjowOjA6MTogRGlyZWN0LUFjY2VzcyAgICAgR2VuZXJp
Yy0gQ29tcGFjdCBGbGFzaCAgICAxLjAxIFBROiAwIEFOU0k6IDAKWyAgICA5LjA0MDEwMl0gc2Nz
aSA2OjA6MDoyOiBEaXJlY3QtQWNjZXNzICAgICBHZW5lcmljLSBTTS94RCBQaWN0dXJlICAgIDEu
MDIgUFE6IDAgQU5TSTogMApbICAgIDkuMDQwNjAwXSBzY3NpIDY6MDowOjM6IERpcmVjdC1BY2Nl
c3MgICAgIEdlbmVyaWMtIE1TL01TLVBybyAgICAgICAgMS4wMyBQUTogMCBBTlNJOiAwClsgICAg
OS4wNDA5NjBdIHNkIDY6MDowOjA6IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzEgdHlwZSAwClsg
ICAgOS4wNDEwMDNdIHNkIDY6MDowOjE6IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzIgdHlwZSAw
ClsgICAgOS4wNDEwNTZdIHNkIDY6MDowOjI6IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzMgdHlw
ZSAwClsgICAgOS4wNDEwOTZdIHNkIDY6MDowOjM6IEF0dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzQg
dHlwZSAwClsgICAgOS4wNDQ1NzVdIHNkIDY6MDowOjE6IFtzZGJdIEF0dGFjaGVkIFNDU0kgcmVt
b3ZhYmxlIGRpc2sKWyAgICA5LjA0NTE5Nl0gc2QgNjowOjA6MjogW3NkY10gQXR0YWNoZWQgU0NT
SSByZW1vdmFibGUgZGlzawpbICAgIDkuMDUwODA2XSBzZCA2OjA6MDowOiBbc2RhXSBBdHRhY2hl
ZCBTQ1NJIHJlbW92YWJsZSBkaXNrClsgICAgOS4wNTE0MzFdIHNkIDY6MDowOjM6IFtzZGRdIEF0
dGFjaGVkIFNDU0kgcmVtb3ZhYmxlIGRpc2sKWyAgICA5LjcwMjA4Ml0gdXNiLXN0b3JhZ2U6IGRl
dmljZSBzY2FuIGNvbXBsZXRlClsgICAgOS43MDYwNjRdIHNjc2kgNzowOjA6MDogRGlyZWN0LUFj
Y2VzcyAgICAgR2VuZXJpYyAgRmxhc2ggSFMtQ0YgICAgICA0LjQ0IFBROiAwIEFOU0k6IDAKWyAg
ICA5LjcwOTE3Nl0gc2NzaSA3OjA6MDoxOiBEaXJlY3QtQWNjZXNzICAgICBHZW5lcmljICBGbGFz
aCBIUy1DT01CTyAgIDQuNDQgUFE6IDAgQU5TSTogMApbICAgIDkuNzA5NTQwXSBzZCA3OjA6MDow
OiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2c1IHR5cGUgMApbICAgIDkuNzA5NTg5XSBzZCA3OjA6
MDoxOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2c2IHR5cGUgMApbICAgIDkuNzgyMTgzXSBzZCA3
OjA6MDowOiBbc2RlXSBBdHRhY2hlZCBTQ1NJIHJlbW92YWJsZSBkaXNrClsgICAgOS43ODYwNDVd
IHNkIDc6MDowOjE6IFtzZGZdIEF0dGFjaGVkIFNDU0kgcmVtb3ZhYmxlIGRpc2sKWyAgIDIyLjQx
MTA0Ml0gc2NzaTggOiBpb2MwOiBMU0lTQVMxMDY4RSBCMywgRndSZXY9MDAxOTJmMDBoLCBQb3J0
cz0xLCBNYXhRPTI2NiwgSVJRPTE2ClsgICAyMi40NDM0NTddIG1wdHNhczogaW9jMDogYXR0YWNo
aW5nIHNhdGEgZGV2aWNlOiBmd19jaGFubmVsIDAsIGZ3X2lkIDAsIHBoeSAwLCBzYXNfYWRkciAw
eDEyMjEwMDAwMDAwMDAwMDAKWyAgIDIyLjQ0NTk0Nl0gc2NzaSA4OjA6MDowOiBEaXJlY3QtQWNj
ZXNzICAgICBBVEEgICAgICBXREMgV0Q1MDAwQUFLUy03IDFEMDUgUFE6IDAgQU5TSTogNQpbICAg
MjIuNDQ3Mzg4XSBzZCA4OjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2c3IHR5cGUgMApb
ICAgMjIuNDQ4OTIzXSBzZCA4OjA6MDowOiBbc2RnXSA5NzY3NzMxNjggNTEyLWJ5dGUgbG9naWNh
bCBibG9ja3M6ICg1MDAgR0IvNDY1IEdpQikKWyAgIDIyLjQ1NzY5Ml0gc2QgODowOjA6MDogW3Nk
Z10gV3JpdGUgUHJvdGVjdCBpcyBvZmYKWyAgIDIyLjQ1NzY5NV0gc2QgODowOjA6MDogW3NkZ10g
TW9kZSBTZW5zZTogNzMgMDAgMDAgMDgKWyAgIDIyLjQ1OTg0OF0gc2QgODowOjA6MDogW3NkZ10g
V3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9y
dCBEUE8gb3IgRlVBClsgICAyMi40NzA4MzFdICBzZGc6IHNkZzEgc2RnMiA8IHNkZzUgPgpbICAg
MjIuNTIzNzI5XSBzZCA4OjA6MDowOiBbc2RnXSBBdHRhY2hlZCBTQ1NJIGRpc2sKWyAgIDIzLjk0
MzkwNl0gRVhUNC1mcyAoc2RnMSk6IGJhcnJpZXJzIGVuYWJsZWQKWyAgIDIzLjk2MzQ2MF0ga2pv
dXJuYWxkMiBzdGFydGluZzogcGlkIDUyNiwgZGV2IHNkZzE6OCwgY29tbWl0IGludGVydmFsIDUg
c2Vjb25kcwpbICAgMjMuOTYzNDY0XSBFWFQ0LWZzIChzZGcxKTogZGVsYXllZCBhbGxvY2F0aW9u
IGVuYWJsZWQKWyAgIDIzLjk2MzQ2N10gRVhUNC1mczogZmlsZSBleHRlbnRzIGVuYWJsZWQKWyAg
IDIzLjk4MTEzNF0gRVhUNC1mczogbWJhbGxvYyBlbmFibGVkClsgICAyMy45ODExNDFdIEVYVDQt
ZnMgKHNkZzEpOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVkIGRhdGEgbW9kZQpbICAg
MjguODIxMDA0XSBBZGRpbmcgMTk4MDAwNzJrIHN3YXAgb24gL2Rldi9zZGc1LiAgUHJpb3JpdHk6
LTEgZXh0ZW50czoxIGFjcm9zczoxOTgwMDA3MmsgClsgICAyOC45MzAwNDddIEVYVDQtZnMgKHNk
ZzEpOiBpbnRlcm5hbCBqb3VybmFsIG9uIHNkZzE6OApbICAgMjkuNzgyNjk5XSB1ZGV2OiBzdGFy
dGluZyB2ZXJzaW9uIDE0NwpbICAgMjkuODE0MzIzXSB1ZGV2OiByZW5hbWVkIG5ldHdvcmsgaW50
ZXJmYWNlIGV0aDMgdG8gZXRoMQpbICAgMjkuODE5NTYwXSB1ZGV2OiByZW5hbWVkIG5ldHdvcmsg
aW50ZXJmYWNlIGV0aDIgdG8gZXRoNApbICAgMjkuODg0NzE0XSBpcF90YWJsZXM6IChDKSAyMDAw
LTIwMDYgTmV0ZmlsdGVyIENvcmUgVGVhbQpbICAgMjkuOTQ0MDQ2XSBkY2RiYXMgZGNkYmFzOiBE
ZWxsIFN5c3RlbXMgTWFuYWdlbWVudCBCYXNlIERyaXZlciAodmVyc2lvbiA1LjYuMC0zLjIpClsg
ICAyOS45OTQ3NzVdIGxwOiBkcml2ZXIgbG9hZGVkIGJ1dCBubyBkZXZpY2VzIGZvdW5kClsgICAy
OS45OTkzMjRdIEFERFJDT05GKE5FVERFVl9VUCk6IGV0aDQ6IGxpbmsgaXMgbm90IHJlYWR5Clsg
ICAzMC4xNjg3NjddIEFERFJDT05GKE5FVERFVl9VUCk6IGV0aDE6IGxpbmsgaXMgbm90IHJlYWR5
ClsgICAzMC4xNzAxNzVdIHVkZXY6IHJlbmFtZWQgbmV0d29yayBpbnRlcmZhY2UgZXRoMV9yZW5h
bWUgdG8gZXRoMwpbICAgMzAuMTcwNTE4XSB1ZGV2OiByZW5hbWVkIG5ldHdvcmsgaW50ZXJmYWNl
IGV0aDRfcmVuYW1lIHRvIGV0aDIKWyAgIDMwLjE3NTA4NV0gdGczIDAwMDA6MDY6MDAuMDogUE1F
IyBkaXNhYmxlZApbICAgMzAuMjY2NjYyXSBBRERSQ09ORihORVRERVZfVVApOiBldGgwOiBsaW5r
IGlzIG5vdCByZWFkeQpbICAgMzAuNDE0OTg0XSBBRERSQ09ORihORVRERVZfVVApOiBldGgzOiBs
aW5rIGlzIG5vdCByZWFkeQpbICAgMzAuNDg4NDM3XSBudmlkaWE6IG1vZHVsZSBsaWNlbnNlICdO
VklESUEnIHRhaW50cyBrZXJuZWwuClsgICAzMC40ODg0NDBdIERpc2FibGluZyBsb2NrIGRlYnVn
Z2luZyBkdWUgdG8ga2VybmVsIHRhaW50ClsgICAzMC41MDUyMjVdIHNocGNocDogU3RhbmRhcmQg
SG90IFBsdWcgUENJIENvbnRyb2xsZXIgRHJpdmVyIHZlcnNpb246IDAuNApbICAgMzAuNTA3ODI1
XSB2aWRlbzEzOTQ6IEluc3RhbGxlZCB2aWRlbzEzOTQgbW9kdWxlClsgICAzMC41Mjk2ODhdIGll
ZWUxMzk0OiByYXcxMzk0OiAvZGV2L3JhdzEzOTQgZGV2aWNlIGluaXRpYWxpemVkClsgICAzMC42
NjcyMTddIEFERFJDT05GKE5FVERFVl9VUCk6IGV0aDI6IGxpbmsgaXMgbm90IHJlYWR5ClsgICAz
MC43NDA5NDddIG52aWRpYSAwMDAwOjAzOjAwLjA6IFBDSSBJTlQgQSAtPiBHU0kgMjQgKGxldmVs
LCBsb3cpIC0+IElSUSAyNApbICAgMzAuNzQwOTU4XSBudmlkaWEgMDAwMDowMzowMC4wOiBzZXR0
aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgIDMwLjc0MTEyNF0gTlZSTTogbG9hZGluZyBOVklE
SUEgVU5JWCB4ODZfNjQgS2VybmVsIE1vZHVsZSAgMjYwLjE5LjEyICBGcmkgT2N0ICA4IDExOjE3
OjA4IFBEVCAyMDEwClsgICAzMC43ODYwMjddIGRybTogZGlzYWdyZWVzIGFib3V0IHZlcnNpb24g
b2Ygc3ltYm9sIG1vZHVsZV9sYXlvdXQKWyAgIDMwLjg3Nzk1N10gMDAwMDoyMjowMC4xOiBldGgy
OiBjaGFuZ2luZyBNVFUgZnJvbSAxNTAwIHRvIDkwMDAKWyAgIDMxLjM3NDM5M10gUlQtU29ja2V0
LUNBTiAwLjkwLjIgLSAoQykgMjAwNiBSVC1Tb2NrZXQtQ0FOIERldmVsb3BtZW50IFRlYW0KWyAg
IDMxLjUyMzEyOF0gUlRDQU4gU0pBMTAwMCBkcml2ZXIgaW5pdGlhbGl6ZWQKWyAgIDMxLjYxMzQ1
OV0gZTEwMDBlOiBldGgxIE5JQyBMaW5rIGlzIFVwIDEwMCBNYnBzIEZ1bGwgRHVwbGV4LCBGbG93
IENvbnRyb2w6IE5vbmUKWyAgIDMxLjYxMzQ2Ml0gMDAwMDoyMjowMC4wOiBldGgxOiAxMC8xMDAg
c3BlZWQ6IGRpc2FibGluZyBUU08KWyAgIDMxLjYxNDQwOV0gQUREUkNPTkYoTkVUREVWX0NIQU5H
RSk6IGV0aDE6IGxpbmsgYmVjb21lcyByZWFkeQpbICAgMzEuNjgwNzMwXSBQRUFLLVBDSS1DQU46
IGluaXRpYWxpemluZyBkZXZpY2UgMDAxYzowMDAxClsgICAzMS42ODA3NDFdIFBFQUstUENJLUNB
TiAwMDAwOjAyOjAwLjA6IFBDSSBJTlQgQSAtPiBHU0kgMjggKGxldmVsLCBsb3cpIC0+IElSUSAy
OApbICAgMzEuNjg1NzY3XSBQRUFLLVBDSS1DQU46IGJhc2VfYWRkcj1mZmZmYzkwMDAzMDcwMDAw
IGNvbmZfYWRkcj1mZmZmYzkwMDAzMDdlMDAwIGlycT0yOApbICAgMzEuNjg1NzgzXSBydGNhbjog
cmVnaXN0ZXJlZCBydGNhbjAKWyAgIDMxLjY4NTc5MV0gUEVBSy1QQ0ktQ0FOOiBiYXNlX2FkZHI9
ZmZmZmM5MDAwMzA3NDQwMCBjb25mX2FkZHI9ZmZmZmM5MDAwMzA3ZTAwMCBpcnE9MjgKWyAgIDMx
LjY4NTgwMl0gcnRjYW46IHJlZ2lzdGVyZWQgcnRjYW4xClsgICAzMi4wMzc5NDBdIHNkIDg6MDow
OjA6IFtzZGddIFNlbnNlIEtleSA6IFJlY292ZXJlZCBFcnJvciBbY3VycmVudF0gW2Rlc2NyaXB0
b3JdClsgICAzMi4wMzc5NDddIERlc2NyaXB0b3Igc2Vuc2UgZGF0YSB3aXRoIHNlbnNlIGRlc2Ny
aXB0b3JzIChpbiBoZXgpOgpbICAgMzIuMDM3OTUwXSAgICAgICAgIDcyIDAxIDAwIDFkIDAwIDAw
IDAwIDBlIDA5IDBjIDAwIDAwIDAwIDAwIDAwIDAwIApbICAgMzIuMDM3OTYyXSAgICAgICAgIDAw
IDAwIDAwIDAwIDAwIDAwIApbICAgMzIuMDM3OTY5XSBzZCA4OjA6MDowOiBbc2RnXSBBZGQuIFNl
bnNlOiBBVEEgcGFzcyB0aHJvdWdoIGluZm9ybWF0aW9uIGF2YWlsYWJsZQpbICAgMzIuMDkzNTY0
XSBzZCA4OjA6MDowOiBbc2RnXSBTZW5zZSBLZXkgOiBSZWNvdmVyZWQgRXJyb3IgW2N1cnJlbnRd
IFtkZXNjcmlwdG9yXQpbICAgMzIuMDkzNTcxXSBEZXNjcmlwdG9yIHNlbnNlIGRhdGEgd2l0aCBz
ZW5zZSBkZXNjcmlwdG9ycyAoaW4gaGV4KToKWyAgIDMyLjA5MzU3M10gICAgICAgICA3MiAwMSAw
MCAxZCAwMCAwMCAwMCAwZSAwOSAwYyAwMCAwMCAwMCAwMCAwMCAwMCAKWyAgIDMyLjA5MzU4NV0g
ICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAKWyAgIDMyLjA5MzU5Ml0gc2QgODowOjA6MDogW3Nk
Z10gQWRkLiBTZW5zZTogQVRBIHBhc3MgdGhyb3VnaCBpbmZvcm1hdGlvbiBhdmFpbGFibGUKWyAg
IDMzLjIyNjQzMl0gdXNwbGFzaDo0ODkgZnJlZWluZyBpbnZhbGlkIG1lbXR5cGUgZmZmZmZmZmZm
NTAwMDAwMC1mZmZmZmZmZmY1ZTAwMDAwClsgICAzMy40MDYxNTFdIGUxMDAwZTogZXRoMiBOSUMg
TGluayBpcyBVcCAxMDAwIE1icHMgRnVsbCBEdXBsZXgsIEZsb3cgQ29udHJvbDogTm9uZQpbICAg
MzMuNDA3MDk2XSBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogZXRoMjogbGluayBiZWNvbWVzIHJl
YWR5ClsgICAzNi40NzU5OTVdIHBwZGV2OiB1c2VyLXNwYWNlIHBhcmFsbGVsIHBvcnQgZHJpdmVy
ClsgICAzNy4zMTExNTddIHNkIDg6MDowOjA6IFtzZGddIFNlbnNlIEtleSA6IFJlY292ZXJlZCBF
cnJvciBbY3VycmVudF0gW2Rlc2NyaXB0b3JdClsgICAzNy4zMTExNjVdIERlc2NyaXB0b3Igc2Vu
c2UgZGF0YSB3aXRoIHNlbnNlIGRlc2NyaXB0b3JzIChpbiBoZXgpOgpbICAgMzcuMzExMTY3XSAg
ICAgICAgIDcyIDAxIDAwIDFkIDAwIDAwIDAwIDBlIDA5IDBjIDAwIDAwIDAwIDAwIDAwIDAwIApb
ICAgMzcuMzExMTgwXSAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIApbICAgMzcuMzExMTg2XSBz
ZCA4OjA6MDowOiBbc2RnXSBBZGQuIFNlbnNlOiBBVEEgcGFzcyB0aHJvdWdoIGluZm9ybWF0aW9u
IGF2YWlsYWJsZQpbICAgMzcuMzM3OTA2XSBDUFUwIGF0dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFp
bi4KWyAgIDM3LjMzNzkwOF0gQ1BVMSBhdHRhY2hpbmcgTlVMTCBzY2hlZC1kb21haW4uClsgICAz
Ny4zMzc5MTBdIENQVTIgYXR0YWNoaW5nIE5VTEwgc2NoZWQtZG9tYWluLgpbICAgMzcuMzM3OTEx
XSBDUFUzIGF0dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFpbi4KWyAgIDM3LjMzNzkxMl0gQ1BVNCBh
dHRhY2hpbmcgTlVMTCBzY2hlZC1kb21haW4uClsgICAzNy4zMzc5MTNdIENQVTUgYXR0YWNoaW5n
IE5VTEwgc2NoZWQtZG9tYWluLgpbICAgMzcuMzM3OTE1XSBDUFU2IGF0dGFjaGluZyBOVUxMIHNj
aGVkLWRvbWFpbi4KWyAgIDM3LjMzNzkxNl0gQ1BVNyBhdHRhY2hpbmcgTlVMTCBzY2hlZC1kb21h
aW4uClsgICAzNy40MTI2MDddIENQVTAgYXR0YWNoaW5nIHNjaGVkLWRvbWFpbjoKWyAgIDM3LjQx
MjYxMF0gIGRvbWFpbiAwOiBzcGFuIDAtMyBsZXZlbCBNQwpbICAgMzcuNDEyNjEyXSAgIGdyb3Vw
czogMCAxIDIgMwpbICAgMzcuNDEyNjE1XSAgIGRvbWFpbiAxOiBzcGFuIDAtNyBsZXZlbCBDUFUK
WyAgIDM3LjQxMjYxNl0gICAgZ3JvdXBzOiAwLTMgKF9fY3B1X3Bvd2VyID0gNDA5NikgNC03IChf
X2NwdV9wb3dlciA9IDQwOTYpClsgICAzNy40MTI2MjFdIENQVTEgYXR0YWNoaW5nIHNjaGVkLWRv
bWFpbjoKWyAgIDM3LjQxMjYyMl0gIGRvbWFpbiAwOiBzcGFuIDAtMyBsZXZlbCBNQwpbICAgMzcu
NDEyNjIzXSAgIGdyb3VwczogMSAyIDMgMApbICAgMzcuNDEyNjI1XSAgIGRvbWFpbiAxOiBzcGFu
IDAtNyBsZXZlbCBDUFUKWyAgIDM3LjQxMjYyN10gICAgZ3JvdXBzOiAwLTMgKF9fY3B1X3Bvd2Vy
ID0gNDA5NikgNC03IChfX2NwdV9wb3dlciA9IDQwOTYpClsgICAzNy40MTI2MzBdIENQVTIgYXR0
YWNoaW5nIHNjaGVkLWRvbWFpbjoKWyAgIDM3LjQxMjYzMV0gIGRvbWFpbiAwOiBzcGFuIDAtMyBs
ZXZlbCBNQwpbICAgMzcuNDEyNjMyXSAgIGdyb3VwczogMiAzIDAgMQpbICAgMzcuNDEyNjM1XSAg
IGRvbWFpbiAxOiBzcGFuIDAtNyBsZXZlbCBDUFUKWyAgIDM3LjQxMjYzNl0gICAgZ3JvdXBzOiAw
LTMgKF9fY3B1X3Bvd2VyID0gNDA5NikgNC03IChfX2NwdV9wb3dlciA9IDQwOTYpClsgICAzNy40
MTI2MzldIENQVTMgYXR0YWNoaW5nIHNjaGVkLWRvbWFpbjoKWyAgIDM3LjQxMjY0MF0gIGRvbWFp
biAwOiBzcGFuIDAtMyBsZXZlbCBNQwpbICAgMzcuNDEyNjQyXSAgIGdyb3VwczogMyAwIDEgMgpb
ICAgMzcuNDEyNjQ0XSAgIGRvbWFpbiAxOiBzcGFuIDAtNyBsZXZlbCBDUFUKWyAgIDM3LjQxMjY0
NV0gICAgZ3JvdXBzOiAwLTMgKF9fY3B1X3Bvd2VyID0gNDA5NikgNC03IChfX2NwdV9wb3dlciA9
IDQwOTYpClsgICAzNy40MTI2NDldIENQVTQgYXR0YWNoaW5nIHNjaGVkLWRvbWFpbjoKWyAgIDM3
LjQxMjY1MF0gIGRvbWFpbiAwOiBzcGFuIDQtNyBsZXZlbCBNQwpbICAgMzcuNDEyNjUxXSAgIGdy
b3VwczogNCA1IDYgNwpbICAgMzcuNDEyNjUzXSAgIGRvbWFpbiAxOiBzcGFuIDAtNyBsZXZlbCBD
UFUKWyAgIDM3LjQxMjY1NV0gICAgZ3JvdXBzOiA0LTcgKF9fY3B1X3Bvd2VyID0gNDA5NikgMC0z
IChfX2NwdV9wb3dlciA9IDQwOTYpClsgICAzNy40MTI2NThdIENQVTUgYXR0YWNoaW5nIHNjaGVk
LWRvbWFpbjoKWyAgIDM3LjQxMjY1OV0gIGRvbWFpbiAwOiBzcGFuIDQtNyBsZXZlbCBNQwpbICAg
MzcuNDEyNjYwXSAgIGdyb3VwczogNSA2IDcgNApbICAgMzcuNDEyNjYzXSAgIGRvbWFpbiAxOiBz
cGFuIDAtNyBsZXZlbCBDUFUKWyAgIDM3LjQxMjY2NF0gICAgZ3JvdXBzOiA0LTcgKF9fY3B1X3Bv
d2VyID0gNDA5NikgMC0zIChfX2NwdV9wb3dlciA9IDQwOTYpClsgICAzNy40MTI2NjddIENQVTYg
YXR0YWNoaW5nIHNjaGVkLWRvbWFpbjoKWyAgIDM3LjQxMjY2OF0gIGRvbWFpbiAwOiBzcGFuIDQt
NyBsZXZlbCBNQwpbICAgMzcuNDEyNjY5XSAgIGdyb3VwczogNiA3IDQgNQpbICAgMzcuNDEyNjcy
XSAgIGRvbWFpbiAxOiBzcGFuIDAtNyBsZXZlbCBDUFUKWyAgIDM3LjQxMjY3M10gICAgZ3JvdXBz
OiA0LTcgKF9fY3B1X3Bvd2VyID0gNDA5NikgMC0zIChfX2NwdV9wb3dlciA9IDQwOTYpClsgICAz
Ny40MTI2NzddIENQVTcgYXR0YWNoaW5nIHNjaGVkLWRvbWFpbjoKWyAgIDM3LjQxMjY3OF0gIGRv
bWFpbiAwOiBzcGFuIDQtNyBsZXZlbCBNQwpbICAgMzcuNDEyNjc5XSAgIGdyb3VwczogNyA0IDUg
NgpbICAgMzcuNDEyNjgxXSAgIGRvbWFpbiAxOiBzcGFuIDAtNyBsZXZlbCBDUFUKWyAgIDM3LjQx
MjY4M10gICAgZ3JvdXBzOiA0LTcgKF9fY3B1X3Bvd2VyID0gNDA5NikgMC0zIChfX2NwdV9wb3dl
ciA9IDQwOTYpClsgICAzNy40MTMyMTNdIENQVTAgYXR0YWNoaW5nIE5VTEwgc2NoZWQtZG9tYWlu
LgpbICAgMzcuNDEzMjE1XSBDUFUxIGF0dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFpbi4KWyAgIDM3
LjQxMzIxNl0gQ1BVMiBhdHRhY2hpbmcgTlVMTCBzY2hlZC1kb21haW4uClsgICAzNy40MTMyMTdd
IENQVTMgYXR0YWNoaW5nIE5VTEwgc2NoZWQtZG9tYWluLgpbICAgMzcuNDEzMjE4XSBDUFU0IGF0
dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFpbi4KWyAgIDM3LjQxMzIxOV0gQ1BVNSBhdHRhY2hpbmcg
TlVMTCBzY2hlZC1kb21haW4uClsgICAzNy40MTMyMjBdIENQVTYgYXR0YWNoaW5nIE5VTEwgc2No
ZWQtZG9tYWluLgpbICAgMzcuNDEzMjIxXSBDUFU3IGF0dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFp
bi4KWyAgIDM3LjUzMjIwMF0gQ1BVMCBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgMzcuNTMy
MjA1XSAgZG9tYWluIDA6IHNwYW4gMC0zIGxldmVsIE1DClsgICAzNy41MzIyMDddICAgZ3JvdXBz
OiAwIDEgMiAzClsgICAzNy41MzIyMDldICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpb
ICAgMzcuNTMyMjExXSAgICBncm91cHM6IDAtMyAoX19jcHVfcG93ZXIgPSA0MDk2KSA0LTcgKF9f
Y3B1X3Bvd2VyID0gNDA5NikKWyAgIDM3LjUzMjIxNF0gQ1BVMSBhdHRhY2hpbmcgc2NoZWQtZG9t
YWluOgpbICAgMzcuNTMyMjE1XSAgZG9tYWluIDA6IHNwYW4gMC0zIGxldmVsIE1DClsgICAzNy41
MzIyMTddICAgZ3JvdXBzOiAxIDIgMyAwClsgICAzNy41MzIyMTldICAgZG9tYWluIDE6IHNwYW4g
MC03IGxldmVsIENQVQpbICAgMzcuNTMyMjIxXSAgICBncm91cHM6IDAtMyAoX19jcHVfcG93ZXIg
PSA0MDk2KSA0LTcgKF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDM3LjUzMjIyNF0gQ1BVMiBhdHRh
Y2hpbmcgc2NoZWQtZG9tYWluOgpbICAgMzcuNTMyMjI1XSAgZG9tYWluIDA6IHNwYW4gMC0zIGxl
dmVsIE1DClsgICAzNy41MzIyMjZdICAgZ3JvdXBzOiAyIDMgMCAxClsgICAzNy41MzIyMjldICAg
ZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgMzcuNTMyMjMwXSAgICBncm91cHM6IDAt
MyAoX19jcHVfcG93ZXIgPSA0MDk2KSA0LTcgKF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDM3LjUz
MjIzM10gQ1BVMyBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgMzcuNTMyMjM0XSAgZG9tYWlu
IDA6IHNwYW4gMC0zIGxldmVsIE1DClsgICAzNy41MzIyMzVdICAgZ3JvdXBzOiAzIDAgMSAyClsg
ICAzNy41MzIyMzhdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgMzcuNTMyMjM5
XSAgICBncm91cHM6IDAtMyAoX19jcHVfcG93ZXIgPSA0MDk2KSA0LTcgKF9fY3B1X3Bvd2VyID0g
NDA5NikKWyAgIDM3LjUzMjI0Ml0gQ1BVNCBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgMzcu
NTMyMjQzXSAgZG9tYWluIDA6IHNwYW4gNC03IGxldmVsIE1DClsgICAzNy41MzIyNDRdICAgZ3Jv
dXBzOiA0IDUgNiA3ClsgICAzNy41MzIyNDddICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQ
VQpbICAgMzcuNTMyMjQ4XSAgICBncm91cHM6IDQtNyAoX19jcHVfcG93ZXIgPSA0MDk2KSAwLTMg
KF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDM3LjUzMjI1MV0gQ1BVNSBhdHRhY2hpbmcgc2NoZWQt
ZG9tYWluOgpbICAgMzcuNTMyMjUyXSAgZG9tYWluIDA6IHNwYW4gNC03IGxldmVsIE1DClsgICAz
Ny41MzIyNTNdICAgZ3JvdXBzOiA1IDYgNyA0ClsgICAzNy41MzIyNTZdICAgZG9tYWluIDE6IHNw
YW4gMC03IGxldmVsIENQVQpbICAgMzcuNTMyMjU3XSAgICBncm91cHM6IDQtNyAoX19jcHVfcG93
ZXIgPSA0MDk2KSAwLTMgKF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDM3LjUzMjI2MF0gQ1BVNiBh
dHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgMzcuNTMyMjYxXSAgZG9tYWluIDA6IHNwYW4gNC03
IGxldmVsIE1DClsgICAzNy41MzIyNjJdICAgZ3JvdXBzOiA2IDcgNCA1ClsgICAzNy41MzIyNjVd
ICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgMzcuNTMyMjY2XSAgICBncm91cHM6
IDQtNyAoX19jcHVfcG93ZXIgPSA0MDk2KSAwLTMgKF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDM3
LjUzMjI3MF0gQ1BVNyBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgMzcuNTMyMjcxXSAgZG9t
YWluIDA6IHNwYW4gNC03IGxldmVsIE1DClsgICAzNy41MzIyNzJdICAgZ3JvdXBzOiA3IDQgNSA2
ClsgICAzNy41MzIyNzRdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgMzcuNTMy
Mjc1XSAgICBncm91cHM6IDQtNyAoX19jcHVfcG93ZXIgPSA0MDk2KSAwLTMgKF9fY3B1X3Bvd2Vy
ID0gNDA5NikKWyAgIDQwLjExODM1OV0gc2QgODowOjA6MDogW3NkZ10gU2Vuc2UgS2V5IDogUmVj
b3ZlcmVkIEVycm9yIFtjdXJyZW50XSBbZGVzY3JpcHRvcl0KWyAgIDQwLjExODM2NF0gRGVzY3Jp
cHRvciBzZW5zZSBkYXRhIHdpdGggc2Vuc2UgZGVzY3JpcHRvcnMgKGluIGhleCk6ClsgICA0MC4x
MTgzNjZdICAgICAgICAgNzIgMDEgMDAgMWQgMDAgMDAgMDAgMGUgMDkgMGMgMDAgMDAgMDAgMDAg
MDAgMDAgClsgICA0MC4xMTgzNzFdICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgClsgICA0MC4x
MTgzNzRdIHNkIDg6MDowOjA6IFtzZGddIEFkZC4gU2Vuc2U6IEFUQSBwYXNzIHRocm91Z2ggaW5m
b3JtYXRpb24gYXZhaWxhYmxlClsgICA0MC4xMjI2NTVdIENQVTAgYXR0YWNoaW5nIE5VTEwgc2No
ZWQtZG9tYWluLgpbICAgNDAuMTIyNjU5XSBDUFUxIGF0dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFp
bi4KWyAgIDQwLjEyMjY2MV0gQ1BVMiBhdHRhY2hpbmcgTlVMTCBzY2hlZC1kb21haW4uClsgICA0
MC4xMjI2NjJdIENQVTMgYXR0YWNoaW5nIE5VTEwgc2NoZWQtZG9tYWluLgpbICAgNDAuMTIyNjYz
XSBDUFU0IGF0dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFpbi4KWyAgIDQwLjEyMjY2NV0gQ1BVNSBh
dHRhY2hpbmcgTlVMTCBzY2hlZC1kb21haW4uClsgICA0MC4xMjI2NjZdIENQVTYgYXR0YWNoaW5n
IE5VTEwgc2NoZWQtZG9tYWluLgpbICAgNDAuMTIyNjY3XSBDUFU3IGF0dGFjaGluZyBOVUxMIHNj
aGVkLWRvbWFpbi4KWyAgIDQwLjIwNjU5MV0gQ1BVMCBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpb
ICAgNDAuMjA2NTkzXSAgZG9tYWluIDA6IHNwYW4gMC0zIGxldmVsIE1DClsgICA0MC4yMDY1OTRd
ICAgZ3JvdXBzOiAwIDEgMiAzClsgICA0MC4yMDY1OTddICAgZG9tYWluIDE6IHNwYW4gMC03IGxl
dmVsIENQVQpbICAgNDAuMjA2NTk4XSAgICBncm91cHM6IDAtMyAoX19jcHVfcG93ZXIgPSA0MDk2
KSA0LTcgKF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDQwLjIwNjYwMl0gQ1BVMSBhdHRhY2hpbmcg
c2NoZWQtZG9tYWluOgpbICAgNDAuMjA2NjAzXSAgZG9tYWluIDA6IHNwYW4gMC0zIGxldmVsIE1D
ClsgICA0MC4yMDY2MDRdICAgZ3JvdXBzOiAxIDIgMyAwClsgICA0MC4yMDY2MDddICAgZG9tYWlu
IDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgNDAuMjA2NjA4XSAgICBncm91cHM6IDAtMyAoX19j
cHVfcG93ZXIgPSA0MDk2KSA0LTcgKF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDQwLjIwNjYxMV0g
Q1BVMiBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgNDAuMjA2NjEyXSAgZG9tYWluIDA6IHNw
YW4gMC0zIGxldmVsIE1DClsgICA0MC4yMDY2MTRdICAgZ3JvdXBzOiAyIDMgMCAxClsgICA0MC4y
MDY2MTZdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgNDAuMjA2NjE3XSAgICBn
cm91cHM6IDAtMyAoX19jcHVfcG93ZXIgPSA0MDk2KSA0LTcgKF9fY3B1X3Bvd2VyID0gNDA5NikK
WyAgIDQwLjIwNjYyMV0gQ1BVMyBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgNDAuMjA2NjIy
XSAgZG9tYWluIDA6IHNwYW4gMC0zIGxldmVsIE1DClsgICA0MC4yMDY2MjNdICAgZ3JvdXBzOiAz
IDAgMSAyClsgICA0MC4yMDY2MjZdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAg
NDAuMjA2NjI3XSAgICBncm91cHM6IDAtMyAoX19jcHVfcG93ZXIgPSA0MDk2KSA0LTcgKF9fY3B1
X3Bvd2VyID0gNDA5NikKWyAgIDQwLjIwNjYzMF0gQ1BVNCBhdHRhY2hpbmcgc2NoZWQtZG9tYWlu
OgpbICAgNDAuMjA2NjMxXSAgZG9tYWluIDA6IHNwYW4gNC03IGxldmVsIE1DClsgICA0MC4yMDY2
MzJdICAgZ3JvdXBzOiA0IDUgNiA3ClsgICA0MC4yMDY2MzVdICAgZG9tYWluIDE6IHNwYW4gMC03
IGxldmVsIENQVQpbICAgNDAuMjA2NjM2XSAgICBncm91cHM6IDQtNyAoX19jcHVfcG93ZXIgPSA0
MDk2KSAwLTMgKF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDQwLjIwNjYzOV0gQ1BVNSBhdHRhY2hp
bmcgc2NoZWQtZG9tYWluOgpbICAgNDAuMjA2NjQwXSAgZG9tYWluIDA6IHNwYW4gNC03IGxldmVs
IE1DClsgICA0MC4yMDY2NDFdICAgZ3JvdXBzOiA1IDYgNyA0ClsgICA0MC4yMDY2NDRdICAgZG9t
YWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgNDAuMjA2NjQ1XSAgICBncm91cHM6IDQtNyAo
X19jcHVfcG93ZXIgPSA0MDk2KSAwLTMgKF9fY3B1X3Bvd2VyID0gNDA5NikKWyAgIDQwLjIwNjY0
OF0gQ1BVNiBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgNDAuMjA2NjQ5XSAgZG9tYWluIDA6
IHNwYW4gNC03IGxldmVsIE1DClsgICA0MC4yMDY2NTBdICAgZ3JvdXBzOiA2IDcgNCA1ClsgICA0
MC4yMDY2NTNdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpbICAgNDAuMjA2NjU0XSAg
ICBncm91cHM6IDQtNyAoX19jcHVfcG93ZXIgPSA0MDk2KSAwLTMgKF9fY3B1X3Bvd2VyID0gNDA5
NikKWyAgIDQwLjIwNjY1N10gQ1BVNyBhdHRhY2hpbmcgc2NoZWQtZG9tYWluOgpbICAgNDAuMjA2
NjU4XSAgZG9tYWluIDA6IHNwYW4gNC03IGxldmVsIE1DClsgICA0MC4yMDY2NTldICAgZ3JvdXBz
OiA3IDQgNSA2ClsgICA0MC4yMDY2NjJdICAgZG9tYWluIDE6IHNwYW4gMC03IGxldmVsIENQVQpb
ICAgNDAuMjA2NjYzXSAgICBncm91cHM6IDQtNyAoX19jcHVfcG93ZXIgPSA0MDk2KSAwLTMgKF9f
Y3B1X3Bvd2VyID0gNDA5NikKWyAgIDQwLjIwNzE1Nl0gQ1BVMCBhdHRhY2hpbmcgTlVMTCBzY2hl
ZC1kb21haW4uClsgICA0MC4yMDcxNThdIENQVTEgYXR0YWNoaW5nIE5VTEwgc2NoZWQtZG9tYWlu
LgpbICAgNDAuMjA3MTU5XSBDUFUyIGF0dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFpbi4KWyAgIDQw
LjIwNzE2MF0gQ1BVMyBhdHRhY2hpbmcgTlVMTCBzY2hlZC1kb21haW4uClsgICA0MC4yMDcxNjFd
IENQVTQgYXR0YWNoaW5nIE5VTEwgc2NoZWQtZG9tYWluLgpbICAgNDAuMjA3MTYyXSBDUFU1IGF0
dGFjaGluZyBOVUxMIHNjaGVkLWRvbWFpbi4KWyAgIDQwLjIwNzE2M10gQ1BVNiBhdHRhY2hpbmcg
TlVMTCBzY2hlZC1kb21haW4uClsgICA0MC4yMDcxNjRdIENQVTcgYXR0YWNoaW5nIE5VTEwgc2No
ZWQtZG9tYWluLgpbICAgNDAuMzI2MTkxXSBDUFUwIGF0dGFjaGluZyBzY2hlZC1kb21haW46Clsg
ICA0MC4zMjYxOTNdICBkb21haW4gMDogc3BhbiAwLTMgbGV2ZWwgTUMKWyAgIDQwLjMyNjE5Nl0g
ICBncm91cHM6IDAgMSAyIDMKWyAgIDQwLjMyNjIwNF0gICBkb21haW4gMTogc3BhbiAwLTcgbGV2
ZWwgQ1BVClsgICA0MC4zMjYyMDVdICAgIGdyb3VwczogMC0zIDQtNwpbICAgNDAuMzI2MjA4XSBD
UFUxIGF0dGFjaGluZyBzY2hlZC1kb21haW46ClsgICA0MC4zMjYyMDldICBkb21haW4gMDogc3Bh
biAwLTMgbGV2ZWwgTUMKWyAgIDQwLjMyNjIxMF0gICBncm91cHM6IDEgMiAzIDAKWyAgIDQwLjMy
NjIxM10gICBkb21haW4gMTogc3BhbiAwLTcgbGV2ZWwgQ1BVClsgICA0MC4zMjYyMTRdICAgIGdy
b3VwczogMC0zIDQtNwpbICAgNDAuMzI2MjE3XSBDUFUyIGF0dGFjaGluZyBzY2hlZC1kb21haW46
ClsgICA0MC4zMjYyMThdICBkb21haW4gMDogc3BhbiAwLTMgbGV2ZWwgTUMKWyAgIDQwLjMyNjIx
OV0gICBncm91cHM6IDIgMyAwIDEKWyAgIDQwLjMyNjIyMV0gICBkb21haW4gMTogc3BhbiAwLTcg
bGV2ZWwgQ1BVClsgICA0MC4zMjYyMjNdICAgIGdyb3VwczogMC0zIDQtNwpbICAgNDAuMzI2MjI1
XSBDUFUzIGF0dGFjaGluZyBzY2hlZC1kb21haW46ClsgICA0MC4zMjYyMjZdICBkb21haW4gMDog
c3BhbiAwLTMgbGV2ZWwgTUMKWyAgIDQwLjMyNjIyN10gICBncm91cHM6IDMgMCAxIDIKWyAgIDQw
LjMyNjIzMF0gICBkb21haW4gMTogc3BhbiAwLTcgbGV2ZWwgQ1BVClsgICA0MC4zMjYyMzFdICAg
IGdyb3VwczogMC0zIDQtNwpbICAgNDAuMzI2MjMzXSBDUFU0IGF0dGFjaGluZyBzY2hlZC1kb21h
aW46ClsgICA0MC4zMjYyMzRdICBkb21haW4gMDogc3BhbiA0LTcgbGV2ZWwgTUMKWyAgIDQwLjMy
NjIzNV0gICBncm91cHM6IDQgNSA2IDcKWyAgIDQwLjMyNjIzOF0gICBkb21haW4gMTogc3BhbiAw
LTcgbGV2ZWwgQ1BVClsgICA0MC4zMjYyMzldICAgIGdyb3VwczogNC03IDAtMwpbICAgNDAuMzI2
MjQxXSBDUFU1IGF0dGFjaGluZyBzY2hlZC1kb21haW46ClsgICA0MC4zMjYyNDJdICBkb21haW4g
MDogc3BhbiA0LTcgbGV2ZWwgTUMKWyAgIDQwLjMyNjI0M10gICBncm91cHM6IDUgNiA3IDQKWyAg
IDQwLjMyNjI0Nl0gICBkb21haW4gMTogc3BhbiAwLTcgbGV2ZWwgQ1BVClsgICA0MC4zMjYyNDdd
ICAgIGdyb3VwczogNC03IDAtMwpbICAgNDAuMzI2MjQ5XSBDUFU2IGF0dGFjaGluZyBzY2hlZC1k
b21haW46ClsgICA0MC4zMjYyNTBdICBkb21haW4gMDogc3BhbiA0LTcgbGV2ZWwgTUMKWyAgIDQw
LjMyNjI1Ml0gICBncm91cHM6IDYgNyA0IDUKWyAgIDQwLjMyNjI1NF0gICBkb21haW4gMTogc3Bh
biAwLTcgbGV2ZWwgQ1BVClsgICA0MC4zMjYyNTVdICAgIGdyb3VwczogNC03IDAtMwpbICAgNDAu
MzI2MjU4XSBDUFU3IGF0dGFjaGluZyBzY2hlZC1kb21haW46ClsgICA0MC4zMjYyNTldICBkb21h
aW4gMDogc3BhbiA0LTcgbGV2ZWwgTUMKWyAgIDQwLjMyNjI2MF0gICBncm91cHM6IDcgNCA1IDYK
WyAgIDQwLjMyNjI2Ml0gICBkb21haW4gMTogc3BhbiAwLTcgbGV2ZWwgQ1BVClsgICA0MC4zMjYy
NjNdICAgIGdyb3VwczogNC03IDAtMwpbICAgNDEuNjkxOTY4XSBldGgxOiBubyBJUHY2IHJvdXRl
cnMgcHJlc2VudApbICAgNDQuMTIyMDgxXSBldGgyOiBubyBJUHY2IHJvdXRlcnMgcHJlc2VudApb
ICAgNDcuNzgxODI0XSB0ZzM6IGV0aDA6IExpbmsgaXMgdXAgYXQgMTAwIE1icHMsIGZ1bGwgZHVw
bGV4LgpbICAgNDcuNzgxODI2XSB0ZzM6IGV0aDA6IEZsb3cgY29udHJvbCBpcyBvbiBmb3IgVFgg
YW5kIG9uIGZvciBSWC4KWyAgIDQ3Ljc4Mjc0OV0gQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGV0
aDA6IGxpbmsgYmVjb21lcyByZWFkeQpbICAgNjIuMDY5NDk5XSBSUEM6IFJlZ2lzdGVyZWQgdWRw
IHRyYW5zcG9ydCBtb2R1bGUuClsgICA2Mi4wNjk1MDFdIFJQQzogUmVnaXN0ZXJlZCB0Y3AgdHJh
bnNwb3J0IG1vZHVsZS4KWyAgIDYyLjE0MjEzNF0gc3ZjOiBmYWlsZWQgdG8gcmVnaXN0ZXIgbG9j
a2R2MSBSUEMgc2VydmljZSAoZXJybm8gOTcpLgpbICAgNjQuNjMyMDgyXSBzZCA4OjA6MDowOiBb
c2RnXSBTZW5zZSBLZXkgOiBSZWNvdmVyZWQgRXJyb3IgW2N1cnJlbnRdIFtkZXNjcmlwdG9yXQpb
ICAgNjQuNjMyMDg5XSBEZXNjcmlwdG9yIHNlbnNlIGRhdGEgd2l0aCBzZW5zZSBkZXNjcmlwdG9y
cyAoaW4gaGV4KToKWyAgIDY0LjYzMjA5Ml0gICAgICAgICA3MiAwMSAwMCAxZCAwMCAwMCAwMCAw
ZSAwOSAwYyAwMCAwMCAwMCAwMCAwMCAwMCAKWyAgIDY0LjYzMjEwNF0gICAgICAgICAwMCAwMCAw
MCAwMCAwMCAwMCAKWyAgIDY0LjYzMjExMV0gc2QgODowOjA6MDogW3NkZ10gQWRkLiBTZW5zZTog
QVRBIHBhc3MgdGhyb3VnaCBpbmZvcm1hdGlvbiBhdmFpbGFibGUKWyAgIDY0LjY1OTQ5NV0gc2Qg
ODowOjA6MDogW3NkZ10gU2Vuc2UgS2V5IDogUmVjb3ZlcmVkIEVycm9yIFtjdXJyZW50XSBbZGVz
Y3JpcHRvcl0KWyAgIDY0LjY1OTQ5OV0gRGVzY3JpcHRvciBzZW5zZSBkYXRhIHdpdGggc2Vuc2Ug
ZGVzY3JpcHRvcnMgKGluIGhleCk6ClsgICA2NC42NTk1MDBdICAgICAgICAgNzIgMDEgMDAgMWQg
MDAgMDAgMDAgMGUgMDkgMGMgMDAgMDAgMDAgMDAgMDAgMDAgClsgICA2NC42NTk1MDZdICAgICAg
ICAgMDAgMDAgMDAgMDAgMDAgMDAgClsgICA2NC42NTk1MDldIHNkIDg6MDowOjA6IFtzZGddIEFk
ZC4gU2Vuc2U6IEFUQSBwYXNzIHRocm91Z2ggaW5mb3JtYXRpb24gYXZhaWxhYmxlClsgICA2NC42
NzI3MDhdIHNkIDg6MDowOjA6IFtzZGddIFNlbnNlIEtleSA6IFJlY292ZXJlZCBFcnJvciBbY3Vy
cmVudF0gW2Rlc2NyaXB0b3JdClsgICA2NC42NzI3MTJdIERlc2NyaXB0b3Igc2Vuc2UgZGF0YSB3
aXRoIHNlbnNlIGRlc2NyaXB0b3JzIChpbiBoZXgpOgpbICAgNjQuNjcyNzEzXSAgICAgICAgIDcy
IDAxIDAwIDFkIDAwIDAwIDAwIDBlIDA5IDBjIDAwIDAwIDAwIGZmIDAwIDAwIApbICAgNjQuNjcy
NzE5XSAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDUwIApbICAgNjQuNjcyNzIyXSBzZCA4OjA6MDow
OiBbc2RnXSBBZGQuIFNlbnNlOiBBVEEgcGFzcyB0aHJvdWdoIGluZm9ybWF0aW9uIGF2YWlsYWJs
ZQpbICAgNjQuNzEwMTQ0XSBzZCA4OjA6MDowOiBbc2RnXSBTZW5zZSBLZXkgOiBSZWNvdmVyZWQg
RXJyb3IgW2N1cnJlbnRdIFtkZXNjcmlwdG9yXQpbICAgNjQuNzEwMTUwXSBEZXNjcmlwdG9yIHNl
bnNlIGRhdGEgd2l0aCBzZW5zZSBkZXNjcmlwdG9ycyAoaW4gaGV4KToKWyAgIDY0LjcxMDE1M10g
ICAgICAgICA3MiAwMSAwMCAxZCAwMCAwMCAwMCAwZSAwOSAwYyAwMCAwMCAwMCAwMCAwMCAwMCAK
WyAgIDY0LjcxMDE2NV0gICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAKWyAgIDY0LjcxMDE3Ml0g
c2QgODowOjA6MDogW3NkZ10gQWRkLiBTZW5zZTogQVRBIHBhc3MgdGhyb3VnaCBpbmZvcm1hdGlv
biBhdmFpbGFibGUKWyAgIDY0LjgyNDU4Nl0gc2QgODowOjA6MDogW3NkZ10gU2Vuc2UgS2V5IDog
UmVjb3ZlcmVkIEVycm9yIFtjdXJyZW50XSBbZGVzY3JpcHRvcl0KWyAgIDY0LjgyNDU5M10gRGVz
Y3JpcHRvciBzZW5zZSBkYXRhIHdpdGggc2Vuc2UgZGVzY3JpcHRvcnMgKGluIGhleCk6ClsgICA2
NC44MjQ1OTZdICAgICAgICAgNzIgMDEgMDAgMWQgMDAgMDAgMDAgMGUgMDkgMGMgMDAgMDAgMDAg
MDAgMDAgMDAgClsgICA2NC44MjQ2MDhdICAgICAgICAgMDAgNGYgMDAgYzIgMDAgNTAgClsgICA2
NC44MjQ2MTVdIHNkIDg6MDowOjA6IFtzZGddIEFkZC4gU2Vuc2U6IEFUQSBwYXNzIHRocm91Z2gg
aW5mb3JtYXRpb24gYXZhaWxhYmxlClsgICA2OC43NzIyNzldIFVERi1mczogTm8gVlJTIGZvdW5k
ClsgICA2OC43NzIyODNdIFVERi1mczogTm8gcGFydGl0aW9uIGZvdW5kICgxKQpbICAgNjguODU2
NzAyXSBJU08gOTY2MCBFeHRlbnNpb25zOiBSUklQXzE5OTFBCg==
--0016363b86f0fd94eb0493b5b9d8--

