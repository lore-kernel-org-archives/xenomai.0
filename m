Message-ID: <4CD1ED16.8030103@domain.hid>
Date: Thu, 04 Nov 2010 00:15:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>	<4CD11AB1.8090407@domain.hid>	<4CD13A70.8040702@domain.hid>	<4CD14B1E.4000707@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>	<4CD18782.7090607@domain.hid>	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>	<4CD1BA29.9000303@domain.hid>	<1288816871.1842.84.camel@domain.hid>
	<4CD1DC1B.8060407@domain.hid>	<4CD1DE12.5010309@domain.hid>
	<4CD1E890.5010702@domain.hid> <4CD1EC2F.4040603@domain.hid>
In-Reply-To: <4CD1EC2F.4040603@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig79932FC75C592F9760550CDA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79932FC75C592F9760550CDA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 04.11.2010 00:11, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Am 03.11.2010 23:11, Jan Kiszka wrote:
>>> Am 03.11.2010 23:03, Jan Kiszka wrote:
>>>> But we not not always use atomic ops for manipulating status bits (b=
ut
>>>> we do in other cases where this is no need - different story). This =
may
>>>> fix the race:
>>> Err, nonsense. As we manipulate xnsched::status also outside of nkloc=
k
>>> protection, we must _always_ use atomic ops.
>>>
>>> This screams for a cleanup: local-only bits like XNHTICK or XNINIRQ
>>> should be pushed in a separate status word that can then be safely
>>> modified non-atomically.
>>
>> Second try to fix and clean up the sched status bits. Anders, please
>> test.
>>
>> Jan
>>
>> diff --git a/include/nucleus/pod.h b/include/nucleus/pod.h
>> index 01ff0a7..5987a1f 100644
>> --- a/include/nucleus/pod.h
>> +++ b/include/nucleus/pod.h
>> @@ -277,12 +277,10 @@ static inline void xnpod_schedule(void)
>>  	 * context is active, or if we are caught in the middle of a
>>  	 * unlocked context switch.
>>  	 */
>> -#if XENO_DEBUG(NUCLEUS)
>>  	if (testbits(sched->status, XNKCOUT|XNINIRQ|XNSWLOCK))
>>  		return;
>> -#else /* !XENO_DEBUG(NUCLEUS) */
>> -	if (testbits(sched->status,
>> -		     XNKCOUT|XNINIRQ|XNSWLOCK|XNRESCHED) !=3D XNRESCHED)
>> +#if !XENO_DEBUG(NUCLEUS)
>> +	if (!sched->resched)
>>  		return;
>>  #endif /* !XENO_DEBUG(NUCLEUS) */
>=20
> Having only one test was really nice here, maybe we simply read a
> barrier before reading the status?
>=20

I agree - but the alternative is letting all modifications of
xnsched::status use atomic bitops (that's required when folding all bits
into a single word). And that should be much more costly, specifically
on SMP.

Jan


--------------enig79932FC75C592F9760550CDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzR7RkACgkQitSsb3rl5xSdAgCgvV+yWpvWbcLoSVTDGFU0erN3
CksAnjXB1bPFy0bAzPLq5q9LdYXPs0cz
=lDqe
-----END PGP SIGNATURE-----

--------------enig79932FC75C592F9760550CDA--

