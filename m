Message-ID: <4E359B1D.7020508@domain.hid>
Date: Sun, 31 Jul 2011 20:12:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QnZD3-00080U-DV@xenomai.org> <4E358F10.7070203@domain.hid>
	<4E359412.4090309@domain.hid> <4E35950E.6000900@domain.hid>
In-Reply-To: <4E35950E.6000900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE2B91206B5948728E19D96A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : rt_print: Provide
	rt_puts
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE2B91206B5948728E19D96A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-31 19:46, Gilles Chanteperdrix wrote:
> On 07/31/2011 07:42 PM, Jan Kiszka wrote:
>> On 2011-07-31 19:21, Gilles Chanteperdrix wrote:
>>> On 07/31/2011 06:49 PM, GIT version control wrote:
>>>> +int rt_puts(const char *s)
>>>> +{
>>>> +	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, NULL);
>>>> +}
>>>
>>> gcc for ARM chokes here: it says that NULL can not be converted to a
>>> va_list, however I try it.
>>
>> Hmm. Does this work?
>>
>> diff --git a/src/skins/common/rt_print.c b/src/skins/common/rt_print.c=

>> index 186de48..52538d8 100644
>> --- a/src/skins/common/rt_print.c
>> +++ b/src/skins/common/rt_print.c
>> @@ -243,7 +243,9 @@ int rt_printf(const char *format, ...)
>>
>>  int rt_puts(const char *s)
>>  {
>> -	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, NULL);
>> +	va_list dummy;
>> +
>> +	return print_to_buffer(stdout, 0, RT_PRINT_MODE_PUTS, s, dummy);
>>  }
>>
>>  void rt_syslog(int priority, const char *format, ...)
>>
>>
>> Not really beautiful as well, I know.
>=20
> It seems to work now, but some later version of gcc may decide to warn
> us that this argument is used without being initialized...

Yes. I've pushed a cleaner version.

Jan


--------------enigAE2B91206B5948728E19D96A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk41mx8ACgkQitSsb3rl5xTZtwCgiab8Y0OkvKdFEEyROO0rTAZ0
37YAoNXXRAllqUcJhv8KlPiMWQzQxl5G
=+I1O
-----END PGP SIGNATURE-----

--------------enigAE2B91206B5948728E19D96A--

