Message-ID: <48F7C92F.2010509@domain.hid>
Date: Fri, 17 Oct 2008 01:07:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F6195C.7070801@domain.hid>	<48F6492C.4090500@domain.hid>	<48F660E7.8090906@domain.hid>	<48F79AF9.6030303@domain.hid>
	<48F7B5F8.7020105@domain.hid> <48F7BA7F.3030007@domain.hid>
	<48F7BD8B.5010209@domain.hid> <48F7BF94.9050409@domain.hid>
In-Reply-To: <48F7BF94.9050409@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig335955824801E872C7DC8B27"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rt_task_info.status encoding
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig335955824801E872C7DC8B27
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> I start to believe we are arguing with different (miss-)use case in
>>>> mind. Mine is definitely not about "helping" the user to switch the
>>>> thread mode even more actively. It is about validating application
>>>> states, it is about thread state reflection without any other action=
s
>>>> than reporting errors. T_PRIMARY is part of the picture for the dual=

>>>> kernel Xenomai version, and it will remain such as long as there are=
 two
>>>> kernels. Even better, it is a very helpful application debugging too=
l
>>>> when it comes to runtime validation of their real-time behavior. Aga=
in,
>>>> it is NOT about promoting more use of rt_task_set_mode!
>>> SIGXCPU may be used validate current thread mode, and it has the
>>> advantage that it can not be misused.
>> You are not always able to install or switch signal handlers when
>> crossing application module boundaries. And you can't use it to valida=
te
>> the opposite (RT thread calls into lengthy, not RT-context suited
>> library function).
>=20
> For me, one problem of SIGXCPU is when one non RT thread acquires a
> mutex shared with a RT thread, and then calls some functions which caus=
e
> it to switch to secondary mode. But we could conceivably modify the
> nucleus to detect this kind of situation.
>=20
> Another problem is that malloc, free, new and delete do not necessarily=

> cause a switch to secondary mode. But this also could conceivably be
> solved by wrapping/overriding these calls and call the SIGXCPU handler
> in the wrapper.

Yes, and add getimeofday to this list. Even worse: When it triggers, the
backtrace stops in the vsyscall page, not allowing to identify the caller=
=2E

>=20
> Other than that, I do not see what you mean.

SIGXCPU becomes useless if you are unable to install a signal handler,
e.g. from within an invoked library. rt_task_inquire is then an
alternative mechanism to add debug assertions.

Jan


--------------enig335955824801E872C7DC8B27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj3yTYACgkQniDOoMHTA+k8qQCfXVT2FXgidwj0X1Qho069+XWG
++YAn0pfjiOnXcW+fK8t6pSKe/gZwBn8
=WfhK
-----END PGP SIGNATURE-----

--------------enig335955824801E872C7DC8B27--

