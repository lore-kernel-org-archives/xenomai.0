Date: Thu, 10 May 2012 15:26:27 +0200 (CEST)
From: aubin.rebillat@domain.hid
Message-ID: <1466485845.144436688.1336656387004.JavaMail.root@domain.hid>
In-Reply-To: <80969791.144436365.1336656376390.JavaMail.root@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai on the TS-7553 ARM SBC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,=20

I am trying to port Xenomai on the TS-7553 SBC from Technologic systems, ba=
sed on the ECONA CNS2132 (STAR8132) from Cavium networks (250 MHz arm922t).
A Linux kernel is available for this board, version 2.6.24.4, which is runn=
ing fine.
I patched this kernel with adeos-ipipe-2.6.24-arm-1.9-01.patch and I implem=
ented all the IPIPE code for the CNS2132 and everything is compiling and bo=
oting fine.

Therefore, I applied the procedure to add the Xenomai nucleus (version 2.5.=
6) to my IPIPE patched kernel:

> prepare_kernel.sh --arch=3Darm --linux=3D../linux-2.6.24.4 make=20
> O=3D../build_root ts7500_defconfig make O=3D../build_root bzImage modules

And everything is compiling fine (Just an error due to the non-existence of=
 the phy_addr_t type in 2.6.24 kernel which is easy to fix).

Also, This board does not support standard bootloaders (GRUB, U-BOOT, =E2=
=80=A6), it uses a specific one (TS-BOOTROM) developed by the board manufac=
turer.
The bootloader is quite simple, it initialises some hardware and loads the =
kernel and initrd into ram before jumping on the kernel code.
Then after the kernel boot, an initialisation script in the initrd mounts a=
 debian partition, executes pivot_root on it and launches the debian init p=
rogram.
Due to this boot process to have a debian environment, I preferred to have =
a fine running kernel with Xenomai before adding any user space support.

My problem is that during the initialisation script in the initrd the kerne=
l hangs and only if Xenomai is enabled in the kernel configuration. Without=
 Xenomai, the kernel is booting to debian correctly.

Could it be because of the lack of user space support ?=20
It does not seem likely because if Xenomai crashes a log should be printed.=
 Am I wrong ?

Could it be because of the initrd ? Do I need a xenomai specific initrd ?=
=20
I did not see anything about initrd and xenomai anywhere so I assume that t=
he answers are ''no''. Am I wrong ?

In my tests, I disabled the pivot_root call in the init script but it does =
not change anything.

Nevertheless, here is the boot log :

[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 16256
[    0.000000] Kernel command line: root=3D/dev/ram0 init=3D/linuxrc consol=
e=3Dnull lpj=3D958464
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000000] I-pipe 1.9-01: pipeline enabled.
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes=
)
[    0.010000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.020000] Memory:MB64MB total
[    0.020000] Memory: 58252KB available (2100K code, 329K data, 88K init)
[    0.030000] Calibrating delay loop (skipped)... 191.69 BogoMIPS preset
[    0.030000] Mount-cache hash table entries: 512
[    0.040000] CPU: Testing write buffer coherency: [    0.050000] net_name=
space: 64 bytes
[    0.050000] NET: Registered protocol family 16
[    0.060000] PCI clock at 33M
[    0.060000] PCI: bus0: Fast back to back transfers disabled
[    0.060000] PCI Bridge found
[    0.070000] PCI: enabling device 0000:00:00.0 (0140 -> 0142)
[    0.070000] PCI map irq: 00:00.00 slot 0, pin 1, irq: 0
[    0.150000] NET: Registered protocol family 2
[    0.250000] IP route cache hash table entries: 1024 (order: 0, 4096 byte=
s)
[    0.250000] IPv4 FIB: Using LC-trie version 0.408
[    0.250000] TCP established hash table entries: 2048 (order: 2, 16384 by=
tes)
[    0.260000] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.270000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.270000] TCP reno registered
[    0.310000] checking if image is initramfs...isn't (bad gzip magic numbe=
rs); looks like an d
[    0.480000] Freeing initrd memory: 4096K
[    0.480000] NetWinder Floating Point Emulator V0.97 (extended precision)
[    0.490000] I-pipe: Domain Xenomai registered.
[    0.490000] Xenomai: hal/arm started.
[    0.500000] Xenomai: scheduling class idle registered.
[    0.500000] Xenomai: scheduling class rt registered.
[    0.540000] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[    0.550000] Xenomai: starting native API services.
[    0.550000] Xenomai: starting POSIX services.
[    0.560000] Xenomai: starting RTDM services.
[    0.560000] io scheduler noop registered
[    0.560000] io scheduler deadline registered (default)
[    0.560000] Serial: 8250/16550 driver $Revision: 1.1.1.1 $ 2 ports, IRQ =
sharing disabled
[    0.560000] serial8250: ttyS0 at MMIO 0x78000000 (irq =3D 9) is a 16550A
[    0.560000] serial8250: ttyS1 at MMIO 0x78800000 (irq =3D 10) is a 16550=
A
[    0.560000] RAMDISK driver initialized: 4 RAM disks of 16384K size 1024 =
blocksize
[    0.560000] nbd: registered device at major 43
[    0.560000] Star NIC Driver(for Linux Kernel 2.6) - Star Semiconductor
[    0.560000]     rxring.vir_addr=3D0xFFC00000 rxring.phy_addr=3D0x0355200=
0
[    0.560000]     txring.vir_addr=3D0xFFC01000 txring.phy_addr=3D0x0355300=
0
[    0.560000] Star Internal PHY
[    0.560000] MAC Addr: 00:d0:69:45:40:14
[    0.560000]=20
[    0.560000] star_nic_init_module: internal phy patch included.
[    0.560000] star_nic_init_module: scatter/gather enabled.
[    0.560000]=20
[    0.560000] i2c /dev entries driver
[    0.560000] str8100_i2c_dev_init: i2c module version 1.0.0
[    0.560000] str8100_i2c_init: current_clock=3D400000l, CLKDIV=3D77
[    0.560000] TCP cubic registered
[    0.560000] NET: Registered protocol family 1
[    0.560000] NET: Registered protocol family 17
[    0.560000] RPC: Registered udp transport module.
[    0.560000] RPC: Registered tcp transport module.
[    0.560000] RAMDISK: ext2 filesystem found at block 0
[    0.560000] RAMDISK: Loading 2048KiB [1 disk] into ram disk... e.
[    0.560000] EXT2-fs warning: mounting unchecked fs, running e2fsck is re=
commended
[    0.560000] VFS: Mounted root (ext2 filesystem).
[    0.560000] Freeing init memory: 88K
[    0.560000] Warning: unable to open an initial console.

As you can see no problem is reported at all.

Does anyone have an idea about what may go wrong ?

Thank you very much,

Best regards,

--=20
Aubin REBILLAT

