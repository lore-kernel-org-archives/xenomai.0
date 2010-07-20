Message-ID: <4C44E9C9.3020600@domain.hid>
Date: Mon, 19 Jul 2010 17:11:53 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid> <4C43D265.9080609@domain.hid>
	<4C43FC4F.3010006@domain.hid> <4C440D6F.1060204@domain.hid>
In-Reply-To: <4C440D6F.1060204@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------040408050902090404030608"
Subject: Re: [Xenomai-help] Adeos patched kernel hangs mounting root file
 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040408050902090404030608
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

  The debounce clock is not the source of the problem.
On the 2430 chip, the debounce clock is under software control. For the 
OMAP3 chips, its been placed under hardware control. So the 2.6.31 
kernel classifies the  this message as a warning...

1053         host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
1054         /*
1055          * MMC can still work without debounce clock.
1056          */
1057         if (IS_ERR(host->dbclk))
1058                 dev_warn(mmc_dev(host->mmc), "Failed to get 
debounce clock\n");
1059         else

In the 2.6.33 kernel the message has been made 2430 specific...

1709         if (cpu_is_omap2430()) {
1710                 host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
1711                 /*
1712                  * MMC can still work without debounce clock.
1713                  */
1714                 if (IS_ERR(host->dbclk))
1715                         dev_warn(mmc_dev(host->mmc),
1716                                 "Failed to get debounce clock\n");
1717                 else
... snipped ...                                       " clk failed\n");
1724         }

I removed all of the patches  and rebuilt without the Adeos patch. I 
lost host USB Host Port capability, but the BeagleBoard booted.

I then applied the Adeos patch, but disabled Xenomai. The result is the 
same. The board hangs waiting for /dev/mmcblk0p2.

Reading boot sector
Loading u-boot.bin from mmc


U-Boot 2009.06-rc2 (Nov 02 2009 - 23:57:20)

OMAP3530-GP ES3.0, CPU-OPP2 L3-165MHz
OMAP3 Beagle board + LPDDR/NAND
DRAM:  256 MB
NAND:  256 MiB
In:    serial
Out:   serial
Err:   serial
Board revision C
Die ID #317000030000000004013f8a1701a01b
Hit any key to stop autoboot:  0
mmc1 is available
reading uImage

1882552 bytes read
## Booting kernel from Legacy Image at 80300000 ...
    Image Name:   Angstrom/2.6.31/beagleboard
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    1882488 Bytes =  1.8 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing 
Linux.........................................................................................
.............................. done, booting the kernel.
Linux version 2.6.31-omap1 (Bob@domain.hid) (gcc version 4.3.3 (GCC) ) 
#3 Mon Jul 19 14:55:27 PDT 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES3.0
SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS2,115200n8 root=/dev/mmcblk0p2 rw 
rootfstype=ext3 rootwait
PID hash table entries: 1024 (order: 10, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255872KB available (3268K code, 331K data, 132K init, 0K highmem)
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 13000000 Hz
I-pipe 1.16-01: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
Found NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VMMC1: 1850 <--> 3150 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
regulator: VPLL2: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
SCSI subsystem initialized
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0
musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.
msgmni has been set to 500
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
i2c /dev entries driver
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbmon: debugfs is not available
g_ether gadget: using random self ethernet address
g_ether gadget: using random host ethernet address
usb0: MAC b2:59:96:51:13:fa
usb0: HOST MAC da:76:f6:16:2e:21
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.31-omap1 musb-hcd
usb usb1: SerialNumber: musb_hdrc
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
regulator_init_complete: incomplete constraints, leaving VDVI on
regulator_init_complete: incomplete constraints, leaving VDAC on
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Waiting for root device /dev/mmcblk0p2...

The Angstrom developers are working at 2.6.32. The 2.6.31 kernel is the 
newest kernel that both Angstrom and Xenomai support. I know that not 
applying the patches that Angstrom provided 2.6.31 kernel, broke the 
ability of my BeagleBoard to use the EHCI USB host Port on the board.

I suspect that the problem is something specific to the way the 
BeagleBoard uses the OMAP3530 as an SD card controller. There are 
multiple ways to attach a SD card interface to a OMAP3 chip. There may 
be a difference between the board that you are using and the BeagleBoard.

The SD cards that I am using are Class 4 (4-bit wide) 2 to 4 GB cards. 
The BeagleBoard attaches the SD card interface to the MMC1 port. SD 
cards can also be attached via an SPI bus.
How does the SD card attache in your board?

The BeagleBoard SRM references a "Card Detect" interrupt.8.11.3 Card Detect
> When a card is inserted into the SD/MMC connector, the Card Detect pin 
> is grounded.
> This is detected on pin P12 of the TPS65950. An interrupt, if enabled, 
> is sent to the
> OMAP3530 via the interrupt pin. The SW can be written such that the 
> system comes out of sleep or a reduced frequency mode when the card is 
> detected.
There doesn't seem to be any other interrupt signal external to the OMAP 
chip.

I'll dig deeper and find out specifically which interrupts the 
BeagleBoard SD card affects.

Regards,
Bob Feretich

On 7/19/2010 1:31 AM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>>    Thank you for the quick reply.
>>
>> I rebuilt the non-Adeos patched kernel with the 32 KHz clocked disabled.
>> It booted correctly, so that wasn't the problem.  I didn't see any other
>> significant differences in the console boot logs.
>>
>> The console log for the non-Adeos patched kernel with the 32 KHz clocked
>> disabled is pasted below. The /proc/interrupts contents is displayed at
>> the end.
>>
>> I used the 1.16-01 patch.
>>
>>> Reading boot sector
>>> Loading u-boot.bin from mmc
>>>
>>>
>>> ... snipped ...
>>>
>>> beagleboard login: root
>>> root@domain.hid:~# cat /proc/interrupts
>>>             CPU0
>>>    7:          2        INTC  TWL4030-PIH
>>>   11:          0        INTC  prcm
>>>   12:       1078        INTC  DMA
>>>   37:       1009        INTC  gp timer
>>>   56:        273        INTC  i2c_omap
>>>   61:          0        INTC  i2c_omap
>>>   72:          1        INTC  serial idle
>>>   73:          1        INTC  serial idle
>>>   74:        158        INTC  serial idle, serial
>>>   77:          0        INTC  ehci_hcd:usb1
>>>   83:       1346        INTC  mmc0
>>>   92:          1        INTC  musb_hdrc
>>>   93:          0        INTC  musb_hdrc
>>> 378:          2     twl4030  twl4030_usb
>>> 384:          0     twl4030  mmc0
>>> Err:          0
>>> root@domain.hid:~#
> Ok. Several questions: what is this MADC patch you were talking about?
> If this is a kernel patch, if yes, could you try and remove it?
>
> You have an error message about mmc:
> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
>
> which I do not have. Could this not explain some issues?
>
> You are using the 2.6.31 kernel which does not work for you, whereas
> 2.6.33 works for me. Could you test 2.6.33?
>

--------------040408050902090404030608
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    The debounce clock is not the source of the problem.<br>
    On the 2430 chip, the debounce clock is under software control. For
    the OMAP3 chips, its been placed under hardware control. So the
    2.6.31 kernel classifies the  this message as a warning...<br>
    <br>
    <small><tt>1053         host-&gt;dbclk = clk_get(&amp;pdev-&gt;dev,
        "mmchsdb_fck");<br>
        1054         /*<br>
        1055          * MMC can still work without debounce clock.<br>
        1056          */<br>
        1057         if (IS_ERR(host-&gt;dbclk))<br>
        1058                 dev_warn(mmc_dev(host-&gt;mmc), "Failed to
        get debounce clock\n");<br>
        1059         else</tt></small><br>
    <br>
    In the 2.6.33 kernel the message has been made 2430 specific...<br>
    <br>
    <small><tt>1709         if (cpu_is_omap2430()) {<br>
        1710                 host-&gt;dbclk = clk_get(&amp;pdev-&gt;dev,
        "mmchsdb_fck");<br>
        1711                 /*<br>
        1712                  * MMC can still work without debounce
        clock.<br>
        1713                  */<br>
        1714                 if (IS_ERR(host-&gt;dbclk))<br>
        1715                         dev_warn(mmc_dev(host-&gt;mmc),<br>
        1716                                 "Failed to get debounce
        clock\n");<br>
        1717                 else<br>
        ... snipped ...                                       " clk
        failed\n");<br>
        1724         }</tt></small><br>
    <br>
    I removed all of the patches  and rebuilt without the Adeos patch. I
    lost host USB Host Port capability, but the BeagleBoard booted.<br>
    <br>
    I then applied the Adeos patch, but disabled Xenomai. The result is
    the same. The board hangs waiting for /dev/mmcblk0p2.<br>
    <br>
    <small><tt>Reading boot sector<br>
        Loading u-boot.bin from mmc<br>
        <br>
        <br>
        U-Boot 2009.06-rc2 (Nov 02 2009 - 23:57:20)<br>
        <br>
        OMAP3530-GP ES3.0, CPU-OPP2 L3-165MHz<br>
        OMAP3 Beagle board + LPDDR/NAND<br>
        DRAM:  256 MB<br>
        NAND:  256 MiB<br>
        In:    serial<br>
        Out:   serial<br>
        Err:   serial<br>
        Board revision C<br>
        Die ID #317000030000000004013f8a1701a01b<br>
        Hit any key to stop autoboot:  0 <br>
        mmc1 is available<br>
        reading uImage<br>
        <br>
        1882552 bytes read<br>
        ## Booting kernel from Legacy Image at 80300000 ...<br>
           Image Name:   Angstrom/2.6.31/beagleboard<br>
           Image Type:   ARM Linux Kernel Image (uncompressed)<br>
           Data Size:    1882488 Bytes =  1.8 MB<br>
           Load Address: 80008000<br>
           Entry Point:  80008000<br>
           Verifying Checksum ... OK<br>
           Loading Kernel Image ... OK<br>
        OK<br>
        <br>
        Starting kernel ...<br>
        <br>
        Uncompressing
Linux.........................................................................................<br>
        .............................. done, booting the kernel.<br>
        Linux version 2.6.31-omap1 (<a class="moz-txt-link-abbreviated" href="mailto:Bob@domain.hid">Bob@domain.hid</a>) (gcc version 4.3.3
        (GCC) ) #3 Mon Jul 19 14:55:27 PDT 2010<br>
        CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f<br>
        CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction
        cache<br>
        Machine: OMAP3 Beagle Board<br>
        Memory policy: ECC disabled, Data cache writeback<br>
        OMAP3430 ES3.0<br>
        SRAM: Mapped pa 0x40200000 to va 0xe3000000 size: 0x100000<br>
        Built 1 zonelists in Zone order, mobility grouping on.  Total
        pages: 65024<br>
        Kernel command line: console=ttyS2,115200n8 root=/dev/mmcblk0p2
        rw rootfstype=ext3 rootwait<br>
        PID hash table entries: 1024 (order: 10, 4096 bytes)<br>
        Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
        Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
        Memory: 128MB 128MB = 256MB total<br>
        Memory: 255872KB available (3268K code, 331K data, 132K init, 0K
        highmem)<br>
        NR_IRQS:402<br>
        Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz<br>
        Reprogramming SDRC clock to 332000000 Hz<br>
        GPMC revision 5.0<br>
        IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96
        interrupts<br>
        Total of 96 interrupts on 1 active controller<br>
        OMAP34xx GPIO hardware version 2.5<br>
        OMAP clockevent source: GPTIMER1 at 13000000 Hz<br>
        I-pipe 1.16-01: pipeline enabled.<br>
        Console: colour dummy device 80x30<br>
        Calibrating delay loop... 498.07 BogoMIPS (lpj=2490368)<br>
        Mount-cache hash table entries: 512<br>
        CPU: Testing write buffer coherency: ok<br>
        regulator: core version 0.5<br>
        NET: Registered protocol family 16<br>
        Found NAND on CS0<br>
        Registering NAND on CS0<br>
        OMAP DMA hardware revision 4.0<br>
        bio: create slab &lt;bio-0&gt; at 0<br>
        i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz<br>
        twl4030: PIH (irq 7) chaining IRQs 368..375<br>
        twl4030: power (irq 373) chaining IRQs 376..383<br>
        twl4030: gpio (irq 368) chaining IRQs 384..401<br>
        regulator: VMMC1: 1850 &lt;--&gt; 3150 mV normal standby<br>
        regulator: VDAC: 1800 mV normal standby<br>
        regulator: VUSB1V5: 1500 mV normal standby<br>
        regulator: VUSB1V8: 1800 mV normal standby<br>
        regulator: VUSB3V1: 3100 mV normal standby<br>
        regulator: VPLL2: 1800 mV normal standby<br>
        regulator: VSIM: 1800 &lt;--&gt; 3000 mV normal standby<br>
        i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz<br>
        SCSI subsystem initialized<br>
        twl4030_usb twl4030_usb: Initialized TWL4030 USB module<br>
        usbcore: registered new interface driver usbfs<br>
        usbcore: registered new interface driver hub<br>
        usbcore: registered new device driver usb<br>
        musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=0<br>
        musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92<br>
        NET: Registered protocol family 2<br>
        IP route cache hash table entries: 2048 (order: 1, 8192 bytes)<br>
        TCP established hash table entries: 8192 (order: 4, 65536 bytes)<br>
        TCP bind hash table entries: 8192 (order: 3, 32768 bytes)<br>
        TCP: Hash tables configured (established 8192 bind 8192)<br>
        TCP reno registered<br>
        NET: Registered protocol family 1<br>
        VFS: Disk quotas dquot_6.5.2<br>
        Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>
        JFFS2 version 2.2. (NAND) ï¿½Â© 2001-2006 Red Hat, Inc.<br>
        msgmni has been set to 500<br>
        alg: No test for stdrng (krng)<br>
        Block layer SCSI generic (bsg) driver version 0.4 loaded (major
        253)<br>
        io scheduler noop registered<br>
        io scheduler anticipatory registered (default)<br>
        io scheduler deadline registered<br>
        io scheduler cfq registered<br>
        Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled<br>
        serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654<br>
        serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654<br>
        serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654<br>
        console [ttyS2] enabled<br>
        brd: module loaded<br>
        loop: module loaded<br>
        i2c /dev entries driver<br>
        usbcore: registered new interface driver asix<br>
        usbcore: registered new interface driver cdc_ether<br>
        usbcore: registered new interface driver net1080<br>
        usbcore: registered new interface driver cdc_subset<br>
        usbcore: registered new interface driver zaurus<br>
        usbmon: debugfs is not available<br>
        g_ether gadget: using random self ethernet address<br>
        g_ether gadget: using random host ethernet address<br>
        usb0: MAC b2:59:96:51:13:fa<br>
        usb0: HOST MAC da:76:f6:16:2e:21<br>
        g_ether gadget: Ethernet Gadget, version: Memorial Day 2008<br>
        g_ether gadget: g_ether ready<br>
        musb_hdrc musb_hdrc: MUSB HDRC host driver<br>
        musb_hdrc musb_hdrc: new USB bus registered, assigned bus number
        1<br>
        usb usb1: New USB device found, idVendor=1d6b, idProduct=0002<br>
        usb usb1: New USB device strings: Mfr=3, Product=2,
        SerialNumber=1<br>
        usb usb1: Product: MUSB HDRC host driver<br>
        usb usb1: Manufacturer: Linux 2.6.31-omap1 musb-hcd<br>
        usb usb1: SerialNumber: musb_hdrc<br>
        usb usb1: configuration #1 chosen from 1 choice<br>
        hub 1-0:1.0: USB hub found<br>
        hub 1-0:1.0: 1 port detected<br>
        mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock<br>
        TCP cubic registered<br>
        NET: Registered protocol family 17<br>
        NET: Registered protocol family 15<br>
        RPC: Registered udp transport module.<br>
        RPC: Registered tcp transport module.<br>
        Power Management for TI OMAP3.<br>
        VFP support v0.3: implementor 41 architecture 3 part 30 variant
        c rev 1<br>
        regulator_init_complete: incomplete constraints, leaving VDVI on<br>
        regulator_init_complete: incomplete constraints, leaving VDAC on<br>
        drivers/rtc/hctosys.c: unable to open rtc device (rtc0)<br>
        Waiting for root device /dev/mmcblk0p2...</tt></small><br>
    <br>
    The Angstrom developers are working at 2.6.32. The 2.6.31 kernel is
    the newest kernel that both Angstrom and Xenomai support. I know
    that not applying the patches that Angstrom provided 2.6.31 kernel,
    broke the ability of my BeagleBoard to use the EHCI USB host Port on
    the board.<br>
    <br>
    I suspect that the problem is something specific to the way the
    BeagleBoard uses the OMAP3530 as an SD card controller. There are
    multiple ways to attach a SD card interface to a OMAP3 chip. There
    may be a difference between the board that you are using and the
    BeagleBoard.<br>
    <br>
    The SD cards that I am using are Class 4 (4-bit wide) 2 to 4 GB
    cards. The BeagleBoard attaches the SD card interface to the MMC1
    port. SD cards can also be attached via an SPI bus.<br>
    How does the SD card attache in your board?<br>
    <br>
    The BeagleBoard SRM references a "Card Detect" interrupt.8.11.3 Card
    Detect<br>
    <blockquote type="cite">When a card is inserted into the SD/MMC
      connector, the Card Detect pin is grounded.<br>
      This is detected on pin P12 of the TPS65950. An interrupt, if
      enabled, is sent to the<br>
      OMAP3530 via the interrupt pin. The SW can be written such that
      the system comes out of sleep or a reduced frequency mode when the
      card is detected.</blockquote>
    There doesn't seem to be any other interrupt signal external to the
    OMAP chip.<br>
    <br>
    I'll dig deeper and find out specifically which interrupts the
    BeagleBoard SD card affects.<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    On 7/19/2010 1:31 AM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C440D6F.1060204@domain.hid" type="cite">
      <pre wrap="">Bob Feretich wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">  Thank you for the quick reply.

I rebuilt the non-Adeos patched kernel with the 32 KHz clocked disabled. 
It booted correctly, so that wasn't the problem.  I didn't see any other 
significant differences in the console boot logs.

The console log for the non-Adeos patched kernel with the 32 KHz clocked 
disabled is pasted below. The /proc/interrupts contents is displayed at 
the end.

I used the 1.16-01 patch.

</pre>
        <blockquote type="cite">
          <pre wrap="">Reading boot sector
Loading u-boot.bin from mmc


... snipped ...

beagleboard login: root
root@domain.hid:~# cat /proc/interrupts
           CPU0
  7:          2        INTC  TWL4030-PIH
 11:          0        INTC  prcm
 12:       1078        INTC  DMA
 37:       1009        INTC  gp timer
 56:        273        INTC  i2c_omap
 61:          0        INTC  i2c_omap
 72:          1        INTC  serial idle
 73:          1        INTC  serial idle
 74:        158        INTC  serial idle, serial
 77:          0        INTC  ehci_hcd:usb1
 83:       1346        INTC  mmc0
 92:          1        INTC  musb_hdrc
 93:          0        INTC  musb_hdrc
378:          2     twl4030  twl4030_usb
384:          0     twl4030  mmc0
Err:          0
root@domain.hid:~# 
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
Ok. Several questions: what is this MADC patch you were talking about?
If this is a kernel patch, if yes, could you try and remove it?

You have an error message about mmc:
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock

which I do not have. Could this not explain some issues?

You are using the 2.6.31 kernel which does not work for you, whereas
2.6.33 works for me. Could you test 2.6.33?

</pre>
    </blockquote>
  </body>
</html>

--------------040408050902090404030608--

