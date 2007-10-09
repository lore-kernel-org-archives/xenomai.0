Message-ID: <470BC537.8010200@domain.hid>
Date: Tue, 09 Oct 2007 20:15:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>
In-Reply-To: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] RTAI and Xenomai latency in kernel mode
	on	AT91SAM9261-EK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: xenomai@xenomai.org

Gregory CLEMENT wrote:
> Here, they are the last latency we get on AT91SAM9261-EK. As just now
> I haven't the board at home, I send the last result we stored. The
> prority of dbgu should be set to 6 instead of 7, but I can't assure
> it, for Xenomai.

Hmm, hardware interrupt priorities must not impact the worst-case
latency if I-pipe acks and mask them appropriately (the worst case is
when multiple interrupts happen in a row, not at the same time). But
this statement is not based on knowledge about potential pitfalls of
this arch. Are there specialities that require this tweaking?

> first Xenomai:
>=20
> #insmod /lib/modules/2.6.20.13/kernel/drivers/xenomai/testing/xeno_time=
rbench.ko
> #cd /usr/xenomai/bin/

Which versions were you using for both tests? Do you still have the
involved .configs?

> #./latency -t 2 -p 150 -h -H 500
...
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|       3.480|      11.779|      99.163|       0|    14:23:01/14:23:=
01
>=20
> It was run under calibrator load during more than 14 hours.
>=20
> Now RTAI:
>=20
> Oneshot timer with 500=B5s period,  LATENCY =3D6000ns and SETUPTIME 150=
0
>  duration : 17h
>=20
> 1970/01/1 22:34:51
> RTH|    lat min|    ovl min|    lat avg|    lat max|    ovl max|   over=
runs
> RTD|       3221|       2577|       4997|      26095|      53801|       =
   0
> RTD|       3221|       2577|       5163|      25451|      53801|       =
   0
> RTD|       3221|       2577|       5159|      25128|      53801|       =
   0
> RTD|       3221|       2577|       4799|      23518|      53801|       =
   0
> RTD|       3221|       2577|       4828|      25128|      53801|       =
   0
> RTD|       3221|       2577|       5089|      23518|      53801|       =
   0
> RTD|       3221|       2577|       4580|      23840|      53801|       =
   0
> RTD|       3221|       2577|       4924|      25128|      53801|       =
   0
> RTD|       3221|       2577|       4740|      24806|      53801|       =
   0
> RTD|       3221|       2577|       4251|      25128|      53801|       =
   0

Again, what would simplify the discussion enormously is a function
back-trace of the measured maximum latencies, just like "latency -f"
generates. The numbers will become worse, for sure, but we would gain a
very good overview about what is executed and what delayed which kernel.
If you see a chance to perform such a test and you need some hints on
the tracer setup (or did you use it before?), please let us know!

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

