Message-ID: <2862c2c80707160150s1db21911y5cd7111a88213881@domain.hid>
Date: Mon, 16 Jul 2007 16:50:07 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707160128h37312a6and595d0b9a92312c1@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_41438_2205149.1184575807040"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707152040v1cc27cb2kc33f1cbf21932cba@domain.hid>
	<18075.3438.734938.482223@domain.hid>
	<2862c2c80707160043w581aa4c5i20c2c7de1e0e2412@domain.hid>
	<2ff1a98a0707160128h37312a6and595d0b9a92312c1@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_41438_2205149.1184575807040
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

Here the full log messages:

Linux version 2.6.20 (root@domain.hid) (gcc version 3.4.2) #9 Mon Jul 16 16:05:34
MYT 2007
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=00003177
Machine: KB920x
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 180 MHz, master 60 MHz, main 10.000 MHz
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
CPU0: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
Built 1 zonelists.  Total pages: 16256
Kernel command line: console=ttyS0,115200 root=/dev/nfs nfsroot=
172.16.6.174:/home/yeow/kwikbyte/KB9202B/target_fs ip=172.16.6.203
AT91: 96 gpio irqs in 3 banks
PID hash table entries: 256 (order: 8, 1024 bytes)
I-pipe 1.7-03: pipeline enabled.
Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 61616KB available (2884K code, 254K data, 104K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
audit: initializing netlink socket (disabled)
audit(0.550:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a ATMEL_SERIAL
atmel_usart.1: ttyS1 at MMIO 0xfffc0000 (irq = 6) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffc4000 (irq = 7) is a ATMEL_SERIAL
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Link now 100-FullDuplex
eth0: AT91 ethernet at 0xfefbc000 int=24 100-FullDuplex (14:09:07:05:05:02)
eth0: Intel LXT971A PHY
NAND device: Manufacturer ID: 0x20, Chip ID: 0x75 (ST Micro NAND 32MiB 3,3V
8-bit)
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 32MiB 3,3V 8-bit":
0x00000000-0x02000000 : "nand_fs"
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 23, io mem 0x00300000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: Link now 100-FullDuplex
eth0: Link now 100-FullDuplex
IP-Config: Guessing netmask 255.255.0.0
IP-Config: Complete:
      device=eth0, addr=172.16.6.203, mask=255.255.0.0, gw=255.255.255.255,
     host=172.16.6.203, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=172.16.6.174, rootpath=
Looking up port of RPC 100003/2 on 172.16.6.174
Looking up port of RPC 100005/1 on 172.16.6.174
VFS: Mounted root (nfs filesystem).
Freeing init memory: 104K
- HANG

Any ideas? What's going wrong?

regards,
chun yeow

On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> On 7/16/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> > On 7/16/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > > Yeoh Chun Yeow wrote:
> > > > > Dear all,
> > > > >
> > > > > I have applied the
> > adeos-ipipe-2.6.20-arm-1.7.03.patch for kernel
> > 2.6.20(patches with
> > > > > 2.6.20-at91.patch) on my AT91RM9200 board from kwikbyte.
> > >
> > > this patch is booting fine here on an AT91RM9200 board, booting with
> > > NFS. But I had similar problems when enabling the I-pipe tracer, so be
> > > sure that the tracer is disabled. Also, could you try without the
> > > 2.6.20-at91 patch ? If it still does not boot without the I-pipe
> tracer
> > > and without the 2.6.20-at91 patch, please send us your .config.
> >
> > Dear Gilles,
> >
> > I have recompiled the kernel either with or without the 2.6.20-at91patch,
> > but the result remains the same. But this time with more kernel log
> > messages:
> >
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> > eth0: Link now 100-FullDuplex
> > eth0: Link now 100-FullDuplex
> > IP-Config: Guessing netmask 255.255.0.0
> > IP-Config: Complete:
> >       device=eth0, addr= 172.16.6.203, mask=255.255.0.0, gw=
> 255.255.255.255,
> >      host=172.16.6.203, domain=, nis-domain=(none),
> >      bootserver= 255.255.255.255, rootserver=172.16.6.174, rootpath=
> > Looking up port of RPC 100003/2 on 172.16.6.174
> > Looking up port of RPC 100005/1 on 172.16.6.174
> > VFS: Mounted root (nfs filesystem).
> > Freeing init memory: 104K
> > -- HANG
> >
> > Attach my config file. I check the 2.6.20-at91 patch and found out that
> it
> > is simply adding USB gadget support and SPI device.
>
> Thanks for the .config, could you also send us the full logs ?
>
> >
> > Is that possible that the interrupts overflow? My master clock frequency
> is
> > 60MHz. How to determine the delay in __ipipe_mach_set_dev?
>
> I-pipe uses an AT91 timer counter, with a frequency which is a
> sub-multiple of
> the master clock frequency. The timer frequency is deduced from the master
> clock frequency in include/asm-arm/arch-at91rm9200/timex.h
>
> Please, avoid dropping the mailing list from the CC.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_41438_2205149.1184575807040
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>Here the full log messages:<br><br>Linux version 2.6.20 (root@domain.hid) (gcc version 3.4.2) #9 Mon Jul 16 16:05:34 MYT 2007<br>CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=00003177<br>Machine: KB920x<br>
Memory policy: ECC disabled, Data cache writeback<br>Clocks: CPU 180 MHz, master 60 MHz, main 10.000 MHz<br>CPU0: D VIVT write-back cache<br>CPU0: I cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets<br>CPU0: D cache: 16384 bytes, associativity 64, 32 byte lines, 8 sets
<br>Built 1 zonelists.&nbsp; Total pages: 16256<br>Kernel command line: console=ttyS0,115200 root=/dev/nfs nfsroot=172.16.6.174:/home/yeow/kwikbyte/KB9202B/target_fs ip=<a href="http://172.16.6.203">172.16.6.203</a><br>AT91: 96 gpio irqs in 3 banks
<br>PID hash table entries: 256 (order: 8, 1024 bytes)<br>I-pipe 1.7-03: pipeline enabled.<br>Console: colour dummy device 80x30<br>Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<br>Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
<br>Memory: 64MB = 64MB total<br>Memory: 61616KB available (2884K code, 254K data, 104K init)<br>Mount-cache hash table entries: 512<br>CPU: Testing write buffer coherency: ok<br>NET: Registered protocol family 16<br>SCSI subsystem initialized
<br>usbcore: registered new interface driver usbfs<br>usbcore: registered new interface driver hub<br>usbcore: registered new device driver usb<br>NET: Registered protocol family 2<br>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
<br>TCP established hash table entries: 2048 (order: 1, 8192 bytes)<br>TCP bind hash table entries: 1024 (order: 0, 4096 bytes)<br>TCP: Hash tables configured (established 2048 bind 1024)<br>TCP reno registered<br>NetWinder Floating Point Emulator 
V0.97 (double precision)<br>audit: initializing netlink socket (disabled)<br>audit(0.550:1): initialized<br>VFS: Disk quotas dquot_6.5.1<br>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
<br>io scheduler noop registered<br>io scheduler anticipatory registered<br>io scheduler deadline registered<br>io scheduler cfq registered (default)<br>atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a ATMEL_SERIAL<br>
atmel_usart.1: ttyS1 at MMIO 0xfffc0000 (irq = 6) is a ATMEL_SERIAL<br>atmel_usart.2: ttyS2 at MMIO 0xfffc4000 (irq = 7) is a ATMEL_SERIAL<br>RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize<br>loop: loaded (max 8 devices)
<br>eth0: Link now 100-FullDuplex<br>eth0: AT91 ethernet at 0xfefbc000 int=24 100-FullDuplex (14:09:07:05:05:02)<br>eth0: Intel LXT971A PHY<br>NAND device: Manufacturer ID: 0x20, Chip ID: 0x75 (ST Micro NAND 32MiB 3,3V 8-bit)
<br>Scanning device for bad blocks<br>Creating 1 MTD partitions on &quot;NAND 32MiB 3,3V 8-bit&quot;:<br>0x00000000-0x02000000 : &quot;nand_fs&quot;<br>at91_ohci at91_ohci: AT91 OHCI<br>at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
<br>at91_ohci at91_ohci: irq 23, io mem 0x00300000<br>usb usb1: configuration #1 chosen from 1 choice<br>hub 1-0:1.0: USB hub found<br>hub 1-0:1.0: 1 port detected<br>Initializing USB Mass Storage driver...<br>usbcore: registered new interface driver usb-storage
<br>USB Mass Storage support registered.<br>usbcore: registered new interface driver libusual<br>usbcore: registered new interface driver usbhid<br>drivers/usb/input/hid-core.c: v2.6:USB HID core driver<br>mice: PS/2 mouse device common for all mice
<br>AT91 MMC: 4 wire bus mode not supported by this driver - using 1 wire<br>TCP cubic registered<br>NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>eth0: Link now 100-FullDuplex<br>eth0: Link now 100-FullDuplex
<br>IP-Config: Guessing netmask <a href="http://255.255.0.0">255.255.0.0</a><br>IP-Config: Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=<a href="http://172.16.6.203">172.16.6.203</a>, mask=<a href="http://255.255.0.0">255.255.0.0
</a>, gw=<a href="http://255.255.255.255">255.255.255.255</a>,<br>&nbsp;&nbsp;&nbsp;&nbsp; host=<a href="http://172.16.6.203">172.16.6.203</a>, domain=, nis-domain=(none),<br>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=<a href="http://255.255.255.255">255.255.255.255</a>
, rootserver=<a href="http://172.16.6.174">172.16.6.174</a>, rootpath=<br>Looking up port of RPC 100003/2 on <a href="http://172.16.6.174">172.16.6.174</a><br>Looking up port of RPC 100005/1 on <a href="http://172.16.6.174">
172.16.6.174</a><br>VFS: Mounted root (nfs filesystem).<br>Freeing init memory: 104K<br><span style="color: rgb(255, 0, 0);">- HANG</span><br><br>Any ideas? What&#39;s going wrong?<br><br>regards,<br>chun yeow<br><br><div>
<span class="gmail_quote">On 7/16/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On 7/16/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid">yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt; On 7/16/07, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org
</a>&gt; wrote:<br>&gt; &gt; Yeoh Chun Yeow wrote:<br>&gt; &gt; &gt; &gt; Dear all,<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; I have applied the<br>&gt; adeos-ipipe-2.6.20-arm-1.7.03.patch for kernel<br>&gt; 2.6.20(patches with
<br>&gt; &gt; &gt; &gt; 2.6.20-at91.patch) on my AT91RM9200 board from kwikbyte.<br>&gt; &gt;<br>&gt; &gt; this patch is booting fine here on an AT91RM9200 board, booting with<br>&gt; &gt; NFS. But I had similar problems when enabling the I-pipe tracer, so be
<br>&gt; &gt; sure that the tracer is disabled. Also, could you try without the<br>&gt; &gt; 2.6.20-at91 patch ? If it still does not boot without the I-pipe tracer<br>&gt; &gt; and without the 2.6.20-at91 patch, please send us your .config.
<br>&gt;<br>&gt; Dear Gilles,<br>&gt;<br>&gt; I have recompiled the kernel either with or without the 2.6.20-at91 patch,<br>&gt; but the result remains the same. But this time with more kernel log<br>&gt; messages:<br>&gt;
<br>&gt; NET: Registered protocol family 1<br>&gt; NET: Registered protocol family 17<br>&gt; eth0: Link now 100-FullDuplex<br>&gt; eth0: Link now 100-FullDuplex<br>&gt; IP-Config: Guessing netmask <a href="http://255.255.0.0">
255.255.0.0</a><br>&gt; IP-Config: Complete:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr= <a href="http://172.16.6.203">172.16.6.203</a>, mask=<a href="http://255.255.0.0">255.255.0.0</a>, gw=<a href="http://255.255.255.255">255.255.255.255
</a>,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;host=<a href="http://172.16.6.203">172.16.6.203</a>, domain=, nis-domain=(none),<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bootserver= <a href="http://255.255.255.255">255.255.255.255</a>, rootserver=<a href="http://172.16.6.174">172.16.6.174
</a>, rootpath=<br>&gt; Looking up port of RPC 100003/2 on <a href="http://172.16.6.174">172.16.6.174</a><br>&gt; Looking up port of RPC 100005/1 on <a href="http://172.16.6.174">172.16.6.174</a><br>&gt; VFS: Mounted root (nfs filesystem).
<br>&gt; Freeing init memory: 104K<br>&gt; -- HANG<br>&gt;<br>&gt; Attach my config file. I check the 2.6.20-at91 patch and found out that it<br>&gt; is simply adding USB gadget support and SPI device.<br><br>Thanks for the .config, could you also send us the full logs ?
<br><br>&gt;<br>&gt; Is that possible that the interrupts overflow? My master clock frequency is<br>&gt; 60MHz. How to determine the delay in __ipipe_mach_set_dev?<br><br>I-pipe uses an AT91 timer counter, with a frequency which is a sub-multiple of
<br>the master clock frequency. The timer frequency is deduced from the master<br>clock frequency in include/asm-arm/arch-at91rm9200/timex.h<br><br>Please, avoid dropping the mailing list from the CC.<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix
<br></blockquote></div><br>

------=_Part_41438_2205149.1184575807040--

