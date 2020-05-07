MIME-Version: 1.0
References: <1108-5eb3fa80-f-411d5c80@96373630>
 <5a87e02f-d037-0776-4911-6625af262d31@siemens.com>
 <a4862249-133f-2980-aa7f-6005b3f18096@siemens.com>
In-Reply-To: <a4862249-133f-2980-aa7f-6005b3f18096@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 7 May 2020 08:42:30 -0400
Message-ID: <CALLqZ8QNcM-rWU_3OOHU_jkoTUqp=VbGwD=9DYxoi7-NpmmkVA@mail.gmail.com>
Subject: Re: Kernel panic while booting in single processor mode
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On Thu, May 7, 2020 at 8:38 AM Jan Kiszka via Xenomai <xenomai@xenomai.org>
wrote:

> On 07.05.20 14:35, Jan Kiszka wrote:
> > On 07.05.20 14:10, Fran=C3=A7ois Legal wrote:
> >> Le Jeudi, Mai 07, 2020 11:38 CEST, Jan Kiszka <jan.kiszka@siemens.com>
> >> a =C3=A9crit:
> >>> On 07.05.20 11:02, Fran=C3=A7ois Legal wrote:
> >>>> Le Jeudi, Mai 07, 2020 10:42 CEST, Jan Kiszka
> >>>> <jan.kiszka@siemens.com> a =C3=A9crit:
> >>>>> On 07.05.20 10:36, Fran=C3=A7ois Legal via Xenomai wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> trying to diagnose an imprecise external abort, I reconfigured the
> >>>>>> kernel to boot on a single core (SMP disabled) with I&D caches
> >>>>>> disabled.
> >>>>>>
> >>>>>> Config is linux 4.4.189, xenomai-3.0.9
> >>>>>>
> >>>>>> During the boot, when the system creates the thread for RTNET
> >>>>>> stack mgr, I get a kernel panic as you can see below.
> >>>>>> I could track that down to the "list_add_tail(&timer->next_stat,
> >>>>>> &clock->timerq);" in __xntimer_init.
> >>>>>>
> >>>>>> Looks like clock->timerq (which is nkclock->timerq) is not
> >>>>>> initialized.
> >>>>>>
> >>>>>> Am I missing something ?
> >>>>>
> >>>>> I thinks there was an ordering issue... Is RTnet built-in (I suspec=
t
> >>>>> from the backtrace) or a module? That should be addressed in 3.1,
> >>>>> possibly not backported to 3.0 (or only in current stable). I would
> >>>>> have
> >>>>> to dig into the git history myself now.
> >>>>>
> >>>>> Jan
> >>>>>
> >>>>
> >>>> It is built in. There used to be an ordering issue (which I fixed in
> >>>> a patch some monthes ago), but that was due to protocols being
> >>>> probed before stack manager. Here, there is something wrong with the
> >>>> xnthreads I think.
> >>>>
> >>>> There might be something wrong with my config however, as I did not
> >>>> pay attention, but earlier in the boot, I just noticed this :
> >>>> [   11.613033] [Xenomai] scheduling class rt registered.
> >>>> [   11.615582] I-pipe: could not find timer for cpu #0
> >>>> [   11.616487] [Xenomai] init failed, code -19
> >>>>
> >>>> That might explain why the nkclock is not properly initialized.
> >>>>
> >>>
> >>> Yep, that's the root cause. We then fail ungracefully later, another
> >>> issue, patches welcome.
> >>>
> >>> Jan
> >>>
> >>
> >> I'm not sure how to go through this. The timer used by xenomai is
> >> (used to be) the twd (which is arm cortex A9 core private timer),
> >> which driver depends on HAVE_SMP.
> >> I don't quite understand why that depends on SMP as this is a private
> >> core peripheral. Anyway, it looks like it comes from upstream, so
> >> there not much we can do here.
> >>
> >> I'm quite surprise here. That means any Cortex A9 MPCore cluster
> >> running as AMP or with a single core enabled can't work with xenomai ?
> >> What about the IMX6 solo and stuff like that ? Aren't they supported ?
> >>
> >> I think I can patch the global_timer driver to make it look like TWD,
> >> but it does not seem right.
> >
> > Does the issue persist with newer kernel versions, specifically now
> > 4.19? Maybe there is something we could backport.
>
> And also check latest ipipe-4.4.y-cip where were are at 4.4.218.
>
> >
> > Keep in mind that I received little feedback on the 4.4 maintenance /wr=
t
> > ARM. I only picked up a few fixes and improvements I happened to come
> > across and Philippe once pointed out.
> >
> > Jan
> >
>
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


What happens if you leave SMP enabled and just set number of cpus to 1? I
haven=E2=80=99t dealt with AMP system but I did have Zynq 7000 running fine=
 in AMP
let me look at that config. I can look quick at 4.19 also if that helps.

Greg

>
>
>
