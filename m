Message-ID: <4461BB5A.3010403@domain.hid>
Date: Wed, 10 May 2006 12:07:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] zombie mutex owners
References: <44619D0B.1080402@domain.hid>
	<b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
In-Reply-To: <b647ffbd0605100216p7ba1d67eu7afc8df4fb29d828@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig777070B4F7866DE56B1E0A41"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig777070B4F7866DE56B1E0A41
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi Jan,
>=20
>>
>> running the attached test case for the native skin, you will get an ug=
ly
>> lock-up on probably all Xenomai versions. Granted, this code is a bit
>> synthetic. I originally thought I could trigger the bug also via
>> timeouts when waiting on mutexes, but this scenario is safe (the timeo=
ut
>> is cleared before being able to cause harm).
>>
>=20
> just in order to educate me as probably I might have got something
> wrong at the first glance :)
>=20
> if we take this one:
>=20
> --- mutex.c    2006-02-27 15:34:58.000000000 +0100
> +++ mutex-NEW.c    2006-05-10 11:55:25.000000000 +0200
> @@ -391,7 +391,7 @@ int rt_mutex_lock (RT_MUTEX *mutex,
>     err =3D -EIDRM; /* Mutex deleted while pending. */
>     else if (xnthread_test_flags(&task->thread_base,XNTIMEO))
>     err =3D -ETIMEDOUT; /* Timeout.*/
> -    else if (xnthread_test_flags(&task->thread_base,XNBREAK))
> +    else if (xnthread_test_flags(&task->thread_base,XNBREAK) &&
> mutex->owner !=3D task)
>     err =3D -EINTR; /* Unblocked.*/
>=20
>  unlock_and_exit:
>=20
> As I understand task2 has a lower prio and that's why
>=20
> [task1] rt_mutex_unlock
> [task 1] rt_task_unblock(task1)
>=20
> are called in a row.
>=20
> ok, task2 wakes up in rt_mutex_unlock() (when task1 is blocked on
> rt_mutex_lock()) and finds XNBREAK flag but,
>=20
> [doc] -EINTR is returned if rt_task_unblock() has been called for the
> waiting task (1) before the mutex has become available (2).
>=20
> (1) it's true, task2 was still waiting at that time;
> (2) it's wrong, task2 was already the owner.
>=20
> So why just not to bail out XNBREAK and continue task2 as it has a
> mutex (as shown above) ?

Indeed, this solves the issue more gracefully.

Looking at this again from a different perspective and running the test
case with your patch in a slightly different way, I think I
misinterpreted the crash. If I modify task2 like this

void task2_fnc(void *arg)
{
        printf("started task2\n");
        if (rt_mutex_lock(&mtx, 0) < 0) {
                printf("lock failed in task2\n");
                return;
        }
//        rt_mutex_unlock(&mtx);

        printf("done task2\n");
}

I'm also getting a crash. So the problem seems to be releasing a mutex
ownership on task termination. Well, this needs further examination.

Looks like the issue is limited to cleanup problems and is not that
widespread to other skins as I thought. RTDM is not involved as it does
not know EINTR for rtdm_mutex_lock. The POSIX skins runs in a loop on
interruption and should recover from this.

Besides this, we then may want to consider if introducing a pending
ownership of synch objects is worthwhile to improve efficiency of PIP
users. Not critical, but if it comes at a reasonable price... Will try
to draft something.

Jan


--------------enig777070B4F7866DE56B1E0A41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYbtaniDOoMHTA+kRApjAAJ9OuW8mbBArRt6m1Uuotn8eDG+O1gCbBQsC
v4uHFfiB3O5+L82ZBDusQBY=
=nL8Z
-----END PGP SIGNATURE-----

--------------enig777070B4F7866DE56B1E0A41--

