Message-ID: <45D034FF.90900@domain.hid>
Date: Mon, 12 Feb 2007 10:35:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Multiple NIC trouble
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>	
	<17864.63903.244809.994959@domain.hid>	
	<cbe23c50702062357m6d8b913fsc65af3339ba092de@domain.hid>	
	<45C9B7C4.8050705@domain.hid>	
	<cbe23c50702080711s18459ea7le22545518bfc7c6f@domain.hid>	
	<45CB4291.408@domain.hid>	
	<cbe23c50702090849i3bfff5a0j64acbcd58163f880@domain.hid>	
	<45CCA96C.7080605@domain.hid>
	<cbe23c50702120058s2bf042d0o95bb1a69997e921a@domain.hid>
In-Reply-To: <cbe23c50702120058s2bf042d0o95bb1a69997e921a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1E78387E4984AD98D2A17231"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E78387E4984AD98D2A17231
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Eric Noulard wrote:
> 2007/2/9, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> Maybe you should enable kernel debugging and xenomai debugging. If I
>> were you, I would reserve the console for error logging, I would not u=
se
>> it to log in.
>>
>> From your logs, there is one thing you should try first: disable HPET
>> timer, since the box seems to have one and it is used by Linux, and
>> there is no support whatsoever of the HPET timer by Xenomai.
>=20
> Bingo,
>=20
> I disable HPET and xeno-test now runs just fine with no hang at all.
>=20

Interesting.

>>>>>>>>>>
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=

> worst
> RTD|       3.346|       3.622|      13.130|       0|       3.346|    =20
> 13.130
> RTD|       3.352|       3.626|      12.365|       0|       3.346|    =20
> 13.130
> RTD|       3.352|       3.629|      12.533|       0|       3.346|    =20
> 13.130
> RTD|       3.342|       3.625|      11.598|       0|       3.342|    =20
> 13.130
>>>>>>>>>>>
>=20
> Thanks to all of us for this bug hunt.
>=20
> I've just added CONFIG_HPET and CONFIG_HPET_TIMER to
> "should be avoided?" kernel option in the Wiki FAQ:
> http://www.xenomai.org/index.php/FAQs#Installation_and_Setup
>=20
> I don't know much about Kconfig syntax but I think it should be
> useful to add explicit warnings when HPET_xxx are enabled
> just as you do with APM, CPU_FREQ etc...
>=20
> I located this in linux/init/Kconfig
> and would try something like:
>=20
> comment "WARNING! You enabled HPET timer support "
>        depends on HPET || HPET_TIMER
> comment "option. These options are known to cause troubles with Xenomai=
=2E"
>        depends on HPET || HPET_TIMER

ACK.

But can someone explain *why* there is a clash? Is it due to I-pipe
injecting tick events *aside* HPET-generated ticks? I think we should
address this clash when I-pipe has to be adopted to clock_event/dyntick
in 2.6.21.

>=20
> I may try to re-enable MSI in order to see if its OK without HPET
> but with MSI.
>=20
> Thanks again.

Jan


--------------enig1E78387E4984AD98D2A17231
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0DUCniDOoMHTA+kRApGgAKCAbTmGp6NiQhSSuZGMKAEizePfmwCbBI0G
cY0Ay/9+N+csuo/8xv/CHqc=
=hzc5
-----END PGP SIGNATURE-----

--------------enig1E78387E4984AD98D2A17231--

