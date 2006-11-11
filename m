From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] timer-handling adeos/xenomai on arm
Date: Sat, 11 Nov 2006 19:45:09 +0100
References: <1162810995.5144.20.camel@domain.hid>
	<200611111533.51160.Sebastian.Smolorz@domain.hid>
	<17749.64255.935835.17174@domain.hid>
In-Reply-To: <17749.64255.935835.17174@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200611111945.10309.Sebastian.Smolorz@domain.hid>
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
>  > Sebastian Smolorz wrote:
>  > > Gilles Chanteperdrix wrote:
>  > > > Schl=E4gl "Manfred jun." wrote:
>  > > >  > Hi again!
>  > > >  >
>  > > >  > I've the presumption, there is something wrong with my
>  > > >  > timer-handling. Could you please take a look at my handling.
>  > > >  >
>  > > >  > Thanks in advance!
>  > > >
>  > > > The problem I see with your code is that you are updating
>  > > > ns_timer_lxlost in __ipipe_mach_acktimer, the integrator
>  > > > architecture code, which also uses a decrementer does not do that.
>  > > > Apart from that, I see nothing wrong.
>  > >
>  > > I see another one which has to do with the fact that __ipipe_mach_tsc
>  > > is updated both in __ipipe_mach_get_tsc and __ipipe_mach_set_dec. Th=
is
>  > > leads to double-added ticks because the latter funcion is called only
>  > > once a period and the former even more than once. So Xenomai counts
>  > > jiffies in /proc/xenomai/timer to fast. Manfred, can you confirm thi=
s?
>  >
>  > Forget this, my eyes weren't open this morning ... In=20
>  > __ipipe_mach_get_tsc there is no update of __ipipe_mach_tsc, of course.
>
> Right, but __ipipe_mach_tsc and ns_timer_lxlost get also updated in
> __ipipe_mach_acktimer, this looks wrong, in the integrator
> implementation, they are updated in the timer interrupt, only if the
> timer is not stolen.

OK, let's speculate a little bit. (Maybe all of the following turns out to =
be=20
completely wrong, but it wouldn't be the first time for me today. ;-)=20
Hopefully Manfred can give some comments which pieces of my speculation are=
=20
right.)

The timer counts down to zero, causes an interrupt and then reloads=20
automatically with ns_timer_reload. So, when __ipipe_mach_acktimer is calle=
d=20
ns_timer_reload ticks have passed and can be added to __ipipe_mach_tsc and=
=20
ns_timer_lxlost. Some ticks later, __ipipe_mach_set_dec is executed, the=20
passed ticks are added to __ipipe_mach_tsc and ns_timer_lxlost and the time=
r=20
is reprogrammed to the new value.

Could be right ...

Sebastian

