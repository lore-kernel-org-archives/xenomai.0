From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] timer-handling adeos/xenomai on arm
Date: Sun, 12 Nov 2006 19:51:36 +0100
References: <1162810995.5144.20.camel@domain.hid>
	<200611111945.10309.Sebastian.Smolorz@domain.hid>
	<17750.14872.480581.403298@domain.hid>
In-Reply-To: <17750.14872.480581.403298@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200611121951.37050.Sebastian.Smolorz@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Sebastian Smolorz wrote:
>  > >  > Sebastian Smolorz wrote:
>  > >  > > Gilles Chanteperdrix wrote:
>  > >  > > > Schl=E4gl "Manfred jun." wrote:
>  > >  > > >  > Hi again!
>  > >  > > >  >
>  > >  > > >  > I've the presumption, there is something wrong with my
>  > >  > > >  > timer-handling. Could you please take a look at my handlin=
g.
>  > >  > > >  >
>  > >  > > >  > Thanks in advance!
>  > >  > > >
>  > >  > > > The problem I see with your code is that you are updating
>  > >  > > > ns_timer_lxlost in __ipipe_mach_acktimer, the integrator
>  > >  > > > architecture code, which also uses a decrementer does not do
>  > >  > > > that. Apart from that, I see nothing wrong.
>  > >  > >
>  > >  > > I see another one which has to do with the fact that
>  > >  > > __ipipe_mach_tsc is updated both in __ipipe_mach_get_tsc and
>  > >  > > __ipipe_mach_set_dec. This leads to double-added ticks because
>  > >  > > the latter funcion is called only once a period and the former
>  > >  > > even more than once. So Xenomai counts jiffies in
>  > >  > > /proc/xenomai/timer to fast. Manfred, can you confirm this?
>  > >  >
>  > >  > Forget this, my eyes weren't open this morning ... In
>  > >  > __ipipe_mach_get_tsc there is no update of __ipipe_mach_tsc, of
>  > >  > course.
>  > >
>  > > Right, but __ipipe_mach_tsc and ns_timer_lxlost get also updated in
>  > > __ipipe_mach_acktimer, this looks wrong, in the integrator
>  > > implementation, they are updated in the timer interrupt, only if the
>  > > timer is not stolen.
>  >
>  > OK, let's speculate a little bit. (Maybe all of the following turns out
>  > to be completely wrong, but it wouldn't be the first time for me today.
>  > ;-) Hopefully Manfred can give some comments which pieces of my
>  > speculation are right.)
>  >
>  > The timer counts down to zero, causes an interrupt and then reloads
>  > automatically with ns_timer_reload. So, when __ipipe_mach_acktimer is
>  > called ns_timer_reload ticks have passed and can be added to
>  > __ipipe_mach_tsc and ns_timer_lxlost. Some ticks later,
>  > __ipipe_mach_set_dec is executed, the passed ticks are added to
>  > __ipipe_mach_tsc and ns_timer_lxlost and the timer is reprogrammed to
>  > the new value.
>
> The problem is that when Xenomai manages the timer, it get reloaded with
> values distinct from ns_timer_reload,

But the reload value is assigned to ns_timer_reload in set_dec. So every ti=
me=20
__ipipe_mach_acktimer is executed it adds the last set reload value which i=
s=20
the right one, isn't it?

> it is even not reloaded at all=20
> when the system is a bit late,

Are you referring to the discussed ipipe_trigger_irq call when the delay is=
=20
zero?

=2D-
Sebastian

