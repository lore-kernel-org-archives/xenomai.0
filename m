Message-ID: <46BC8074.3090104@domain.hid>
Date: Fri, 10 Aug 2007 17:12:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>	
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>	
	<46BAF956.5090401@domain.hid>	
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>	
	<1186676576.4978.12.camel@domain.hid> <46BC1494.2010303@domain.hid>	
	<Pine.LNX.4.64.0708100951160.23969@domain.hid>
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>
In-Reply-To: <3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4B194B150DD3623E86CB91AA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: andy motten <andy.motten@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B194B150DD3623E86CB91AA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

andy motten wrote:
> 2007/8/10, Klaas Gadeyne <klaas.gadeyne@domain.hid>:
>> On Fri, 10 Aug 2007, Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>>> The linux kernel used now is 2.6.20.9 with ipipe patch 1.8-08.
>>>>> We use branch 2.3.x of Xenomai (Last changed Revision 2898)
>>>>>
>>>>> While running xeno-test, the system locks-up just after the latency=

>>>>> test.
>>>> Confirmed here. Houston, we do have a problem with the switchtest, o=
r
>>>> soimething this test triggers (and not necessarily the FPU mgmt)...
>>> Any news on this? Does it already happen by just running switchtest
>>> stand-alone (it doesn't do so here at least)? Is this a pure 2.3.x
>>> issue, or is it also visible for 2.4? /me currently rebuilds some tre=
es
>>> to assess the local situation.
>> Andy will probably continue testing today, so more info will follow, b=
ut
>> (see
>> <https://mail.gna.org/public/xenomai-help/2007-08/msg00044.html>) at
>> first sight we encountered similar issues on trunk (2.2.x seems
>> unaffected).
>>
>> Klaas
>=20
>=20
> We have disabled NMI watchdog like Gilles Chanteperdrix suggested in hi=
s
> previous message.
>=20
> For the moment We have no hard locks anymore. The linux kernel used is =
still
> 2.6.20.9 with ipipe patch 1.8-08.
> We use branch 2.3.x of Xenomai (Last changed Revision 2898). The only t=
hing
> We have changed is turning off the "NMI watchdog".
>=20
> There is no obvious reason why this happened (according to us), but it =
may
> have something to do with the AGP bus (we turned it OFF in this kernel,=
 it
> was already turned OFF in the previous tests, but it was ON in the firs=
t
> tests).

Yet another broken x86 system...?

>=20
> For seeing if this system will not hard lock anymore, the system will s=
tay
> on this weekend (continuously running xeno-tests with high loads). We w=
ill
> inform you of the results after the weekend.

BTW, given that the SMI workaround is infunctional on your system: Do
you get reasonable latencies ATM? It looked to me like the NMI watchdog
might have triggered due to SMI-related delays.

[/me still wonders what Philippe found...]

Jan


--------------enig4B194B150DD3623E86CB91AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGvIB0niDOoMHTA+kRAsfxAJ4lrlx1YHS0rjy+CUa66vSyGq+FPwCfc1Y9
/78r8sas2gBKnbW6ikMB0hY=
=w5ZX
-----END PGP SIGNATURE-----

--------------enig4B194B150DD3623E86CB91AA--

