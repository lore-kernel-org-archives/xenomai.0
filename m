From: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Date: Thu, 8 Nov 2007 10:41:56 +0100
References: <200711061807.26236.lepalom@domain.hid>
	<200711071859.33094.lepalom@domain.hid> <4732991C.1080008@domain.hid>
In-Reply-To: <4732991C.1080008@domain.hid>
MIME-Version: 1.0
Message-Id: <200711081041.57506.lepalom@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Subject: Re: [Xenomai-help] IRQ issues in xenomai and rtnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: mathias_koehrer@domain.hid, xenomai@xenomai.org

A Dijous 08 Novembre 2007, Roland Tollenaar va escriure:
> Hi
>
> > I have selected in the bios that each pci slot htat has a ethernet has a
> > specific irq, but when I load a rtnet driver, it assigns another irq.
> > Making more test, now with 2.6.23 the irq assigned in bios more or less i
> > maintained but still _again_ when load the rtnet driver, the box hangs
> > ...
>
> Is there any possibility of posting the irq assignemts as you set them
> in the BIOS when it hangs and.....


yes, in the bios I can chose an assignment to each pci. So, looking the free 
irqs showed by /proc/interrups I put one network card to 11 an another to 7, 
that was the free. I have test several combinations.

> > I must put a irq specific for each card if not the kernel doesn't boot or
> > I put irq auto and irqpoll in the kenel options. With this configuration
> > I can configure the cards:
> >
> > and the system doesn't hang ...

well, as I said in a mail 5 minutes after the system hangs ....

> the irq output of lspci -v when the system does not hang?

palomo@domain.hid:~$  lspci -v
00:00.0 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a1)
        Subsystem: Giga-byte Technology Unknown device 5001
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: <access denied>

00:01.0 ISA bridge: nVidia Corporation MCP61 LPC Bridge (rev a2)
        Subsystem: Giga-byte Technology Unknown device 0c11
        Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation MCP61 SMBus (rev a2)
        Subsystem: Giga-byte Technology Unknown device 0c11
        Flags: 66MHz, fast devsel, IRQ 10
        I/O ports at b800 [size=64]
        I/O ports at 1c00 [size=64]
        I/O ports at 1c40 [size=64]
        Capabilities: <access denied>

00:01.2 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a2)
        Subsystem: Giga-byte Technology Unknown device 0c11
        Flags: 66MHz, fast devsel

00:02.0 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2) 
(prog-if 10 [OHCI])
        Subsystem: Giga-byte Technology Unknown device 5004
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at ed106000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <access denied>

00:02.1 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2) 
(prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology Unknown device 5004
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at ed105000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <access denied>

00:04.0 PCI bridge: nVidia Corporation MCP61 PCI bridge (rev a1) (prog-if 01 
[Subtractive decode])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e9000000-eaffffff
        Prefetchable memory behind bridge: ed000000-ed0fffff
        Capabilities: <access denied>

00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio (rev a2)
        Subsystem: Giga-byte Technology Unknown device a002
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at ed100000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>

00:06.0 IDE interface: nVidia Corporation MCP61 IDE (rev a2) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Giga-byte Technology Unknown device 5002
        Flags: bus master, 66MHz, fast devsel, latency 0
        [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] 
[size=8]
        [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] 
[size=1]
        [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] 
[size=8]
        [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] 
[size=1]
        I/O ports at f000 [size=16]
        Capabilities: <access denied>

00:07.0 Bridge: nVidia Corporation MCP61 Ethernet (rev a2)
        Subsystem: Giga-byte Technology Unknown device e000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 1279
        Memory at ed107000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at bc00 [size=8]
        Capabilities: <access denied>

00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2) 
(prog-if 85 [Master SecO PriO])
        Subsystem: Giga-byte Technology Unknown device b002
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        I/O ports at 09f0 [size=8]
        I/O ports at 0bf0 [size=4]
        I/O ports at 0970 [size=8]
        I/O ports at 0b70 [size=4]
        I/O ports at d000 [size=16]
        Memory at ed108000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <access denied>

00:08.1 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2) 
(prog-if 85 [Master SecO PriO])
        Subsystem: Giga-byte Technology Unknown device b002
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 10
        I/O ports at 09e0 [size=8]
        I/O ports at 0be0 [size=4]
        I/O ports at 0960 [size=8]
        I/O ports at 0b60 [size=4]
        I/O ports at e400 [size=16]
        Memory at ed104000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <access denied>

00:0d.0 VGA compatible controller: nVidia Corporation Unknown device 03d0 (rev 
a2) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology Unknown device d000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        Memory at eb000000 (64-bit, non-prefetchable) [size=16M]
        [virtual] Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: <access denied>

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: <access denied>

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
        Flags: fast devsel
        Capabilities: <access denied>

01:06.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 01)
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at ed000000 (32-bit, prefetchable) [size=4K]
        I/O ports at a000 [size=32]
        Memory at ea000000 (32-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at e9000000 [disabled] [size=1M]

01:07.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 05)
        Subsystem: Intel Corporation Unknown device 0009
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at ed001000 (32-bit, prefetchable) [size=4K]
        I/O ports at a400 [size=32]
        Memory at ea100000 (32-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at e9100000 [disabled] [size=1M]
        Capabilities: <access denied>

01:09.0 Signal processing controller: Unknown device 1762:3112 (rev 05)
        Subsystem: Unknown device 1762:3112
        Flags: medium devsel
        Memory at ea200000 (32-bit, non-prefetchable) [size=1M]

01:0e.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 
Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Giga-byte Technology Unknown device 1000
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at ea304000 (32-bit, non-prefetchable) [size=2K]
        Memory at ea300000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>


> Also the output of /proc/xenomai/irq IIRC.

palomo@domain.hid:~$ cat /proc/xenomai/irq
IRQ         CPU0        CPU1
1285:           0           0         [IPI]
1288:           2           2         [timer]
1289:           0           0         [critical sync]
1346:           0           0         [virtual]

> For what its worth, I understand that there may be no sharing of the IRQ
> of a real-time device with a non-rt device. In particular not a non-rt
> device that is being used. 

no,  I can test it again but I think that I have been not able to have a 
combination without share at least irq of one of the network cards.

> Although my experience was then always that 
> the freezing just occurs when rtnet is started 

me too.

> so your system hanging on 
> boot strikes me as a bit odd. Unless of course you start rtnet in one of
> the rc bootscrips of course?

no, the hanging at boot time is when I don't put the noapic option in the 
2.6.22 kernels (it's known bug) with 2.6.23 depends of irqpoll, or the manual 
assignment in the bios.

Thanks.

Leo

> > A Dimecres 07 Novembre 2007, Jan Kiszka va escriure:
> >> Leopold Palomo-Avellaneda wrote:
> >>> A Dimecres 07 Novembre 2007, Karl Reichert va escriure:
> >>> [...]
> >>>
> >>>>> the _same_ card was working with rtnet (not xenomai but rtai) in a
> >>>>> configuration that I had in another box.
> >>>>
> >>>> That's what I mean, the card is not the problem. The problem is the
> >>>> current setup, so as a result it is not working. But of course not the
> >>>> card is the one to blame. ...
> >>>
> >>> are you working for intel? ;-)
> >>>
> >>> no, I'm joking.
> >>>
> >>> Sadly, I have tested the same configuration with a rtai kernel and I
> >>> got the same hang :-( Also, the network card got the same irq in rtai
> >>> ...
> >>
> >> IRQ issues are generally I-pipe issues. And RTAI uses (almost) the same
> >> I-pipe patch as Xenomai, thus shares the same bugs until they are fixed
> >> upstream. Generally.
> >>
> >> There are currently a few fixes floating around on Adeos-main, and we
> >> (Xenomai) have some new report probably regarding MSI. As I think I have
> >> seen something about MSI in your config as well, could you try to
> >> disable CONFIG_PCI_MSI to check if at least the hangs disappears (given,
> >> of course, IRQs line will then not be in conflict again)? Also can you
> >> try (unless you already do so) with the latest I-pipe patch for, say,
> >> 2.6.23.x?
> >>
> >> Another hint regard IRQ conflict avoidance: If RTnet (or RT hardware in
> >> general) shares some line with a Linux device you may not depend upon
> >> (Firewire? USB?), just unload the related Linux drivers. Of course, this
> >> doesn't fly if it is your main IDE/SATA device...
> >>
> >> Note that this IRQ stuff is most likely not RTnet business, so it would
> >> be good to move the thread over to Xenomai.
> >>
> >> Jan
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help



