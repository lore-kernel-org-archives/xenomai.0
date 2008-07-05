Message-ID: <486F4C47.5030205@domain.hid>
Date: Sat, 05 Jul 2008 12:26:15 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1215251268.3029.13.camel@domain.hid>
In-Reply-To: <1215251268.3029.13.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unhandled irq 33
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vivek Berodhia <vivek.berodhia@domain.hid>
Cc: xenomai@xenomai.org

Vivek Berodhia wrote:
> Dear All,
> 
> Help me,
> I am facing a problem during booting with xenomai kernel "unhandled
> irq33".
>         
> Kernel Configuration. 
>         
>         ARCH= powerpc
>         CROSS_COMPILE=gcc-6xx-
>         target machine = mpc8323
>         
> following is serial port capture of problem..please help me..
>

Your software kit is obsolete. Upgrading to Xenomai 2.4.4 is strongly
recommended. At the very least, upgrade your I-pipe support to 2.1-04 first, and
in any case, enable CONFIG_DEBUG_BUGVERBOSE to get sensible backtraces.

http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2.6.24-powerpc-DENX-2.1-04.patch

If the problem persists, switch off the Xenomai support from the kernel
configuration, then retry. If nothing improves, try disabling the I-pipe
support, basically booting a standard kernel. Please make sure to send us the
output of /proc/interrupts along with the kernel log when you get a bootable
config, so that we can try to figure out what went wrong with the previous ones.

>         
>         TFTP from server 192.168.4.51; our IP address is 192.168.4.251
>         Filename 'uImage'.
>         Load address: 0x200000
>         Loading:
>         #################################################################
>                  ################################################
>         done
>         Bytes transferred = 1658616 (194ef8 hex)
>         Using FSL UEC0 device
>         TFTP from server 192.168.4.51; our IP address is 192.168.4.251
>         Filename 'my.dtb'.
>         Load address: 0x400000
>         Loading: #
>         done
>         Bytes transferred = 8192 (2000 hex)
>         ## Booting image at 00200000 ...
>            Image Name:   Linux-2.6.24.2
>            Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>            Data Size:    1658552 Bytes =  1.6 MB
>            Load Address: 00000000
>            Entry Point:  00000000
>            Verifying Checksum ... OK
>            Uncompressing Kernel Image ... OK
>            Booting using the fdt at 0x400000
>         WARNING: could not set linux,stdout-path FDT_ERR_NOTFOUND.
>         Using MPC832x RDB machine description
>         Linux version 2.6.24.2 (root@domain.hid) (gcc version 4.2.2) #1
>         Sat Jul 5
>         11:10:57 IST 2008
>         console [udbg0] enabled
>         setup_arch: bootmem
>         mpc832x_rdb_setup_arch()
>         Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware
>         bus
>         number: 0->0
>         arch: exit
>         Zone PFN ranges:
>           DMA             0 ->    16384
>           Normal      16384 ->    16384
>         Movable zone start PFN for each node
>         early_node_map[1] active PFN ranges
>             0:        0 ->    16384
>         Built 1 zonelists in Zone order, mobility grouping on.  Total
>         pages:
>         16256
>         Kernel command line: nfsroot=192.168.4.51:/opt/eldk/nfs2
>         ip=192.168.4.251:192.168.4.51:192.168.4.254:255.255.255.0:Coral_Router:eth1:off root=0
>         IPIC (128 IRQ sources) at fdefb700
>         PID hash table entries: 256 (order: 8, 1024 bytes)
>         clocksource: timebase mult[7800001] shift[22] registered
>         I-pipe 2.1-00: pipeline enabled.
>         Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
>         Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
>         Memory: 61120k/65536k available (3344k kernel code, 4356k
>         reserved, 152k
>         data, 238k bss, 148k init)
>         SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1,
>         Nodes=1
>         Mount-cache hash table entries: 512
>         device-tree: Duplicate name in /, renamed to "chosen#1"
>         net_namespace: 64 bytes
>         NET: Registered protocol family 16
>                      
>         PCI: Probing PCI hardware
>         SCSI subsystem initialized
>         usbcore: registered new interface driver usbfs
>         usbcore: registered new interface driver hub
>         usbcore: registered new device driver usb
>         Time: timebase clocksource has been installed.
>         NET: Registered protocol family 2
>         IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>         TCP established hash table entries: 2048 (order: 2, 16384 bytes)
>         TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
>         TCP: Hash tables configured (established 2048 bind 2048)
>         TCP reno registered
>         I-pipe: Domain Xenomai registered.
>         Xenomai: hal/powerpc started.
>         Xenomai: real-time nucleus v2.4.2 (One Big Rush) loaded.
>         Xenomai: starting native API services.
>         Xenomai: starting POSIX services.
>         Xenomai: starting RTDM services.
>         io scheduler noop registered
>         io scheduler anticipatory registered (default)
>         io scheduler deadline registered
>         io scheduler cfq registered
>         Generic RTC Driver v1.07
>         Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
>         disabled
>         serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 18) is a 16550A
>         console handover: boot [udbg0] -> real [ttyS0]
>         serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 19) is a 16550A
>         RAMDISK driver initialized: 16 RAM disks of 32768K size 1024
>         blocksize
>         loop: module loaded
>         Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
>         Copyright (c) 1999-2006 Intel Corporation.
>         UCC Ethernet Controller MII Bus: probed
>         ucc_geth: QE UCC Gigabit Ethernet Controller
>         Driver 'sd' needs updating - please use bus_type methods
>         mpc83xx_spi.1: MPC83xx SPI Controller driver at 0xc50084c0 (irq
>         = 20)
>         usbmon: debugfs is not available
>         Initializing USB Mass Storage driver...
>         usbcore: registered new interface driver usb-storage
>         USB Mass Storage support registered.
>         i2c /dev entries driver
>         WDT driver for MPC83xx initialized. mode:reset timeout=65535 (32
>         seconds)
>         mmc_spi spi1216.0: SD/MMC host mmc0, no DMA, no WP, no poweroff
>         TCP cubic registered
>         irq 33, desc: c034cf04, depth: 0, count: 0, unhandled: 0
>         irq 33, desc: c034cf04, depth: 0, count: 0, unhandled: 0
>         ->handle_irq():  c0019c0c, ->chip(): c03ae368, ->action():
>         00000000
>              IRQ_LEVEL set
>            IRQ_NOPROBE set
>          IRQ_NOREQUEST set
>         illegal vector 33 received!
>         ------------[ cut here ]------------
>         Kernel BUG at c00504b0 [verbose debug info unavailable]
>         Oops: Exception in kernel mode, sig: 5 [#1]
>         MPC832x RDB
>         Modules linked in:
>         NIP: c00504b0 LR: c00504b0 CTR: c01a0c04
>         REGS: c3935a30 TRAP: 0700   Not tainted  (2.6.24.2)
>         MSR: 00021032 <ME,IR,DR>  CR: 24222024  XER: 00000000
>         TASK = c385c7a0[761] 'mpc83xx_spi.1' THREAD: c3934000
>         GPR00: c00504b0 c3935ae0 c385c7a0 0000001f 00001267 ffffffff
>         c01a30f0
>         00004000 
>         GPR08: 00000001 c0354f70 00000003 c0350000 44222022 fffffd7f
>         03ffd000
>         00800000 
>         GPR16: ffffffff 80000000 c0370000 c0370000 c0380d20 c0380d44
>         c0380d40
>         fffffffd 
>         GPR24: 00000000 c0369b04 000004a0 00000420 c0385484 00000021
>         c02db248
>         c034cf04 
>         Call Trace:
>         [c3935ae0] [c00504b0]  (unreliable)
>         [c3935b00] [c00515e8] 
>         [c3935b10] [c00094e4] 
>         [c3935b20] [c0009820] 
>         [c3935b50] [c0009a98] 
>         [c3935b60] [c0011630] 
>         --- Exception: 501[c3935c20] [0000114a]  (unreliable)
>         [c3935c70] [c0053a74] 
>         [c3935c80] [c0028108] 
>         [c3935d00] [c0028328] 
>         [c3935d50] [c00503c8] 
>         [c3935d70] [c00515e8] 
>         [c3935d80] [c00094e4] 
>         [c3935d90] [c0009820] 
>         [c3935dc0] [c0009a98] 
>         [c3935dd0] [c0011630] 
>         --- Exception: 501[c3935e90] [fffffd7f]  (unreliable)
>         [c3935ea0] [c02a8a7c] 
>         [c3935ee0] [c01e0200] 
>         [c3935f00] [c01dfbec] 
>         [c3935f50] [c0039e0c] 
>         [c3935f90] [c003a0f8] 
>         [c3935fd0] [c003e738] 
>         [c3935ff0] [c0010b1c] 
>         Instruction dump:
>         3d20c037 57ab103a 392954d8 3c60c02e 7d6b4a14 7fa4eb78 396b0040
>         3863b2f8 
>         812b0008 39290001 912b0008 4bfd7de1 <0fe00000> 48000000 3c80c02e
>         7fc3f378 
>         ---[ end trace e55df3d7b6b0ab0d ]---
>         
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

