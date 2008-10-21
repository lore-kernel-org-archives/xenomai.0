Message-ID: <48FD91D3.7070902@domain.hid>
Date: Tue, 21 Oct 2008 10:24:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48FCDC52.1070507@domain.hid>	<48FCE40C.1080100@domain.hid>	<48FCEB70.7030808@domain.hid>	<48FCEC25.2040200@domain.hid>	<48FCED48.5050608@domain.hid>	<48FCF14C.8050103@domain.hid>
	<48FCF2E2.8050809@domain.hid>	<48FCF4FB.1040104@domain.hid>
	<48FCF74E.1090102@domain.hid> <48FCF86F.3030007@domain.hid>
	<48FD867C.7020606@domain.hid>
In-Reply-To: <48FD867C.7020606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig830CC104AF944AD8B4411B4A"
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
To: rpm@xenomai.org
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig830CC104AF944AD8B4411B4A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>>> I get this warning when compiling trunk:
>>>>>>>>>>>
>>>>>>>>>>> checking for __thread... rm: cannot remove `conftest1.dir': I=
s a directory
>>>>>>>>>>> yes
>>>>>>>>>>>
>>>>>>>>>> That simple, it's a typo in this line:
>>>>>>>>>>
>>>>>>>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/configure.in=
?v=3DSVN-trunk#394
>>>>>>>>>>
>>>>>>>>>> Also, that rm should be done outside the if block to play safe=
=2E
>>>>>>>>> Ok. But once this is fixed, I get a segmentation fault with __t=
hread on
>>>>>>>>> ARM in rt_task_trampoline. I am currently testing the SIGWINCH =
thing,
>>>>>>>>> and if __thread is disabled, there is no segfault.
>>>>>>>> If a #ifdef 0 xeno_set_current, there is no segfault.
>>>>>>>>
>>>>>>> Interesting. What about removing the initial-exec attributes? Is
>>>>>>> __thread otherwise know to work on your platform?
>>>>>> Yes. This is a race condition, the real bug is, IMHO:
>>>>>> 	__native_self =3D *iargs->task;
>>>>>> When the segfault happens iargs->task is NULL. I suspect you are n=
ot
>>>>>> supposed to use iargs after the __native_task_create syscall.
>>>>> Yes, that was the problem.
>>>> What did you change? Can you explain the why to me?
>>> Because I guess iargs is no longer valid at this point. So, I saved t=
he
>>> task pointer and reused it.
>>>
>> Sorry, makes no sense to me: *iargs is on the stack of the
>> rt_task_create caller, and that one is not expected to proceed until w=
e
>> issue __xn_sys_barrier.
>>
>=20
> Gilles is right, the caller may vanish before your thread variable is a=
ssigned.
> __sys_barrier is there to synchronize with rt_task_start(), not interna=
lly with
> the task creator.
>=20
> parent: rt_task_create
> 	-> child: rt_task_trampoline
> 		-> xnshadow_map
> 			-> wakeup_process(parent)
> <parent stack unwinding>
> 	-> child: assignment from automatic data, oops.
>=20
> You may want to track how the completion block is used.

Damn, signal_completion is already invoked by xnshadow_map - OK, now
this makes a lot of sense.

Just checked the rest, and I introduced the same issue to vxworks. Will f=
ix.

Jan


--------------enig830CC104AF944AD8B4411B4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj9kdcACgkQniDOoMHTA+miIgCdHdpi+dmX2bq+jJW0FRFkMPwa
/TkAmwRhou5tQrdjPcOLCXvBu+AFP68q
=ctxS
-----END PGP SIGNATURE-----

--------------enig830CC104AF944AD8B4411B4A--

