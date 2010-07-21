Message-ID: <4C47597F.1010406@domain.hid>
Date: Wed, 21 Jul 2010 13:33:03 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
	<4C468040.3030509@domain.hid> <4C468485.5060408@domain.hid>
In-Reply-To: <4C468485.5060408@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------080509030607040807030800"
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
--------------080509030607040807030800
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

  I reverted the patch that you suggested. Spurious interrupts crashed 
the kernel during boot. (console log below)

The only data that I have to go on for the difference between the Adeos 
hang on 2.6.31 and successful boot on 2.6.33 is interrupts on IRQ 384, 
which occur on 2.6.31 but not 2.6.33.
This change in interrupts is independent of the Adeos patch, so I will 
build a vanilla 2.6.32 kernel and see if the interrupts occur there. 
This may help isolate which kernel change made the difference.

Regards,
Bob Feretich

Boot log with 2.6.31 patch reverted...
Texas Instruments X-Loader 1.4.2 (Feb 19 2009 - 12:01:24)
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

1882564 bytes read
## Booting kernel from Legacy Image at 80300000 ...
    Image Name:   Angstrom/2.6.31/beagleboard
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    1882500 Bytes =  1.8 MB
    Load Address: 80008000
    Entry Point:  80008000
    Verifying Checksum ... OK
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing 
Linux....................................................................................................
................... done, booting the kernel.
Linux version 2.6.31-omap1 (Bob@domain.hid) (gcc version 4.3.3 (GCC) ) 
#1 Wed Jul 21 12:11:46 PDT 2010
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
usb0: MAC 0a:42:53:3d:f4:42
usb0: HOST MAC 7a:a1:c1:fe:37:e9
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
Spurious irq 95: 0xffffffdf, please flush posted write for irq 56

... a total of 1023 of these messages are generated ...

Spurious irq 95: 0xffffffdf, please flush posted write for irq 56
Unable to handle kernel NULL pointer dereference at virtual address 00000060
pgd = c0004000
[00000060] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.31-omap1 #1)
PC is at 0x60
LR is at irq_enter+0x10/0x64
pc : [<00000060>]    lr : [<c004f61c>]    psr: a0000193
sp : cf81a010  ip : cf81a000  fp : fffffffb
r10: 00000004  r9 : ffffffff  r8 : c038c9f8
r7 : c038ca18  r6 : c03b3b80  r5 : 00000000  r4 : 00000042
r3 : 0000005f  r2 : cf81a018  r1 : c0377ccf  r0 : c0076954
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 80004019  DAC: 00000017
Process ï¿½ï¿½;ï¿½ (pid: 0, stack limit = 0xcf8182e8)

On 7/20/2010 10:24 PM, Gilles Chanteperdrix wrote:
> That is not really possible. The Adeos pipeline does not really "see"
> the twl4030 level 2 interrupts, as I said, these are dispatched manually
> by a thread, and not handled by the usual chained interrupts mechanism.
>
> However, I had trouble with this code on 2.6.33 generating spurious i2c
> interrupts, which lead me to the following patch:
> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cdc72520c88b329fa785b0e1f45392cdfff10ec6;hp=e52fee515be7c5b914c201c19604cd700afbc44f
>
> which I backported to 2.6.31 without testing it. Could you try and
> revert it?

--------------080509030607040807030800
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    I reverted the patch that you suggested. Spurious interrupts crashed
    the kernel during boot. (console log below)<br>
    <br>
    The only data that I have to go on for the difference between the
    Adeos hang on 2.6.31 and successful boot on 2.6.33 is interrupts on
    IRQ 384, which occur on 2.6.31 but not 2.6.33.<br>
    This change in interrupts is independent of the Adeos patch, so I
    will build a vanilla 2.6.32 kernel and see if the interrupts occur
    there. This may help isolate which kernel change made the
    difference.<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
    <br>
    Boot log with 2.6.31 patch reverted...<br>
    <small><tt>Texas Instruments X-Loader 1.4.2 (Feb 19 2009 - 12:01:24)<br>
        Reading boot sector<br>
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
        1882564 bytes read<br>
        ## Booting kernel from Legacy Image at 80300000 ...<br>
           Image Name:   Angstrom/2.6.31/beagleboard<br>
           Image Type:   ARM Linux Kernel Image (uncompressed)<br>
           Data Size:    1882500 Bytes =  1.8 MB<br>
           Load Address: 80008000<br>
           Entry Point:  80008000<br>
           Verifying Checksum ... OK<br>
           Loading Kernel Image ... OK<br>
        OK<br>
        <br>
        Starting kernel ...<br>
        <br>
        Uncompressing
Linux....................................................................................................<br>
        ................... done, booting the kernel.<br>
        Linux version 2.6.31-omap1 (<a class="moz-txt-link-abbreviated" href="mailto:Bob@domain.hid">Bob@domain.hid</a>) (gcc version 4.3.3
        (GCC) ) #1 Wed Jul 21 12:11:46 PDT 2010<br>
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
        usb0: MAC 0a:42:53:3d:f4:42<br>
        usb0: HOST MAC 7a:a1:c1:fe:37:e9<br>
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
        Spurious irq 95: 0xffffffdf, please flush posted write for irq
        56<br>
        <br>
        ... a total of 1023 of these messages are generated ...<br>
        <br>
        Spurious irq 95: 0xffffffdf, please flush posted write for irq
        56<br>
        Unable to handle kernel NULL pointer dereference at virtual
        address 00000060<br>
        pgd = c0004000<br>
        [00000060] *pgd=00000000<br>
        Internal error: Oops: 0 [#1]<br>
        Modules linked in:<br>
        CPU: 0    Not tainted  (2.6.31-omap1 #1)<br>
        PC is at 0x60<br>
        LR is at irq_enter+0x10/0x64<br>
        pc : [&lt;00000060&gt;]    lr : [&lt;c004f61c&gt;]    psr:
        a0000193<br>
        sp : cf81a010  ip : cf81a000  fp : fffffffb<br>
        r10: 00000004  r9 : ffffffff  r8 : c038c9f8<br>
        r7 : c038ca18  r6 : c03b3b80  r5 : 00000000  r4 : 00000042<br>
        r3 : 0000005f  r2 : cf81a018  r1 : c0377ccf  r0 : c0076954<br>
        Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment
        user<br>
        Control: 10c5387d  Table: 80004019  DAC: 00000017<br>
        Process ï¿½ï¿½;ï¿½ (pid: 0, stack limit = 0xcf8182e8)</tt></small><br>
    <br>
    On 7/20/2010 10:24 PM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C468485.5060408@domain.hid" type="cite">That
      is not really possible. The Adeos pipeline does not really "see"<br>
      <pre wrap="">the twl4030 level 2 interrupts, as I said, these are dispatched manually
by a thread, and not handled by the usual chained interrupts mechanism.

However, I had trouble with this code on 2.6.33 generating spurious i2c
interrupts, which lead me to the following patch:
<a class="moz-txt-link-freetext" href="http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cdc72520c88b329fa785b0e1f45392cdfff10ec6;hp=e52fee515be7c5b914c201c19604cd700afbc44f">http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=cdc72520c88b329fa785b0e1f45392cdfff10ec6;hp=e52fee515be7c5b914c201c19604cd700afbc44f</a>

which I backported to 2.6.31 without testing it. Could you try and
revert it?
</pre>
    </blockquote>
  </body>
</html>

--------------080509030607040807030800--

