Date: Sat, 28 Mar 2015 19:28:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150328182808.GL25831@hermes.click-hack.org>
References: <CACreCVLG=dtjriCzUUqYtOK1Pz+NqYoPFNLJZ4KrM-AccBoHPA@mail.gmail.com>
 <CACreCVKO35Xt9qgerZnw9V3GTRwnGPn_URkL+1C4ymeHUGfK5A@mail.gmail.com>
 <CACreCVLg5ufmVAK_+6P1KpYaQ0ShkkPw9m=5+A+Ao=xtA9tEDQ@mail.gmail.com>
 <551679A2.20508@xenomai.org>
 <20150328113638.GA25635@hermes.click-hack.org>
 <55169F35.1080108@xenomai.org>
 <20150328150516.GG25831@hermes.click-hack.org>
 <5516EBB6.6030208@xenomai.org>
 <20150328181016.GK25831@hermes.click-hack.org>
 <5516F073.4040001@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5516F073.4040001@xenomai.org>
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: GP Orcullo <kinsamanka@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sat, Mar 28, 2015 at 07:18:27PM +0100, Philippe Gerum wrote:
> On 03/28/2015 07:10 PM, Gilles Chanteperdrix wrote:
> > On Sat, Mar 28, 2015 at 06:58:14PM +0100, Philippe Gerum wrote:
> >> On 03/28/2015 04:05 PM, Gilles Chanteperdrix wrote:
> >>> On Sat, Mar 28, 2015 at 01:31:49PM +0100, Philippe Gerum wrote:
> >>>> On 03/28/2015 12:36 PM, Gilles Chanteperdrix wrote:
> >>>>> On Sat, Mar 28, 2015 at 10:51:30AM +0100, Philippe Gerum wrote:
> >>>>>> On 03/28/2015 10:05 AM, GP Orcullo wrote:
> >>>>>>> On Fri, Mar 27, 2015 at 8:12 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
> >>>>>>>> On Fri, Mar 27, 2015 at 6:19 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
> >>>>>>>>> What happens in between the clocksource switch and head domain registration?
> >>>>>>>>>
> >>>>>>>>> [    0.090129] DMA: preallocated 4096 KiB pool for atomic coherent
> >>>>>>>>> allocations
> >>>>>>>>> [    0.095333] Switching to clocksource ipipe_tsc
> >>>>>>>>> [    0.122397] I-pipe: head domain Xenomai registered.
> >>>>>>>>> [    0.124618] Xenomai: hal/arm started.
> >>>>>>>>>
> >>>>>>>>> I'm trying to trace the code to find out where it stops. I tried
> >>>>>>>>> adding printk to to the set and request functions and the code never
> >>>>>>>>> runs when CONFIG_SMP is enabled.
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>>
> >>>>>>>>> GP Orcullo
> >>>>>>>>
> >>>>>>>> It gets stuck on the call to ipipe_critical_enter:
> >>>>>>>> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/timer.c?id=ipipe-core-3.10.32-arm-7#n279
> >>>>>>>>
> >>>>>>>> Which then gets stuck on ipipe_send_ipi:
> >>>>>>>> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/core.c?id=ipipe-core-3.10.32-arm-7#n1533
> >>>>>>>>
> >>>>>>>
> >>>>>>> I've traced the issue to the ipipe_processor_id() function. It returns
> >>>>>>> the value 512 for processor 0. This value comes from cpu node property
> >>>>>>> of the DT file.
> >>>>>>>
> >>>>>>> Changing ipipe_processor_id() to return 0 instead of 512 allows the
> >>>>>>> kernel to boot but it fails the switchtest regression test.
> >>>>>>>
> >>>>>>> Changing the cpu0 reg value on the DT file allows the kernel to boot
> >>>>>>> and pass all the xenomai regression tests but it generates the
> >>>>>>> following warning at boot:
> >>>>>>
> >>>>>> No, this property for armv7 must match MPIDR[23:0], i.e. the physical id
> >>>>>> of the core.
> >>>>>>
> >>>>>>> What's the proper way of fixing this?
> >>>>>>>
> >>>>>>
> >>>>>> By fixing ipipe_processor_id() in the CONFIG_LEGACY case, it's broken.
> >>>>>> It assumes __cpu_logical_map[] is a hw->logical map, but it is actually
> >>>>>> the opposite.
> >>>>>>
> >>>>>> We may have been lucky until now because the physical mapping seems to
> >>>>>> have always matched the logical order on the SMP SoCs people used with
> >>>>>> Xenomai so far, it looks like your A5 core does not follow this order.
> >>>>>
> >>>>> No, cpu_logical_map works both ways, it simply exchanges 0 with
> >>>>> whatever number the boot cpu has
> >>>>> so, since cpu_logical_map[0] == 512 and cpu_logical_map[512] == 0
> >>>>> it should work both ways.
> >>>>
> >>>> It does not make sense. We just cannot do this with DT.
> >>>
> >>> In fact we can. The "only" downside is that we have to have
> >>> cpu_logical_map big enough to allow setting cpu_logical_map[512] to
> >>> 0, so to have NR_CPUS at least 513. Setting up a separate
> >>> reverse map avoids this issue of course, so I will merge that patch
> >>> when it has been tested.
> >>>
> >>>>
> >>>>> At least, that was true before DT.
> >>>>
> >>>> That is the issue with this code.
> >>>
> >>> No the issue is that 512 is larger than 255 and given the way we
> >>> mask in hard_smp_processor_id(), this causes hard_smp_processor_id()
> >>> to return 0 instead of 512 for the boot cpu. The size of the MPIDR
> >>> mask has varied over time, and hard_smp_processor_id() was not
> >>> updated to reflect that change.
> >>>
> >>
> >> The fact that we might change the semantics of __cpu_logical_map[] to
> >> make it a double-entry map does not make it a proper solution. The
> >> regular kernel defines it as a logical->hardware identity mapping array,
> >> I'd rather prefer your latest change which introduces a reverse map instead.
> >>
> >> The calculations and masks used to extract the MPIDR fields have
> >> obviously never changed over time, since this reflects hardware properties.
> > 
> > See commit cb8cf4f821044f140ea5b9c8d4f816f0c05fab44
> > 
> > As the OP explained, it is to take the "cluster ID" into account.
> > Maybe if we look at the ARM11 MPCORE specification, it had no such
> > notion of cluster ID. So, yes, hardware registers do evolve over
> > time. And the code to parse them evolves too.
> > 
> 
> This commit does not change the way the MPIDR is split in fields, which
> is my point. Said differently, MPIDR_AFFINITY_LEVEL did not change since
> it was introduced:
> 
> git diff dca463d..HEAD arch/arm/include/asm/cputype.h

The linux kernel code before that commit did not take into account
the fact that there could be several "clusters", it simply masked
the mpidr register with 0xff and this is what we based the I-pipe
code on. Implementing a reverse map is more complicated than what I
did, if we want to allow that cluster ID to have a different value.
We probably have to add the call to the MPIDR_AFFINITY_LEVEL to the
ipipe_processor_id definition, I have to look more carefully at how
all this works.

-- 
					    Gilles.

