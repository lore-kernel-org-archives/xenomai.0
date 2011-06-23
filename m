Message-ID: <4E03253C.6090208@domain.hid>
Date: Thu, 23 Jun 2011 13:36:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E0264CE.9060508@domain.hid> <4E02ED7E.7040204@domain.hid>
	<4E0301C4.8080605@domain.hid> <4E0302B3.3090201@domain.hid>
	<4E0323A7.2040107@domain.hid>
In-Reply-To: <4E0323A7.2040107@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF0FC82FF5EB9B12A3621A80"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RFC: use a pool of pre-allocated buffers in
	rt_printf
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
--------------enigAF0FC82FF5EB9B12A3621A80
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-06-23 13:29, Gilles Chanteperdrix wrote:
> On 06/23/2011 11:09 AM, Jan Kiszka wrote:
>> On 2011-06-23 11:05, Gilles Chanteperdrix wrote:
>>> On 06/23/2011 09:38 AM, Jan Kiszka wrote:
>>>>> +#ifdef CONFIG_XENO_FASTSYNCH
>>>>> +	if (xeno_get_current() !=3D XN_NO_HANDLE &&
>>>>> +	    !(xeno_get_current_mode() & XNRELAX) && buf_pool_get()) {
>>>>> +		struct print_buffer *old;
>>>>> +
>>>>> +		old =3D buf_pool_get();
>>>>> +		while (old !=3D buffer) {
>>>>> +			buffer =3D old;
>>>>> +			old =3D buf_pool_cmpxchg(buffer, buffer->pool_next);
>>>>
>>>> Though unlikely, it's still possible: The buffer obtained in the las=
t
>>>> round may have been dequeued meanwhile and then freed (in case a thi=
rd
>>>> buffer was released to the pool, filling it up to pool_capacity).
>>>
>>> I do not get it: it seems to me that if the current head (that is
>>> buf_pool_get()) is freed, then the cmpxchg will fail, so we will loop=

>>> and try again.
>>
>> Problematic is the dereferencing of the stale buffer pointer obtained
>> during the last cmpxchg or via buf_pool_get. This happens before the n=
ew
>> cmpxchg.
>=20
> Ok. Got it, that would be a problem only if the stale pointer pointed t=
o
> an unmapped area, but ok, better avoid freeing the buffers. I guess it
> would not be a problem as applications tend to have a fixed number of
> threads anyway.

That is a risky assumption, proven wrong e.g. by one of our
applications. Threads may always be created or destroyed depending on
the mode of an application, specifically if it is a larger one.

Jan


--------------enigAF0FC82FF5EB9B12A3621A80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4DJTwACgkQitSsb3rl5xQHKgCcDiSIsN6nbKs+7SQABcvcRTGx
KOEAoJJzj3ueh6aUx+C5mSwtln22IS2N
=l0nW
-----END PGP SIGNATURE-----

--------------enigAF0FC82FF5EB9B12A3621A80--

