Message-ID: <441EC03B.9000809@domain.hid>
Date: Mon, 20 Mar 2006 15:46:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>	<4417C14A.2010900@domain.hid>	<44180FB8.7080200@domain.hid>	<17432.5656.591747.248941@domain.hid>	<44189C13.3010301@domain.hid>
	<441E9698.5080506@domain.hid> <441EAD78.3030007@domain.hid>
In-Reply-To: <441EAD78.3030007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8163EDBA66DF0AEF2A30155E"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8163EDBA66DF0AEF2A30155E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> ...
>>> The issue that worries me - provided that we bound the adjustment off=
set
>>> to the duration of one tick after some jittery - is that any attempt =
to
>>> get intra-tick precision would lead to a possible discrepancy regardi=
ng
>>> the elapsed time according to those two different scales, between the=

>>> actual count of jiffies tracked by the timer ISR on the timekeeper CP=
U,
>>> and the corrected time value returned by rtdm_read_clock. And this
>>> discrepancy would last for the total duration of the jitter. E.g., fo=
r a
>>> 100 us period, xnpod_get_time() could return 2 albeit rtdm_read_clock=

>>> returns 300, instead of 200. Spuriously mixing both units in
>>> applications would lead to some funky chaos.
>>>
>>
>>
>> Trying to pick up this thread again, I just tried to understand your
>> concerns, but failed so far to imagine a concrete scenario. Could you
>> sketch such a "funky chaotic" situation from the application point of
>> view?
>=20
> Given the description above, just that some skin might return either
> nucleus ticks or corrected timestamps to the applications, which would
> in turn do some arithmetics for converting values they got from the ski=
n
> between both scales internally, and mistakenly use the result while
> assuming that both scales are always in sync. In this situation, and
> during a fraction of the time (i.e. the jitter), both scales might not
> be in sync, and the result would be unusable. This said, this kind of
> issue could be solved by big fat warnings in documentation, explicitely=

> saying that conversions between both scales might be meaningless.

So the worst-case is when a user derives some relative times from two
different time sources, one purely tick-base, the other improved by
inter-tick TSC (when available on that arch)?

Let's say the user takes timestamp t1 =3D rtdm_clock_read() (via some
driver) and a bit later t2 =3D rt_timer_tick2ns(rt_timer_read()). t1 was
set to the last tick Tn + the number of TSC ticks since then:

    t1 =3D Tn * tick_period + TSC_offset

With, e.g., Tn=3D1001, tick_period =3D 1000 us, and TSC_offset =3D 589 us=
:

    t1 =3D 1001 * 1000 us + 589 us =3D 1001569 us

As the next tick may have not stroke yet when taking t2, that value
converted to us can be smaller:

    t2 =3D Tn * tick_period =3D 1001000

Now the difference between t2 and t1 becomes negative (-589 us),
although the user may expect it t2-t1 >=3D 0. Is this non-monotony your
concern?


On the other hand, the advantage of TSC-based synchronised inter-tick
timestamps is that you can do things like

    sleep_until(rt_timer_ns2ticks(rtdm_clock_read() + 1000000))

without risking an error beyond +/- 1 tick (+jitter). With current
jiffies vs. TSC in periodic mode, this is not easily possible. You have
to sync in the application, creating another error source when the delay
between acquiring the TSC and sync'ing the TSC on jiffies is too long.

>=20
> And what would prevent us from improving the accuracy of other
>> timestamping API functions beyond RTDM as well, e.g. on converting fro=
m
>> ticks to nanos in rt_timer_ticks2ns()?
>>
>=20
> I don't understand why rt_timer_ticks2ns() should be impacted by such
> extension. This service must keep a constant behaviour, regardless of
> any outstanding timing issue. I mean, 3 ticks from a 1Khz clock rate
> must always return 3,000,000 nanos, unless you stop passing count of
> ticks but fractional/compound values instead.

Forget about this, it was (pre-lunch) nonsense.

>=20
> The bottom-line is that we should not blur the line between periodic an=
d
> aperiodic timing modes, just for getting precise timestamps in the
> former case. Additionally, and x86-wise, when no TSC is available on th=
e
> target system, rt_timer_tsc() already returns a timestamp obtained from=

> the 8254's channel #2 we use as a free running counter, which is the
> most precise source we have at hand to do so.
>=20
> Periodic mode bears its own limitation, which is basically a loss of
> accuracy we trade against a lower overhead (even if that does not mean
> much except perhaps on x86). What we could do is reducing the jittery
> involved in periodic ticks, by always emulating periodic mode over
> aperiodic shots instead of using e.g. the 8254 in PIT mode (and remove
> the need for the double scale on x86, tsc + 8254 channel #1), but not
> change the basic meaning of periodic timing.

Hmm, interesting, and it also reminds of a long pending (slightly OT)
question I have: why not creating the infrastructure (a dedicated
periodic timer) for providing round-robin scheduling even in aperiodic mo=
de?

>=20
> But maybe we are still discussing different issues actually, so it woul=
d
> be useful that the core issue that triggered the discussion about
> periodic mode precision be exposed again.

Yep, Rodrigo...?

Jan


--------------enig8163EDBA66DF0AEF2A30155E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEHsA7niDOoMHTA+kRAidMAJ9pmL1QbAs849Xca27kOcZf9vedpgCfSfRB
/P6lqPl413muMp1fV//z05o=
=G0DY
-----END PGP SIGNATURE-----

--------------enig8163EDBA66DF0AEF2A30155E--

