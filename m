Message-ID: <46C08E61.9060204@domain.hid>
Date: Mon, 13 Aug 2007 19:01:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>	
	<46BAF956.5090401@domain.hid>	
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>	
	<1186676576.4978.12.camel@domain.hid> <46BC1494.2010303@domain.hid>	
	<Pine.LNX.4.64.0708100951160.23969@domain.hid>	
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>	
	<46BC8074.3090104@domain.hid>	
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>	
	<18112.1512.506911.608273@domain.hid>
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
In-Reply-To: <3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEEA0DF93D1F42633D290B2AB"
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
--------------enigEEA0DF93D1F42633D290B2AB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

andy motten wrote:
>> Klaas Gadeyne wrote:
>>> On Fri, 10 Aug 2007, Jan Kiszka wrote:
>>> [..]
>>>> BTW, given that the SMI workaround is infunctional on your system: D=
o
>>>> you get reasonable latencies ATM? It looked to me like the NMI
>> watchdog
>>>> might have triggered due to SMI-related delays.
>>> We do get very reasonable latencies once the AGP functionality is
>>> turned off (otherwise, latencies are pathetic).  Note that we haven't=

>>> sorted out whether the buggy behaviour and huge latencies are due to
>>> the AGP bus in general or too the specific intel_something_els_here
>>> driver.
>> Did you try the "noaccel" option, as explained in the FAQ ?
>>
>=20
> Yes, but there was no change in performance.

You mean latency?

>=20
> We have tried several configurations of the system, and we get no hard
> lockups anymore.
> Even the configurations that used to lockup are working now without a
> problem.
>=20
> Maybe we forget something, but to be honest, we have no idea what trigg=
ered
> this change in behavior.
> Thanks for all the help.
> As soon as we know something more about this 'random' behavior, We will=
 post
> it.

And the pathetic latencies might be worth a look using the latency
tracer. Just to be sure it's no software issue. Is there any known
non-broken real-time Linux installation for your board, or did you just
try it out for the first time?

Jan


--------------enigEEA0DF93D1F42633D290B2AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwI5hniDOoMHTA+kRAl8qAJwOrnF3Ess514CRKxu24eSBRteCTACeN9hF
oCKe+9TQ9teiAFVgtzK0ztU=
=HGlg
-----END PGP SIGNATURE-----

--------------enigEEA0DF93D1F42633D290B2AB--

