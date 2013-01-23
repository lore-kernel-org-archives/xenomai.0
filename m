MIME-Version: 1.0
In-Reply-To: <50FF4434.7030405@xenomai.org>
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>
	<50F3DD9A.9050306@gmail.com>
	<OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>
	<50FE45E9.1040909@xenomai.org>
	<OF518EBAA9.1B02356C-ON85257AFC.00002A9B-85257AFC.00028E23@aanddtech.com>
	<50FF4434.7030405@xenomai.org>
Date: Tue, 22 Jan 2013 22:43:30 -0500
Message-ID: <CAFVR4DVpsR026fvgybs91iC7-gDLVvBS8wsXBRO0XdzLBcXzpg@mail.gmail.com>
From: Matthew Fornero <matthew.fornero@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org
Cc: mfornero@aanddtech.com

On Tue, Jan 22, 2013 at 9:00 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> On 01/23/2013 01:27 AM, mfornero@aanddtech.com wrote:
>
> > Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on
> > 01/22/2013 02:55:21 AM:
> >
> >> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >> To: mfornero@aanddtech.com,
> >> Cc: Xenomai@xenomai.org
> >> Date: 01/22/2013 02:55 AM
> >> Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
> >>
> >> On 01/22/2013 01:00 AM, mfornero@aanddtech.com wrote:
> >>
> >> > The issue seems to be somewhat erratic, as I was able to run the
> > latency
> >> > test for a couple of hours this morning without observing it. Now
> > however,
> >> > it seems to show up on every boot (I don't believe I changed
> > anything, but
> >> > it's possible).
> >> >
> >> > For reference, I'm booting from a SDHC partitioned as such:
> >> >         1) vfat         256 MB <-- This partition holds the first stage
> >> > bootloader, uboot, the device tree and the Kernel zImage
> >> >         2) ext4         768 MB <-- This partition is the rootfs
> > (busybox +
> >> > xenomai)
> >> >
> >> > The kernel boot command line is:
> >> >         bootargs = "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw
> >> > earlyprintk rootfstype=ext4 rootwait devtmpfs.mount=1";
> >> >
> >> > And I'm using the uboot compilation shipped with the ZedBoard.
> >> >
> >> > My ipipe port can be found here:
> >> > git://github.com/mfornero/ipipe.git
> >>
> >>
> >> At a quick glance, you are missing this change:
> >>
> > http://xenomai.org/index.php/I-pipe-core:ArmPorting#GPIOs_as_interrupt_sources
> >>
> >> In drivers/gpio/gpio-xilinxps.c
> >
> > Thanks Gilles. I fixed the irq handler as follows (pushed to github):
> >
> > --- a/drivers/gpio/gpio-xilinxps.c
> > +++ b/drivers/gpio/gpio-xilinxps.c
> > @@ -422,7 +422,7 @@ void xgpiops_irqhandler(unsigned int irq, struct
> > irq_desc *desc)
> >                         chip->irq_ack(&gpio_irq_desc->irq_data);
> >
> >                         /* call the pin specific handler */
> > -                       generic_handle_irq(gpio_irq);
> > +                       ipipe_handle_demuxed_irq(gpio_irq);
> >                 }
> >                 /* shift to first virtual irq of next bank */
> >                 gpio_irq = (int)irq_get_handler_data(irq) +
> >
> >
> > Unfortunately, this does not seem to have any effect on the issue. I did
> > a couple more tests today, and found the following:
>
>
> Could you run cat /proc/interrupts on the running kernel? Are there not
> other multiplexed gpios you should modify? Have you read the porting
> guide and applied everything (the fact that you missed that point makes
> me think that maybe you did not)? Have you tried enabling I-pipe debugs?
> Other than that, you have to trace starting from __ipipe_grab_irq to
> understand what happens. Debugging such kind of issues by proxy is a bit
> hard.

I'll cat out the proc/interrupts when I get to the office tomorrow. I
did read the porting guide, but stupidly missed that function call. On
this dev kit, we're not initially planning to use GPIO from our code
(real time or otherwise), but of course they could be used by various
peripherals.

I'm somewhat new to arm (mostly worked on x86 until now), so please
excuse my ignorance-- would there be another irq chip or something I
need to multiplex in other driver files (other than the
gpio-xilinxps.c file)? Is there an existing platform I can reference
for this? Maybe some code in the board level file as well?

I'll try the remainder of the above debug steps as well. Unfortunately
our JTAG environment isn't totally stable, but I should be able to get
something going.

> > If I boot with Xenomai off (CONFIG_XENOMAI = n) but IPIPE still on
> > (CONFIG_IPIPE = y), I get a warning at boot. Haven't looked into the
> > root cause of this-- but maybe it's related?
> >
> > mmc0: new high speed SDHC card at address b368
> > mmcblk0: mmc0:b368 F0F0F 3.71 GiB
> >  mmcblk0: p1 p2
> > EXT4-fs (mmcblk0p2): recovery complete
> > EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts:
> > (null)
> > VFS: Mounted root (ext4 filesystem) on device 179:2.
> > devtmpfs: mounted
> > Freeing init memory: 160K
> > ------------[ cut here ]------------
> > WARNING: at arch/arm/mm/context.c:182 __new_context+0x40/0x118()
>
>
> Known issue, which I thought was fixed, but maybe not. Try this patch:
>
> diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> index 3ae015f..79de5dc 100644
> --- a/arch/arm/mm/context.c
> +++ b/arch/arm/mm/context.c
> @@ -167,11 +167,12 @@ static inline void set_mm_context(struct mm_struct
> *mm, unsigned int asid)
>
>  void __new_context(struct mm_struct *mm)
>  {
> -       int cpu = ipipe_processor_id();
>         unsigned long flags;
>         unsigned int asid;
> +       int cpu;
>
>         asid_lock(flags);
> +       cpu = ipipe_processor_id();
>  #ifdef CONFIG_SMP
>         /*
>          * Check the ASID again, in case the change was broadcast from

Will try tomorrow and report if it resolves it.

>
> > If I boot with Xenomai on (CONFIG_XENOMAI = y) and Nucleus as a module
> > (CONFIG_XENO_OPT_NUCLEUS = m), the system boots without issue (not even
> > a warning at boot), but the Nucleus module fails to compile with the
> > following error:
> >
> > [mfornero@hwbuild linux]$ make -j8 modules
> >   CHK     include/linux/version.h
> >   CHK     include/generated/utsrelease.h
> > make[1]: `include/generated/mach-types.h' is up to date.
> >   CALL    scripts/checksyscalls.sh
> >   Building modules, stage 2.
> >   MODPOST 22 modules
> > ERROR: "current_mm" [kernel/xenomai/nucleus/xeno_nucleus.ko] undefined!
> > make[1]: *** [__modpost] Error 1
> > make: *** [modules] Error 2
>
>
> It simply means EXPORT_SYMBOL_GPL(current_mm) is missing.

So this export should go in something like arch/arm/include/asm/mmu_context.h?

Do I need to do anything special for the export given that it's
defined via "DECLARE_PER_CPU"?

Thanks for the help.

Best Regards,

Matthew Fornero

