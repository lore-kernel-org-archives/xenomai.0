Message-ID: <46167B46.6010902@domain.hid>
Date: Fri, 06 Apr 2007 18:54:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Getting the clock model right
References: <46163817.3060007@domain.hid> <46164F5D.4080301@domain.hid>
	<46165943.3050706@domain.hid> <461677BB.1090301@domain.hid>
In-Reply-To: <461677BB.1090301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA1E61F0D681835060BC2BC20"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1E61F0D681835060BC2BC20
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
>>
>>
>>>> (...)
>>>> for smoothly adjusting clocks during runtime would be great. I'm
>>>> thinking about a generic infrastructure to synchronise the Xenomai t=
ime
>>>> on external sources (=3D>distributed clocks).
>>> What do you want, NTP ? Or calling xnpod_settime periodically ?
>>>
>>
>> More like NTP: monotonic clocks that can be derived from custom
>> synchronisation signals, maybe optimised/simplified with fact in mind
>> that those signals should have bounded worst-case jitters (on a hard
>> real-time system like Xenomai).
>>
>> We just implemented such synchronisation based on CAN and serial
>> null-modem signals. RTnet comes with a high-quality distributed clock =
as
>> well. We have not yet implemented a smart clock adjustment (specifical=
ly
>> because our application only needs about 1 millisecond accuracy).
>=20
> What about emitting Adeos events when receiving NTP corrections ? This
> way, we would avoid reinventing NTP ?
>=20

IIRC, NTP was designed to synchronise clocks over unreliable and slow
media. The math behind it /may/ be useful (though it may also turn out
to be too heavy), but beyond that... Already seen a NTP-over-CAN
realisation, e.g.?

And what would NTP over standard network buy us on a Xenomai system when
the accuracy of NTP time stamps taken under Linux gets additionally
degraded by Xenomai activity? I thought about NTP for our problem for a
short while, but then quickly dropped the idea due to lacking guarantees.=


Likely, we rather need something like IEEE 1588, but there are
unfortunate patents around that protocol.


--------------enigA1E61F0D681835060BC2BC20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGFntGniDOoMHTA+kRAn3NAJ9QkVYPl4qSXUpZdFyR0dfsm2f5ZgCeKfty
uAfxUN+UN2IjInzfjSBdZOg=
=z1z0
-----END PGP SIGNATURE-----

--------------enigA1E61F0D681835060BC2BC20--

