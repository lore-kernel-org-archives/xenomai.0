Message-ID: <4BCB096D.5040404@domain.hid>
Date: Sun, 18 Apr 2010 15:30:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1271596366.git.Jan Kiszka
	jan.kiszka@domain.hid>	<5a62361072f2d0555ba65eba6dc2d322ad2f51e9.1271596366.git.Jan
	Kiszka	jan.kiszka@domain.hid>
	<1271597170.16659.34.camel@domain.hid>
In-Reply-To: <1271597170.16659.34.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig90B884E86E83295AB6D0C3F1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v3 02/24] RTDM: Add rtdm_rt_capable()
	service
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90B884E86E83295AB6D0C3F1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2010-04-18 at 15:12 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> This adds rtdm_rt_capable(), a function that can be used by drivers to=

>> detect callers that could issue a service request also from the
>> (typically preferred) real-time context. If that is the case, the driv=
er
>> can trigger a restart of the request if the current context is not
>> real-time.
>>
>> CC: Philippe Gerum <rpm@xenomai.org>
>> CC: Alexis Berlemont <berlemont.hauw@domain.hid>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>  include/rtdm/rtdm_driver.h |    6 ++++++
>>  ksrc/skins/rtdm/drvlib.c   |   25 +++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
>> index 0fc1496..45be404 100644
>> --- a/include/rtdm/rtdm_driver.h
>> +++ b/include/rtdm/rtdm_driver.h
>> @@ -1296,6 +1296,12 @@ static inline int rtdm_in_rt_context(void)
>>  {
>>  	return (rthal_current_domain !=3D rthal_root_domain);
>>  }
>> +
>> +static inline int rtdm_rt_capable(void)
>> +{
>> +	return xnpod_shadow_p();
>> +}
>> +
>=20
> This won't do what your comment states; xnpod_shadow_p() would always
> return false on behalf of a relaxed shadow, since it tests the status
> bits of the current Xenomai thread, which has to be the root one in tha=
t
> case. xnpod_shadow_p is to be used in primary context only, to
> distinguish between kernel-based and userland Xenomai callers.=20
>=20
> What you want is probably something like:
>=20
> static inline int rtdm_rt_capable(void)
> {
> 	return xnshadow_thread(current) !=3D NULL;
> }
>=20

Thanks, will fix.

Jan

PS: Sorry for the From: mess - user error while feeding my posting script=
=2E


--------------enig90B884E86E83295AB6D0C3F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvLCXMACgkQitSsb3rl5xT6ZQCgxnyeESwSsuBgXWOEzsG82LjL
z5AAmgNz3IQ/cvT3Lcgv/0mVVAfmW8cB
=eeLi
-----END PGP SIGNATURE-----

--------------enig90B884E86E83295AB6D0C3F1--

