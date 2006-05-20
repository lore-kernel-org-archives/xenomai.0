Message-ID: <446F2ED7.7030701@domain.hid>
Date: Sat, 20 May 2006 16:59:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
References: <B4D14EA407C38B4DAF92B8EAC9249D7F0179D3BC@mspex01.go.mts.com>
In-Reply-To: <B4D14EA407C38B4DAF92B8EAC9249D7F0179D3BC@mspex01.go.mts.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rosenow, Jim" <Jim.Rosenow@domain.hid>
Cc: xenomai@xenomai.org

Rosenow, Jim wrote:
> Hi,
> 
> I've almost got my mvme5500 running.  I get the following error when 
> booting up.
> 
> kernel BUG in add_preempt_count at kernel/sched.c:2819!
> 
> Oops: kernel access of bad area, sig: 11 [#1]
> 
> I'm a little new at this and don't know whether I'm looking at a xenomai 
> problem, an adeos problem, or something else.

I can't reproduce it on 2.6.14.7 compiled for an icecube target, which 
means that this issue is likely triggered by some code which is 
specifically enabled by the MVME5500 configuration, and/or added by the 
Motorola patch (could not find a public access to it, btw). I suspect an 
issue in the network support this board uses given the boot sequence 
before the oops, but I'm just taking a wild guess.

As Jan suggested, we need to get a usable backtrace for this bug. Try 
applying this patch, along with the ipipe tracer patch.

--- kernel/sched.c~	2006-05-20 12:05:50.000000000 +0200
+++ kernel/sched.c	2006-05-20 16:45:33.000000000 +0200
@@ -2816,6 +2816,10 @@
  	/*
  	 * Underflow?
  	 */
+        if (preempt_count() < 0) {
+	    ipipe_ipipe_trace_panic_freeze();
+	    ipipe_ipipe_trace_panic_dump();
+	}
  	BUG_ON((preempt_count() < 0));
  	preempt_count() += val;
  	/*
> 
> Any help and direction would be appreciated.
> 
>  
> 
> Jim
> 
> 
> ------------------------------------------------------------------------
> 
> Linux/PPC load: console=ttyS0,9600 root=/dev/nfs rw ip=bootp
> Uncompressing Linux...done.
> Now booting the kernel
> Total memory = 512MB; using 1024kB for hash table (at a0400000)
> Linux version 2.6.14.7 (root@domain.hid) (gcc version 4.0.0 (DENX ELD6
> Motorola Computer Group MVME5500  Board
> MVME5500 port (C) 2003-2006 Motorola, Inc.
> Built 1 zonelists
> Kernel command line: console=ttyS0,9600 root=/dev/nfs rw ip=bootp
> PID hash table entries: 4096 (order: 12, 65536 bytes)
> time_init: decrementer frequency = 33.333175 MHz
> I-pipe 1.2-03: pipeline enabled.
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 514176k available (2952k kernel code, 936k data, 164k init, 0k highmem)
> Mount-cache hash table entries: 512
> softlockup thread 0 started up.
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> SCSI subsystem initialized
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/powerpc started.
> Xenomai: real-time nucleus v2.1.1 (Trundrumbalind) loaded.
> Xenomai: starting native API services.
> Xenomai: starting RTDM services.
> Installing knfsd (copyright (C) 1996 okir@domain.hid).
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> Initializing Cryptographic API
> Generic RTC Driver v1.07
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> ttyS0 at MMIO 0x0 (irq = 64) is a 16550A
> ttyS1 at MMIO 0x0 (irq = 64) is a 16550A
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> nbd: registered device at major 43
> Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
> Copyright (c) 1999-2005 Intel Corporation.
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> mvme5500-flash0: Found 2 x16 devices at 0x0 in 32-bit bank
>  Intel/Sharp Extended Query Table at 0x0031
> Using buffer write method
> cfi_cmdset_0001: Erase suspend on write enabled
> Creating 3 MTD partitions on "mvme5500-flash0":
> 0x00000000-0x01400000 : "Linux Kernel + INITRD"
> 0x01400000-0x01f00000 : "Linux JFFS2 Filesystem"
> 0x01f00000-0x02000000 : "Bootloader Flash 0"
> mvme5500-flash1: Found 2 x16 devices at 0x0 in 32-bit bank
>  Intel/Sharp Extended Query Table at 0x0031
> Using buffer write method
> cfi_cmdset_0001: Erase suspend on write enabled
> Creating 2 MTD partitions on "mvme5500-flash1":
> 0x00000000-0x00700000 : "Linux JFFS2 Filesystem"
> 0x00700000-0x00800000 : "Bootloader Flash 1"
> mice: PS/2 mouse device common for all mice
> Tundra TSI148/CA91C042 PCI-VME Bridge Driver 3.5 03/24/2006
> Bad VME slot #00
> i2c /dev entries driver
> kernel BUG in add_preempt_count at kernel/sched.c:2819!
> Oops: kernel access of bad area, sig: 11 [#1]
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

