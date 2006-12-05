From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
Date: Tue, 5 Dec 2006 19:34:12 +0100
References: <E1GrHXk-00023w-Oq@domain.hid>
	<E1GrdKV-00048O-FF@mailer.emlix.com> <4575A2C0.6000305@domain.hid>
In-Reply-To: <4575A2C0.6000305@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612051934.14391.Sebastian.Smolorz@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main@gna.org

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > Gilles Chanteperdrix wrote:
> >> Jan Kiszka wrote:
> >>> Gilles Chanteperdrix wrote:
> >>>> Jan Kiszka wrote:
> >>>>> Sebastian Smolorz wrote:
> >>>>>> Jan Kiszka wrote:
> >>>>>>> Are you tracing into vmalloc'ed memory?
> >>>>>>
> >>>>>> Yes, without CONFIG_IPIPE_TRACE_VMALLOC the system does not boot.
> >>>>>
> >>>>> Hmm, makes me wonder of some laziness of the page mapping or a
> >>>>> missing lock-against-swapping causes this. Could you have a closer
> >>>>> look at the tracer code if we are lacking some magic for the vmalloc
> >>>>> trace buffer (compare to the xnheap code, e.g.)?
> >>>>
> >>>> This is a known issue, the ARM architecture lacks the set_pgdir
> >>>> function, needed in mm/vmalloc.c to workaround the lazy page mapping
> >>>> of vmalloced areas.
> >>>
> >>> Would vmalloc+memset help to be safe for the remaining system runtime?
> >>
> >> Probably not, the vmalloced area is added only to the page table of the
> >> process that calls vmalloc, it is added to other processes table page
> >> only once they use it.
> >
> > Are there any alternatives? Or do we have to live with this restriction?
>
> Try if smaller CONFIG_IPIPE_TRACE_SHIFT makes it boot without
> CONFIG_IPIPE_TRACE_VMALLOC.

I already tried that but it didn't help. First with IPIPE_TRACE_SHIFT set to 
10 and after modifying Kconfig.debug with a value of 5. Booting impossible.

--
Sebastian

