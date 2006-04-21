Message-ID: <4449220E.5000900@domain.hid>
Date: Fri, 21 Apr 2006 20:18:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
References: <4446B348.10403@domain.hid>	<4448B81E.3090605@domain.hid>	<17480.63623.600656.828303@domain.hid>	<4448FE86.4050503@domain.hid>	<17481.417.382690.108221@domain.hid>	<44490B3D.2060600@domain.hid>
	<17481.6439.664844.663463@domain.hid>
	<44491B68.5080905@domain.hid>
In-Reply-To: <44491B68.5080905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2AC6C58B85C2769304B9904D"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AC6C58B85C2769304B9904D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>  > What I suggested was to let people create normal threads using  >
>> pthread_create (likely conforming to the SCHED_OTHER policy), then use=

>>  > the redirected pthread_setschedparam syscall (i.e. always applied
>> to the  > current thread) to promote them as Xenomai shadows, but
>> leave them in  > their original scheduling class. The same goes for
>> rt_task_shadow. This  > would be explicit actions that would not leave=

>> much room for "surprises".
>>
>> If I understand correctly, you mean that one should not be able to
>> create real-time threads with pthread_create. My question was about wh=
at
>> to do of explicit scheduling parameters passed to pthread_create throu=
gh
>> thread creation attributes.
>=20
> Nope, this is obviously not what I meant... :o>
>=20
> This is how one would create hybrids, without changing anything else to=

> the current interface:
>=20
>     pthread_attr_init(&attr);
>     ...
>     pthread_attr_setschedpolicy(&attr,SCHED_OTHER);
>     ...
>     pthread_create(...,&attr,&foo,NULL);
>=20
> and,
>=20
> void *foo (void *cookie)
> {
>     /* The following call maps a shadow thread to "current", but
>               currently only accepts SCHED_FIFO, and would be changed t=
o
>                                    allow SCHED_OTHER/NORMAL. */
>     pthread_setschedparam(...,SCHED_OTHER,...);
>     /* OR, for the native API */
>     rt_task_shadow(...,pri=3D0,...);
> }
>=20

I think it melts down to the question: which kind of SCHED_OTHER threads
will be more common in applications, the hybrid or the normal ones?
Remember that we also still have the __real_pthread_create interface for
creating /really/ normal threads...

The advantage of making hybrids default, even for the attr=3DNULL case,
would be that the user will be able to interact with real-time
SCHED_FIFO/RR threads without further coding effort (might be
interesting for porting existing apps...).

How much overhead would default-shadowing introduce when it is not used
actively? Is it just the kernel pthread structure? Maybe we should
consider allocating that structure from normal kernel memory to save
rt-memory resources (under memory pressure, there is a risk in failing
to create the Linux mate anyway). I could also imagine that SCHED_OTHER
threads will get started in relaxed mode by default so that the Xenomai
scheduler will not be additionally loaded.

Jan


--------------enig2AC6C58B85C2769304B9904D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESSIOniDOoMHTA+kRAmVJAJoDnC5hVGvSIOOJgLq+flHFR+v67QCcCHvb
76Sfx5q6BH6TV4s5Roow9SE=
=4S6X
-----END PGP SIGNATURE-----

--------------enig2AC6C58B85C2769304B9904D--

