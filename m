From: Tim Cussins <timcussins@domain.hid>
In-Reply-To: <4C469259.3000708@domain.hid>
References: <1278943817.7023.18.camel@domain.hid>  <4C3EF6D6.6040907@domain.hid>
	<1279210298.1995.38.camel@domain.hid>
	<1279623645.2187.35.camel@domain.hid>  <4C469259.3000708@domain.hid>
Content-Type: multipart/mixed; boundary="=-Kob0YY+VdkhnTZ29itkF"
Date: Wed, 11 Aug 2010 15:58:43 +0100
Message-ID: <1281538723.2246.120.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Marvell sheeva support
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
Cc: xenomai@xenomai.org


--=-Kob0YY+VdkhnTZ29itkF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi guys,

Managed to get started on the Sheevaplug/xenomai stuff:
  Used mkrootfs. Cool.
  Massaged the mv88fxxxx patch so that it builds with 2.6.33.
  Can't log into the device to run tests. Augh.

Details below! :P

On Wed, 2010-07-21 at 08:23 +0200, Gilles Chanteperdrix wrote:
> Tim Cussins wrote:
> >>> We can also provide you with a root filesystem for validating this platform.
> > 
> > That would be brilliant. I imagine I'll be iterating though uImages on
> > an SD card loaded with your rootfs. Sound ok? Let me know how to obtain
> > the rootfs (or better, show me how you prefer to do it, so I learn
> > something! Ta.)
> 
> You will find the rootfs for orion SOCs, here:
> http://www.xenomai.org/~gch/pub/rootfs-orion.tar.bz2
> 
> Edit etc/inittab to modify the serial console it needs (if it is not
> /dev/ttyS0 running at 115200 bauds). The rootfs is meant to be booted by
> NFS with the kernel IP auto-configuration, so, if you want to boot it on
> an SD card, you will have to connect to the serial console once the
> board is booted, and run "udhcpc" to configure the network by DHCP, or
> use ifconfig to configure it by hand, then launch "telnetd" to be able
> to connect to that board through telnet (if the kernel booted by NFS,
> the telnet server will have been launched automatically)
> 
> In a first telnet session, run:
> latency
> In a second telnet session, if you have FCSE disabled, run:
> dohell
> if you have FCSE enabled, run:
> noltp_hell 14400
> (14400 means that you will generate some load during 14400s, that is 4
> hours).
> When either noltp_hell or dohell displays the line:
> Listening on any address 5566
> On the host, run:
> netcat <target-ip> 5566 > /dev/null
> 
> Now you can return to the telnet session running latency. When the test
> is finished the latency program should stop.
> 
> As for generating the root filesystem, it is not that it is really hard,
> but it is a bit tedious. So, we made a tool to build a root filesystem
> which suits our needs, that is testing Xenomai under load. I have just
> finished working on a version of this tool (called mkrootfs, but I think
> we should find a better name, as this one already exists) user-friendly
> enough to be published. Currently, it is still lacking a documentation.
> You will find it here:
> 
> http://www.xenomai.org/~gch/pub/mkrootfs.tar.bz2
> 
> However, to use it, you will need a few explanations. It is based on
> Kbuild, the Linux kernel build system, so, it will build the same way.
> Create a build directory, cd to it, then run:
> 
> make -C /path/to/mkrootfs O=`pwd` xconfig
> 
> Tweak the configuration. Then run:
> make
> 
> It should build everything.
> 
> It does not download and patch the sources of the packages it uses, you
> have to do this yourself, then pass the path where to look for them to
> the configuration system. We use standard versions of the packages,
> except for LTP, which we modified a bit to run on low-end platforms, and
> which you can find here:
> 
> http://www.xenomai.org/~gch/ltp-20081130-patched.tar.bz2


I've had a good play with mkrootfs - nice. I had to make a couple of
changes to meet my needs (and system, ubuntu 10.04). Is there a git repo
for mkrootfs that I can base my patches on? They're very small btw. More
on that off-list if you want.

> 
> >> You can also use the patch below as a starting point for your port:
> >> http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.29-mv88f6290.patch
> > 
> > I've tried applying this to vanilla 2.6.29 and 2.6.29.6 - it doesn't
> > apply cleanly (well, fails :P). Am I approaching this the wrong way?
> > Also tried chucking the patch into the xenomai tree and getting
> > prepare_kernel.sh to try: still no joy.
> 
> It probably does not apply to vanilla because vanilla has no support for
> the Sheevaplug board. Or am I missing something?

Well, I don't think so. Some hunks are expecting lines of context that
simply don't exist in 2.6.29 == fail.

I took the mv88f6290 patch and bullied it into applying to vanilla
2.6.29. Built ok, but was at home and no way to test, so I just got on
with migrating it to 2.6.33. That seems to be done - check the 2.6.33
boot output:
  
   ...
  I-pipe: Domain Xenomai registered.
  Xenomai: hal/arm started.
  Xenomai: scheduling class idle registered.
  Xenomai: scheduling class rt registered.
  Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
  Xenomai: starting native API services.
  Xenomai: starting POSIX services.
  Xenomai: starting RTDM services.
   ...

Full boot output is attached FYI.

However, I've got a problem with busybox/getty and /dev/ttyS0 so I can't
log in via console OR telnet. Once that's solved, I'll be able to run
the xenomai tests. (In case you've seen it before - /var/log/messages is
slowly filling with:

Aug 11 16:03:36 init: starting pid 638, tty '/dev/ttyS0': '/sbin/getty
115200 ttyS0'
Aug 11 16:03:36 getty[638]: ttyS0: TCGETS: Inappropriate ioctl for
device

)

Cheers,
Tim


--=-Kob0YY+VdkhnTZ29itkF
Content-Disposition: attachment; filename="boot-output"
Content-Type: text/plain; name="boot-output"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Linux version 2.6.33 (timc@domain.hid) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #3 PREEMPT Wed Aug 11 14:30:06 BST 2010
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: Marvell SheevaPlug Reference Board
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyS0,115200 mtdparts=orion_nand:0x400000@domain.hid),
0x8000000@domain.hid) root=/dev/nfs rw ip=dhcp nfsroo
t=10.2.7.70:/home/timc/nfs/orion-rootfs
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256MB 256MB = 512MB total
Memory: 513152KB available (4548K code, 1546K data, 120K init, 0K highmem)
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:114
I-pipe 1.17-02: pipeline enabled.
Console: colour dummy device 80x30
Calibrating delay loop... 1192.75 BogoMIPS (lpj=5963776)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
Kirkwood: MV88F6281-A0, TCLK=200000000.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
cfg80211: Using static regulatory domain info
cfg80211: Regulatory domain: 00
    (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
    (2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2000 mBm)
    (2457000 KHz - 2482000 KHz @ 20000 KHz), (600 mBi, 2000 mBm)
    (2474000 KHz - 2494000 KHz @ 20000 KHz), (600 mBi, 2000 mBm)
    (5170000 KHz - 5250000 KHz @ 40000 KHz), (600 mBi, 2000 mBm)
    (5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 2000 mBm)
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource orion_clocksource
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
msgmni has been set to 1002
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
console [ttyS0] enabled
loop: module loaded
NAND device: Manufacturer ID: 0xec, Chip ID: 0xdc (Samsung NAND 512MiB 3,3V 8-bit)
Scanning device for bad blocks
Bad eraseblock 2330 at 0x000012340000
Bad eraseblock 3396 at 0x00001a880000
7 cmdlinepart partitions found on MTD device orion_nand
Creating 7 MTD partitions on "orion_nand":
0x000000100000-0x000000500000 : "uImage-default"
0x000000500000-0x000000900000 : "uImage-fallback"
0x000000900000-0x000000d00000 : "uImage-main"
0x000000d00000-0x000008d00000 : "rootfs-fallback"
0x000008d00000-0x000010d00000 : "rootfs-main"
0x000010d00000-0x000011d00000 : "persistent"
0x000011d00000-0x000012d00000 : "update"
MV-643xx 10/100/1000 ethernet driver version 1.4
mv643xx_eth smi: probed
net eth0: port 0 with MAC address 00:50:43:01:50:eb
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
orion-ehci orion-ehci.0: Marvell Orion EHCI
orion-ehci orion-ehci.0: new USB bus registered, assigned bus number 1
orion-ehci orion-ehci.0: irq 19, io mem 0xf1050000
orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver ums-datafab
usbcore: registered new interface driver ums-freecom
usbcore: registered new interface driver ums-jumpshot
usbcore: registered new interface driver ums-sddr09
usbcore: registered new interface driver ums-sddr55
mice: PS/2 mouse device common for all mice
rtc-mv rtc-mv: rtc core: registered rtc-mv as rtc0
i2c /dev entries driver
cpuidle: using governor ladder
cpuidle: using governor menu
mmc0: mvsdio driver initialized, lacking card detect (fall back to polling)
Registered led device: plug:green:health
mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: using timer interrupt.
TCP cubic registered
NET: Registered protocol family 17
lib80211: common routines for IEEE802.11 drivers
rtc-mv rtc-mv: setting system clock to 2010-08-11 13:58:13 UTC (1281535093)
Sending DHCP requests .
eth0: link up, 1000 Mb/s, full duplex, flow control disabled
., OK
IP-Config: Got DHCP answer from 10.2.7.70, my address is 10.2.9.37
IP-Config: Complete:
     device=eth0, addr=10.2.9.37, mask=255.255.0.0, gw=10.2.3.7,
     host=10.2.9.37, domain=linn.co.uk, nis-domain=(none),
     bootserver=10.2.7.70, rootserver=10.2.7.70, rootpath=
Looking up port of RPC 100003/2 on 10.2.7.70
Looking up port of RPC 100005/1 on 10.2.7.70
VFS: Mounted root (nfs filesystem) on device 0:13.
Freeing init memory: 120K
nfs: server 10.2.7.70 not responding, still trying
nfs: server 10.2.7.70 OK

--=-Kob0YY+VdkhnTZ29itkF--


