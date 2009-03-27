From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200903271641.09389.pwaechtler@domain.hid>
References: <200903271538.10434.pwaechtler@domain.hid>
	<49CCE84E.7060708@domain.hid> <200903271641.09389.pwaechtler@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Mar 2009 16:59:43 +0100
Message-Id: <1238169583.6815.241.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] use case: possible to boot Posix subsystem in
 <50ms and then Linux?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: pwaechtler@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2009-03-27 at 16:41 +0100, Peter W=C3=A4chtler wrote:
> Am Friday 27 March 2009 15:53:02 schrieb Gilles Chanteperdrix:
> >
> > Xenomai kernel-space support is started somewhere in the middle of th=
e
> > boot process, so, you can probably start kernel-space applications at
> > that time. User-space only works when init has been started, which
> > happens a bit later during the boot process. But you can start Xenoma=
i
> > applications before all the system services have been started.
> >
>=20
> I think the fundamental question is: does Adeos provide a scheduler?=20
>=20

No it does not. Not the kind of scheduler you seem to be thinking of
actually; it only "schedules" interrupt and trap events. Not tasks.

> And I guess the answer is yes, at least "Life-with-Adeos" doc mentions
> primary and secondary execution modes/domains.
>=20

This is dealt with by the Xenomai nucleus. Adeos provides the simplistic
"domain" abstraction, and Xenomai derives the primary/secondary mode
abstractions on top of those.

> In the use case it would be necessary that OSEK subsystem is able to sc=
hedule=20
> between a static number of preconfigured threads WITHOUT the preconditi=
on=20
> that Linux is up and running.
>=20

The way to do this would be to port the Xenomai nucleus and portions of
the POSIX skin over bare metal. I did exactly that once over an ARM ISS,
so this is indeed doable to bypass Linux. The point is: this needs a
full-fledge Xenomai port, a bit like the Xenomai event-driven simulator
interfaces to our RTOS core.

> >
> > As a side note, I have a question for the automotive industry people.
> > Would there be an interest in developing an OSEK skin for Xenomai? I
> > have been thinking about that for some time, but still have not found
> > time to start the job. I have read the OSEK spec, and found the
> > interface pretty simple (though some part of the job has to be done
> > offline, and annoyingly need to read XML files). The OSEK com spec, o=
n
> > the other hand, looks rather scary.
>=20
> There are open source OSEK implementations. AFAIK, all far from complet=
eness.
>=20
> You can start with
> http://opensek.sourceforge.net/
>=20
> or have a look at the list at=20
> http://en.wikipedia.org/wiki/OSEK
>=20
> 	Peter
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
--=20
Philippe.



