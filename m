MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Nov 2012 21:05:35 +0100
From: WONG Sheng Chao <wong@isir.upmc.fr>
In-Reply-To: <788D82C9-694C-486E-AB6B-383A03EC748D@kabelmail.de>
References: <mailman.2.1354034873.1423.xenomai@xenomai.org>
	<788D82C9-694C-486E-AB6B-383A03EC748D@kabelmail.de>
Message-ID: <11c3b4939f895a0a00d84e494f581cb7@isir.upmc.fr>
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Cc: xenomai@xenomai.org

On Tue, 27 Nov 2012 19:42:21 +0100, Stephan Kappertz wrote:
>>
>> Hi Gilles
>>
>> Following your advice i tracked down the include files which need to 
>> be included to remove the error. The kernel now compiles without 
>> errors. I followed the instructions in
>>
>> http://www.xenomai.org/pipermail/xenomai/2012-July/000481.html
>>
>> to change the timer.c and also changing the .handle_irq with 
>> ipipe_handle_multi_irq
>>
>> From the serial terminal i noticed that with CONFIG_IPIPE = ON the 
>> timer is used correctly as in the above post but it hangs at
>>
>> [    0.958295] at24 1-0051: 32768 byte 24c256 EEPROM, writable, 64 
>> bytes/write
>>
>> I followed the troubleshooting guide at
>>
>> 
>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Troubleshooting
>>
>> With both CONFIG_XENOMAI and CONFIG_IPIPE off, the kernel was able 
>> to boot normally
>>
>> Uncompressing Linux... done, booting the kernel.
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 3.2.21-ipipe (chao@chao-laptop) (gcc 
>> version 4.5.4 20120305 (prerelease) (GCC) ) #1 Tue Nov 27 17:19:52 CET 
>> 2012
>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), 
>> cr=10c53c7d
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT 
>> aliasing instruction cache
>> [    0.000000] Machine: am335xevm
>> [    0.000000] Memory policy: ECC disabled, Data cache writeback
>> [    0.000000] AM335X ES1.0 (sgx neon )
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping 
>> on.  Total pages: 65024
>> [    0.000000] Kernel command line: console=ttyO0,115200n8 
>> root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait ip=none
>> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 
>> 131072 bytes)
>> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 
>> 65536 bytes)
>> [    0.000000] Memory: 256MB = 256MB total
>> [    0.000000] Memory: 252968k/252968k available, 9176k reserved, 0K 
>> highmem
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>> [    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
>> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>> [    0.000000]       .text : 0xc0008000 - 0xc05bdd54   (5848 kB)
>> [    0.000000]       .init : 0xc05be000 - 0xc0600000   ( 264 kB)
>> [    0.000000]       .data : 0xc0600000 - 0xc064eea8   ( 316 kB)
>> [    0.000000]        .bss : 0xc064eecc - 0xc06b9214   ( 425 kB)
>> [    0.000000] NR_IRQS:410 nr_irqs:410 410
>> [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 
>> 128 interrupts
>> [    0.000000] Total of 128 interrupts on 1 active controller
>> [    0.000000] OMAP clockevent source: GPTIMER2 at 24000000 Hz
>> [    0.000000] OMAP clocksource: GPTIMER1 at 24000000 Hz
>> [    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps 
>> every 178956ms
>> [    0.000000] Console: colour dummy device 80x30
>> [    0.000244] Calibrating delay loop... 498.89 BogoMIPS 
>> (lpj=2494464)
>> [    0.118703] pid_max: default: 32768 minimum: 301
>> [    0.118865] Security Framework initialized
>> [    0.118942] Mount-cache hash table entries: 512
>> [    0.119410] Initializing cgroup subsys cpuacct
>> [    0.119462] Initializing cgroup subsys devices
>> [    0.119478] Initializing cgroup subsys freezer
>> [    0.119558] CPU: Testing write buffer coherency: ok
>> [    0.120847] devtmpfs: initialized
>> [    0.141418] omap_hwmod: gfx: failed to hardreset
>> [    0.158137] omap_hwmod: pruss: failed to hardreset
>> [    0.158801] print_constraints: dummy:
>> [    0.159070] NET: Registered protocol family 16
>> [    0.160363] OMAP GPIO hardware version 0.1
>> [    0.161676] omap_mux_init: Add partition: #1: core, flags: 0
>> [    0.163248]  omap_i2c.1: alias fck already exists
>> [    0.163661] hw-breakpoint: debug architecture 0x4 unsupported.
>> [    0.163848]  omap2_mcspi.1: alias fck already exists
>> [    0.163985]  omap2_mcspi.2: alias fck already exists
>> [    0.164171]  edma.0: alias fck already exists
>> [    0.164198]  edma.0: alias fck already exists
>> [    0.164222]  edma.0: alias fck already exists
>> [    0.164320] cape: pcm register
>> [    0.174334] bio: create slab <bio-0> at 0
>> [    0.175680] SCSI subsystem initialized
>> [    0.176720] usbcore: registered new interface driver usbfs
>> [    0.176869] usbcore: registered new interface driver hub
>> [    0.177082] usbcore: registered new device driver usb
>> [    0.177245] musb-ti81xx musb-ti81xx: musb0, board_mode=0x13, 
>> plat_mode=0x3
>> [    0.177408] musb-ti81xx musb-ti81xx: musb1, board_mode=0x13, 
>> plat_mode=0x1
>> [    0.177955] omap_i2c omap_i2c.1: bus 1 rev2.4.0 at 100 kHz
>> [    0.179282] Advanced Linux Sound Architecture Driver Version 
>> 1.0.24.
>> [    0.179941] Switching to clocksource gp timer
>> [    0.207177] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
>> [    0.207397] musb-hdrc musb-hdrc.0: dma type: pio
>> [    0.207605] MUSB0 controller's USBSS revision = 4ea20800
>> [    0.208120] musb-hdrc musb-hdrc.0: USB OTG mode controller at 
>> d081c000 using PIO, IRQ 18
>> [    0.208468] musb-hdrc musb-hdrc.1: dma type: pio
>> [    0.208658] MUSB1 controller's USBSS revision = 4ea20800
>> [    0.208803] musb-hdrc musb-hdrc.1: MUSB HDRC host driver
>> [    0.208912] musb-hdrc musb-hdrc.1: new USB bus registered, 
>> assigned bus number 1
>> [    0.209083] usb usb1: New USB device found, idVendor=1d6b, 
>> idProduct=0002
>> [    0.209106] usb usb1: New USB device strings: Mfr=3, Product=2, 
>> SerialNumber=1
>> [    0.209124] usb usb1: Product: MUSB HDRC host driver
>> [    0.209140] usb usb1: Manufacturer: Linux 3.2.21-ipipe musb-hcd
>> [    0.209155] usb usb1: SerialNumber: musb-hdrc.1
>> [    0.209949] hub 1-0:1.0: USB hub found
>> [    0.210075] hub 1-0:1.0: 1 port detected
>> [    0.210643] musb-hdrc musb-hdrc.1: USB Host mode controller at 
>> d081e800 using PIO, IRQ 19
>> [    0.211105] NET: Registered protocol family 2
>> [    0.211358] IP route cache hash table entries: 2048 (order: 1, 
>> 8192 bytes)
>> [    0.211866] TCP established hash table entries: 8192 (order: 4, 
>> 65536 bytes)
>> [    0.212090] TCP bind hash table entries: 8192 (order: 3, 32768 
>> bytes)
>> [    0.212226] TCP: Hash tables configured (established 8192 bind 
>> 8192)
>> [    0.212242] TCP reno registered
>> [    0.212260] UDP hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.212292] UDP-Lite hash table entries: 256 (order: 0, 4096 
>> bytes)
>> [    0.212623] NET: Registered protocol family 1
>> [    0.213057] RPC: Registered named UNIX socket transport module.
>> [    0.213077] RPC: Registered udp transport module.
>> [    0.213090] RPC: Registered tcp transport module.
>> [    0.213103] RPC: Registered tcp NFSv4.1 backchannel transport 
>> module.
>> [    0.213649] cpuidle-am33xx cpuidle-am33xx.0: failed to register 
>> driver
>> [    0.215173] audit: initializing netlink socket (disabled)
>> [    0.215242] type=2000 audit(0.210:1): initialized
>> [    0.226622] VFS: Disk quotas dquot_6.5.2
>> [    0.226705] Dquot-cache hash table entries: 1024 (order 0, 4096 
>> bytes)
>> [    0.228060] msgmni has been set to 494
>> [    0.229491] Block layer SCSI generic (bsg) driver version 0.4 
>> loaded (major 252)
>> [    0.229517] io scheduler noop registered
>> [    0.229531] io scheduler deadline registered
>> [    0.229594] io scheduler cfq registered (default)
>> [    0.230798] Serial: 8250/16550 driver, 4 ports, IRQ sharing 
>> enabled
>> [    0.232402] omap_uart.0: ttyO0 at MMIO 0x44e09000 (irq = 72) is a 
>> OMAP UART0
>> [    0.834573] console [ttyO0] enabled
>> [    0.838986] omap_uart.1: ttyO1 at MMIO 0x48022000 (irq = 73) is a 
>> OMAP UART1
>> [    0.846942] omap_uart.2: ttyO2 at MMIO 0x48024000 (irq = 74) is a 
>> OMAP UART2
>> [    0.854853] omap_uart.3: ttyO3 at MMIO 0x481a6000 (irq = 44) is a 
>> OMAP UART3
>> [    0.862748] omap_uart.4: ttyO4 at MMIO 0x481a8000 (irq = 45) is a 
>> OMAP UART4
>> [    0.870645] omap_uart.5: ttyO5 at MMIO 0x481aa000 (irq = 46) is a 
>> OMAP UART5
>> [    0.879787] brd: module loaded
>> [    0.887606] loop: module loaded
>> [    0.891067] at24 1-0051: 32768 byte 24c256 EEPROM, writable, 64 
>> bytes/write
>> [    0.949996] No daughter card found
>> [    0.953630] at24 1-0050: 32768 byte 24c256 EEPROM, writable, 64 
>> bytes/write
>> [    0.968911] Board name: A335BONE
>> [    0.972328] Board version: 00A6
>> [    0.975629] The board is a AM335x Beaglebone.
>> [    0.980934] tps65217 1-0024: TPS65217 ID 0xf version 1.1
>> [    0.988396] print_constraints: DCDC1: 900 <--> 1800 mV at 1800 mV
>> [    0.996824] print_constraints: DCDC2: 900 <--> 3300 mV at 1275 mV
>> [    1.005246] print_constraints: DCDC3: 900 <--> 1500 mV at 1100 mV
>> [    1.013632] print_constraints: LDO1: 1000 <--> 3300 mV at 1800 mV
>> [    1.022025] print_constraints: LDO2: 900 <--> 3300 mV at 3300 mV
>> [    1.030303] print_constraints: LDO3: 1800 <--> 3300 mV at 3300 mV
>> [    1.038701] print_constraints: LDO4: 1800 <--> 3300 mV at 3300 mV
>> [    1.045724] Maximum current provided by the USB port is 500mA 
>> which is not sufficient when operating @OPP120 and OPPTURBO. The 
>> current requirement for some use-cases using OPP100 might also exceed 
>> the maximum current that the USB port can provide. Unless you are 
>> fully confident that the current requirements for OPP100 use-case 
>> don't exceed the USB limits, switching to AC power is recommended.
>> [    1.082552]  omap_i2c.3: alias fck already exists
>> [    1.087824] omap_i2c omap_i2c.3: bus 3 rev2.4.0 at 100 kHz
>> [    1.098210] at24 3-0054: 32768 byte 24c256 EEPROM, writable, 64 
>> bytes/write
>> [    1.159999] BeagleBone cape EEPROM: could not read eeprom at 
>> address 0x54
>>
>>
>> Here's the log with CONFIG_XENOMAI = OFF and CONFIG_IPIPE = ON
>>
>> Uncompressing Linux... done, booting the kernel.
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 3.2.21-ipipe (chao@chao-laptop) (gcc 
>> version 4.5.4 20120305 (prerelease) (GCC) ) #1 PREEMPT Tue Nov 27 
>> 17:36:26 CET 2012
>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), 
>> cr=10c53c7d
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT 
>> aliasing instruction cache
>> [    0.000000] Machine: am335xevm
>> [    0.000000] Memory policy: ECC disabled, Data cache writeback
>> [    0.000000] AM335X ES1.0 (sgx neon )
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping 
>> on.  Total pages: 65024
>> [    0.000000] Kernel command line: console=ttyO0,115200n8 
>> root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait ip=none
>> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 
>> 131072 bytes)
>> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 
>> 65536 bytes)
>> [    0.000000] Memory: 256MB = 256MB total
>> [    0.000000] Memory: 252464k/252464k available, 9680k reserved, 0K 
>> highmem
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>> [    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
>> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>> [    0.000000]       .text : 0xc0008000 - 0xc061123c   (6181 kB)
>> [    0.000000]       .init : 0xc0612000 - 0xc0655000   ( 268 kB)
>> [    0.000000]       .data : 0xc0656000 - 0xc06a6868   ( 323 kB)
>> [    0.000000]        .bss : 0xc06a688c - 0xc0737d54   ( 582 kB)
>> [    0.000000] NR_IRQS:410 nr_irqs:410 410
>> [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 
>> 128 interrupts
>> [    0.000000] Total of 128 interrupts on 1 active controller
>> [    0.000000] OMAP clockevent source: GPTIMER2 at 24000000 Hz
>> [    0.000000] OMAP clocksource: GPTIMER3 at 24000000 Hz
>> [    0.000000] I-pipe, 24.000 MHz clocksource
>> [    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps 
>> every 178956ms
>> [    0.000000] Interrupt pipeline (release #1)
>> [    0.000000] Console: colour dummy device 80x30
>> [    0.000735] Calibrating delay loop... 498.89 BogoMIPS 
>> (lpj=2494464)
>> [    0.118663] pid_max: default: 32768 minimum: 301
>> [    0.118881] Security Framework initialized
>> [    0.118984] Mount-cache hash table entries: 512
>> [    0.119570] Initializing cgroup subsys cpuacct
>> [    0.119627] Initializing cgroup subsys devices
>> [    0.119645] Initializing cgroup subsys freezer
>> [    0.119746] CPU: Testing write buffer coherency: ok
>> [    0.121323] devtmpfs: initialized
>> [    0.142538] omap_hwmod: gfx: failed to hardreset
>> [    0.159288] omap_hwmod: pruss: failed to hardreset
>> [    0.160005] print_constraints: dummy:
>> [    0.160342] NET: Registered protocol family 16
>> [    0.161800] OMAP GPIO hardware version 0.1
>> [    0.163363] omap_mux_init: Add partition: #1: core, flags: 0
>> [    0.165179]  omap_i2c.1: alias fck already exists
>> [    0.165644] hw-breakpoint: debug architecture 0x4 unsupported.
>> [    0.165856]  omap2_mcspi.1: alias fck already exists
>> [    0.166011]  omap2_mcspi.2: alias fck already exists
>> [    0.166215]  edma.0: alias fck already exists
>> [    0.166245]  edma.0: alias fck already exists
>> [    0.166271]  edma.0: alias fck already exists
>> [    0.166381] cape: pcm register
>> [    0.177948] bio: create slab <bio-0> at 0
>> [    0.179694] SCSI subsystem initialized
>> [    0.180900] usbcore: registered new interface driver usbfs
>> [    0.181072] usbcore: registered new interface driver hub
>> [    0.181333] usbcore: registered new device driver usb
>> [    0.181530] musb-ti81xx musb-ti81xx: musb0, board_mode=0x13, 
>> plat_mode=0x3
>> [    0.181709] musb-ti81xx musb-ti81xx: musb1, board_mode=0x13, 
>> plat_mode=0x1
>> [    0.182363] omap_i2c omap_i2c.1: bus 1 rev2.4.0 at 100 kHz
>> [    0.183779] Advanced Linux Sound Architecture Driver Version 
>> 1.0.24.
>> [    0.184506] Switching to clocksource ipipe_tsc
>> [    0.220287] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
>> [    0.220545] musb-hdrc musb-hdrc.0: dma type: pio
>> [    0.220788] MUSB0 controller's USBSS revision = 4ea20800
>> [    0.221366] musb-hdrc musb-hdrc.0: USB OTG mode controller at 
>> d081c000 using PIO, IRQ 18
>> [    0.221763] musb-hdrc musb-hdrc.1: dma type: pio
>> [    0.221979] MUSB1 controller's USBSS revision = 4ea20800
>> [    0.222143] musb-hdrc musb-hdrc.1: MUSB HDRC host driver
>> [    0.222276] musb-hdrc musb-hdrc.1: new USB bus registered, 
>> assigned bus number 1
>> [    0.222485] usb usb1: New USB device found, idVendor=1d6b, 
>> idProduct=0002
>> [    0.222510] usb usb1: New USB device strings: Mfr=3, Product=2, 
>> SerialNumber=1
>> [    0.222532] usb usb1: Product: MUSB HDRC host driver
>> [    0.222549] usb usb1: Manufacturer: Linux 3.2.21-ipipe musb-hcd
>> [    0.222566] usb usb1: SerialNumber: musb-hdrc.1
>> [    0.223435] hub 1-0:1.0: USB hub found
>> [    0.223478] hub 1-0:1.0: 1 port detected
>> [    0.224106] musb-hdrc musb-hdrc.1: USB Host mode controller at 
>> d081e800 using PIO, IRQ 19
>> [    0.224699] NET: Registered protocol family 2
>> [    0.224989] IP route cache hash table entries: 2048 (order: 1, 
>> 8192 bytes)
>> [    0.225617] TCP established hash table entries: 8192 (order: 4, 
>> 65536 bytes)
>> [    0.225845] TCP bind hash table entries: 8192 (order: 3, 32768 
>> bytes)
>> [    0.225982] TCP: Hash tables configured (established 8192 bind 
>> 8192)
>> [    0.226001] TCP reno registered
>> [    0.226021] UDP hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.226056] UDP-Lite hash table entries: 256 (order: 0, 4096 
>> bytes)
>> [    0.226446] NET: Registered protocol family 1
>> [    0.227121] RPC: Registered named UNIX socket transport module.
>> [    0.227146] RPC: Registered udp transport module.
>> [    0.227162] RPC: Registered tcp transport module.
>> [    0.227176] RPC: Registered tcp NFSv4.1 backchannel transport 
>> module.
>> [    0.227832] cpuidle-am33xx cpuidle-am33xx.0: failed to register 
>> driver
>> [    0.229751] audit: initializing netlink socket (disabled)
>> [    0.229835] type=2000 audit(0.180:1): initialized
>> [    0.241446] VFS: Disk quotas dquot_6.5.2
>> [    0.241550] Dquot-cache hash table entries: 1024 (order 0, 4096 
>> bytes)
>> [    0.243359] msgmni has been set to 493
>> [    0.245251] Block layer SCSI generic (bsg) driver version 0.4 
>> loaded (major 252)
>> [    0.245282] io scheduler noop registered
>> [    0.245297] io scheduler deadline registered
>> [    0.245392] io scheduler cfq registered (default)
>> [    0.246642] Serial: 8250/16550 driver, 4 ports, IRQ sharing 
>> enabled
>> [    0.248598] omap_uart.0: ttyO0 at MMIO 0x44e09000 (irq = 72) is a 
>> OMAP UART0
>> [    0.860338] console [ttyO0] enabled
>> [    0.864664] omap_uart.1: ttyO1 at MMIO 0x48022000 (irq = 73) is a 
>> OMAP UART1
>> [    0.872618] omap_uart.2: ttyO2 at MMIO 0x48024000 (irq = 74) is a 
>> OMAP UART2
>> [    0.880574] omap_uart.3: ttyO3 at MMIO 0x481a6000 (irq = 44) is a 
>> OMAP UART3
>> [    0.888525] omap_uart.4: ttyO4 at MMIO 0x481a8000 (irq = 45) is a 
>> OMAP UART4
>> [    0.896491] omap_uart.5: ttyO5 at MMIO 0x481aa000 (irq = 46) is a 
>> OMAP UART5
>> [    0.905879] brd: module loaded
>> [    0.914179] loop: module loaded
>> [    0.917564] at24 1-0051: 32768 byte 24c256 EEPROM, writable, 64 
>> bytes/write
>>
>>
>> Any advice on how to proceed to debug this problem? I attach the 
>> config files of two cases for your reference.
>>
>
> The kernel hangs because the eeprom driver waits based on timer
> ticks. The timer ticks don't increment because the ipipe irq handler
> is never called.
>
> In arch/arm/mach-omap2/irq.c: static inline void omap_intc_handle_irq
> you need to replace handle_IRQ by ipipe_handle_multi_irq.

>
> - Stephan
>
Hi Stephan

Actually i already replaced the handle_IRQ by ipipe_handle_multi_irq in 
arch/arm/mach-omap2/irq.c following  your previous discussion with 
Gilles. Probably i did a mistake in replacing the function. Since we are 
both using the beaglebone do you mind sending me a copy of your irq.c, 
so that i can compare and see what went wrong?

Best
Wong



