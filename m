Message-ID: <4E0302B3.3090201@domain.hid>
Date: Thu, 23 Jun 2011 11:09:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E0264CE.9060508@domain.hid> <4E02ED7E.7040204@domain.hid>
	<4E0301C4.8080605@domain.hid>
In-Reply-To: <4E0301C4.8080605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6625CA2A3D302851AAB6AB42"
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
--------------enig6625CA2A3D302851AAB6AB42
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-06-23 11:05, Gilles Chanteperdrix wrote:
> On 06/23/2011 09:38 AM, Jan Kiszka wrote:
>>> +#ifdef CONFIG_XENO_FASTSYNCH
>>> +	if (xeno_get_current() !=3D XN_NO_HANDLE &&
>>> +	    !(xeno_get_current_mode() & XNRELAX) && buf_pool_get()) {
>>> +		struct print_buffer *old;
>>> +
>>> +		old =3D buf_pool_get();
>>> +		while (old !=3D buffer) {
>>> +			buffer =3D old;
>>> +			old =3D buf_pool_cmpxchg(buffer, buffer->pool_next);
>>
>> Though unlikely, it's still possible: The buffer obtained in the last
>> round may have been dequeued meanwhile and then freed (in case a third=

>> buffer was released to the pool, filling it up to pool_capacity).
>=20
> I do not get it: it seems to me that if the current head (that is
> buf_pool_get()) is freed, then the cmpxchg will fail, so we will loop
> and try again.

Problematic is the dereferencing of the stale buffer pointer obtained
during the last cmpxchg or via buf_pool_get. This happens before the new
cmpxchg.

>=20
>>> @@ -346,12 +396,36 @@ static void cleanup_buffer(struct print_buffer =
*buffer)
>>>  {
>>>  	struct print_buffer *prev, *next;
>>> =20
>>> +	assert_nrt();
>>> +
>>>  	pthread_setspecific(buffer_key, NULL);
>>> =20
>>>  	pthread_mutex_lock(&buffer_lock);
>>> =20
>>>  	print_buffers();
>>
>> You also need to unhook the buffer from the active list before returni=
ng
>> it to the pool.
>=20
> We can not do that: we want that when rt_print_init takes a buffer from=

> the pool, it does not need to do any operation which would need to
> switch to secondary mode. This includes getting the active list mutex.
> So, the buffer in the pool are also in the active list, but they remain=

> empty, so, nothing will be printed.

Ah, I see.

Jan


--------------enig6625CA2A3D302851AAB6AB42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk4DArYACgkQitSsb3rl5xQWjwCgkCQoC4RkyaGh3caivN4KSoZS
lFkAoJeRZwDVUbDmPPSNzL95VZJWB0Tk
=QSZa
-----END PGP SIGNATURE-----

--------------enig6625CA2A3D302851AAB6AB42--

