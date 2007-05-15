Message-ID: <464982CD.8010609@domain.hid>
Date: Tue, 15 May 2007 11:52:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202BF@FR0-MAILMB20.res.airbus.corp>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C6032202BF@FR0-MAILMB20.res.airbus.corp>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5BE3C827886BBA84910B6A20"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [RTnet-users] Time scale problem.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org, rtnet-users@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5BE3C827886BBA84910B6A20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

RAKOTOSALAMA, Nirilanto wrote:
>>> Hi Everyone
>>>
>>> I'm programming a little client-server application to test=20
>> network performances with xenomai 2.3.1 and rtnet 0.9.9.
>>> The 2 programs are based on the rtnet frag-ip example.
>>> The perdiodic scenario is :
>>> - RSG program sends a datagram to the REMOTE program which=20
>> was waiting.
>>> - REMOTE sends a response to RSG.
>>> - RSG simulates a CPU performing period using rt_timer_spin.
>>> This cycle should take less than 2.5ms.
>>>
>>> I observe strange time measurement :
>>>
>>> For example when I want to run during 10 secs : 1000 cycles of 10 ms
>>> The program calculates a time between 16 and 17 secs (using=20
>> rt_timer_tsc)
>>> But the effective elapsed time (i kept time with a chrono=20
>> :-s ) is around 10secs
>>
>> Before I start looking at details, please check the=20
>> consistency of your
>> local Xenomai clock with this brand new tool:
>>
>> http://svn.gna.org/viewcvs/xenomai/trunk/src/testsuite/clockte
>> st/clocktest.c?view=3Dmarkup
>> (you don't have to switch to trunk, just grab the source and compile
>> manually)
>=20
> Ok I test it.
>=20
>> In case the Linux clock is not screwed up as well, you can check for
>> potential drifts and cross-cpu wraps that way.
>=20
> I have tested the clocktest on the 2 boxes (P4 1.7Ghz and P4 Xeon 1.7Gh=
z)
> (Note that on the 2 boxes, there's this 60% constant factor between eff=
ective=20
> and calculated time.
>=20
> on P4 :
> =3D=3D Tested clock: 0 (CLOCK_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0            -592770.4           -0.210          0            0.0
> the drift stays between -0.200us and -0.210us
>=20
> on P4 Xeon :
> =3D=3D Tested clock: 0 (CLOCK_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0             -17620.8           -0.053          0            0.0
>   1             -17620.8           -0.055          0            0.0
> the drift stays between -0.050us and -0.060us

Looks sane.

>=20
> Is it normal ? And sorry, but I don't understand what do you mean about=
 "cross-cpu wraps that way" ?

That would mean that the TSCs of the SMP box are not in sync and may
cause jumps when migrating between the CPUs or comparing time stamps of
different origins.

Anyway, you issue requires a closer look at the code:

=2E..
> rt_timer_ticks2ns(rt_timer_tsc())

Are you sure that ticks =3D=3D tsc? RTFM :->


Jan


--------------enig5BE3C827886BBA84910B6A20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGSYLPniDOoMHTA+kRAsznAJ0aTvNIgdoWCC7Q4ZRAAj80WLw4hQCePbF3
cCbt05YojdsoI2R43TSqlLk=
=XGdw
-----END PGP SIGNATURE-----

--------------enig5BE3C827886BBA84910B6A20--

