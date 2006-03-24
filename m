Message-ID: <4423F0B1.5010402@domain.hid>
Date: Fri, 24 Mar 2006 14:14:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>	<4417C14A.2010900@domain.hid>	<44180FB8.7080200@domain.hid>	<17432.5656.591747.248941@domain.hid>	<44189C13.3010301@domain.hid>
	<441E9698.5080506@domain.hid> <441EAD78.3030007@domain.hid>
	<441EC03B.9000809@domain.hid> <441FF539.5050704@domain.hid>
In-Reply-To: <441FF539.5050704@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD78D712F5F9C6DEAD81BFEB"
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
--------------enigFD78D712F5F9C6DEAD81BFEB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> ...
>> On the other hand, the advantage of TSC-based synchronised inter-tick
>> timestamps is that you can do things like
>>
>>     sleep_until(rt_timer_ns2ticks(rtdm_clock_read() + 1000000))
>>
>> without risking an error beyond +/- 1 tick (+jitter). With current
>> jiffies vs. TSC in periodic mode, this is not easily possible. You hav=
e
>> to sync in the application, creating another error source when the del=
ay
>> between acquiring the TSC and sync'ing the TSC on jiffies is too long.=

>>
>=20
> The proper way to solve this is rather to emulate the periodic mode ove=
r
> the oneshot machinery, so that we stop having this +/- 1 tick error
> margin. The periodic mode as it is now is purely a x86 legacy; even on
> some ppc boards where the auto-reload feature is available from the
> decrementer, Xeno doesn't use it.
>=20
> The more I think of the x86 situation, the more I find it quite silly. =
I
> mean, picking the periodic mode means that 1) all delays can be
> expressed as multiples of a given constant interval, 2) the constant
> interval must be large enough so that you don't put your board on its
> knees, by processing useless ticks most of the time. What one saves her=
e
> - using periodic mode - is a couple of outb's per tick on the ISA bus,
> since the PIT handles this automatically without software intervention
> once set up properly. We already know that the programming overhead
> (i.e. introduced by those outb's) is perfectly bearable even for high
> frequency sampling like 10Khz loops in aperiodic mode. So why on earth
> do we care about saving two outb's and get a lousy timing accuracy in
> the same move, for constant interval delays which are necessarily going=

> to be much larger than those already supported by the aperiodic mode? E=
r...
>=20
> This is a shift in the underlying logic of the periodic mode we are
> discussing here actually. It used to be a mode where timing accuracy wa=
s
> only approximate, mostly to deal with timeouts, in the watchdog sense.
> Now, it is becoming a way to rely on a constant interval unit, while
> still keeping a high timing accuracy. I'm ok with this, since we don't
> rely on true PIT (except for x86, which is fixable) when running in
> periodic mode, so I see no problem in raising the level of timing
> accuracy of such mode. Existing stuff would not break because of such
> change, but improve instead for people who care for exact durations in
> periodic mode.

Yep, getting rid of as much periodic mode limitations as reasonable in a
transparent way sounds very good to me.

Jan


--------------enigFD78D712F5F9C6DEAD81BFEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEI/CyniDOoMHTA+kRAp35AJ9HUbtXDsR+m18+Ik4CKmYnL4E2OgCfTkWG
mSizJgExBoCeKlWfdcqVXnQ=
=NjoU
-----END PGP SIGNATURE-----

--------------enigFD78D712F5F9C6DEAD81BFEB--

