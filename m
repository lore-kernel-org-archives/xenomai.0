Message-ID: <2ff1a98a0801080941n77422158kdcfbf869ddb351ca@domain.hid>
Date: Tue, 8 Jan 2008 18:41:15 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4783AE81.3020302@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>
	<2ff1a98a0801080518k8970391kc2f0a4166adfe393@domain.hid>
	<47837E28.5040406@domain.hid>
	<2ff1a98a0801080546x16d91744uf21d25c8dc198651@domain.hid>
	<47838178.2010208@domain.hid> <47838B7C.8010704@domain.hid>
	<47839231.1050200@domain.hid> <47839BB1.80901@domain.hid>
	<2ff1a98a0801080811p1fd3262dt7d4f546bb2e08394@domain.hid>
	<4783AE81.3020302@domain.hid>
Subject: Re: [Xenomai-help] posix functions for real time and non real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: philippe.gerum@domain.hid
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai@xenomai.org

On Jan 8, 2008 6:10 PM, Philippe Gerum <philippe.gerum@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > On Jan 8, 2008 4:50 PM, Philippe Gerum <philippe.gerum@domain.hid> wrote:
> >> Jan Kiszka wrote:
> >>> Philippe Gerum wrote:
> >>>> Jan Kiszka wrote:
> >>>>> Gilles Chanteperdrix wrote:
> >>>>>> On Jan 8, 2008 2:44 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >>>>>>> Gilles Chanteperdrix wrote:
> >>>>>>>> When you try to mix up real-time and non real-time threads, it all
> >>>>>>>> becomes very complicated. You do not need your complication: just make
> >>>>>>>> all your tasks real-time tasks (using priority 0 for low priority
> >>>>>>>> tasks) and forget about __real_* calls.
> >>>>>>> That can be inefficient in large applications: You don't need the
> >>>>>>> (average-case) overhead of Xenomai IPC for pure non-RT interaction. And
> >>>>>>> IPC object creation is precisely the critical point, because their type
> >>>>>>> cannot be told apart by the wrapping layer based on generic parameters.
> >>>>>> The point is that you usually do not care.
> >>>>>>
> >>>>> My customer does. :)
> >>>>>
> >>>>> E.g. note that Xenomai IPC does not scale on SMP like glibc/futux-based
> >>>>> stuff does (repeating once again: in the average case).
> >>>>>
> >>>> You mean in the non contended case.
> >>> Specifically, but also
> >>>
> >>>  - the potential need to consider the number of non-RT objects in your
> >>>    RT system design (specifically if there are a lot of them)
> >>>
> >>>  - scalability limitations of nklock (which would be stressed more
> >>>    intensively by contention cases, or when using message queues)
> >>>
> >>> Only when the number of non-RT objects is small, thus negligible, it is
> >>> OK to throw them in the same pot as RT objects. Otherwise, it would be
> >>> crazy to merge both sets.
> >>>
> >> I'm not arguing about this, since all arguments I read about so far cut
> >> both ways, and it vastly depends on runtime conditions, and execution
> >> patterns exhibited by the application. In short, we just don't know when
> >> and where it's going to bite hard, but we know that for sure, this may
> >> bite hard at some point, depending on the use case.
> >>
> >> My point was about the notion that whatever route you may follow to
> >> implement the contended case (well, reasonable ones, I mean), you are
> >> going to face a scalability issue, and futexes with PI coupling have
> >> their own too. In short, YMMV, but as a matter of fact, the current
> >> Xenomai core is not aimed at supporting large SMP scalability.
> >>
> >> This said, the non contended case for Xenomai mutual exclusion objects
> >> in user-space still has to be improved the futex way, and likely the
> >> overhead of syscall interposition by the I-pipe lowered.
> >
> > I once thought about mapping a "mutex page" in user-space, and put the
> > mutex counter on this page. However, this approach has a big drawback:
> > it will not work on ARM if you want to share the mutex between user
> > and kernel space. This is the point where I left this idea.
> >
>
> Well, as a matter of fact, I would not care that much about such a
> "limitation". Day after day, we tell people to use kernel space for
> device drivers and keep it free from any application layer, and
> additionally that they should use RTDM to write device drivers. Since
> the RTDM interface has no obvious reason to rely on basic mutual
> exclusion services with the in-kernel driver, no issue would be raised
> in the common case.
>
> Albeit slightly overkill, it would even be possible to create a mutual
> exclusion building block (which is the desired option) at nucleus level,
> and make it aware of platform-specific limitations. For instance, we
> could tell it to ignore any direct mapping optimization when virtual
> address based cache is in effect.

... or we can get rid completely of the user-space thing on older
ARMs, since atomic_cmpxchg needs a syscall anyway.

-- 
                                               Gilles Chanteperdrix

