Message-ID: <4CD33F0C.1050403@domain.hid>
Date: Fri, 05 Nov 2010 00:17:32 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CD14B1E.4000707@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>	<4CD18782.7090607@domain.hid>	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>	<4CD1BA29.9000303@domain.hid>	<1288816871.1842.84.camel@domain.hid>	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>	<4CD1E890.5010702@domain.hid>
	<4CD1EC2F.4040603@domain.hid>	<4CD1ED16.8030103@domain.hid>
	<4CD1EDA8.10007@domain.hid>	<4CD1F33C.5070208@domain.hid>
	<4CD1F3F5.5080505@domain.hid>	<4CD1F4FE.9020908@domain.hid>
	<4CD1F69B.9070100@domain.hid>	<4CD1F906.1070703@domain.hid>
	<4CD1FABD.1080301@domain.hid>	<4CD2612C.2070507@domain.hid>
	<4CD279F7.7070502@domain.hid>	<4CD27C46.8010302@domain.hid>
	<4CD27DC2.7060607@domain.hid>	<4CD2A96B.3080001@domain.hid>
	<4CD2B2A7.9010900@domain.hid>	<4CD2C50F.1090604@domain.hid>
	<4CD32E76.3080004@domain.hid>
In-Reply-To: <4CD32E76.3080004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1525102AEEEDE03C4491194C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1525102AEEEDE03C4491194C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 04.11.2010 23:06, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>>>> At first sight, here you are more breaking things than cleaning them=
=2E
>>> Still, it has the SMP record for my test program, still runs with ftr=
ace=20
>>> on (after 2 hours, where it previously failed after maximum 23 minute=
s).
>>
>> My version was indeed still buggy, I'm reworking it ATM.
>>
>>> If I get the gist of Jan's changes, they are (using the IPI to transf=
er=20
>>> one bit of information: your cpu needs to reschedule):
>>>
>>> xnsched_set_resched:
>>> -      setbits((__sched__)->status, XNRESCHED);
>>>
>>> xnpod_schedule_handler:
>>> +	xnsched_set_resched(sched);
>>> =09
>>> If you (we?) decide to keep the debug checks, under what circumstance=
s=20
>>> would the current check trigger (in laymans language, that I'll be ab=
le=20
>>> to understand)?
>>
>> That's actually what /me is wondering as well. I do not see yet how yo=
u
>> can reliably detect a missed reschedule reliably (that was the purpose=

>> of the debug check) given the racy nature between signaling resched an=
d
>> processing the resched hints.
>=20
> The purpose of the debugging change is to detect a change of the
> scheduler state which was not followed by setting the XNRESCHED bit.

But that is nucleus business, nothing skins can screw up (as long as
they do not misuse APIs).

> Getting it to work is relatively simple: we add a "scheduler change set=

> remotely" bit to the sched structure which is NOT in the status bit, se=
t
> this bit when changing a remote sched (under nklock). In the debug chec=
k
> code, if the scheduler state changed, and the XNRESCHED bit is not set,=

> only consider this a but if this new bit is not set. All this is
> compiled out if the debug is not enabled.

I still see no benefit in this check. Where to you want to place the bit
set? Aren't that just the same locations where
xnsched_set_[self_]resched already is today?

But maybe you can provide some motivating bug scenarios, real ones of
the past or realistic ones of the future.

Jan


--------------enig1525102AEEEDE03C4491194C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzTPxEACgkQitSsb3rl5xSYoACeLXleakLsOXZ+ATtPMS0iyNmE
6qMAnihPNZ4KOE5MaXxs9Kc+JgJ95bW3
=u8Vk
-----END PGP SIGNATURE-----

--------------enig1525102AEEEDE03C4491194C--

