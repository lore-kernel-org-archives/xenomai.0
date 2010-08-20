From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1282321252.5255.415.camel@domain.hid>
References: <1282319702.5255.405.camel@domain.hid>
	<1282320412.1730.637.camel@domain.hid>
	<1282321252.5255.415.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Aug 2010 18:31:45 +0200
Message-ID: <1282321905.1730.648.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] rt timer jitter
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-08-20 at 18:20 +0200, Krzysztof B=C5=82aszkowski wrote:
> On Fri, 2010-08-20 at 18:06 +0200, Philippe Gerum wrote:
> > On Fri, 2010-08-20 at 17:55 +0200, Krzysztof B=C5=82aszkowski wrote:
> > > Do you have any idea about reducing rt timer jitter ?
> > > I experience annoyingly big jitter in a thread which is supposed to r=
un
> > > at 400us (i reckon this is nothing extra demanding from atom @1.6G)
> > >=20
> > >=20
> > > the thread's loop looks like:
> > >=20
> > > {
> > > function1()
> > > ..2()
> > > ..3()
> > > ..4()
> > >=20
> > > rt_task_wait_period()
> > > }
> > >=20
> > > (^yet another simplified model^)
> >=20
> > This is the typical pattern of the latency test. What figures do you ge=
t
> > with:
> >=20
> > # /usr/xenomai/bin/latency -t0
> > ...
> > # /usr/xenomai/bin/latency -t1
> >=20
>=20
> t0:
>=20
> RTS|     -1.337|     -0.039|     13.285|       0|     0|
> 00:02:13/00:02:13
>=20

Those are common figures for user-space latency on the kind of hw you
run this test on.

>=20
> i can't run t1 because of missing seno_timerbench.ko (i have no idea how
> to find a config option which would build it)
>=20

Did you consider using the "Search" feature from
xconfig/gconfig/whatever, looking for "timerbench"?

config XENO_DRIVERS_TIMERBENCH
	depends on XENO_SKIN_RTDM
	tristate "Timer benchmark driver"
	default y
	help
	Kernel-based benchmark driver for timer latency evaluation.
	See testsuite/latency for a possible front-end.

If you run your app in kernel space, then -t1 is what you want to run.

--=20
Philippe.



