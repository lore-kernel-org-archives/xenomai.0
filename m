MIME-Version: 1.0
In-Reply-To: <20150329124445.GH32766@hermes.click-hack.org>
References: <CACreCVLg5ufmVAK_+6P1KpYaQ0ShkkPw9m=5+A+Ao=xtA9tEDQ@mail.gmail.com>
 <551679A2.20508@xenomai.org>
 <20150328113638.GA25635@hermes.click-hack.org>
 <CACreCVKgzpDYUbMu2ihYtHxV5CSma-eNaH57u-CvCWmKbkoU=Q@mail.gmail.com>
 <20150328185913.GN25831@hermes.click-hack.org>
 <CACreCV+ddKJz6vq4vmb6b+Jd6kxrpbDTXUDyfoQ9WNk48w3u1Q@mail.gmail.com>
 <20150329110623.GB32766@hermes.click-hack.org>
 <CACreCVKG=6AEGF9BVBraHgQ8N=PwqD-6=kzfvinSpU+BBHtpng@mail.gmail.com>
 <20150329120218.GE32766@hermes.click-hack.org>
 <CACreCVLmJAa_hLLVQsiKYLks-4Ev=uAVw=5DFOZ+EL_DZ2VuPA@mail.gmail.com>
 <20150329124445.GH32766@hermes.click-hack.org>
Date: Sun, 29 Mar 2015 20:56:21 +0800
Message-ID: <CACreCV+Uke5rmAQ+2DXcJN-kHGmz-iwf39qDVhd8F_UwvDScdg@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Mar 29, 2015 at 8:44 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Sun, Mar 29, 2015 at 08:38:18PM +0800, GP Orcullo wrote:
> > On Sun, Mar 29, 2015 at 8:02 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> > > On Sun, Mar 29, 2015 at 07:59:13PM +0800, GP Orcullo wrote:
> > > > On Mar 29, 2015 7:07 PM, "Gilles Chanteperdrix" <
> > > > gilles.chanteperdrix@xenomai.org> wrote:
> > > > >
> > > > > On Sun, Mar 29, 2015 at 06:38:45AM +0800, GP Orcullo wrote:
> > > > > > On Sun, Mar 29, 2015 at 2:59 AM, Gilles Chanteperdrix <
> > > > > > gilles.chanteperdrix@xenomai.org> wrote:
> > > > > >
> > > > > > > On Sat, Mar 28, 2015 at 08:27:33PM +0800, GP Orcullo wrote:
> > > > > > > > On Sat, Mar 28, 2015 at 7:36 PM, Gilles Chanteperdrix
> > > > > > > > <gilles.chanteperdrix@xenomai.org> wrote:
> > > > > > > > > On Sat, Mar 28, 2015 at 10:51:30AM +0100, Philippe Gerum
> wrote:
> > > > > > > > >> On 03/28/2015 10:05 AM, GP Orcullo wrote:
> > > > > > > > >> > On Fri, Mar 27, 2015 at 8:12 PM, GP Orcullo <
> > > > kinsamanka@gmail.com>
> > > > > > > wrote:
> > > > > > > > >> >> On Fri, Mar 27, 2015 at 6:19 PM, GP Orcullo <
> > > > kinsamanka@gmail.com>
> > > > > > > wrote:
> > > > > > > > >> >>> What happens in between the clocksource switch and
> head
> > > > domain
> > > > > > > registration?
> > > > > > > > >> >>>
> > > > > > > > >> >>> [    0.090129] DMA: preallocated 4096 KiB pool for
> atomic
> > > > coherent
> > > > > > > > >> >>> allocations
> > > > > > > > >> >>> [    0.095333] Switching to clocksource ipipe_tsc
> > > > > > > > >> >>> [    0.122397] I-pipe: head domain Xenomai registered.
> > > > > > > > >> >>> [    0.124618] Xenomai: hal/arm started.
> > > > > > > > >> >>>
> > > > > > > > >> >>> I'm trying to trace the code to find out where it
> stops. I
> > > > tried
> > > > > > > > >> >>> adding printk to to the set and request functions and
> the
> > > > code
> > > > > > > never
> > > > > > > > >> >>> runs when CONFIG_SMP is enabled.
> > > > > > > > >> >>>
> > > > > > > > >> >>> Thanks,
> > > > > > > > >> >>>
> > > > > > > > >> >>> GP Orcullo
> > > > > > > > >> >>
> > > > > > > > >> >> It gets stuck on the call to ipipe_critical_enter:
> > > > > > > > >> >>
> > > > > > >
> > > >
> > >
> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/timer.c?id=ipipe-core-3.10.32-arm-7#n279
> > > > > > > > >> >>
> > > > > > > > >> >> Which then gets stuck on ipipe_send_ipi:
> > > > > > > > >> >>
> > > > > > >
> > > >
> > >
> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/core.c?id=ipipe-core-3.10.32-arm-7#n1533
> > > > > > > > >> >>
> > > > > > > > >> >
> > > > > > > > >> > I've traced the issue to the ipipe_processor_id()
> function.
> > > It
> > > > > > > returns
> > > > > > > > >> > the value 512 for processor 0. This value comes from cpu
> > > node
> > > > > > > property
> > > > > > > > >> > of the DT file.
> > > > > > > > >> >
> > > > > > > > >> > Changing ipipe_processor_id() to return 0 instead of 512
> > > > allows the
> > > > > > > > >> > kernel to boot but it fails the switchtest regression
> test.
> > > > > > > > >> >
> > > > > > > > >> > Changing the cpu0 reg value on the DT file allows the
> kernel
> > > > to boot
> > > > > > > > >> > and pass all the xenomai regression tests but it
> generates
> > > the
> > > > > > > > >> > following warning at boot:
> > > > > > > > >>
> > > > > > > > >> No, this property for armv7 must match MPIDR[23:0], i.e.
> the
> > > > physical
> > > > > > > id
> > > > > > > > >> of the core.
> > > > > > > > >>
> > > > > > > > >> > What's the proper way of fixing this?
> > > > > > > > >> >
> > > > > > > > >>
> > > > > > > > >> By fixing ipipe_processor_id() in the CONFIG_LEGACY case,
> it's
> > > > broken.
> > > > > > > > >> It assumes __cpu_logical_map[] is a hw->logical map, but
> it is
> > > > > > > actually
> > > > > > > > >> the opposite.
> > > > > > > > >>
> > > > > > > > >> We may have been lucky until now because the physical
> mapping
> > > > seems to
> > > > > > > > >> have always matched the logical order on the SMP SoCs
> people
> > > > used with
> > > > > > > > >> Xenomai so far, it looks like your A5 core does not follow
> > > this
> > > > order.
> > > > > > > > >
> > > > > > > > > No, cpu_logical_map works both ways, it simply exchanges 0
> with
> > > > > > > > > whatever number the boot cpu has
> > > > > > > > > so, since cpu_logical_map[0] == 512 and
> cpu_logical_map[512]
> > > == 0
> > > > > > > > > it should work both ways.
> > > > > > > > > At least, that was true before DT. Now, I find 512 a bit
> high,
> > > are
> > > > > > > > > you sure cpu_logical_map[] is large enough ? Or is it even
> > > > > > > > > initialized with DT ?
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > >                                             Gilles.
> > > > > > > >
> > > > > > > > cpu_logical_map[] contains these values: {512,1,2,3}
> > > > > > >
> > > > > > > Ok, the MPIDR_AFFINITY_LEVEL macro simply masks 0xff. It
> removes
> > > the
> > > > > > > cluster ID in fact. So, I do not see how you can get 512 here.
> > > > > > >
> > > > > > > Please show us the smp_setup_processor_id function you
> compile. Or
> > > > > > > maybe the __cpu_logical_map array is not initialized by this
> > > > > > > function in your case?
> > > > > > >
> > > > > > > --
> > > > > > >                                             Gilles.
> > > > > > >
> > > > > > The array is filled up with entries from the DT, it is done here:
> > > > > >
> > > >
> > >
> https://github.com/hardkernel/linux/blob/odroidc-3.10.y/arch/arm/kernel/devtree.c#L73
> > > > > >
> > > > > > Changing the DT entry for CPU0 allowed the kernel to boot but it
> > > fails
> > > > the
> > > > > > test here:
> > > > > >
> > > >
> > >
> https://github.com/hardkernel/linux/blob/odroidc-3.10.y/arch/arm/kernel/devtree.c#L138-L140
> > > > >
> > > > > Yes, obviously, since the MPIDR of your boot cpu is 512. This
> should
> > > > > get xenomai working however, since then the logical map is not
> > > > > overridden and works as patched by the I-pipe code.
> > > > >
> > > > > Could you get the MPIDR of the other cores ? I suspect they are
> 513,
> > > > > 514, 515, and not 1 2 3.
> > > >
> > > > Tried this and the 3 cpus won't boot.
> > >
> > > You mean adding a printk in secondary_start_kernel to print the
> > > mpidr fails ? Sounds strange.
> > >
> > > --
> > >                                             Gilles.
> > >
> >
> > Sorry, what I meant was changing the reg entries of the 3 cpus on the DT
> > file to 513 - 515 didn't work (the 3 cpus didn't boot).
> >
> > I think masking the result of ipipe_processor_id() with 0xff is enough.
>
> Not a really good idat, it is better to implement a reverse map
> distinct from the logical map, so that when the DT code overwrites
> the logical map, it does not break the I-pipe. The following
> untested patch should do this. Note that in the case of the old
> kernel you are using, you also have to modify vfphw.S to use
> __cpu_reverse_map instead of __cpu_logical_map.
>
> diff --git a/arch/arm/include/asm/ipipe_base.h
> b/arch/arm/include/asm/ipipe_base.h
> index 72ad7a4..651b7d8 100644
> --- a/arch/arm/include/asm/ipipe_base.h
> +++ b/arch/arm/include/asm/ipipe_base.h
> @@ -55,8 +55,8 @@ extern unsigned __ipipe_first_ipi;
>                                       : "=r" (cpunum));                 \
>                 cpunum &= 0xFF;                                         \
>         })
> -extern u32 __cpu_logical_map[];
> -#define ipipe_processor_id()  (__cpu_logical_map[hard_smp_processor_id()])
> +extern u32 *__cpu_reverse_map[];
> +#define ipipe_processor_id()  (__cpu_reverse_map[hard_smp_processor_id()])
>
>  #else /* !legacy */
>  #define hard_smp_processor_id()        raw_smp_processor_id()
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index b10f40f..e4b7d1d 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -469,11 +469,10 @@ void notrace cpu_init(void)
>  #endif
>  }
>
> -#if NR_CPUS > 16
>  u32 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
> -#else
> -u32 __cpu_logical_map[16] = { [0 ... 15] = MPIDR_INVALID };
> -#endif
> +
> +u32 *__cpu_reverse_map;
> +EXPORT_SYMBOL(__cpu_reverse_map);
>
>  void __init smp_setup_processor_id(void)
>  {
> @@ -486,12 +485,17 @@ void __init smp_setup_processor_id(void)
>         /* printk on I-pipe needs per cpu data */
>         set_my_cpu_offset(per_cpu_offset(0));
>  #endif
> -       BUG_ON(max > ARRAY_SIZE(__cpu_logical_map));
>
>         cpu_logical_map(0) = cpu;
> -       for (i = 1; i < max; ++i)
> +       for (i = 1; i < nr_cpu_ids; ++i)
>                 cpu_logical_map(i) = i == cpu ? 0 : i;
>
> +       __cpu_reverse_map = kmalloc(max * sizeof(*__cpu_reverse_map));
> +       BUG_ON(!__cpu_reverse_map);
> +
> +       for (i = 1; i < nr_cpu_ids; i++)
> +               __cpu_reverse_map[cpu_logical_map(i)] = i;
> +
>         /*
>          * clear __my_cpu_offset on boot CPU to avoid hang caused by
>          * using percpu variable early, for example, lockdep will
>
>
>
> >
> > Regarding the switchtest failing with the test I previously did when I
> > masked ipipe_processor_id() with 0xff, I'm getting the same result on
> > xenomai 3.x. So I think this switchtest failure is a separate issue.
>
> How does it fail? What message does it print?
>
> --
>                                             Gilles.
>

On xenomai 3.x, the test just hangs after printing the Threads list, then
an "Alarm clock" message appears and the test is aborted. I haven't
investigated it yet.


-- 
GP Orcullo
