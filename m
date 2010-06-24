Date: Thu, 24 Jun 2010 11:22:59 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100624092259.GA21635@domain.hid>
References: <4C0692A9.2080806@domain.hid>
	<1276080083.18906.52.camel@domain.hid>
	<20100609181153.GA27353@domain.hid>
	<1276902677.12743.108.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1276902677.12743.108.camel@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [PATCH] Mayday support (was: Re: [RFC] Break out
	of endless user space loops)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org, xenomai@xenomai.org

On Sat, Jun 19, 2010 at 01:11:17AM +0200, Philippe Gerum wrote:
> On Wed, 2010-06-09 at 20:11 +0200, Tschaeche IT-Services wrote:
> > On Wed, Jun 09, 2010 at 12:41:23PM +0200, Philippe Gerum wrote:
> > > We definitely need user feedback on this. Typically, does arming th=
e
> > > nucleus watchdog with that patch support in, properly recovers from=
 your
> > > favorite "get me out of here" situation? TIA,
> > >=20
> > > You can pull this stuff from
> > > git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.
> >=20
> > manually build a kernel (timeout 1s) with your patches.
> > user space linked to 2.5.3 libraries without any patches.
> > Looks fine: the amok task is switched to secondary domain
> > (we catched the SIGXCPU) running the loop in secondary domain.
> > then, on a SIGTRAP the task leaves the loop.
> >=20
> > also, if SIGTRAP arives before SIGXCPU it looks good,
> > apart from the latency of 1s.
> >=20
> > did not check the ucontext within the exception handler, yet.
> > would like to setup a reproducible kernel build first...
> > we will go into deeper testing in 2 weeks.
> >=20
> > maybe we need a finer granularity than 1s for the watchdog timeout.
> > is there a chance?
>=20
> The watchdog is not meant to be used for implementing application-level
> health monitors, which is what you seem to be looking after. The
> watchdog is really about pulling the break while debugging, as a mean
> not to brick your board when things start to hit the crapper, without
> knowing anything from the error source. For that purpose, the current 1=
s
> granularity is just fine. It makes the nucleus watchdog as tactful as a
> lumberjack, which is what we want in those circumstances: we want it to
> point the finger at the problem we did not know about yet and keep the
> board afloat; it is neither meant to monitor a specific code we know in
> advance that might misbehave, nor provide any kind of smart contingency
> plan.
>=20
> I would rather think that you may need something like a RTDM driver
> actually implementing smarter health monitoring features that you could
> use along with your app. That driver would expose a normalized socket
> interface for observing how things go app-wise, by collecting data abou=
t
> the current health status. It would have to tap into the mayday routine=
s
> for recovering from runaway situations it may detect via its own,
> fine-grained watchdog service for instance.

Perfect, that's exactly what we want (and already have implemented).
How can i tap into the MayDay routines from my driver?
Is there a rt_mayday(RT_TASK)?

Cheers,

	Olli

--=20
Tschaeche IT-Services       Tel.:  +49/9134/9089850
Dr.-Ing. Oliver Tsch=E4che    Mobil: +49/176/20435601
Welluckenweg 4              Email: services@domain.hid
91077 Neunkirchen

