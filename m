Date: Sun, 29 Mar 2015 13:06:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150329110623.GB32766@hermes.click-hack.org>
References: <20150325160852.GK15125@hermes.click-hack.org>
 <CACreCV+tYp1QConFh2uKWjnqVOQ4uA=xLmbyay_XT9mui0txfw@mail.gmail.com>
 <CACreCVLG=dtjriCzUUqYtOK1Pz+NqYoPFNLJZ4KrM-AccBoHPA@mail.gmail.com>
 <CACreCVKO35Xt9qgerZnw9V3GTRwnGPn_URkL+1C4ymeHUGfK5A@mail.gmail.com>
 <CACreCVLg5ufmVAK_+6P1KpYaQ0ShkkPw9m=5+A+Ao=xtA9tEDQ@mail.gmail.com>
 <551679A2.20508@xenomai.org>
 <20150328113638.GA25635@hermes.click-hack.org>
 <CACreCVKgzpDYUbMu2ihYtHxV5CSma-eNaH57u-CvCWmKbkoU=Q@mail.gmail.com>
 <20150328185913.GN25831@hermes.click-hack.org>
 <CACreCV+ddKJz6vq4vmb6b+Jd6kxrpbDTXUDyfoQ9WNk48w3u1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCV+ddKJz6vq4vmb6b+Jd6kxrpbDTXUDyfoQ9WNk48w3u1Q@mail.gmail.com>
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

On Sun, Mar 29, 2015 at 06:38:45AM +0800, GP Orcullo wrote:
> On Sun, Mar 29, 2015 at 2:59 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
> > On Sat, Mar 28, 2015 at 08:27:33PM +0800, GP Orcullo wrote:
> > > On Sat, Mar 28, 2015 at 7:36 PM, Gilles Chanteperdrix
> > > <gilles.chanteperdrix@xenomai.org> wrote:
> > > > On Sat, Mar 28, 2015 at 10:51:30AM +0100, Philippe Gerum wrote:
> > > >> On 03/28/2015 10:05 AM, GP Orcullo wrote:
> > > >> > On Fri, Mar 27, 2015 at 8:12 PM, GP Orcullo <kinsamanka@gmail.com>
> > wrote:
> > > >> >> On Fri, Mar 27, 2015 at 6:19 PM, GP Orcullo <kinsamanka@gmail.com>
> > wrote:
> > > >> >>> What happens in between the clocksource switch and head domain
> > registration?
> > > >> >>>
> > > >> >>> [    0.090129] DMA: preallocated 4096 KiB pool for atomic coherent
> > > >> >>> allocations
> > > >> >>> [    0.095333] Switching to clocksource ipipe_tsc
> > > >> >>> [    0.122397] I-pipe: head domain Xenomai registered.
> > > >> >>> [    0.124618] Xenomai: hal/arm started.
> > > >> >>>
> > > >> >>> I'm trying to trace the code to find out where it stops. I tried
> > > >> >>> adding printk to to the set and request functions and the code
> > never
> > > >> >>> runs when CONFIG_SMP is enabled.
> > > >> >>>
> > > >> >>> Thanks,
> > > >> >>>
> > > >> >>> GP Orcullo
> > > >> >>
> > > >> >> It gets stuck on the call to ipipe_critical_enter:
> > > >> >>
> > http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/timer.c?id=ipipe-core-3.10.32-arm-7#n279
> > > >> >>
> > > >> >> Which then gets stuck on ipipe_send_ipi:
> > > >> >>
> > http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/core.c?id=ipipe-core-3.10.32-arm-7#n1533
> > > >> >>
> > > >> >
> > > >> > I've traced the issue to the ipipe_processor_id() function. It
> > returns
> > > >> > the value 512 for processor 0. This value comes from cpu node
> > property
> > > >> > of the DT file.
> > > >> >
> > > >> > Changing ipipe_processor_id() to return 0 instead of 512 allows the
> > > >> > kernel to boot but it fails the switchtest regression test.
> > > >> >
> > > >> > Changing the cpu0 reg value on the DT file allows the kernel to boot
> > > >> > and pass all the xenomai regression tests but it generates the
> > > >> > following warning at boot:
> > > >>
> > > >> No, this property for armv7 must match MPIDR[23:0], i.e. the physical
> > id
> > > >> of the core.
> > > >>
> > > >> > What's the proper way of fixing this?
> > > >> >
> > > >>
> > > >> By fixing ipipe_processor_id() in the CONFIG_LEGACY case, it's broken.
> > > >> It assumes __cpu_logical_map[] is a hw->logical map, but it is
> > actually
> > > >> the opposite.
> > > >>
> > > >> We may have been lucky until now because the physical mapping seems to
> > > >> have always matched the logical order on the SMP SoCs people used with
> > > >> Xenomai so far, it looks like your A5 core does not follow this order.
> > > >
> > > > No, cpu_logical_map works both ways, it simply exchanges 0 with
> > > > whatever number the boot cpu has
> > > > so, since cpu_logical_map[0] == 512 and cpu_logical_map[512] == 0
> > > > it should work both ways.
> > > > At least, that was true before DT. Now, I find 512 a bit high, are
> > > > you sure cpu_logical_map[] is large enough ? Or is it even
> > > > initialized with DT ?
> > > >
> > > > --
> > > >                                             Gilles.
> > >
> > > cpu_logical_map[] contains these values: {512,1,2,3}
> >
> > Ok, the MPIDR_AFFINITY_LEVEL macro simply masks 0xff. It removes the
> > cluster ID in fact. So, I do not see how you can get 512 here.
> >
> > Please show us the smp_setup_processor_id function you compile. Or
> > maybe the __cpu_logical_map array is not initialized by this
> > function in your case?
> >
> > --
> >                                             Gilles.
> >
> The array is filled up with entries from the DT, it is done here:
> https://github.com/hardkernel/linux/blob/odroidc-3.10.y/arch/arm/kernel/devtree.c#L73
> 
> Changing the DT entry for CPU0 allowed the kernel to boot but it fails the
> test here:
> https://github.com/hardkernel/linux/blob/odroidc-3.10.y/arch/arm/kernel/devtree.c#L138-L140

Yes, obviously, since the MPIDR of your boot cpu is 512. This should
get xenomai working however, since then the logical map is not
overridden and works as patched by the I-pipe code.

Could you get the MPIDR of the other cores ? I suspect they are 513,
514, 515, and not 1 2 3.

We have two choices:
1- admit that with Xenomai 2.6, we will only support one cluster ID,
and only replace the logical map with a reverse map for your case,
continuing masking with 0xff in I-pipe code;
2- build a complete reverse map, probably using two maps, a cluster
map which gives a pointer to a per-cpu reverse map, the reverse map
being implemented for each cluster, and mask with 0xffffff in
I-pipe code.

I can try and send a new patch for choice 1.

-- 
					    Gilles.

