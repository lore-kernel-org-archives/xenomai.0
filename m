MIME-Version: 1.0
In-Reply-To: <5436A64B.90705@xenomai.org>
References: <542EA6A2.306@xenomai.org>
 <CACreCVKe_nw=6p1xQkbziPne4cW74kx0EtUWG0kC4roS7+w+yw@mail.gmail.com>
 <20141003191454.GF9452@sisyphus.hd.free.fr>
 <CACreCVLi=QT72p0pca76_7tsJn+TazdQjyy7NHW_NwfxCYbuKA@mail.gmail.com>
 <20141003224829.GA6850@sisyphus.hd.free.fr>
 <CACreCV+TDzXxX=e7MpscYcGn1sTTye9N-mED0iPfqVB9Zm4xdQ@mail.gmail.com>
 <20141004113116.GC7596@sisyphus.hd.free.fr>
 <CACreCV+ok_Ogd3iFPGNS3n640hdLQC3C_Pyzz=w80St-7buXWQ@mail.gmail.com>
 <20141005220404.GL14975@sisyphus.hd.free.fr>
 <CACreCVJFa6FB=3WR_OuMvACeYOWaA035T4KK7dFg8vHhyqkz8w@mail.gmail.com>
 <20141005223051.GN14975@sisyphus.hd.free.fr>
 <CACreCVLQsaq01vsNA_V_bu9_NyMCTwZTiZJo2sFXJHgaaVjQVg@mail.gmail.com>
 <54365E17.3020102@xenomai.org>
 <CACreCV+QtwuhhGeFpnuLP-6Y1FfLCQHqNkrzyfwgqEgrxXU9eQ@mail.gmail.com>
 <5436607B.7090609@xenomai.org>
 <CACreCV+HdWC9Deysy2miL2NZ65RFVRRk87uG9rBaUBrn=hhqag@mail.gmail.com>
 <5436A64B.90705@xenomai.org>
Date: Mon, 20 Oct 2014 15:29:26 +0800
Message-ID: <CACreCVJUPiiX_7733g1EWZCVmUH0oFWhLknhKB2K8se1fi4a1g@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Oct 9, 2014 11:14 PM, "Gilles Chanteperdrix" <
gilles.chanteperdrix@xenomai.org> wrote:
>
> On 10/09/2014 01:06 PM, GP Orcullo wrote:
> > On Oct 9, 2014 6:16 PM, "Gilles Chanteperdrix" <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >>
> >> On 10/09/2014 12:12 PM, GP Orcullo wrote:
> >>> On Thu, Oct 9, 2014 at 6:06 PM, Gilles Chanteperdrix
> >>> <gilles.chanteperdrix@xenomai.org> wrote:
> >>>> On 10/09/2014 12:02 PM, GP Orcullo wrote:
> >>>>> On Mon, Oct 6, 2014 at 6:30 AM, Gilles Chanteperdrix
> >>>>> <gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>
> >>>>>> It means that Linux was interrupted by Xenomai during its timer
> >>>>>> interrupt, and that Xenomai interrupted it for 280us. This may
> >>>>>> happens with switchtest if it has a really long chain of context
> >>>>>> switches. If you want to check what happened, enable the I-pipe
> >>>>>> tracer, and trigger a trace freeze right before this message.
> >>>>>>
> >>>>>> --
> >>>>>>                                             Gilles.
> >>>>>
> >>>>> One more piece to the puzzle: disabling CONFIG_IPIPE_DEBUG_INTERNAL
> >>>>> causes the system to lockup.
> >>>>>
> >>>> How do you know this is related?
> >>>>
> >>>> --
> >>>>
 Gilles.
> >>>
> >>> Sorry, I quoted the wrong message.
> >>>
> >>> If CONFIG_PREEMPT is disabled and CONFIG_IPIPE_DEBUG_INTERNAL is not
> >>> disabled, the system works fine.
> >>>
> >> So, there is a problem, likely in your port with CONFIG_PREEMPT, but
> >> maybe in Xenomai (I need to check, because I am not so sure I tested
> >> xeno-regression-test without CONFIG_PREEMPT).
> >>
> >> And there is a problem in your port without
CONFIG_IPIPE_DEBUG_INTERNAL.
> >> This I do not need to check, I have tested Xenomai wihout this option
> >> enabled.
> >>
> >> So, my question is: how do you know the two issues are related?
> >>
> >> --
> >>                                                                 Gilles.
> >
> > I don't know the answer.
> >
> > I'm only looking at the effects and not the cause of the issue.
> >
> > So,  where shall I start digging?  What's in
CONFIG_IPIPE_DEBUG_INTERNAL
> > that would somehow suppress the problem?
> >
>
> Quite frankly, I would go the other way: check that every piece of code
> which may be executed over real-time context does not use any Linux
> code. That does not include a lot of code, actually all that is covered
> by the porting guide:
> - the interrupt controller callbacks (note that the GIC handles some SOC
> specific callabcks, so if you have some, you need to check them)
> - the chained interrupt demux handlers
> - the timer and tsc management functions.
> - some workaround specific code that hooks in the iowrite/writel
> functions, such as the L2 cache synchronization on omap4.
>
> And it seems that is all, so, there should not be a lot of code to check.
>
> --
>

Hello Gilles,

Thanks for all the help.

The problem was traced to the tsc emulation,  the counter somehow gets
messed up when the global timer is shared with Linux.

Using the global timer exclusively for the tsc emulation fixed all the
issues that have been encountered.

I'll post the updated ipipe patches soon.

Regards,

Gemi
