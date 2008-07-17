Message-ID: <487F26A5.1040908@domain.hid>
Date: Thu, 17 Jul 2008 13:01:57 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <487B8B3E.8020805@domain.hid> <487B91F6.3070909@domain.hid>
	<487BA305.6040401@domain.hid> <487BB89B.6010604@domain.hid>
	<487BF171.2090902@domain.hid> <487C42CB.5080405@domain.hid>
	<487DCCA4.60509@domain.hid> <487E6557.8060109@domain.hid>
In-Reply-To: <487E6557.8060109@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7307252B277867E6B5D7747F"
Subject: Re: [Xenomai-help] rt_task_bind() and timeout values
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
--------------enig7307252B277867E6B5D7747F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

your new patch works with TM_NONBLOCK und user timeouts,
but bind now fails for TM_INFINITE: it returns immediately with ETIMEDOUT=
=2E..

Philippe Gerum schrieb:
> Stefan Kisdaroczi wrote:
>> Hi,
>>
>> your patch didnt work. The bind_calls are now blocking infinite (at
>> least much too long, still waiting...)
>> To compile i had to change following line in your patch:
>> -    if (timeout !=3D TM_NONBLOCK && timeout !=3D TM_INFINITE)
>> +    if (timeout !=3D XN_NONBLOCK && timeout !=3D XN_INFINITE)
>>
>=20
> Ok, fair enough. This one has been tested. No kidding.
>=20
> --- ksrc/nucleus/registry.c	(revision 4050)
> +++ ksrc/nucleus/registry.c	(revision 4051)
> @@ -711,7 +711,6 @@
>  	xnobject_t *object;
>  	xnthread_t *thread;
>  	xntbase_t *tbase;
> -	xnticks_t stime;
>  	int err =3D 0;
>  	spl_t s;
>=20
> @@ -723,7 +722,8 @@
>=20
>  	xnlock_get_irqsave(&nklock, s);
>=20
> -	stime =3D xntbase_get_time(tbase);
> +	if (timeout !=3D XN_INFINITE && timeout !=3D XN_NONBLOCK)
> +		timeout +=3D xntbase_get_time(tbase);
>=20
>  	for (;;) {
>  		object =3D registry_hash_find(key);
> @@ -738,18 +738,8 @@
>  			goto unlock_and_exit;
>  		}
>=20
> -		if (timeout !=3D XN_INFINITE) {
> -			xnticks_t now =3D xntbase_get_time(tbase);
> -
> -			if (stime + timeout >=3D now)
> -				break;
> -
> -			timeout -=3D (now - stime);
> -			stime =3D now;
> -		}
> -
>  		thread->registry.waitkey =3D key;
> -		xnsynch_sleep_on(&registry_hash_synch, timeout, XN_RELATIVE);
> +		xnsynch_sleep_on(&registry_hash_synch, timeout, XN_REALTIME);
>=20
>  		if (xnthread_test_info(thread, XNTIMEO)) {
>  			err =3D -ETIMEDOUT;
>=20
>> I will use following patch for the moment, this works.
>>
>> --- xenomai/nucleus/registry.c.old    2008-07-15 00:36:10.000000000 +0=
200
>> +++ xenomai/nucleus/registry.c    2008-07-15 15:28:23.000000000 +0200
>> @@ -733,8 +733,10 @@ int xnregistry_bind(const char *key, xnt
>>          if (timeout !=3D XN_INFINITE) {
>>              xnticks_t now =3D xntbase_get_time(tbase);
>>
>> -            if (stime + timeout >=3D now)
>> -                break;
>> +            if (stime + timeout <=3D now) {
>> +                err =3D -ETIMEDOUT;
>> +                goto unlock_and_exit;
>> +            }      =20
>>
>>              timeout -=3D (now - stime);
>>              stime =3D now;
>>
>>
>> Philippe Gerum schrieb:
>>> Stefan Kisdaroczi wrote:
>>>> Hi Philippe,
>>>>
>>>> the attached patch fixed the problem for me.
>>> Good spot. Now it's official, since four years that feature exists or=

>>> so, nobody
>>> actually used registry timeouts... Oh, well...
>>>
>>>> However, i think that in the "break case" still EACCES is returned.
>>>> Can the break be replaced with a "return ETIMEDOUT" ?
>>>>
>>> Yes, normally we should do that along with your patch. Actually, the =
most
>>> appropriate fix would be to use an absolute timeout value internally,=

>>> since the
>>> nucleus allows it.
>>>
>>> --- ksrc/nucleus/registry.c    (revision 4044)
>>> +++ ksrc/nucleus/registry.c    (working copy)
>>> @@ -711,7 +711,6 @@
>>>      xnobject_t *object;
>>>      xnthread_t *thread;
>>>      xntbase_t *tbase;
>>> -    xnticks_t stime;
>>>      int err =3D 0;
>>>      spl_t s;
>>>
>>> @@ -723,7 +722,8 @@
>>>
>>>      xnlock_get_irqsave(&nklock, s);
>>>
>>> -    stime =3D xntbase_get_time(tbase);
>>> +    if (timeout !=3D TM_NONBLOCK && timeout !=3D TM_INFINITE)
>>> +        timeout +=3D xntbase_get_time(tbase);
>>>
>>>      for (;;) {
>>>          object =3D registry_hash_find(key);
>>> @@ -738,18 +738,8 @@
>>>              goto unlock_and_exit;
>>>          }
>>>
>>> -        if (timeout !=3D XN_INFINITE) {
>>> -            xnticks_t now =3D xntbase_get_time(tbase);
>>> -
>>> -            if (stime + timeout >=3D now)
>>> -                break;
>>> -
>>> -            timeout -=3D (now - stime);
>>> -            stime =3D now;
>>> -        }
>>> -
>>>          thread->registry.waitkey =3D key;
>>> -        xnsynch_sleep_on(&registry_hash_synch, timeout, XN_RELATIVE)=
;
>>> +        xnsynch_sleep_on(&registry_hash_synch, timeout, XN_ABSOLUTE)=
;
>>>
>>>          if (xnthread_test_info(thread, XNTIMEO)) {
>>>              err =3D -ETIMEDOUT;
>>>  --
>>> Philippe.
>>>
>>>
>>
>=20
>=20



--------------enig7307252B277867E6B5D7747F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFIfyamIPTw9rIdn6oRAouWAJjmvnyVBO8wDLXrF1r5Mao3R1c+AJ9ppiTP
oh16OgbWBe7A3FVZFV8JnQ==
=eYe9
-----END PGP SIGNATURE-----

--------------enig7307252B277867E6B5D7747F--

