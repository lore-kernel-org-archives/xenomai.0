MIME-Version: 1.0
In-Reply-To: <20150918074633.GA7301@hermes.click-hack.org>
References: <CAFkYNwaqLYu7vAAyAt6Q9qfKL4iBa+N1BuzgJWhN6z4NfA5U=g@mail.gmail.com>
 <44k2rqz38u.fsf@be-well.ilk.org>
 <CAFkYNwYJ7ah+U97Pwuqwf9Phg=J0rTjr1txfGtg0FuoN2oP7cg@mail.gmail.com>
 <20150917133220.GB31663@hermes.click-hack.org>
 <CAFkYNwacX=h7trKNEBq=KZX627nRA7u6zk6YoEOLj8_J_LEa1Q@mail.gmail.com>
 <20150918074633.GA7301@hermes.click-hack.org>
Date: Sat, 19 Sep 2015 00:24:38 +1200
Message-ID: <CAFkYNwaBpwoC7rZBV4eRd7XEZ+c1GzNJZN9ZY_n9WO184A=pFQ@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Error code -19
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I have checked in .config. However, I am not sure what string to search for
device tree. Would you please advise what string would it be for the clock?

In .config

CONFIG_ARM_GLOBAL_TIMER=y
CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK=y



On 18 September 2015 at 19:46, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Fri, Sep 18, 2015 at 01:39:36PM +1200, vibnwis wrote:
> > Thank you for looking into my problems.
> >
> > Please find attached the kern.log.
> >
> > Thanks in advance.
> >
> > On 18 September 2015 at 01:32, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> > > On Fri, Sep 18, 2015 at 01:02:53AM +1200, vibnwis wrote:
> > > > I tried my best to understand what is being described in
> > >
> > > Please post the full kernel logs.
> > >
> > > --
> > >                                             Gilles.
> > > https://click-hack.org
> > >
>
> > Jan  1 00:00:07 arm kernel: [    1.454040] [Xenomai] scheduling class
> idle registered.
> > Jan  1 00:00:07 arm kernel: [    1.454040] [Xenomai] scheduling class rt
> registered.
> > Jan  1 00:00:07 arm kernel: [    1.454315] I-pipe: high-resolution clock
> not working
> > Jan  1 00:00:07 arm kernel: [    1.454498] [Xenomai] init failed, code
> -19
>
> So, the problem is the clock, not the timer. On a cortex A9, the
> I-pipe uses the global timer as clock. Is the global timer enabled
> in the kernel configuration, and is it declared in the device tree?
>
> Regards.
>
> --
>                                             Gilles.
> https://click-hack.org
>
