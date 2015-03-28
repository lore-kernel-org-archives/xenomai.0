Date: Sat, 28 Mar 2015 18:23:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150328172330.GJ25831@hermes.click-hack.org>
References: <CACreCVKO35Xt9qgerZnw9V3GTRwnGPn_URkL+1C4ymeHUGfK5A@mail.gmail.com>
 <CACreCVLg5ufmVAK_+6P1KpYaQ0ShkkPw9m=5+A+Ao=xtA9tEDQ@mail.gmail.com>
 <551679A2.20508@xenomai.org>
 <20150328113638.GA25635@hermes.click-hack.org>
 <CACreCVKgzpDYUbMu2ihYtHxV5CSma-eNaH57u-CvCWmKbkoU=Q@mail.gmail.com>
 <20150328130620.GA25831@hermes.click-hack.org>
 <20150328131214.GB25831@hermes.click-hack.org>
 <20150328132252.GC25831@hermes.click-hack.org>
 <20150328133725.GD25831@hermes.click-hack.org>
 <CACreCVKhWaLWWu6aWCLaJue8MvRnG0Efb9-jn=12TJDooC6kgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVKhWaLWWu6aWCLaJue8MvRnG0Efb9-jn=12TJDooC6kgA@mail.gmail.com>
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Mar 28, 2015 at 11:20:05PM +0800, GP Orcullo wrote:
> On Sat, Mar 28, 2015 at 9:37 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Sat, Mar 28, 2015 at 02:22:52PM +0100, Gilles Chanteperdrix wrote:
> >> On Sat, Mar 28, 2015 at 02:12:14PM +0100, Gilles Chanteperdrix wrote:
> >> > On Sat, Mar 28, 2015 at 02:06:20PM +0100, Gilles Chanteperdrix wrote:
> >> > > On Sat, Mar 28, 2015 at 08:27:33PM +0800, GP Orcullo wrote:
> >> > > > On Sat, Mar 28, 2015 at 7:36 PM, Gilles Chanteperdrix
> >> > > > <gilles.chanteperdrix@xenomai.org> wrote:
> >> > > > > On Sat, Mar 28, 2015 at 10:51:30AM +0100, Philippe Gerum wrote:
> >> > > > >> On 03/28/2015 10:05 AM, GP Orcullo wrote:
> >> > > > >> > On Fri, Mar 27, 2015 at 8:12 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
> >> > > > >> >> On Fri, Mar 27, 2015 at 6:19 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
> >> > > > >> >>> What happens in between the clocksource switch and head domain registration?
> >> > > > >> >>>
> >> > > > >> >>> [    0.090129] DMA: preallocated 4096 KiB pool for atomic coherent
> >> > > > >> >>> allocations
> >> > > > >> >>> [    0.095333] Switching to clocksource ipipe_tsc
> >> > > > >> >>> [    0.122397] I-pipe: head domain Xenomai registered.
> >> > > > >> >>> [    0.124618] Xenomai: hal/arm started.
> >> > > > >> >>>
> >> > > > >> >>> I'm trying to trace the code to find out where it stops. I tried
> >> > > > >> >>> adding printk to to the set and request functions and the code never
> >> > > > >> >>> runs when CONFIG_SMP is enabled.
> >> > > > >> >>>
> >> > > > >> >>> Thanks,
> >> > > > >> >>>
> >> > > > >> >>> GP Orcullo
> >> > > > >> >>
> >> > > > >> >> It gets stuck on the call to ipipe_critical_enter:
> >> > > > >> >> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/timer.c?id=ipipe-core-3.10.32-arm-7#n279
> >> > > > >> >>
> >> > > > >> >> Which then gets stuck on ipipe_send_ipi:
> >> > > > >> >> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/core.c?id=ipipe-core-3.10.32-arm-7#n1533
> >> > > > >> >>
> >> > > > >> >
> >> > > > >> > I've traced the issue to the ipipe_processor_id() function. It returns
> >> > > > >> > the value 512 for processor 0. This value comes from cpu node property
> >> > > > >> > of the DT file.
> >> > > > >> >
> >> > > > >> > Changing ipipe_processor_id() to return 0 instead of 512 allows the
> >> > > > >> > kernel to boot but it fails the switchtest regression test.
> >> > > > >> >
> >> > > > >> > Changing the cpu0 reg value on the DT file allows the kernel to boot
> >> > > > >> > and pass all the xenomai regression tests but it generates the
> >> > > > >> > following warning at boot:
> >> > > > >>
> >> > > > >> No, this property for armv7 must match MPIDR[23:0], i.e. the physical id
> >> > > > >> of the core.
> >> > > > >>
> >> > > > >> > What's the proper way of fixing this?
> >> > > > >> >
> >> > > > >>
> >> > > > >> By fixing ipipe_processor_id() in the CONFIG_LEGACY case, it's broken.
> >> > > > >> It assumes __cpu_logical_map[] is a hw->logical map, but it is actually
> >> > > > >> the opposite.
> >> > > > >>
> >> > > > >> We may have been lucky until now because the physical mapping seems to
> >> > > > >> have always matched the logical order on the SMP SoCs people used with
> >> > > > >> Xenomai so far, it looks like your A5 core does not follow this order.
> >> > > > >
> >> > > > > No, cpu_logical_map works both ways, it simply exchanges 0 with
> >> > > > > whatever number the boot cpu has
> >> > > > > so, since cpu_logical_map[0] == 512 and cpu_logical_map[512] == 0
> >> > > > > it should work both ways.
> >> > > > > At least, that was true before DT. Now, I find 512 a bit high, are
> >> > > > > you sure cpu_logical_map[] is large enough ? Or is it even
> >> > > > > initialized with DT ?
> >> > > > >
> >> > > > > --
> >> > > > >                                             Gilles.
> >> > > >
> >> > > > cpu_logical_map[] contains these values: {512,1,2,3}
> >> > > >
> >> > > > This is the cpu entry:
> >> > > > https://github.com/hardkernel/linux/blob/odroidc-3.10.y/arch/arm/boot/dts/meson8b_odroidc.dts#L9-L32
> >> > > >
> >> > > > Changing the reg values alters the contents of cpu_logical_map[].
> >> > >
> >> > > Ok, in that case, to make it work, cpu_logical_map would need to
> >> > > have 513 entries to be able to have cpu_logical_map[512] == 0.
> >> > > Or replace cpu_logical_map with a reverse map which is a copy of
> >> > > cpu_logical_map plus the additional entry to make it work.
> >> > >
> >> > > If you are using an older version of the code, there may be a
> >> > > reference to __cpu_logical_map from the VFP code which you need to
> >> > > replace with __cpu_reverse_map.
> >> > >
> >> > > Please try the following untested patch:
> >> >
> >> > Scrap that. Missing kmalloc, off-by-one error. I am sorry, but I
> >> > will not be able to work on that. Do you get the idea, are you able
> >> > to fix it on your own ?
> >>
> >> Last attempt:
> >
> > We also need to fix hard_smp_processor_id for cpus larger than 255
> > (also the VFP code in old patches).
> > So, the final patch is:
> >
> > diff --git a/arch/arm/include/asm/ipipe_base.h b/arch/arm/include/asm/ipipe_base.h
> > index 72ad7a4..e920175 100644
> > --- a/arch/arm/include/asm/ipipe_base.h
> > +++ b/arch/arm/include/asm/ipipe_base.h
> > @@ -53,10 +53,10 @@ extern unsigned __ipipe_first_ipi;
> >                         "       mov     %0, #0\n"                       \
> >                         "       .popsection"                            \
> >                                       : "=r" (cpunum));                 \
> > -               cpunum &= 0xFF;                                         \
> > +               cpunum &= 0xFFFFFF;                                     \
> >         })
> > -extern u32 __cpu_logical_map[];
> > -#define ipipe_processor_id()  (__cpu_logical_map[hard_smp_processor_id()])
> > +extern u32 *__cpu_reverse_map[];
> > +#define ipipe_processor_id()  (__cpu_reverse_map[hard_smp_processor_id()])
> >
> >  #else /* !legacy */
> >  #define hard_smp_processor_id()        raw_smp_processor_id()
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index b10f40f..df02a76 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -469,29 +469,33 @@ void notrace cpu_init(void)
> >  #endif
> >  }
> >
> > -#if NR_CPUS > 16
> >  u32 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
> > -#else
> > -u32 __cpu_logical_map[16] = { [0 ... 15] = MPIDR_INVALID };
> > -#endif
> > +
> > +u32 *__cpu_reverse_map;
> > +EXPORT_SYMBOL(__cpu_reverse_map);
> >
> >  void __init smp_setup_processor_id(void)
> >  {
> >         int i;
> >         u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
> >         u32 cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> > -       u32 max = cpu + 1 > nr_cpu_ids ? cpu + 1 : nr_cpu_ids;
> > +       u32 max = nr_cpu_ids > mpidr + 1 ? nr_cpu_ids : mpidr + 1;
> >
> >  #ifdef CONFIG_IPIPE
> >         /* printk on I-pipe needs per cpu data */
> >         set_my_cpu_offset(per_cpu_offset(0));
> >  #endif
> > -       BUG_ON(max > ARRAY_SIZE(__cpu_logical_map));
> >
> >         cpu_logical_map(0) = cpu;
> > -       for (i = 1; i < max; ++i)
> > +       for (i = 1; i < nr_cpu_ids; ++i)
> >                 cpu_logical_map(i) = i == cpu ? 0 : i;
> >
> > +       __cpu_reverse_map = kmalloc(max * sizeof(*__cpu_reverse_map));
> > +       BUG_ON(!__cpu_reverse_map);
> > +
> > +       for (i = 0; i < nr_cpu_ids; i++)
> > +               __cpu_reverse_map[cpu_logical_map(i)] = i;
> > +
> >         /*
> >          * clear __my_cpu_offset on boot CPU to avoid hang caused by
> >          * using percpu variable early, for example, lockdep will
> >
> > --
> >                                             Gilles.
> 
> The kernel doesn't boot on this one.

Ok, the 512 may not be the real register value, but introduced by
the MPIDR_AFFINITY_LEVEL macro. Could you try the following patch ?

diff --git a/arch/arm/include/asm/ipipe_base.h b/arch/arm/include/asm/ipipe_base.h
index 72ad7a4..e920175 100644
--- a/arch/arm/include/asm/ipipe_base.h
+++ b/arch/arm/include/asm/ipipe_base.h
@@ -53,10 +53,10 @@ extern unsigned __ipipe_first_ipi;
 			"	mov	%0, #0\n"			\
 			"	.popsection"				\
 				      : "=r" (cpunum));			\
-		cpunum &= 0xFF;						\
+		cpunum &= 0xFFFFFF;					\
 	})
-extern u32 __cpu_logical_map[];
-#define ipipe_processor_id()  (__cpu_logical_map[hard_smp_processor_id()])
+extern u32 *__cpu_reverse_map[];
+#define ipipe_processor_id()  (__cpu_reverse_map[hard_smp_processor_id()])
 
 #else /* !legacy */
 #define hard_smp_processor_id()	raw_smp_processor_id()
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index b10f40f..3c77609 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -469,29 +469,34 @@ void notrace cpu_init(void)
 #endif
 }
 
-#if NR_CPUS > 16
 u32 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
-#else
-u32 __cpu_logical_map[16] = { [0 ... 15] = MPIDR_INVALID };
-#endif
+
+u32 *__cpu_reverse_map;
+EXPORT_SYMBOL(__cpu_reverse_map);
 
 void __init smp_setup_processor_id(void)
 {
 	int i;
 	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
 	u32 cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-	u32 max = cpu + 1 > nr_cpu_ids ? cpu + 1 : nr_cpu_ids;
+	u32 max = nr_cpu_ids > mpidr + 1 ? nr_cpu_ids : mpidr + 1;
 
 #ifdef CONFIG_IPIPE
 	/* printk on I-pipe needs per cpu data */
 	set_my_cpu_offset(per_cpu_offset(0));
 #endif
-	BUG_ON(max > ARRAY_SIZE(__cpu_logical_map));
 
 	cpu_logical_map(0) = cpu;
-	for (i = 1; i < max; ++i)
+	for (i = 1; i < nr_cpu_ids; ++i)
 		cpu_logical_map(i) = i == cpu ? 0 : i;
 
+	__cpu_reverse_map = kmalloc(max * sizeof(*__cpu_reverse_map));
+	BUG_ON(!__cpu_reverse_map);
+
+	__cpu_reverse_map[0] = mpidr;
+	for (i = 1; i < max; i++)
+		__cpu_reverse_map[i] = i == mpidr ? 0 : i;
+
 	/*
 	 * clear __my_cpu_offset on boot CPU to avoid hang caused by
 	 * using percpu variable early, for example, lockdep will

-- 
					    Gilles.

