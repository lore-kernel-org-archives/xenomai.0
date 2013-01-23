In-Reply-To: <50FE45E9.1040909@xenomai.org>
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>	<50F3DD9A.9050306@gmail.com>
	<OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>
	<50FE45E9.1040909@xenomai.org>
MIME-Version: 1.0
Message-ID: <OF518EBAA9.1B02356C-ON85257AFC.00002A9B-85257AFC.00028E23@aanddtech.com>
From: mfornero@aanddtech.com
Date: Tue, 22 Jan 2013 19:27:54 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on 
01/22/2013 02:55:21 AM:

> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> To: mfornero@aanddtech.com, 
> Cc: Xenomai@xenomai.org
> Date: 01/22/2013 02:55 AM
> Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
> 
> On 01/22/2013 01:00 AM, mfornero@aanddtech.com wrote:
> 
> > The issue seems to be somewhat erratic, as I was able to run the 
latency 
> > test for a couple of hours this morning without observing it. Now 
however, 
> > it seems to show up on every boot (I don't believe I changed anything, 
but 
> > it's possible).
> > 
> > For reference, I'm booting from a SDHC partitioned as such:
> >         1) vfat         256 MB <-- This partition holds the first 
stage 
> > bootloader, uboot, the device tree and the Kernel zImage
> >         2) ext4         768 MB <-- This partition is the rootfs 
(busybox + 
> > xenomai)
> > 
> > The kernel boot command line is:
> >         bootargs = "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw 
> > earlyprintk rootfstype=ext4 rootwait devtmpfs.mount=1";
> > 
> > And I'm using the uboot compilation shipped with the ZedBoard.
> > 
> > My ipipe port can be found here:
> > git://github.com/mfornero/ipipe.git
> 
> 
> At a quick glance, you are missing this change:
> 
http://xenomai.org/index.php/I-pipe-core:ArmPorting#GPIOs_as_interrupt_sources

> 
> In drivers/gpio/gpio-xilinxps.c

Thanks Gilles. I fixed the irq handler as follows (pushed to github):

--- a/drivers/gpio/gpio-xilinxps.c
+++ b/drivers/gpio/gpio-xilinxps.c
@@ -422,7 +422,7 @@ void xgpiops_irqhandler(unsigned int irq, struct 
irq_desc *desc)
                        chip->irq_ack(&gpio_irq_desc->irq_data);
 
                        /* call the pin specific handler */
-                       generic_handle_irq(gpio_irq);
+                       ipipe_handle_demuxed_irq(gpio_irq);
                }
                /* shift to first virtual irq of next bank */
                gpio_irq = (int)irq_get_handler_data(irq) +


Unfortunately, this does not seem to have any effect on the issue. I did a 
couple more tests today, and found the following:

=========================================

If I change the kernel command line to turn on debug outputs:

bootargs = "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw earlyprintk 
rootfstype=ext4 rootwait debug loglevel=7 devtmpfs.mount=1";

and I #define DEBUG in driver/mmc/host/sdhci.c, I get a printk whenever 
the sdhc interrupt occurs. It seems to (usually) occur for a few seconds 
shortly after boot, stop occurring for ~300 seconds, occur for a few 
seconds, and repeat. During this time I usually get the bug previously 
described.

=========================================

If I boot with Xenomai off (CONFIG_XENOMAI = n) but IPIPE still on 
(CONFIG_IPIPE = y), I get a warning at boot. Haven't looked into the root 
cause of this-- but maybe it's related?

mmc0: new high speed SDHC card at address b368
mmcblk0: mmc0:b368 F0F0F 3.71 GiB
 mmcblk0: p1 p2
EXT4-fs (mmcblk0p2): recovery complete
EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: 
(null)
VFS: Mounted root (ext4 filesystem) on device 179:2.
devtmpfs: mounted
Freeing init memory: 160K
------------[ cut here ]------------
WARNING: at arch/arm/mm/context.c:182 __new_context+0x40/0x118()
Modules linked in:
[<c0013ea8>] (unwind_backtrace+0x0/0x11c) from [<c0021444>] 
(warn_slowpath_common+0x4c/0x64)
[<c0021444>] (warn_slowpath_common+0x4c/0x64) from [<c0021474>] 
(warn_slowpath_null+0x18/0x1c)
[<c0021474>] (warn_slowpath_null+0x18/0x1c) from [<c001bae4>] 
(__new_context+0x40/0x118)
[<c001bae4>] (__new_context+0x40/0x118) from [<c0017830>] 
(__switch_mm_inner+0x100/0x138)
[<c0017830>] (__switch_mm_inner+0x100/0x138) from [<c00a6940>] 
(flush_old_exec+0x390/0x4c4)
[<c00a6940>] (flush_old_exec+0x390/0x4c4) from [<c00dc344>] 
(load_elf_binary+0x2c4/0x1160)
[<c00dc344>] (load_elf_binary+0x2c4/0x1160) from [<c00a58c4>] 
(search_binary_handler+0x80/0x284)
[<c00a58c4>] (search_binary_handler+0x80/0x284) from [<c00a7120>] 
(do_execve+0x268/0x370)
[<c00a7120>] (do_execve+0x268/0x370) from [<c00115bc>] 
(kernel_execve+0x38/0x7c)
[<c00115bc>] (kernel_execve+0x38/0x7c) from [<c034ea40>] 
(init_post+0x80/0xc4)
[<c034ea40>] (init_post+0x80/0xc4) from [<c0492970>] 
(kernel_init+0x180/0x1bc)
---[ end trace 6ca5fe09ac15b646 ]---
xemacps e000b000.eth: Set clk to 124999998 Hz
xemacps e000b000.eth: link up (1000/FULL)

=========================================

If I boot with Xenomai on (CONFIG_XENOMAI = y) and Nucleus as a module 
(CONFIG_XENO_OPT_NUCLEUS = m), the system boots without issue (not even a 
warning at boot), but the Nucleus module fails to compile with the 
following error:

[mfornero@hwbuild linux]$ make -j8 modules
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  Building modules, stage 2.
  MODPOST 22 modules
ERROR: "current_mm" [kernel/xenomai/nucleus/xeno_nucleus.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

=========================================

Stefan-- are you seeing anything like this on your port?

Best Regards,

Matthew Fornero
