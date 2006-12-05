Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] vxworks- and posix-skin simultaneously
Date: Tue, 5 Dec 2006 12:12:44 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A6C63C4@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

> > Can anybody tell me about the actual state of using=20
> vxworks-skin and posix-skin simultaneously ? Is it possible,=20
> compiling one application with vxWorks-skin and an other one=20
> with the posix-skin and to use/execute these two applications=20
> simultaneously on one system ?
>=20
> Yes, feasible. There are example applications available for=20
> both skins, so setting up your own quick test will not take=20
> you much time.
>=20
> >=20
> > In an earlier posting I have read, that all skins (or at=20
> least the native and the posix one) should be compiled as=20
> modules, so they do not overide the timer mode. Is this still=20
> true ? And if yes, dosn?t need the posix skin an aperiodic=20
> timer, but the timer is set to periodic mode by the vxworks=20
> skin ? So, can an vxworks application and an posix=20
> applications run together ??
>=20
> It's true that the vxworks skin still forces the nucleus into=20
> periodic timer mode. This is a known shortcoming of the=20
> current timer subsystem.
> As announced earlier, we are aiming at a redesign to overcome=20
> this during the 2.4 development cycle. Ideas exist, remaining=20
> issues are also identified. But our resources are still=20
> limited, so there is no promise on a time-frame.
>=20


> Anyway, if you do not rely on having sub-tick timer precision=20
> for the posix applications you are planning, the available=20
> support should already be fine for you.
>=20

Sorry, but what does "sub-tick timer precision" mean (isn=B4t the timer =
counting ticks) ?
Do I have to use the posix timers in a different way, when using =
periodic mode, or is just the timer resolution changing (incremnting by =
1000000 when the period is  1ms e.g.) ?
What is a reasonable value for the timer period in the kenrel settings =
(1ms=3D1000000 ns ?)

Tank your for answering my dummy questions
Roderik

