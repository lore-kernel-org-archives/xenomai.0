Message-ID: <48FCF443.8060901@domain.hid>
Date: Mon, 20 Oct 2008 23:12:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid> <48FCE40C.1080100@domain.hid>
	<48FCEB70.7030808@domain.hid> <48FCEC25.2040200@domain.hid>
	<48FCED48.5050608@domain.hid> <48FCF14C.8050103@domain.hid>
In-Reply-To: <48FCF14C.8050103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E60BC9CD0ADDE6144447D94"
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
--------------enig8E60BC9CD0ADDE6144447D94
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> I get this warning when compiling trunk:
>>>>>>
>>>>>> checking for __thread... rm: cannot remove `conftest1.dir': Is a d=
irectory
>>>>>> yes
>>>>>>
>>>>> That simple, it's a typo in this line:
>>>>>
>>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/configure.in?v=3D=
SVN-trunk#394
>>>>>
>>>>> Also, that rm should be done outside the if block to play safe.
>>>> Ok. But once this is fixed, I get a segmentation fault with __thread=
 on
>>>> ARM in rt_task_trampoline. I am currently testing the SIGWINCH thing=
,
>>>> and if __thread is disabled, there is no segfault.
>>> If a #ifdef 0 xeno_set_current, there is no segfault.
>>>
>> Interesting. What about removing the initial-exec attributes? Is
>> __thread otherwise know to work on your platform?
>=20
> Yes. This is a race condition, the real bug is, IMHO:
> 	__native_self =3D *iargs->task;
> When the segfault happens iargs->task is NULL. I suspect you are not
> supposed to use iargs after the __native_task_create syscall.

Don't see the race yet. iargs is provided by the trampoline creator, and
with that one we synchronize with the barrier AFTER this access - or
does the compiler some fancy reordering here?

Jan


--------------enig8E60BC9CD0ADDE6144447D94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj89EMACgkQniDOoMHTA+l+TwCfVsLVojknAkvipCOzHxr2Roji
l84An2s06/wIKo7nI4YjslLvvuu4JQ6O
=jCQE
-----END PGP SIGNATURE-----

--------------enig8E60BC9CD0ADDE6144447D94--

