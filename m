Message-ID: <49103EE8.6090000@domain.hid>
Date: Tue, 04 Nov 2008 13:24:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <490F0C59.9060506@domain.hid> <490F0D1E.3080509@domain.hid>
	<491004C8.8040406@domain.hid> <49101EBE.9090007@domain.hid>
	<49102216.9030207@domain.hid> <49103A9A.2080703@domain.hid>
In-Reply-To: <49103A9A.2080703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Using Xenomai in early boot phase.
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
>> Wolfgang Grandegger wrote:
>>> Wolfgang Grandegger wrote:
>>>> Philippe Gerum wrote:
>>>>> Wolfgang Grandegger wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I want to use a Xenomai task overtaking the duties of a watchdog running
>>>>>> under Linux as soon as the Xenomai layer is available during boot up. Is
>>>>>>   there a function or variable I could inspect? With 2.3.x, I called
>>>>>> rtdm_init_task() until it returned without error but with 2.4.x it
>>>>>> results in a kernel crash :-(.
>>>>>>
>>>>> What is the value of CONFIG_XENO_OPT_SYS_STACKPOOLSZ?
>>>>   #
>>>>   # Nucleus options
>>>>   #
>>>>   CONFIG_XENO_OPT_PERVASIVE=y
>>>>   CONFIG_XENO_OPT_SYS_STACKPOOLSZ=32
>>>>   # CONFIG_XENO_OPT_PRIOCPL is not set
>>>>   CONFIG_XENO_OPT_PIPE=y
>>> Some more input on that issue. Here is the oops and the NIP location:
>>>
>>> XLB Arb cnf: 8000a006
>>> mpc5xxx_ide: Setting up IDE interface ide0...
>>> Probing IDE interface ide0...
>>> Oops: kernel access of bad area, sig: 11
>>> NIP: C0113364 XER: 20000000 LR: C0113320 SP: C047DB30 REGS: c047da80 TRAP: 0300    Not tainted
>>> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>>> DAR: 0000003C, DSISR: 20000000
>>> TASK = c047c000[1] 'swapper' Last syscall: 120
>>> last math 00000000 last altivec 00000000
>>> GPR00: 00000003 C047DB30 C047C000 00000009 FFFFFFF7 C01CF395 C0220000 00000000
>>> GPR08: 00000038 C01ECC00 C02445F4 00000000 00000000 100803B0 07FCF000 08099000
>>> GPR16: C0220000 FFFFFF7F C0230000 FFF75F97 C022B3C0 00000000 C01ECC0C C0230000
>>> GPR24: 00000000 00000000 00000010 C02446F4 3B9A0000 00000000 00000000 C0244590
>>> Call backtrace:
>>> C0113320 C0111F00 C010DD0C C013D810 C00DA48C C001EAB4 C001A70C
>>> C001A598 C001A254 C00079C0 C000D63C C0024C50 C00243AC C000D298
>>> C000D508 C0005CF4 0039FBC0 C00F0A4C C00F0EA0 C00F15C0 C00F210C
>>> C02149C8 C0214A14 C020A64C C00039A0 C0008678
>>> Kernel panic: Aiee, killing interrupt handler!
>>> In interrupt handler - not syncing
>>>  <0>Rebooting in 180 seconds..
>>>
>>> $ ppc_6xx-gdb vmlinux:
>>> ...
>>> (gdb) l *0xC0113364
>>> 0xc0113364 is in __xntimer_init (queue.h:51).
>>> 46              holder->last = holder;
>>> 47              holder->next = holder;
>>> 48      }
>>> 49
>>> 50      static inline void ath(xnholder_t *head, xnholder_t *holder)
>>> 51      {
>>> 52              /* Inserts the new element right after the heading one  */
>>> 53              holder->last = head;
>>> 54              holder->next = head->next;
>>> 55              holder->next->last = holder;
>>>
>>> Wolfgang.
>>>
>> Thanks. Could you send me the full boot log until the oops occurs as well? TIA,
> 
> Ses below. As mentioned earlier, rtdm_task_init() is called early before the
> Xenomai sub-system gets initialized.
> 

The point is, how much earlier, and as a matter of fact, at least one skin
should have initialized before any service creating a Xenomai task could be
invoked, like rtdm_task_init(). As you mentioned and from your boot log, not
even the nucleus was started, so I don't understand how this could have ever
worked with any Xenomai version actually (the gist of the matter is that we
don't have the internal allocator set up for grabbing stack memory for the new
task at that point). You may want to make your task creation routine a
late_initcall to fix this.

> Wolfgang.
> 
> 
> U-Boot 1.3.4_@domain.hid (Sep  3 2008 - 13:44:11)
> 
> CPU:   MPC5200B v2.2, Core v1.4 at 396 MHz
>        Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
> Board: MAN UC101
> I2C:   85 kHz, ready
> i2c_read: failed to address chip
> DTT:   1 FAILED INIT
> DRAM:  128 MB
> FLASH:  8 MB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   FEC ETHERNET
> IDE:   Bus 0: OK
>   Device 0: Model: SILICONSYSTEMS INC 64MB Firm: 240-0230 Ser#: 496CTZ63Se611SC00918
>             Type: Hard Disk
>             Capacity: 62.5 MB = 0.0 GB (128128 x 512)
>   Device 1: Model:  Firm:  Ser#:
>             Type: # 1F #
>             Capacity: not available
> Hit any key to stop autoboot:  0
> reading uc101_lx.img
> 
> 992316 bytes read
> reading uInitrd.img
> 
> 1059055 bytes read
> ## Booting kernel from Legacy Image at 00200000 ...
>    Image Name:   Linux-2.4.25
>    Created:      2008-11-04   7:41:51 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    992252 Bytes = 969 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 00400000 ...
>    Image Name:   Pivot Root Helper
>    Created:      2008-06-18   8:45:02 UTC
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    1058991 Bytes =  1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Loading Ramdisk to 07e11000, end 07f138af ... OK
> Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
> Linux version 2.4.25 (arowil@domain.hid) (gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-10)) #1 @(#)MR_kernel_UC101_0.62.1.1.8.offen Di 4. Nov 08:36:30 CET 2008
> On node 0 totalpages: 32768
> zone(0): 32768 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/loop0 ro wdt=off console=ttyS0,38400 trace=on
> I-pipe 1.2-02: pipeline enabled.
> Calibrating delay loop... 263.78 BogoMIPS
> Memory: 125512k available (1736k kernel code, 664k data, 68k init, 0k highmem)
> Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
> Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
> Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> Journalled Block Device driver loaded
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> i2c-core.o: i2c core module version 2.6.1 (20010830)
> i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
> i2c locking set to 1
> i2c-proc.o version 2.6.1 (20010830)
> pty: 256 Unix98 ptys configured
> ttyS0 on PSC1
> ttyS1 on PSC2
> ttyS2 on PSC6
> PCF8563 Real-Time Clock Driver $Revision: 1.3 $ wd@domain.hid
> WDT: Software Watchdog Timer 1.0.0 (disabled)
> SRAM_DRV: initialized
> uc101_gpio: 1.1
> PCI.IBM-1 found at irq 6
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> loop: loaded (max 8 devices)
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
> Port Config is: 0x4d558044
> ipb=132MHz, set clock period to 7
> GPIO config: 4d558044
> ATA invalid: 01000000
> ATA hostcnf: 03000000
> ATA pio1   : 100a0a00
> ATA pio2   : 02040600
> XLB Arb cnf: 8000a006
> mpc5xxx_ide: Setting up IDE interface ide0...
> Probing IDE interface ide0...
> Oops: kernel access of bad area, sig: 11
> NIP: C0113364 XER: 20000000 LR: C0113320 SP: C047DB30 REGS: c047da80 TRAP: 0300    Not tainted
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 0000003C, DSISR: 20000000
> TASK = c047c000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 00000003 C047DB30 C047C000 00000009 FFFFFFF7 C01CF395 C0220000 00000000
> GPR08: 00000038 C01ECC00 C02445F4 00000000 00000000 5FFFFFF7 07FCF000 08099000
> GPR16: C0220000 BFFFFF7F C0230000 7FFE5F97 C022B3C0 00000000 C01ECC0C C0230000
> GPR24: 00000000 00000000 00000010 C02446F4 3B9A0000 00000000 00000000 C0244590
> Call backtrace:
> C0113320 C0111F00 C010DD0C C013D810 C00DA48C C001EAB4 C001A70C
> C001A598 C001A254 C00079C0 C000D63C C0024C50 C00243AC C000D298
> C000D508 C0005CF4 0039FBC0 C00F0A4C C00F0EA0 C00F15C0 C00F210C
> C02149C8 C0214A14 C020A64C C00039A0 C0008678
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  <0>Rebooting in 180 seconds..
> 


-- 
Philippe.

