Message-ID: <4B8D8617.9060501@domain.hid>
Date: Tue, 02 Mar 2010 22:41:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B8D55AD.9090901@domain.hid>	<4B8D5768.7080402@domain.hid>	<4B8D57D4.3040200@domain.hid>	<4B8D58AB.8090203@domain.hid>
	<4B8D58F7.80507@domain.hid> <4B8D73F9.3020309@domain.hid>
In-Reply-To: <4B8D73F9.3020309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4AB00128CB54088EA3B0BE6F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Posix mutex unit test fails on git head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4AB00128CB54088EA3B0BE6F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles,
>>>>>>
>>>>>> can you (or someone else) confirm this:
>>>>>>
>>>>>> # mutex-torture-posix
>>>>>> simple_wait
>>>>>> simple mutex_lock 1: 1 (Operation not permitted)
>>>>>>
>>>>>> I'm on a x86_64 target (2.6.32.8 with latest I-pipe), Xenomai is
>>>>>> unpatched git head.
>>>>>>
>>>>> Looks like a bug in the test case: We do not wrap sched_setschedule=
r
>>>>> which it uses, and my config does not auto-shadow main. Fix will fo=
llow.
>>>> The test works here, but fails in cond_signaler, mutex_lock 2, just
>>>> checked out v2.5.1 to see if we already had the bug.
>>>>
>>> Weird. Works for me with this fix:
>>>
>>> diff --git a/src/testsuite/unit/mutex-torture.c b/src/testsuite/unit/=
mutex-torture.c
>>> index 70bda14..ebdd4f2 100644
>>> --- a/src/testsuite/unit/mutex-torture.c
>>> +++ b/src/testsuite/unit/mutex-torture.c
>>> @@ -657,7 +657,7 @@ int main(void)
>>>  	/* Set scheduling parameters for the current process */
>>>  #ifdef XENO_POSIX
>>>  	sparam.sched_priority =3D 2;
>>> -	sched_setscheduler(0, SCHED_FIFO, &sparam);
>>> +	pthread_setschedparam(pthread_self(), SCHED_FIFO, &sparam);
>>>  #else /* __NATIVE_SKIN__ */
>>>  	rt_task_shadow(&main_tid, "main_task", 2, 0);
>>>  #endif /* __NATIVE_SKIN__ */
>>>
>>>
>>> # mutex-torture-posix
>>> simple_wait
>>> recursive_wait
>>> errorcheck_wait
>>> mode_switch
>>> pi_wait
>>> lock_stealing
>>> lock_stealing mutex_trylock: not supported
>>> simple_condwait
>>> recursive_condwait
>>> cond_signaler, mutex_lock 2 waited 0.854 us
>> No, that is a bug. We should have waited 10ms, and we wait less than a=
 us.
>>
>=20
> Ok. Should be fixed by commit af93ec87f975b387243127090b578d57922b38dc.=

> The bug was on the same goddamn pass as the one we are trying to fix to=

> return proper return values to user-space.
>=20

Yes, looks good!

I've hacked up some additional (basic) test cases for times mutex and
cond waiting, and now I'm looking into the posix side of that infamous
workaround.

Jan


--------------enig4AB00128CB54088EA3B0BE6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuNhhcACgkQitSsb3rl5xSG9ACfYBnsF07Og6q0F6wrdakD/dmL
NbwAn0PTAmuCcBE2hhe8sdIdJlLVKBgd
=ClPK
-----END PGP SIGNATURE-----

--------------enig4AB00128CB54088EA3B0BE6F--

