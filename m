Message-ID: <4415BB0D.8070808@domain.hid>
Date: Mon, 13 Mar 2006 19:33:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM and Timer functions
References: <200603091443.25714.lbocseg@domain.hid>
	<4411C646.80802@domain.hid>	<17429.43814.412464.35016@domain.hid>
	<200603131431.35216.lbocseg@domain.hid>
In-Reply-To: <200603131431.35216.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB4FAFC26038DFA45A007DEE3"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4FAFC26038DFA45A007DEE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Segunda 13 Mar=E7o 2006 14:25, Gilles Chanteperdrix escreveu:
>=20
>> Jan Kiszka wrote:
>>>> Sometimes the result is "Should be near 84000: 100000", that is kind=
 of
>>>> correct, since the tickval is 100000, although I think that those
>>>> functions in the RTDM driver context should be independent of the ti=
ck
>>>> value set by the user program... Maybe using oneshot in the driver
>>>> calls and periodic in the application... I really don't know what wo=
uld
>>>> be the best approach here...
>>> rtdm_clock_read always uses the nucleus clock. Using something differ=
ent
>>> (e.g. always TSC) would break applications specifying absolute times
>>> derived from the return values of other skins' functions.
>> Maybe adding a service to RTDM would allow users to measure short time=

>> intervals with RTDM using the TSC ?
>>
>> The native (rt_timer_tsc()) and posix (clock_gettime(CLOCK_MONOTONIC))=

>> skins have a way to do this.
>=20
> This would fit great for my needs (and most developers I think)!
>=20

Will think about it. Actually, I'm not a big fan of this. It creates the
risk that someone feeds the output of this service into (incompatible)
timed RTDM services. Even worse, this would work for aperiodic mode but
fail for periodic.

We would definitely need a good name for it,
rtdm_clock_read_ex(<clock-id>), rtdm_clock_read_tsc(),
rtdm_clock_read_monotonic()? I'm not going to break rtdm_clock_read() by
adding an argument (otherwise, I would have to fix too many drivers on
my own... :-/).

Jan


--------------enigB4FAFC26038DFA45A007DEE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFbsNniDOoMHTA+kRAuYrAJ0fyR6rK8YbUFowtuDTsBFSDcbgCgCdEA/3
/WuKCuMCABi3kgoVpvJB9zo=
=1knq
-----END PGP SIGNATURE-----

--------------enigB4FAFC26038DFA45A007DEE3--

