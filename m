From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17749.64255.935835.17174@domain.hid>
Date: Sat, 11 Nov 2006 17:31:59 +0100
Subject: Re: [Xenomai-help] timer-handling adeos/xenomai on arm
In-Reply-To: <200611111533.51160.Sebastian.Smolorz@domain.hid>
References: <1162810995.5144.20.camel@domain.hid>
	<17749.44672.200334.645300@domain.hid>
	<200611111252.13782.Sebastian.Smolorz@domain.hid>
	<200611111533.51160.Sebastian.Smolorz@domain.hid>
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
 > Sebastian Smolorz wrote:
 > > Gilles Chanteperdrix wrote:
 > > > Schl=E4gl "Manfred jun." wrote:
 > > >  > Hi again!
 > > >  >
 > > >  > I've the presumption, there is something wrong with my timer-ha=
ndling.
 > > >  > Could you please take a look at my handling.
 > > >  >
 > > >  > Thanks in advance!
 > > >
 > > > The problem I see with your code is that you are updating
 > > > ns_timer_lxlost in __ipipe_mach_acktimer, the integrator architect=
ure
 > > > code, which also uses a decrementer does not do that. Apart from t=
hat, I
 > > > see nothing wrong.
 > >
 > > I see another one which has to do with the fact that __ipipe_mach_ts=
c is
 > > updated both in __ipipe_mach_get_tsc and __ipipe_mach_set_dec. This =
leads
 > > to double-added ticks because the latter funcion is called only once=
 a
 > > period and the former even more than once. So Xenomai counts jiffies
 > > in /proc/xenomai/timer to fast. Manfred, can you confirm this?
 >=20
 > Forget this, my eyes weren't open this morning ... In  __ipipe_mach_ge=
t_tsc=20
 > there is no update of __ipipe_mach_tsc, of course.

Right, but __ipipe_mach_tsc and ns_timer_lxlost get also updated in
__ipipe_mach_acktimer, this looks wrong, in the integrator
implementation, they are updated in the timer interrupt, only if the
timer is not stolen.

--=20


					    Gilles Chanteperdrix.

