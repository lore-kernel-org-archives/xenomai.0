Message-ID: <4BCCEA8A.6030101@domain.hid>
Date: Tue, 20 Apr 2010 01:43:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1271672940.git.jan.kiszka@domain.hid>	<c6fc15b891bca9854ca9e6f8f7d07960bfcec6a2.1271672940.git.jan.kiszka@domain.hid>
	<1271715341.16659.170.camel@domain.hid>
In-Reply-To: <1271715341.16659.170.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE831509418B30729D56E17FB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v4 02/25] RTDM: Add rtdm_rt_capable()
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
--------------enigE831509418B30729D56E17FB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2010-04-19 at 12:28 +0200, Jan Kiszka wrote:
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
>> index 0fc1496..d124157 100644
>> --- a/include/rtdm/rtdm_driver.h
>> +++ b/include/rtdm/rtdm_driver.h
>> @@ -1296,6 +1296,12 @@ static inline int rtdm_in_rt_context(void)
>>  {
>>  	return (rthal_current_domain !=3D rthal_root_domain);
>>  }
>> +
>> +static inline int rtdm_rt_capable(void)
>> +{
>> +	return (!xnpod_root_p() || xnshadow_thread(current) !=3D NULL);
>> +}
>> +
>=20
> This patch still has fundamental flaw, the service would not work
> correctly and would actually return the wrong value, in case it is used=

> deeply buried into some helper code, traversed by asynchronous Xenomai
> contexts.

Using it from that contexts would be the fundamental flaw. We can catch
this, though.

> At the very least, you should avoid this by binding that
> service to a valid rtdm_dev_context, so that you know that it is called=

> from a context that is correct in the first place, where a
> rtdm_dev_context reference is available.
>=20
> I.e.=20
> static inline int rtdm_rt_capable(struct rtdm_dev_context *context), an=
d
> extract the information from that context structure. That would avoid a=

> lot of headaches down the road to your user base.

The context is not that helpful here.

But instead of using current, we can force the caller to pass the
user_info which is only available in helper context:

static inline int rtdm_rt_capable(rtdm_user_info_t *user_info)
{
	XENO_ASSERT(RTDM, !xnpod_asynch_p(), return 0;);

	return (!xnpod_root_p() ||
		(user_info && xnshadow_thread(user_info) !=3D NULL));
}

Pushed a corresponding patch.

Jan


--------------enigE831509418B30729D56E17FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvM6o4ACgkQitSsb3rl5xRt4ACfcwxL2r63YnZBMSo0DuoKFZCU
WTwAniLeicFAJg2WutywpI3LRTa+YmhF
=V+RF
-----END PGP SIGNATURE-----

--------------enigE831509418B30729D56E17FB--

