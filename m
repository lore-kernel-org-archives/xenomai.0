Message-ID: <4E031097.2090409@domain.hid>
Date: Thu, 23 Jun 2011 12:08:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>	<4E01CA9A.2040709@domain.hid>	<17296_1308741006_4E01CD8E_17296_18611_1_ECB646CBB62FD044927FDEDF0252D3E701E388B361AA@THSONEA01CMS03P.one.grp>	<4E01CE25.2020202@domain.hid>	<17288_1308741885_4E01D0FD_17288_343_1_ECB646CBB62FD044927FDEDF0252D3E701E388B36206@domain.hid>	<4E01E0EE.90002@domain.hid>	<18303_1308746837_4E01E455_18303_6972_2_ECB646CBB62FD044927FDEDF0252D3E701E388B3645B@THSONEA01CMS03P.one.grp>	<4E01E62D.8050504@domain.hid>	<18217_1308821465_4E0307D9_18217_13108_1_ECB646CBB62FD044927FDEDF0252D3E701E388B85F94@domain.hid>
	<4E030D1D.5080406@domain.hid>
In-Reply-To: <4E030D1D.5080406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD4BAB46F9132FAF44B617132"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Kernel panic on boot with 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: varname <varname@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD4BAB46F9132FAF44B617132
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-23 11:53, varname wrote:
> VEYSSIERE Nicolas wrote:
>> Found the problem !
>>
>> It works on an Intel E5400 processor (for the host) but not on an
>> Intel E2140
>=20
> So what was the problem? Looking at [1], I guess support for VT-x?
>=20

Running without VT-x means that vbox emulates a CPU. And that may be a
different type than what your guest kernel expects. Or that the modeling
is incomplete or buggy.

Virtualization without VT-x/AMD-V is no good idea anyway (way too slow).

Jan



--------------enigD4BAB46F9132FAF44B617132
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4DEJcACgkQitSsb3rl5xTaLgCfeadUGRguV1FLnxYcnYAL3rlt
e/8An3ZjCIOtFRO/paR5fL4WtnMqlPOR
=A4F2
-----END PGP SIGNATURE-----

--------------enigD4BAB46F9132FAF44B617132--

