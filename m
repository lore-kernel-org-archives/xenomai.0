Date: Thu, 3 Nov 2011 11:13:53 -0400
Message-ID: <20111103151353.GB30117@domain.hid>
References: <20111102201210.GY30117@domain.hid>
	<4EB1B691.9020801@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <4EB1B691.9020801@domain.hid>
From: lsorense@domain.hid (Lennart Sorensen)
Subject: Re: [Adeos-main] irq related kernel crash with adeos 3.0.4 powerpc.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 02, 2011 at 10:30:57PM +0100, Philippe Gerum wrote:
> Does this help? If not, then your .config would be welcome.
> 
> diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> index 707d297..c1e0b7e 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> @@ -257,6 +257,9 @@ static struct irq_chip qe_ic_irq_chip = {
>  	.irq_unmask = qe_ic_unmask_irq,
>  	.irq_mask = qe_ic_mask_irq,
>  	.irq_mask_ack = qe_ic_mask_irq,
> +#ifdef CONFIG_IPIPE
> +	.irq_eoi = qe_ic_mask_irq,
> +#endif
>  };
>  
>  static int qe_ic_host_match(struct irq_host *h, struct device_node *node)

No, that unfortunately didn't help.

So here is the capture of the entire boot, and the .config file I am using.

-- 
Len Sorensen

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ipipe.crash.log"
Content-Transfer-Encoding: quoted-printable



2009.11RR17 (Aug 17 2010 - 16:29:38) MPC83XX

Reset Status:

CPU:   e300c1, MPC8360EA, Rev: 2.1 at 533.333 MHz, CSB: 266.667 MHz
I2C:   Reset
BOARD: 12-02-0029-003 [00090000]
UPMA:  Configured for Compact Flash PIO Mode=20
I2C:   ready
SPI:   ready
DRAM:  512 MB
MTEST: Testing data bus
MTEST: Testing address bus
MTEST: PASS
BCSR:  0xE0012 (0 try 0 ms)
USB:   GPIO-V02 Initialized
FLASH: 32 MB
Using default environment settings

In:    serial
Out:   serial
Err:   serial
MAC:   ethaddr	00:0A:DC:FB:FE:FD
MAC:   eth1addr	00:0A:DC:FB:FE:FF
MAC:   eth2addr	00:0A:DC:FB:FE:FE
MAC:   eth3addr	00:00:00:00:00:00
MAC:   eth4addr	00:00:00:00:00:00
MAC:   eth5addr	00:00:00:00:00:00
DTT:   1 is 29 C
DTT:   2 is 28 C
DTT:   3 FAILED INIT
Net:   FSL UEC0 [PRIME]
IDE:   Bus 0: OK=20
  Device 0: Model: SMART CF Firm: 20071016 Ser#: 20090324026D4A694A69
            Type: Hard Disk
            Capacity: 3823.8 MB =3D 3.7 GB (7831152 x 512)
Net:   mgmt PHY:0x0F disabled OK
Hit any key to stop autoboot:  0=20
Loading file "uboot-8360e-target1.ver" from ide device 0:4 (gpt4)
** File not found uboot-8360e-target1.ver
Normal boot; no version file found

**** Boot Partition 4 ****
[4-0]: Debian GNU/Linux, kernel 3.0.0-2-8360e
[4-1]: Debian GNU/Linux, kernel 3.0.0-2-8360e (BIST mode)
[4-2]: Debian GNU/Linux, kernel 3.0.0-2-8360e (single-user mode)
[4-3]: Debian GNU/Linux, kernel 3.0.0-2-8360e (service mode)
[4-4]: Debian GNU/Linux, kernel 3.0.0-2-8360e (shell only)
[4-5]: Debian GNU/Linux, kernel 2.6.38-2-8360e
[4-6]: Debian GNU/Linux, kernel 2.6.38-2-8360e (BIST mode)
[4-7]: Debian GNU/Linux, kernel 2.6.38-2-8360e (single-user mode)
[4-8]: Debian GNU/Linux, kernel 2.6.38-2-8360e (service mode)
[4-9]: Debian GNU/Linux, kernel 2.6.38-2-8360e (shell only)

**** Boot Partition 6 ****
[6-0]: Debian GNU/Linux, kernel 2.6.38-2-8360e
[6-1]: Debian GNU/Linux, kernel 2.6.38-2-8360e (BIST mode)
[6-2]: Debian GNU/Linux, kernel 2.6.38-2-8360e (single-user mode)
[6-3]: Debian GNU/Linux, kernel 2.6.38-2-8360e (service mode)

Auto booting [4-3], Hit [ESC] key to stop:  1 =08=08=08 0=20
Auto booting [4-3]
uImage-3.0.0-2-8360e loaded to 0x1008000 [0x1D4BB5]
/fdt/fdt-12-02-0029-003.dtb loaded to 0x1000000 [0x356D]
BCSR:  Ver E0012 up to date
bcsr_update: OK
## Booting kernel from Legacy Image at 01008000 ...
   Image Name:   Linux-3.0.0-2-8360e
   Created:      2011-11-03  15:03:50 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1919861 Bytes =3D  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 01000000
   Booting using the fdt blob at 0x1000000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 00ff9000, end 00fff56c ... OK
Using RC8360 CM machine description
Linux version 3.0.0-2-8360e (unknown) (root@domain.hid) (gcc version 4.3.5 (De=
bian 4.3.5-4) ) #1 Thu Nov 3 11:03:38 EDT 2011
bootconsole [udbg0] enabled
setup_arch: bootmem
rc8360cm_setup_arch()
no dts entry for hotswap buffer gpio
pio-handle not available
error configuring hotswap gpio pin
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00020000
  Normal   empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00020000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=3D/dev/sda5 ro 3 bootver=3D2009.11RR17
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515552k/524288k available (3792k kernel code, 8736k reserved, 176k =
data, 168k bss, 144k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfdef1000..0xfe000000  : early ioremap
  * 0xe1000000..0xfdef1000  : vmalloc & ioremap
SLUB: Genslabs=3D15, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
NR_IRQS:512
IPIC (128 IRQ sources) at e1000700
CMIC: bcsr address: 0xe1004000
BCSR UCPCM interrupt controller loaded.
clocksource: timebase mult[3c00001] shift[22] registered
I-pipe 2.13-03: pipeline enabled.
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
            =20
bio: create slab <bio-0> at 0
Freescale Elo / Elo Plus DMA driver
SCSI subsystem initialized
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
fsl-elo-dma e00082a8.dma: #0 (fsl,elo-dma-channel), irq 71
fsl-elo-dma e00082a8.dma: #1 (fsl,elo-dma-channel), irq 71
fsl-elo-dma e00082a8.dma: #2 (fsl,elo-dma-channel), irq 71
fsl-elo-dma e00082a8.dma: #3 (fsl,elo-dma-channel), irq 71
Can't map reserved IRQ
audit: initializing netlink socket (disabled)
type=3D2000 audit(0.194:1): initialized
I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: scheduling class pss registered.
Xenomai: scheduling class tp registered.
Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
msgmni has been set to 1006
NET: Registered protocol family 38
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 16) is a 16550A
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
scsi0 : pata_platform
ata1: PATA max PIO6 mmio cmd 0xf8008000 ctl 0xf800820c irq 43
fe000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID =
0x000089 Chip ID 0x00227e
Amd/Fujitsu Extended Query Table at 0x0040
  Amd/Fujitsu Extended Query version 1.3.
number of CFI chips: 1
Creating 3 MTD partitions on "fe000000.flash":
0x000000000000-0x000000040000 : "u-boot"
0x000000040000-0x000000060000 : "u-boot-env"
0x000000060000-0x000002000000 : "free"
Fixed MDIO Bus: probed
GPIO Bitbanged MDIO: probed
Error: Driver 'mdio-gpio' is already registered, aborting...
Freescale PowerQUICC MII Bus: probed
Freescale PowerQUICC MII Bus: probed
i2c /dev entries driver
mpc-i2c e0003000.i2c: timeout 1000000 us
rtc-m41t80 0-0068: chip found, driver version 0.05
rtc-m41t80 0-0068: rtc core: registered m41t82 as rtc0
ata1.00: CFA: SMART CF, 20071016, max UDMA/100
ata1.00: 7831152 sectors, multi 0: LBA=20
ata1.00: configured for PIO
scsi 0:0:0:0: Direct-Access     ATA      SMART CF         2007 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 7831152 512-byte logical blocks: (4.00 GB/3.73 GiB)
rtc-m41t80 0-0068: Power Down at 2011-11-03 15:10:13
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
mpc-i2c e0003100.i2c: timeout 1000000 us
i2c-pca954x 1-0072: pca9545-2: rst gpio =3D 84 flag =3D 1
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
i2c-pca954x 1-0073: pca9545-6: shared rst gpio =3D 84 flag =3D 1
Creating sysfs files for RX1500
rcnetlink: Linux RC_GNLINK v 1 registered
sd 0:0:0:0: [sda] Attached SCSI disk
rcksapi: Driver successfully loaded.
rcksapi: Common subsystem successfully registered.
TCP cubic registered
NET: Registered protocol family 10
rtc-m41t80 0-0068: setting system clock to 2011-11-03 15:11:00 UTC (1320333=
060)
EXT3-fs (sda5): recovery required on readonly filesystem
EXT3-fs (sda5): write access will be enabled during recovery
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda5): recovery complete
EXT3-fs (sda5): mounted filesystem with ordered data mode
VFS: Mounted root (ext3 filesystem) readonly on device 8:5.
Freeing unused kernel memory: 144k init
INIT: version 2.86 booting
Starting the hotplug events dispatcher: udevdudevd (1011): /proc/1011/oom_a=
dj is deprecated, please use /proc/1011/oom_score_adj instead.
=2E
Synthesizing the initial hotplug events...talitos e0030000.crypto: hwrng
talitos e0030000.crypto: authenc-hmac-sha1-cbc-aes-talitos
lm75 0-0048: hwmon0: sensor 'lm75'
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
lm75 0-0049: hwmon1: sensor 'lm75'
talitos e0030000.crypto: authenc-hmac-sha1-cbc-3des-talitos
usbcore: registered new device driver usb
Disabling lock debugging due to kernel taint
of_isp1763_probe: fsl-lbc-reg cs 3 br F8011001 or FFFF0714
nxp-isp1763 f8010000.usb: ST-Erricson ISP1763 USB Host Controller
nxp-isp1763 f8010000.usb: new USB bus registered, assigned bus number 1
isp1763_hc_setup: devflags 0x80 hwmode 0x4
nxp-isp1763 f8010000.usb: bus width: 16
nxp-isp1763 f8010000.usb: irq 82, io mem 0xf8010000
nxp-isp1763 f8010000.usb: USB ISP 1763 HW rev. 32 started
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
isp1763: generic netlink ver 1 registered
talitos e0030000.crypto: authenc-hmac-sha256-cbc-aes-talitos
talitos e0030000.crypto: authenc-hmac-sha256-cbc-3des-talitos
talitos e0030000.crypto: authenc-hmac-md5-cbc-aes-talitos
talitos e0030000.crypto: authenc-hmac-md5-cbc-3des-talitos
talitos e0030000.crypto: cbc-aes-talitos
talitos e0030000.crypto: cbc-3des-talitos
talitos e0030000.crypto: md5-talitos
talitos e0030000.crypto: sha1-talitos
talitos e0030000.crypto: sha224-talitos
talitos e0030000.crypto: sha256-talitos
usb 1-1: new high speed USB device number 2 using nxp-isp1763
done.
Waiting for /dev to be fully populated...ucc_geth: QE UCC Gigabit Ethernet =
Controller
hub 1-1:1.0: USB hub found
fsl_spi e01004c0.spi: at 0xe313e4c0 (irq =3D 25), QE CPU mode
spi_master spi32766: has a mux on chipselect 1
hub 1-1:1.0: 2 ports detected
fsl_spi e0100500.spi: at 0xe3142500 (irq =3D 26), QE CPU mode
ucc_geth e0103200.ucc: waiting for firmware QE_ENET_mpc8360_r2.1.bin
qe-firmware: firmware 'Microcode version 0.0.0 for MPC8360 r2.1' for 8360 V=
2.1
qe-firmware: uploading microcode 'Microcode for MPC8360 r2.1'
ucc_geth: UCC4 at 0xe0103200 (irq =3D 35)
ucc_geth: UCC1 has 8 rx-queues
ucc_geth: UCC1 at 0xe0102000 (irq =3D 27)
ucc_geth: UCC2 at 0xe0103000 (irq =3D 28)
Unable to handle kernel paging request for instruction fetch
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
RC8360 CM
Modules linked in: m25p80(+) ucc_geth_driver spi_fsl_spi firmware_class spi=
_fsl_lib rx1k5_spimux ltc4215 isp1763(O) usbcore lm75 talitos
NIP: 00000000 LR: c001e980 CTR: 00000000
REGS: dfa0dae0 TRAP: 0400   Tainted: G           O  (3.0.0-2-8360e)
MSR: 20001032 <ME,IR,DR>  CR: 44002424  XER: 00000000
TASK =3D df99bb90[1011] 'udevd' THREAD: dfa0c000
GPR00: c001e968 dfa0db90 df99bb90 c03bcc48 00000002 c03c90a4 c03c90a0 c03c9=
0a4=20
GPR08: 00000002 00000000 00000002 df804000 00000000 1002a39c 00044b83 3b9ac=
a00=20
GPR16: dfa0dd10 10624dd3 c033ec98 00000000 c03ba000 00008000 dfa0dd18 c03ba=
000=20
GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 00000019 c03bc=
c48=20
NIP [00000000]   (null)
LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
Call Trace:
[dfa0db90] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0dbb0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0dbc0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0dbf0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0dc00] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0dcc0] [c00268e0] console_unlock+0x1a8/0x210 (unreliable)
[dfa0dcf0] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0dd00] [c0026e88] vprintk+0x198/0x394
[dfa0ddb0] [c02eebb0] printk+0x134/0x1b0
[dfa0de00] [c00153f8] bad_page_fault+0xd4/0xfc
[dfa0de10] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ded0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0def0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0df00] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0df30] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0df40] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at 0xfeb54d0
    LR =3D 0xfeb5490
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 4c54d6f28a4a0340 ]---
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#2]
RC8360 CM
Modules linked in: m25p80(+) ucc_geth_driver spi_fsl_spi firmware_class spi=
_fsl_lib rx1k5_spimux ltc4215 isp1763(O) usbcore lm75 talitos
NIP: 00000000 LR: c001e980 CTR: 00000000
REGS: dfa0d810 TRAP: 0400   Tainted: G      D    O  (3.0.0-2-8360e)
MSR: 20001032 <ME,IR,DR>  CR: 44002424  XER: 00000000
TASK =3D df99bb90[1011] 'udevd' THREAD: dfa0c000
GPR00: c001e968 dfa0d8c0 df99bb90 c03bcc48 00000002 c03c90a4 c03c90a0 c03c9=
0a4=20
GPR08: 00000002 00000000 00000002 df804000 00000000 1002a39c 00044b83 3b9ac=
a00=20
GPR16: dfa0dd10 10624dd3 c033ec98 00000000 c03ba000 00008000 dfa0dd18 c03ba=
000=20
GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 00000019 c03bc=
c48=20
NIP [00000000]   (null)
LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
Call Trace:
[dfa0d8c0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d8e0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d8f0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d920] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d930] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0d9f0] [10624dd3] 0x10624dd3 (unreliable)
[dfa0da20] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0da30] [c005e4a4] acct_collect+0x13c/0x178
[dfa0da50] [c002a050] do_exit+0x580/0x6a4
[dfa0daa0] [c000beb0] die+0x21c/0x228
[dfa0dac0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0dad0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0db90] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0dbb0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0dbc0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0dbf0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0dc00] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0dcc0] [c00268e0] console_unlock+0x1a8/0x210 (unreliable)
[dfa0dcf0] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0dd00] [c0026e88] vprintk+0x198/0x394
[dfa0ddb0] [c02eebb0] printk+0x134/0x1b0
[dfa0de00] [c00153f8] bad_page_fault+0xd4/0xfc
[dfa0de10] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ded0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0def0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0df00] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0df30] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0df40] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at 0xfeb54d0
    LR =3D 0xfeb5490
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 4c54d6f28a4a0341 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#3]
RC8360 CM
Modules linked in: m25p80(+) ucc_geth_driver spi_fsl_spi firmware_class spi=
_fsl_lib rx1k5_spimux ltc4215 isp1763(O) usbcore lm75 talitos
NIP: 00000000 LR: c001e980 CTR: 00000000
REGS: dfa0d4a0 TRAP: 0400   Tainted: G      D    O  (3.0.0-2-8360e)
MSR: 20001032 <ME,IR,DR>  CR: 44002484  XER: 00000000
TASK =3D df99bb90[1011] 'udevd' THREAD: dfa0c000
GPR00: c001e968 dfa0d550 df99bb90 c03bcc48 00000002 00000001 c03c90a0 c03c9=
0a4=20
GPR08: 00000002 00000000 00000002 df804000 00000000 1002a39c c03b75d8 c03f0=
900=20
GPR16: c03f4e18 00000004 c02f346c 00000001 00000000 c002a098 dfa0c000 dfa0c=
03c=20
GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 00000019 c03bc=
c48=20
NIP [00000000]   (null)
LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
Call Trace:
[dfa0d550] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d570] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d580] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d5b0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d5c0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d780] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d7d0] [c000beb0] die+0x21c/0x228
[dfa0d7f0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d800] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d8c0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d8e0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d8f0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d920] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d930] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0d9f0] [10624dd3] 0x10624dd3 (unreliable)
[dfa0da20] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0da30] [c005e4a4] acct_collect+0x13c/0x178
[dfa0da50] [c002a050] do_exit+0x580/0x6a4
[dfa0daa0] [c000beb0] die+0x21c/0x228
[dfa0dac0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0dad0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0db90] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0dbb0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0dbc0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0dbf0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0dc00] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0dcc0] [c00268e0] console_unlock+0x1a8/0x210 (unreliable)
[dfa0dcf0] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0dd00] [c0026e88] vprintk+0x198/0x394
[dfa0ddb0] [c02eebb0] printk+0x134/0x1b0
[dfa0de00] [c00153f8] bad_page_fault+0xd4/0xfc
[dfa0de10] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ded0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0def0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0df00] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0df30] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0df40] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at 0xfeb54d0
    LR =3D 0xfeb5490
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 4c54d6f28a4a0342 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#4]
RC8360 CM
Modules linked in: m25p80(+) ucc_geth_driver spi_fsl_spi firmware_class spi=
_fsl_lib rx1k5_spimux ltc4215 isp1763(O) usbcore lm75 talitos
NIP: 00000000 LR: c001e980 CTR: 00000000
REGS: dfa0d130 TRAP: 0400   Tainted: G      D    O  (3.0.0-2-8360e)
MSR: 20001032 <ME,IR,DR>  CR: 44002484  XER: 00000000
TASK =3D df99bb90[1011] 'udevd' THREAD: dfa0c000
GPR00: c001e968 dfa0d1e0 df99bb90 c03bcc48 00000002 00000000 c03c90a0 c03c9=
0a4=20
GPR08: 00000002 00000000 00000002 df804000 00000000 1002a39c c03b75d8 c03f0=
900=20
GPR16: c03f4e18 00000004 c02f346c 00000001 00000000 c002a098 dfa0c000 dfa0c=
03c=20
GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 00000019 c03bc=
c48=20
NIP [00000000]   (null)
LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
Call Trace:
[dfa0d1e0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d200] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d210] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d240] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d250] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d410] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d460] [c000beb0] die+0x21c/0x228
[dfa0d480] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d490] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d550] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d570] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d580] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d5b0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d5c0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d780] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d7d0] [c000beb0] die+0x21c/0x228
[dfa0d7f0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d800] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d8c0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d8e0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d8f0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d920] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d930] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0d9f0] [10624dd3] 0x10624dd3 (unreliable)
[dfa0da20] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0da30] [c005e4a4] acct_collect+0x13c/0x178
[dfa0da50] [c002a050] do_exit+0x580/0x6a4
[dfa0daa0] [c000beb0] die+0x21c/0x228
[dfa0dac0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0dad0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0db90] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0dbb0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0dbc0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0dbf0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0dc00] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0dcc0] [c00268e0] console_unlock+0x1a8/0x210 (unreliable)
[dfa0dcf0] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0dd00] [c0026e88] vprintk+0x198/0x394
[dfa0ddb0] [c02eebb0] printk+0x134/0x1b0
[dfa0de00] [c00153f8] bad_page_fault+0xd4/0xfc
[dfa0de10] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ded0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0def0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0df00] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0df30] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0df40] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at 0xfeb54d0
    LR =3D 0xfeb5490
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 4c54d6f28a4a0343 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#5]
RC8360 CM
Modules linked in: m25p80(+) ucc_geth_driver spi_fsl_spi firmware_class spi=
_fsl_lib rx1k5_spimux ltc4215 isp1763(O) usbcore lm75 talitos
NIP: 00000000 LR: c001e980 CTR: 00000000
REGS: dfa0cdc0 TRAP: 0400   Tainted: G      D    O  (3.0.0-2-8360e)
MSR: 20001032 <ME,IR,DR>  CR: 44002484  XER: 00000000
TASK =3D df99bb90[1011] 'udevd' THREAD: dfa0c000
GPR00: c001e968 dfa0ce70 df99bb90 c03bcc48 00000002 00000000 c03c90a0 c03c9=
0a4=20
GPR08: 00000002 00000000 00000002 df804000 00000000 1002a39c c03b75d8 c03f0=
900=20
GPR16: c03f4e18 00000004 c02f346c 00000001 00000000 c002a098 dfa0c000 dfa0c=
03c=20
GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 00000019 c03bc=
c48=20
NIP [00000000]   (null)
LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
Call Trace:
[dfa0ce70] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0ce90] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cea0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0ced0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cee0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d0a0] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d0f0] [c000beb0] die+0x21c/0x228
[dfa0d110] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d120] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d1e0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d200] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d210] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d240] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d250] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d410] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d460] [c000beb0] die+0x21c/0x228
[dfa0d480] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d490] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d550] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d570] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d580] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d5b0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d5c0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d780] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d7d0] [c000beb0] die+0x21c/0x228
[dfa0d7f0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d800] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d8c0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d8e0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d8f0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d920] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d930] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0d9f0] [10624dd3] 0x10624dd3 (unreliable)
[dfa0da20] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0da30] [c005e4a4] acct_collect+0x13c/0x178
[dfa0da50] [c002a050] do_exit+0x580/0x6a4
[dfa0daa0] [c000beb0] die+0x21c/0x228
[dfa0dac0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0dad0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0db90] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0dbb0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0dbc0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0dbf0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0dc00] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0dcc0] [c00268e0] console_unlock+0x1a8/0x210 (unreliable)
[dfa0dcf0] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0dd00] [c0026e88] vprintk+0x198/0x394
[dfa0ddb0] [c02eebb0] printk+0x134/0x1b0
[dfa0de00] [c00153f8] bad_page_fault+0xd4/0xfc
[dfa0de10] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ded0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0def0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0df00] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0df30] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0df40] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at 0xfeb54d0
    LR =3D 0xfeb5490
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 4c54d6f28a4a0344 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#6]
RC8360 CM
Modules linked in: m25p80(+) ucc_geth_driver spi_fsl_spi firmware_class spi=
_fsl_lib rx1k5_spimux ltc4215 isp1763(O) usbcore lm75 talitos
NIP: 00000000 LR: c001e980 CTR: 00000000
REGS: dfa0ca50 TRAP: 0400   Tainted: G      D    O  (3.0.0-2-8360e)
MSR: 20001032 <ME,IR,DR>  CR: 44002484  XER: 00000000
TASK =3D df99bb90[1011] 'udevd' THREAD: dfa0c000
GPR00: c001e968 dfa0cb00 df99bb90 c03bcc48 00000002 00000000 c03c90a0 c03c9=
0a4=20
GPR08: 00000002 00000000 00000002 df804000 00000000 1002a39c c03b75d8 c03f0=
900=20
GPR16: c03f4e18 00000004 c02f346c 00000001 00000000 c002a098 dfa0c000 dfa0c=
03c=20
GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 00000019 c03bc=
c48=20
NIP [00000000]   (null)
LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
Call Trace:
[dfa0cb00] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0cb20] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cb30] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0cb60] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cb70] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0cd30] [c002a098] do_exit+0x5c8/0x6a4
[dfa0cd80] [c000beb0] die+0x21c/0x228
[dfa0cda0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0cdb0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ce70] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0ce90] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cea0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0ced0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cee0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d0a0] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d0f0] [c000beb0] die+0x21c/0x228
[dfa0d110] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d120] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d1e0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d200] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d210] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d240] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d250] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d410] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d460] [c000beb0] die+0x21c/0x228
[dfa0d480] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d490] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d550] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d570] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d580] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d5b0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d5c0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d780] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d7d0] [c000beb0] die+0x21c/0x228
[dfa0d7f0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d800] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d8c0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d8e0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d8f0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d920] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d930] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0d9f0] [10624dd3] 0x10624dd3 (unreliable)
[dfa0da20] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0da30] [c005e4a4] acct_collect+0x13c/0x178
[dfa0da50] [c002a050] do_exit+0x580/0x6a4
[dfa0daa0] [c000beb0] die+0x21c/0x228
[dfa0dac0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0dad0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0db90] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0dbb0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0dbc0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0dbf0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0dc00] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0dcc0] [c00268e0] console_unlock+0x1a8/0x210 (unreliable)
[dfa0dcf0] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0dd00] [c0026e88] vprintk+0x198/0x394
[dfa0ddb0] [c02eebb0] printk+0x134/0x1b0
[dfa0de00] [c00153f8] bad_page_fault+0xd4/0xfc
[dfa0de10] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ded0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0def0] [c000eadc] __ipipe_ack_irq+0x18/0x28
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 4c54d6f28a4a0345 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#7]
RC8360 CM
Modules linked in: m25p80(+) ucc_geth_driver spi_fsl_spi firmware_class spi=
_fsl_lib rx1k5_spimux ltc4215 isp1763(O) usbcore lm75 talitos
NIP: 00000000 LR: c001e980 CTR: 00000000
REGS: dfa0c6e0 TRAP: 0400   Tainted: G      D    O  (3.0.0-2-8360e)
MSR: 20001032 <ME,IR,DR>  CR: 44002484  XER: 00000000
TASK =3D df99bb90[1011] 'udevd' THREAD: dfa0c000
GPR00: c001e968 dfa0c790 df99bb90 c03bcc48 00000002 00000000 c03c90a0 c03c9=
0a4=20
GPR08: 00000002 00000000 00000002 df804000 00000000 1002a39c c03b75d8 c03f0=
900=20
GPR16: c03f4e18 00000004 c02f346c 00000001 00000000 c002a098 dfa0c000 dfa0c=
03c=20
GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 00000019 c03bc=
c48=20
NIP [00000000]   (null)
LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
Call Trace:
[dfa0c790] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0c7b0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0c7c0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0c7f0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0c800] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0c9c0] [c002a098] do_exit+0x5c8/0x6a4
[dfa0ca10] [c000beb0] die+0x21c/0x228
[dfa0ca30] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0ca40] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0cb00] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0cb20] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cb30] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0cb60] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cb70] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0cd30] [c002a098] do_exit+0x5c8/0x6a4
[dfa0cd80] [c000beb0] die+0x21c/0x228
[dfa0cda0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0cdb0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ce70] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0ce90] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cea0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0ced0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cee0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d0a0] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d0f0] [c000beb0] die+0x21c/0x228
[dfa0d110] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d120] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d1e0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d200] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d210] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d240] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d250] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d410] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d460] [c000beb0] die+0x21c/0x228
[dfa0d480] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d490] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d550] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d570] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d580] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d5b0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d5c0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d780] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d7d0] [c000beb0] die+0x21c/0x228
[dfa0d7f0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d800] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d8c0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d8e0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d8f0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d920] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d930] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
[dfa0d9f0] [10624dd3] 0x10624dd3 (unreliable)
[dfa0da20] [c0070230] __ipipe_unstall_root+0x58/0x5c
[dfa0da30] [c005e4a4] acct_collect+0x13c/0x178
[dfa0da50] [c002a050] do_exit+0x580/0x6a4
[dfa0daa0] [c000beb0] die+0x21c/0x228
[dfa0dac0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0dad0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0db90] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0dbb0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0dbc0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
---[ end trace 4c54d6f28a4a0346 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#8]
RC8360 CM
Modules linked in: m25p80(+) ucc_geth_driver spi_fsl_spi firmware_class spi=
_fsl_lib rx1k5_spimux ltc4215 isp1763(O) usbcore lm75 talitos
NIP: 00000000 LR: c001e980 CTR: 00000000
REGS: dfa0c370 TRAP: 0400   Tainted: G      D    O  (3.0.0-2-8360e)
MSR: 20001032 <ME,IR,DR>  CR: 44002484  XER: 00000000
TASK =3D df99bb90[1011] 'udevd' THREAD: dfa0c000
GPR00: c001e968 dfa0c420 df99bb90 c03bcc48 00000002 00000000 c03c90a0 c03c9=
0a4=20
GPR08: 00000002 00000000 00000002 df804000 00000000 1002a39c c03b75d8 c03f0=
900=20
GPR16: c03f4e18 00000004 c02f346c 00000001 00000000 c002a098 dfa0c000 dfa0c=
03c=20
GPR24: c000eac4 000004a0 c03d8344 c03f0900 c03f5084 df805100 00000019 c03bc=
c48=20
NIP [00000000]   (null)
LR [c001e980] qe_ic_cascade_low_ipic+0x38/0x74
Call Trace:
[dfa0c420] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0c440] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0c450] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0c480] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0c490] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0c650] [c002a098] do_exit+0x5c8/0x6a4
[dfa0c6a0] [c000beb0] die+0x21c/0x228
[dfa0c6c0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0c6d0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0c790] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0c7b0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0c7c0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0c7f0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0c800] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0c9c0] [c002a098] do_exit+0x5c8/0x6a4
[dfa0ca10] [c000beb0] die+0x21c/0x228
[dfa0ca30] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0ca40] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0cb00] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0cb20] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cb30] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0cb60] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cb70] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0cd30] [c002a098] do_exit+0x5c8/0x6a4
[dfa0cd80] [c000beb0] die+0x21c/0x228
[dfa0cda0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0cdb0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ce70] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0ce90] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cea0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0ced0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cee0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d0a0] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d0f0] [c000beb0] die+0x21c/0x228
[dfa0d110] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d120] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d1e0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d200] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d210] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d240] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d250] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d410] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d460] [c000beb0] die+0x21c/0x228
[dfa0d480] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d490] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d550] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d570] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d580] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d5b0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d5c0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d780] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d7d0] [c000beb0] die+0x21c/0x228
[dfa0d7f0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d800] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d8c0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d8e0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d8f0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d920] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d930] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __ipipe_sync_stage+0x160/0x1f8
    LR =3D __ipipe_unstall_root+0x58/0x5c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX=20
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[dfa0c2a0] [c00084d4] show_stack+0x48/0x168 (unreliable)
[dfa0c2e0] [c02ee93c] panic+0xa4/0x1e4
[dfa0c330] [c000bebc] kernel_bad_stack+0x0/0x4c
[dfa0c350] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0c360] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0c420] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0c440] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0c450] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0c480] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0c490] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0c650] [c002a098] do_exit+0x5c8/0x6a4
[dfa0c6a0] [c000beb0] die+0x21c/0x228
[dfa0c6c0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0c6d0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0c790] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0c7b0] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0c7c0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0c7f0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0c800] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0c9c0] [c002a098] do_exit+0x5c8/0x6a4
[dfa0ca10] [c000beb0] die+0x21c/0x228
[dfa0ca30] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0ca40] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0cb00] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0cb20] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cb30] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0cb60] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cb70] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0cd30] [c002a098] do_exit+0x5c8/0x6a4
[dfa0cd80] [c000beb0] die+0x21c/0x228
[dfa0cda0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0cdb0] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0ce70] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0ce90] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0cea0] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0ced0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0cee0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d0a0] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d0f0] [c000beb0] die+0x21c/0x228
[dfa0d110] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d120] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d1e0] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d200] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d210] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d240] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d250] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d410] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d460] [c000beb0] die+0x21c/0x228
[dfa0d480] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d490] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
[dfa0d550] [c001e968] qe_ic_cascade_low_ipic+0x20/0x74 (unreliable)
[dfa0d570] [c000eadc] __ipipe_ack_irq+0x18/0x28
[dfa0d580] [c000eebc] __ipipe_handle_irq+0x130/0x15c
[dfa0d5b0] [c000eff0] __ipipe_grab_irq+0x3c/0x70
[dfa0d5c0] [c0010ef4] __ipipe_ret_from_except+0x0/0xc
--- Exception: 501 at __schedule+0x20c/0x470
    LR =3D __schedule+0x200/0x470
[dfa0d780] [c002a098] do_exit+0x5c8/0x6a4
[dfa0d7d0] [c000beb0] die+0x21c/0x228
[dfa0d7f0] [c00153d8] bad_page_fault+0xb4/0xfc
[dfa0d800] [c0010aa8] handle_page_fault+0x7c/0x80
--- Exception: 400 at   (null)
    LR =3D qe_ic_cascade_low_ipic+0x38/0x74
Rebooting in 180 seconds..
--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8360.config"

#
# Automatically generated make config: don't edit
# Linux/powerpc 3.0.0 Kernel Configuration
#
# CONFIG_PPC64 is not set

#
# Processor support
#
CONFIG_PPC_BOOK3S_32=y
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_PPC_BOOK3S=y
CONFIG_6xx=y
CONFIG_PPC_FPU=y
# CONFIG_FSL_EMB_PERFMON is not set
# CONFIG_ALTIVEC is not set
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_STD_MMU_32=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_PPC_HAVE_PMU_SUPPORT=y
CONFIG_PPC_PERF_CTRS=y
# CONFIG_SMP is not set
CONFIG_PPC32=y
CONFIG_32BIT=y
CONFIG_WORD_SIZE=32
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
CONFIG_MMU=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
CONFIG_NR_IRQS=512
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_GPIO=y
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
# CONFIG_SOFTDISABLE is not set
CONFIG_IRQSTACKS=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_OF=y
CONFIG_PPC_UDBG_16550=y
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_EPAPR_BOOT is not set
CONFIG_DEFAULT_UIMAGE=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_HAVE_IRQ_WORK=y
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_FHANDLE is not set
# CONFIG_TASKSTATS is not set
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y
CONFIG_HAVE_GENERIC_HARDIRQS=y

#
# IRQ subsystem
#
CONFIG_GENERIC_HARDIRQS=y
CONFIG_HAVE_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
# CONFIG_SPARSE_IRQ is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_PREEMPT_RCU is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_CGROUPS is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_EXPERT=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_PERF_COUNTERS is not set
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_DMA_API_DEBUG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_BLOCK=y
CONFIG_LBDAF=y
# CONFIG_BLK_DEV_BSG is not set
CONFIG_BLK_DEV_INTEGRITY=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
# CONFIG_INLINE_SPIN_TRYLOCK is not set
# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK is not set
# CONFIG_INLINE_SPIN_LOCK_BH is not set
# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
CONFIG_INLINE_SPIN_UNLOCK=y
# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_READ_TRYLOCK is not set
# CONFIG_INLINE_READ_LOCK is not set
# CONFIG_INLINE_READ_LOCK_BH is not set
# CONFIG_INLINE_READ_LOCK_IRQ is not set
# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
CONFIG_INLINE_READ_UNLOCK=y
# CONFIG_INLINE_READ_UNLOCK_BH is not set
CONFIG_INLINE_READ_UNLOCK_IRQ=y
# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
# CONFIG_INLINE_WRITE_TRYLOCK is not set
# CONFIG_INLINE_WRITE_LOCK is not set
# CONFIG_INLINE_WRITE_LOCK_BH is not set
# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
CONFIG_INLINE_WRITE_UNLOCK=y
# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
# CONFIG_MUTEX_SPIN_ON_OWNER is not set

#
# Real-time sub-system
#
CONFIG_XENOMAI=y
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_SCHED_CLASSES=y
CONFIG_XENO_OPT_SCHED_TP=y
CONFIG_XENO_OPT_SCHED_TP_NRPART=4
CONFIG_XENO_OPT_SCHED_SPORADIC=y
CONFIG_XENO_OPT_SCHED_SPORADIC_MAXREPL=8
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3072
CONFIG_XENO_OPT_SYS_HEAPSZ=12288
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=2048
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_SHIRQ is not set
CONFIG_XENO_OPT_SELECT=y

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_VIRTICK=1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0

#
# Scalability
#
CONFIG_XENO_OPT_SCALABLE_SCHED=y
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH=y
CONFIG_XENO_HW_FPU=y
CONFIG_XENO_HW_UNLOCKED_SWITCH=y

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=m
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=0
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_BUFFER=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
CONFIG_XENO_OPT_NATIVE_INTR=y
CONFIG_XENO_SKIN_POSIX=m
CONFIG_XENO_OPT_POSIX_PERIOD=0
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
# CONFIG_XENO_OPT_POSIX_SELECT is not set
CONFIG_XENO_OPT_DEBUG_POSIX=y
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=m
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_OPT_RTDM_SELECT=y

#
# Drivers
#

#
# Serial drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set

#
# Testing drivers
#
# CONFIG_XENO_DRIVERS_TESTING_LEGACY_NAMES is not set
# CONFIG_XENO_DRIVERS_TIMERBENCH is not set
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
# CONFIG_XENO_DRIVERS_SWITCHTEST is not set
# CONFIG_XENO_DRIVERS_SIGTEST is not set
# CONFIG_XENO_DRIVERS_RTDMTEST is not set

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

#
# ANALOGY drivers
#
# CONFIG_XENO_DRIVERS_ANALOGY is not set

#
# Real-time IPC drivers
#
# CONFIG_XENO_DRIVERS_RTIPC is not set
# CONFIG_FREEZER is not set
# CONFIG_PPC_XICS is not set
# CONFIG_PPC_ICP_NATIVE is not set
# CONFIG_PPC_ICP_HV is not set
# CONFIG_PPC_ICS_RTAS is not set

#
# Platform support
#
# CONFIG_PPC_CHRP is not set
# CONFIG_PPC_MPC512x is not set
# CONFIG_PPC_MPC52xx is not set
# CONFIG_PPC_PMAC is not set
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PPC_82xx is not set
# CONFIG_PQ2ADS is not set
CONFIG_PPC_83xx=y
# CONFIG_MPC830x_RDB is not set
CONFIG_RC8360_CM=y
# CONFIG_MPC831x_RDB is not set
# CONFIG_MPC832x_MDS is not set
# CONFIG_MPC832x_RDB is not set
# CONFIG_MPC834x_MDS is not set
# CONFIG_MPC834x_ITX is not set
# CONFIG_MPC836x_MDS is not set
# CONFIG_MPC836x_RDK is not set
# CONFIG_MPC837x_MDS is not set
# CONFIG_MPC837x_RDB is not set
# CONFIG_SBC834x is not set
# CONFIG_ASP834x is not set
# CONFIG_KMETER1 is not set
# CONFIG_PPC_86xx is not set
# CONFIG_EMBEDDED6xx is not set
# CONFIG_AMIGAONE is not set
# CONFIG_PPC_WSP is not set
# CONFIG_KVM_GUEST is not set
# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
CONFIG_IPIC=y
# CONFIG_MPIC is not set
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
# CONFIG_PPC_RTAS is not set
# CONFIG_MMIO_NVRAM is not set
# CONFIG_MPIC_U3_HT_IRQS is not set
# CONFIG_PPC_MPC106 is not set
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_P7_NAP is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_TAU is not set
CONFIG_QUICC_ENGINE=y
CONFIG_QE_GPIO=y
# CONFIG_FSL_ULI1575 is not set
CONFIG_SIMPLE_GPIO=y
# CONFIG_MCU_MPC8349EMITX is not set

#
# Kernel options
#
CONFIG_IPIPE=y
CONFIG_IPIPE_DOMAINS=4
CONFIG_IPIPE_DELAYED_ATOMICSW=y
# CONFIG_IPIPE_UNMASKED_CONTEXT_SWITCH is not set
CONFIG_IPIPE_HAVE_PREEMPTIBLE_SWITCH=y
# CONFIG_HIGHMEM is not set
CONFIG_TICK_ONESHOT=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_BINFMT_ELF=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_IOMMU_HELPER is not set
# CONFIG_SWIOTLB is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_HAS_WALK_MEMORY=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_MAX_ACTIVE_REGIONS=32
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
CONFIG_PPC_4K_PAGES=y
CONFIG_FORCE_MAX_ZONEORDER=11
# CONFIG_CMDLINE_BOOL is not set
CONFIG_EXTRA_TARGETS=""
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM_RUNTIME is not set
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
CONFIG_ZONE_DMA=y
# CONFIG_NEED_DMA_MAP_STATE is not set
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_FSL_SOC=y
CONFIG_FSL_LBC=y
CONFIG_PPC_PCI_CHOICE=y
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCCARD is not set
# CONFIG_HAS_RAPIDIO is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_PAGE_OFFSET=0xc0000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_PHYSICAL_START=0x00000000
CONFIG_TASK_SIZE=0xc0000000
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_LRO=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
# CONFIG_IPV6_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_CONNTRACK_MARK=y
# CONFIG_NF_CONNTRACK_ZONES is not set
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CT_PROTO_DCCP=m
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=m
CONFIG_NF_CT_PROTO_UDPLITE=m
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NETFILTER_TPROXY=m
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
# CONFIG_IP_SET_BITMAP_IP is not set
# CONFIG_IP_SET_BITMAP_IPMAC is not set
# CONFIG_IP_SET_BITMAP_PORT is not set
# CONFIG_IP_SET_HASH_IP is not set
# CONFIG_IP_SET_HASH_IPPORT is not set
# CONFIG_IP_SET_HASH_IPPORTIP is not set
# CONFIG_IP_SET_HASH_IPPORTNET is not set
# CONFIG_IP_SET_HASH_NET is not set
# CONFIG_IP_SET_HASH_NETPORT is not set
# CONFIG_IP_SET_LIST_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_CONNTRACK_IPV4=m
CONFIG_NF_CONNTRACK_PROC_COMPAT=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_DCCP=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PROTO_UDPLITE=m
CONFIG_NF_NAT_PROTO_SCTP=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_NF_NAT_SIP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_CONNTRACK_IPV6=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_ULOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=y
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_L2TP=m
# CONFIG_L2TP_DEBUGFS is not set
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
CONFIG_LLC2=m
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
CONFIG_WAN_ROUTER=m
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_INGRESS=m

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=m
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_IPT=m
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=m
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=m
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
# CONFIG_MTD_BLKDEVS is not set
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_M25P80=m
CONFIG_M25PXX_USE_FAST_READ=y
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR flash memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_UBI is not set
CONFIG_DTC=y
CONFIG_OF=y

#
# Device Tree and Open Firmware support
#
CONFIG_PROC_DEVICETREE=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_DEVICE=y
CONFIG_OF_GPIO=y
CONFIG_OF_I2C=y
CONFIG_OF_NET=y
CONFIG_OF_SPI=y
CONFIG_OF_MDIO=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_MISC_DEVICES is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_TGT is not set
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_WAIT_SCAN=m

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_FSL is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
CONFIG_PATA_PLATFORM=y
CONFIG_PATA_OF_PLATFORM=y

#
# Generic fallback / legacy drivers
#
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_IFB=m
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_VETH is not set
CONFIG_MII=y
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=y
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_MICREL_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_GPIO=y
CONFIG_NET_ETHERNET=y
# CONFIG_ENC28J60 is not set
# CONFIG_ETHOC is not set
# CONFIG_DNET is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
# CONFIG_B44 is not set
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_XILINX_EMACLITE is not set
CONFIG_NETDEV_1000=y
CONFIG_FSL_PQ_MDIO=y
# CONFIG_GIANFAR is not set
CONFIG_UCC_GETH=m
CONFIG_UGETH_TX_ON_DEMAND=y
# CONFIG_MV643XX_ETH is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_STMMAC_ETH is not set
# CONFIG_NETDEV_10000 is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_IPHETH=m
CONFIG_WAN=y
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
CONFIG_WAN_ROUTER_DRIVERS=m

#
# CAIF transport drivers
#
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_MPPE=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
# CONFIG_SLIP is not set
CONFIG_SLHC=m
CONFIG_NETCONSOLE=m
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX3107 is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_OF_PLATFORM is not set
# CONFIG_SERIAL_QE is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_XILINX_PS_UART=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_HVC_UDBG is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_RX1000_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_RAMOOPS is not set
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y

#
# I2C Hardware Bus support
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_MPC=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PCA954X=y
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_FSL_LIB=m
CONFIG_SPI_FSL_SPI=m
# CONFIG_SPI_FSL_ESPI is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_TLE62X0 is not set
CONFIG_SPI_DS26514=m

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable Device Drivers -> PPS to see the PTP clock options.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
CONFIG_ARCH_REQUIRE_GPIOLIB=y
CONFIG_GPIOLIB=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers:
#
# CONFIG_GPIO_BASIC_MMIO is not set
# CONFIG_GPIO_IT8761E is not set
# CONFIG_GPIO_XILINX is not set

#
# I2C GPIO expanders:
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_SX150X is not set
# CONFIG_GPIO_ADP5588 is not set

#
# PCI GPIO expanders:
#

#
# SPI GPIO expanders:
#
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_74X164 is not set

#
# AC97 GPIO expanders:
#

#
# MODULbus GPIO expanders:
#
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_M41T81 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_MAX6369_WDT=m
# CONFIG_8xxx_WDT is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set
# CONFIG_MFD_SUPPORT is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_DRM is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set
# CONFIG_SOUND is not set
# CONFIG_HID_SUPPORT is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB_ARCH_HAS_OHCI is not set
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_DEVICE_CLASS is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_MON=m
# CONFIG_USB_WUSB is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1760_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HWA_HCD is not set

#
# Enable Host or Gadget support to see Inventra options
#

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=m
# CONFIG_USB_LIBUSUAL is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_EZUSB is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_FUNSOFT is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MOTOROLA is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_HP4X is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIEMENS_MPI is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_VIVOPAY_SERIAL is not set
# CONFIG_USB_SERIAL_ZIO is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_GADGET is not set

#
# OTG and related infrastructure
#
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_NFC_DEVICES is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_DS3234 is not set
# CONFIG_RTC_DRV_PCF2123 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_GENERIC is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=y
CONFIG_FSL_DMA=y
# CONFIG_TIMB_DMA is not set
CONFIG_DMA_ENGINE=y

#
# DMA Clients
#
CONFIG_NET_DMA=y
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_STAGING is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_DEFAULTS_TO_ORDERED=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
# CONFIG_EXT4_FS is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=m
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=m
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFS_FSCACHE=y
CONFIG_NFSD=m
# CONFIG_NFSD_DEPRECATED is not set
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
CONFIG_UCC_FAST=y
CONFIG_UCC=y
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=m
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_LRU_CACHE=m
# CONFIG_AVERAGE is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_MASK=0x01b6
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_IPIPE_DEBUG is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
# CONFIG_LOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_WRITECOUNT is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_LKDTM is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_SYSCTL_SYSCALL_CHECK=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_PPC_DISABLE_WERROR is not set
CONFIG_PPC_WERROR=y
CONFIG_PRINT_STACK_DEPTH=64
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_PPC_EMULATED_STATS is not set
# CONFIG_CODE_PATCHING_SELFTEST is not set
# CONFIG_FTR_FIXUP_SELFTEST is not set
# CONFIG_MSI_BITMAP_SELFTEST is not set
# CONFIG_XMON is not set
# CONFIG_VIRQ_DEBUG is not set
# CONFIG_BDI_SWITCH is not set
CONFIG_BOOTX_TEXT=y
# CONFIG_PPC_EARLY_DEBUG is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=m
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP=m
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
CONFIG_CRYPTO_HMAC=m
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_ZLIB=m
# CONFIG_CRYPTO_LZO is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_FSL_CAAM is not set
CONFIG_CRYPTO_DEV_TALITOS=m
# CONFIG_PPC_CLOCK is not set
CONFIG_PPC_LIB_RHEAP=y
# CONFIG_VIRTUALIZATION is not set

--LZvS9be/3tNcYl/X--

