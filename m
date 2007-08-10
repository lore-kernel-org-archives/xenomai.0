Message-ID: <46BC1494.2010303@domain.hid>
Date: Fri, 10 Aug 2007 09:32:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>	
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>	
	<46BAF956.5090401@domain.hid>	
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
	<1186676576.4978.12.camel@domain.hid>
In-Reply-To: <1186676576.4978.12.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig67C6C694524B809A107AF452"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67C6C694524B809A107AF452
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-08-09 at 18:09 +0200, andy motten wrote:
>> Hello, thanks for the fast response.
>>
>> We have followed your advice:
>>  - enabled the linux debugs, nmi_watchdog debugs and Xenomai debugs.
>>  - make use of a serial console.
>>
>> The linux kernel used now is 2.6.20.9 with ipipe patch 1.8-08.
>> We use branch 2.3.x of Xenomai (Last changed Revision 2898)
>>
>> While running xeno-test, the system locks-up just after the latency
>> test.
>=20
> Confirmed here. Houston, we do have a problem with the switchtest, or
> soimething this test triggers (and not necessarily the FPU mgmt)...

Any news on this? Does it already happen by just running switchtest
stand-alone (it doesn't do so here at least)? Is this a pure 2.3.x
issue, or is it also visible for 2.4? /me currently rebuilds some trees
to assess the local situation.

Jan


--------------enig67C6C694524B809A107AF452
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGvBSVniDOoMHTA+kRAit1AJwMJ2Z0ya6elF1mxkOi2OJixKI3aACeL6Y6
UHVsxO6nsFRWkc6yIT5nCQc=
=u2S5
-----END PGP SIGNATURE-----

--------------enig67C6C694524B809A107AF452--

