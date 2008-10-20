Message-ID: <48FCF4FB.1040104@domain.hid>
Date: Mon, 20 Oct 2008 23:15:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid>
	<48FCE40C.1080100@domain.hid>	<48FCEB70.7030808@domain.hid>
	<48FCEC25.2040200@domain.hid>	<48FCED48.5050608@domain.hid>
	<48FCF14C.8050103@domain.hid> <48FCF2E2.8050809@domain.hid>
In-Reply-To: <48FCF2E2.8050809@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig13A284A0B3389C06B8C17B3E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Warning when compiling trunk.
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
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13A284A0B3389C06B8C17B3E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> I get this warning when compiling trunk:
>>>>>>>
>>>>>>> checking for __thread... rm: cannot remove `conftest1.dir': Is a =
directory
>>>>>>> yes
>>>>>>>
>>>>>> That simple, it's a typo in this line:
>>>>>>
>>>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/configure.in?v=3D=
SVN-trunk#394
>>>>>>
>>>>>> Also, that rm should be done outside the if block to play safe.
>>>>> Ok. But once this is fixed, I get a segmentation fault with __threa=
d on
>>>>> ARM in rt_task_trampoline. I am currently testing the SIGWINCH thin=
g,
>>>>> and if __thread is disabled, there is no segfault.
>>>> If a #ifdef 0 xeno_set_current, there is no segfault.
>>>>
>>> Interesting. What about removing the initial-exec attributes? Is
>>> __thread otherwise know to work on your platform?
>> Yes. This is a race condition, the real bug is, IMHO:
>> 	__native_self =3D *iargs->task;
>> When the segfault happens iargs->task is NULL. I suspect you are not
>> supposed to use iargs after the __native_task_create syscall.
>=20
> Yes, that was the problem.

What did you change? Can you explain the why to me?

>=20
> However, another problem, should not the __thread variables be given th=
e
> weak attribute too? If a native thread tries to use a pthread mutex, I
> want pthread_mutex_lock to obtain the current xnhandle_t set by the
> native skin, not an inexistant one that should have been set by the
> posix skin but obviously has not.
>=20

Yes, true. Please commit a fix as you are already patching.

Jan


--------------enig13A284A0B3389C06B8C17B3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj89PsACgkQniDOoMHTA+mICACdEYl1CaVu/Cd7V7T/5u2LEbXz
uIMAnRs6pqy9G6h+m3kPJd7mScC1jREq
=YM+E
-----END PGP SIGNATURE-----

--------------enig13A284A0B3389C06B8C17B3E--

