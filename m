Message-ID: <46167701.7060004@domain.hid>
Date: Fri, 06 Apr 2007 18:36:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Getting the clock model right
References: <46163817.3060007@domain.hid> <46164F5D.4080301@domain.hid>
	<46165943.3050706@domain.hid> <46166396.9080400@domain.hid>
In-Reply-To: <46166396.9080400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAEE7A4E2B8BB8F290B7F4347"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEE7A4E2B8BB8F290B7F4347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Hi,
>>>>
>>>> recent announcement of some new TSC synchronisation feature in RTAI =
made
>>>> me stick my nose into this and think about the whole issue of clock
>>>> synchronisation again. Well, let's not talk about RTAI details here,=
 but
>>>> they got one thing right: as long as we cannot handle unsynch'ed TSC=
 on
>>>> SMP, we need some detection and alarming as the bare minimum.
>>>>
>>>> Why can't we handle such cases yet? First, there seems to be still s=
ome
>>>> bugs hidden in the core (one example: xntimer_start_aperiodic() uses=
 the
>>>> local time stamp to start a remote timer).
>>> Reading the code, there seem to be only two places where the local ts=
c
>>> is used to set a remote timer, it is xntimer_start_aperiodic, and
>>> xntimer_move_aperiodic, which is used by xntimer_migrate. So we are l=
eft
>>> with only one bug: starting a timer on the remote CPU, this could eas=
ily
>>> be implemented with a queue which would be handled by the timer IPI.
>>>
>>
>> As I said: fixable based on thorough review - but only a minor part of=

>> the problem.
>=20
> I fail to see the remaining part of the problem.
>=20

Consider a simple scenario consisting of a shared communication device
over which packets arrive and get time-stamped. Now, if applications
that receive those packets sit on different, unsynchronised CPUs, they
have to know on which CPU the time stamps were taken in order to relate
them to other events correctly. Basically the same issue you have on
distributed systems as well.

If we leave the user with broken local clocks, we _must_ provide the
information about the clock source. There are always scenarios where you
_cannot_ separate your applications in a way that they run totally
independent on different CPUs. And then we should provide means to
synchronise the clocks, or the user has to re-invent the wheel over and
over again. Given the latter, doing this inside the core in a
transparent manner is far smarter.

Jan


--------------enigAEE7A4E2B8BB8F290B7F4347
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGFncBniDOoMHTA+kRArZSAJ9jC6cs3+VDZeKwG7aAuV8UbGTCLACaAt7p
Hh1ZivlUmi5XiLkPBpfZzyc=
=q5SE
-----END PGP SIGNATURE-----

--------------enigAEE7A4E2B8BB8F290B7F4347--

