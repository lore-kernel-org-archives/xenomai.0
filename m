Message-ID: <4726F2B5.5000307@domain.hid>
Date: Tue, 30 Oct 2007 10:00:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1078761341.20071030094041@domain.hid>
In-Reply-To: <1078761341.20071030094041@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] how to stop a runaway task
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Carsten_Spie=DF?= <mail@domain.hid>
Cc: xenomai@xenomai.org

Carsten Spie=DF wrote:
> Hello,
>=20
> i'm running Xenomai 2.3.2 on a PPC target with Linux 2.4.25 kernel.
> I trying to programm a supervising task, that detects a runaway task
> and suspend it.
>=20
> My aproach was to make a high priority periodic task to look if
> the low prio task is running correctly and suspend it when it detects
> failure.
> But this approach didn't work, the higer prio task isn't called unless
> the lower prio task gives up cpu (by calling e.g. rt_task_yield or
> nanosleep) (see attached demo source)

This would basically say that the core does not give any real-time
guarantee. Please send some demo code showing this.

>=20
> When not being cooperative (removing the rt_task_yield in the demo)
> my system is reset after some seconds.
>=20
> Why isn't my supervising task scheduled?
>=20

Try enabling the nucleus watchdog (Xenomai debug options). It does kill
runaway tasks. If this works on your setup, then your code must be
wrong. If it does not trigger, then we need to understand why  -- there
is one case where it may not trigger, but this does not involve any
breakage in task management.

> Tanks for help, regards
>=20
> Carsten
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.

