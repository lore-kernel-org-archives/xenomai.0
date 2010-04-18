Message-ID: <4BCB0BC0.3000101@domain.hid>
Date: Sun, 18 Apr 2010 15:40:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>	
	<5a62361072f2d0555ba65eba6dc2d322ad2f51e9.1271596366.git.Jan
	Kiszka jan.kiszka@domain.hid>	
	<1271597170.16659.34.camel@domain.hid>
	<1271597409.16659.37.camel@domain.hid>
In-Reply-To: <1271597409.16659.37.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFF15E87D8F4A06BDDB452DBD"
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
--------------enigFF15E87D8F4A06BDDB452DBD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2010-04-18 at 15:26 +0200, Philippe Gerum wrote:
>> On Sun, 2010-04-18 at 15:12 +0200, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>>
>>> This adds rtdm_rt_capable(), a function that can be used by drivers t=
o
>>> detect callers that could issue a service request also from the
>>> (typically preferred) real-time context. If that is the case, the dri=
ver
>>> can trigger a restart of the request if the current context is not
>>> real-time.
>>>
>>> CC: Philippe Gerum <rpm@xenomai.org>
>>> CC: Alexis Berlemont <berlemont.hauw@domain.hid>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>> ---
>>>  include/rtdm/rtdm_driver.h |    6 ++++++
>>>  ksrc/skins/rtdm/drvlib.c   |   25 +++++++++++++++++++++++++
>>>  2 files changed, 31 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
>>> index 0fc1496..45be404 100644
>>> --- a/include/rtdm/rtdm_driver.h
>>> +++ b/include/rtdm/rtdm_driver.h
>>> @@ -1296,6 +1296,12 @@ static inline int rtdm_in_rt_context(void)
>>>  {
>>>  	return (rthal_current_domain !=3D rthal_root_domain);
>>>  }
>>> +
>>> +static inline int rtdm_rt_capable(void)
>>> +{
>>> +	return xnpod_shadow_p();
>>> +}
>>> +
>> This won't do what your comment states; xnpod_shadow_p() would always
>> return false on behalf of a relaxed shadow, since it tests the status
>> bits of the current Xenomai thread, which has to be the root one in th=
at
>> case. xnpod_shadow_p is to be used in primary context only, to
>> distinguish between kernel-based and userland Xenomai callers.=20
>>
>> What you want is probably something like:
>>
>> static inline int rtdm_rt_capable(void)
>> {
>> 	return xnshadow_thread(current) !=3D NULL;
>> }
>=20
> Btw, the predicate as you defined it would not work over kernel-based
> Xenomai threads. rtdm_rt_capable() is ambiguous here.

(!xnpod_root_p() || xnshadow_thread(current) !=3D NULL) ?

That would also avoid dereferencing current in a potentially unsafe
context (if we still have such problematic archs).

Jan


--------------enigFF15E87D8F4A06BDDB452DBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvLC8AACgkQitSsb3rl5xQufgCg55XmRyMOcryoqEXLFE5u6c+l
SjMAnAnqWgVOOpjj57I2ItwyGdDs+W/n
=eDJb
-----END PGP SIGNATURE-----

--------------enigFF15E87D8F4A06BDDB452DBD--

