Message-ID: <48F8753C.5000901@domain.hid>
Date: Fri, 17 Oct 2008 13:21:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.644116499@domain.hid>	<48F7A064.20404@domain.hid>
	<48F7C5D1.3010500@domain.hid>	<48F855DB.3070300@domain.hid>
	<48F86F6A.1010801@domain.hid> <48F86FED.2010409@domain.hid>
	<48F8738E.8070709@domain.hid>
In-Reply-To: <48F8738E.8070709@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB78021062AFFC45F9F173F39"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 08/12] Use fast xnsynch with native skin
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB78021062AFFC45F9F173F39
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>
>>>>>> Same remark for the #ifdefs.
>>>>> Yes, but most cases (maybe except for owner checking) are unavoidab=
le
>>>>> due to heavy differences. I hope that we may have only FASTXNSYCH a=
rchs
>>>>> one day.
>>>>>
>>>>>> I also do not understand your modification
>>>>>> of rt_cond_wait_inner, this code is very tense; posix and native h=
ad the
>>>>>> same bug in this area at different times, so this change should pr=
obably
>>>>>> be made separately.
>>>>> Which modification precisely (damn, I need to find out what makes q=
uilt
>>>>> cause this attachment confusion)? Note that lockcnt tracking change=
d
>>>>> with this patch: the lock owner himself is in charge of maintaining=
 it,
>>>>> not some thread handing the lock over.
>>>>>
>>>>> That said, I would happily analyse the case that broke before. I wi=
ll
>>>>> also check if I can break out the lockcnt maintenance change, but I=

>>>>> think to recall that it was coupled to the fast path changes.
>>>> The point is that in case of rt_cond_wait, the mutex must unlock
>>>> completely regardless of the current lock count. So, the count is se=
t to
>>>> 1 before calling the function which unlocks the last level of the
>>>> recursion count. As far as I can see, you removed the part which set=
s
>>>> the counter to 1.
>>>>
>>> Don't find that spot. Are we talking about this change or something e=
lse?
>>>
>>>> --- a/ksrc/skins/native/cond.c
>>>> +++ b/ksrc/skins/native/cond.c
>>>> @@ -407,24 +407,26 @@ int rt_cond_wait_inner(RT_COND *cond, RT
>>> ...
>>>>  	mutex->lockcnt =3D 0;
>>>> =20
>>>> -	if (xnsynch_release(&mutex->synch_base)) {
>>>> -		mutex->lockcnt =3D 1;
>>>> -		/* Scheduling deferred */
>>>> -	}
>>>> +	xnsynch_release(&mutex->synch_base);
>>>> +	/* Scheduling deferred */
>>>> =20
>>>>  	xnsynch_sleep_on(&cond->synch_base, timeout, timeout_mode);
>>>> =20
>>> In case it's the above: That setting of lockcnt is actually on behalf=
 of
>>> the new owner (xnsynch_release !=3D NULL =3D> we woke up a new owner)=
=2E And
>>> that has been sanitized in the patch in so far that only the owner
>>> manipulates lockcnt, always. If you see a remaining issue in this
>>> approach or find a hole in the implementation, please let me know.
>> Who sets the lockcnt to 0 if there is no next owner ?
>=20
> Ok. It appears in the code you quoted. However, your modification
> changes the behaviour of the mutex code:
>=20
> with the old version, the mutex will appear locked if an owner has been=

> woken up
> with the new version, the mutex will appear unlocked between the time
> when a new owner has been woken up and the time this new owner gets out=

> of xnsynch_acquire, allowing the lock to be stolen by another thread.

But that is what cond_wait is about: releasing the associated lock to
whoever gets it - either directly or via lock-stealing. I see no problem
here. Moreover, lockcnt is never used (and must not!) as an indication
if a lock is free. It is a pure helper for the lock owner to track
recursion. And it is also no longer consistent between kernel and user
side, another reason to allow only the lock owner to play with it.

Jan


--------------enigB78021062AFFC45F9F173F39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj4dTwACgkQniDOoMHTA+mQOwCeLKjRliJBA0LKPeSm9MN5qTiW
t9cAn25kWAhdo3TVtnAv7QqMPLHE0Y3d
=me/P
-----END PGP SIGNATURE-----

--------------enigB78021062AFFC45F9F173F39--

