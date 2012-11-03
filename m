Message-ID: <50958BA3.1000903@xenomai.org>
Date: Sat, 03 Nov 2012 22:24:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <k73ua9$nf5$1@ger.gmane.org>
In-Reply-To: <k73ua9$nf5$1@ger.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Beagle-XM - ipipe-core-3.2.21
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <gmane@reliableembeddedsystems.com>
Cc: xenomai@xenomai.org

On 11/03/2012 09:20 PM, Robert Berger wrote:

> Hi,
> 
> I try to get Xenomai run on a Beagle-XM rev c.
> 
> That's what I use:
> 
> *) xenomai-head commit 9534fff1f0247c4c1a9bd104b0ef65df340ead4f
> *) ipipe-core-3.2.21-arm-1.patch
> *) ELDK 5.2.1 generic-armv7a
> *) linux-stable 3.2.21
> *) rootfs on 2nd partition of SD card (for now)
> *) kernel loaded over tftp


What version of the Linux kernel? Is it a vanilla 3.2.21?

> 
> That's what I observed so far:
> 
> 1) default config
> *) default kernel boots
> *) ipipe patched kernel hangs:
> 
> Filename 'beagle-xm/uImage'.
> Load address: 0x80200000
> Loading: #################################################################
> done
> Bytes transferred = 3607600 (370c30 hex)
> ## Booting kernel from Legacy Image at 80200000 ...
>    Image Name:   Linux-3.2.21-xenomai-student-dir
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3607536 Bytes = 3.4 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> 
> --> hangs here <--


As repeated many times on this list and probably on the linux-arm-kernel
mailing list too, in that case, use earlyprintk.


> 
> 1) custom config (able to boot rootfs over nfs)
> *) custom kernel boots with network support
> *) ipipe patched kernel tells me this:
> 
> ...
> [    0.342254] Division by zero in kernel.
> [    0.342315] [<c00134b8>] (unwind_backtrace+0x0/0xe0) from
> [<c03837d4>] (Ldiv0+0x8/0x10)
> [    0.342376] [<c03837d4>] (Ldiv0+0x8/0x10) from [<c04df888>]
> (rthal_arch_init+0x94/0xd8)
> [    0.342407] [<c04df888>] (rthal_arch_init+0x94/0xd8) from
> [<c00c4564>] (rthal_init+0x7c/0x25c)
> [    0.342437] [<c00c4564>] (rthal_init+0x7c/0x25c) from [<c084f58c>]
> (__xeno_sys_init+0x20/0x30c)
> [    0.342468] [<c084f58c>] (__xeno_sys_init+0x20/0x30c) from
> [<c000883c>] (do_one_initcall+0x90/0x160)
> [    0.342498] [<c000883c>] (do_one_initcall+0x90/0x160) from
> [<c08388a0>] (kernel_init+0xd8/0x180)
> [    0.342529] [<c08388a0>] (kernel_init+0xd8/0x180) from [<c000dfec>]
> (kernel_thread_exit+0x0/0x8)
> [    0.342559] Division by zero in kernel.
> [    0.342590] [<c00134b8>] (unwind_backtrace+0x0/0xe0) from
> [<c03837d4>] (Ldiv0+0x8/0x10)
> [    0.342620] [<c03837d4>] (Ldiv0+0x8/0x10) from [<c03837a4>]
> (__aeabi_uidivmod+0x8/0x18)
> [    0.342620] [<c03837a4>] (__aeabi_uidivmod+0x8/0x18) from
> [<c04df898>] (rthal_arch_init+0xa4/0xd8)
> [    0.342651] [<c04df898>] (rthal_arch_init+0xa4/0xd8) from
> [<c00c4564>] (rthal_init+0x7c/0x25c)
> [    0.342681] [<c00c4564>] (rthal_init+0x7c/0x25c) from [<c084f58c>]
> (__xeno_sys_init+0x20/0x30c)
> [    0.342712] [<c084f58c>] (__xeno_sys_init+0x20/0x30c) from
> [<c000883c>] (do_one_initcall+0x90/0x160)
> [    0.342742] [<c000883c>] (do_one_initcall+0x90/0x160) from
> [<c08388a0>] (kernel_init+0xd8/0x180)
> [    0.342773] [<c08388a0>] (kernel_init+0xd8/0x180) from [<c000dfec>]
> (kernel_thread_exit+0x0/0x8)
> [    0.342895] Division by zero in kernel.
> [    0.342926] [<c00134b8>] (unwind_backtrace+0x0/0xe0) from
> [<c0382d2c>] (Ldiv0_64+0x8/0x18)
> [    0.342956] [<c0382d2c>] (Ldiv0_64+0x8/0x18) from [<c04df8a4>]
> (rthal_arch_init+0xb0/0xd8)
> [    0.342987] [<c04df8a4>] (rthal_arch_init+0xb0/0xd8) from
> [<c00c4564>] (rthal_init+0x7c/0x25c)
> [    0.343017] [<c00c4564>] (rthal_init+0x7c/0x25c) from [<c084f58c>]
> (__xeno_sys_init+0x20/0x30c)
> [    0.343048] [<c084f58c>] (__xeno_sys_init+0x20/0x30c) from
> [<c000883c>] (do_one_initcall+0x90/0x160)
> [    0.343078] [<c000883c>] (do_one_initcall+0x90/0x160) from
> [<c08388a0>] (kernel_init+0xd8/0x180)
> [    0.343109] [<c08388a0>] (kernel_init+0xd8/0x180) from [<c000dfec>]
> (kernel_thread_exit+0x0/0x8)
> [    0.343261] Division by zero in kernel.
> [    0.343292] [<c00134b8>] (unwind_backtrace+0x0/0xe0) from
> [<c0382d2c>] (Ldiv0_64+0x8/0x18)
> [    0.343322] [<c0382d2c>] (Ldiv0_64+0x8/0x18) from [<c04df8b0>]
> (rthal_arch_init+0xbc/0xd8)
> [    0.343353] [<c04df8b0>] (rthal_arch_init+0xbc/0xd8) from
> [<c00c4564>] (rthal_init+0x7c/0x25c)
> [    0.343383] [<c00c4564>] (rthal_init+0x7c/0x25c) from [<c084f58c>]
> (__xeno_sys_init+0x20/0x30c)
> [    0.343414] [<c084f58c>] (__xeno_sys_init+0x20/0x30c) from
> [<c000883c>] (do_one_initcall+0x90/0x160)
> [    0.343444] [<c000883c>] (do_one_initcall+0x90/0x160) from
> [<c08388a0>] (kernel_init+0xd8/0x180)
> [    0.343475] [<c08388a0>] (kernel_init+0xd8/0x180) from [<c000dfec>]
> (kernel_thread_exit+0x0/0x8)
> [    0.343475] Xenomai: system init failed, code -9.
> [    0.343505] Xenomai: native skin init failed, code -9.
> [    0.343505] Xenomai: starting POSIX services.
> [    0.343536] Xenomai: POSIX skin init failed, code -9.
> [    0.343536] Xenomai: RTDM skin init failed, code -9.
> ...
> [    5.234558] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> [    5.241973] Waiting 2sec before mounting root device...
> ^[^[^[^[[B^[[B^[[B^[[A[  464.874786] smsc95xx 1-2.1:1.0: eth0: register
> 'smsc95xx' at usb-ehci-omap.0-2.1, smsc95xx USB 2.0 Ethernet,
> 62:9d:d5:c4:cf:f8
> [  464.887939] VFS: Cannot open root device "mmcblk0p2" or
> unknown-block(0,0)
> [  464.895233] Please append a correct "root=" boot option; here are the
> available partitions:
> [  464.904113] Kernel panic - not syncing: VFS: Unable to mount root fs
> on unknown-block(0,0)
> [  464.912811] [<c00134b8>] (unwind_backtrace+0x0/0xe0) from
> [<c05e5bec>] (panic+0x50/0x188)
> [  464.921447] [<c05e5bec>] (panic+0x50/0x188) from [<c0838ca0>]
> (mount_block_root+0x1d0/0x214)
> [  464.930328] [<c0838ca0>] (mount_block_root+0x1d0/0x214) from
> [<c0838eb0>] (mount_root+0xe4/0x100)
> [  464.939636] [<c0838eb0>] (mount_root+0xe4/0x100) from [<c0839028>]
> (prepare_namespace+0x15c/0x1bc)
> [  464.949188] [<c0839028>] (prepare_namespace+0x15c/0x1bc) from
> [<c0838910>] (kernel_init+0x148/0x180)
> [  464.958831] [<c0838910>] (kernel_init+0x148/0x180) from [<c000dfec>]
> (kernel_thread_exit+0x0/0x8)
> 
> more detailed info about Linux booting is here: http://pastebin.com/54bBuXQi
> 
> Do you have anything to suggest?


As repeated many times on this list, a stack trace is meaningless if you
do not provide us with the disassembly of the function which fails. In
that case that would be rthal_arch_init. Anyway, something is probably
wrong with the registration of the tsc emulation, or with the ipipe_timer.

-- 
                                                                Gilles.

