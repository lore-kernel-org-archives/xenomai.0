From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] timer-handling adeos/xenomai on arm
Date: Sat, 11 Nov 2006 15:33:51 +0100
References: <1162810995.5144.20.camel@domain.hid>
	<17749.44672.200334.645300@domain.hid>
	<200611111252.13782.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200611111252.13782.Sebastian.Smolorz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200611111533.51160.Sebastian.Smolorz@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Gilles Chanteperdrix wrote:
> > Schl=E4gl "Manfred jun." wrote:
> >  > Hi again!
> >  >
> >  > I've the presumption, there is something wrong with my timer-handlin=
g.
> >  > Could you please take a look at my handling.
> >  >
> >  > Thanks in advance!
> >
> > The problem I see with your code is that you are updating
> > ns_timer_lxlost in __ipipe_mach_acktimer, the integrator architecture
> > code, which also uses a decrementer does not do that. Apart from that, I
> > see nothing wrong.
>
> I see another one which has to do with the fact that __ipipe_mach_tsc is
> updated both in __ipipe_mach_get_tsc and __ipipe_mach_set_dec. This leads
> to double-added ticks because the latter funcion is called only once a
> period and the former even more than once. So Xenomai counts jiffies
> in /proc/xenomai/timer to fast. Manfred, can you confirm this?

=46orget this, my eyes weren't open this morning ... In  __ipipe_mach_get_t=
sc=20
there is no update of __ipipe_mach_tsc, of course.

Sebastian

