Message-ID: <46D407B7.1060805@domain.hid>
Date: Tue, 28 Aug 2007 13:32:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>	
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>	
	<46BC8074.3090104@domain.hid>	
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>	
	<18112.1512.506911.608273@domain.hid>	
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>	
	<46C08E61.9060204@domain.hid>	
	<3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>	
	<3535aae80708270627l4064dd1fif3e6aa10314d38f@domain.hid>	
	<46D301EE.5020805@domain.hid>
	<3535aae80708280306l2adbc447vf522780a92d26c27@domain.hid>
In-Reply-To: <3535aae80708280306l2adbc447vf522780a92d26c27@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4FB43419ECD914D5EC8741DF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: andy motten <andy.motten@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4FB43419ECD914D5EC8741DF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

andy motten wrote:
>> That specific Xenomai bug should be fixed in 2.4, please check your
>> testcase against -rc1 e.g. Unfortunately we have no backport of the fi=
x
>> in 2.3 yet. Can't tell right now if this is tricky, but this test
>> demonstrates that $SOMETHING should be done...
>>
>> Jan
>=20
>=20
> We have tried xenomai 2.4 rc1 (last changed revision 2865) with linux k=
ernel
> 2.6.20.9 (ipipe 1.8-06) and linux kernel 2.6.22.1 (ipipe 1.9-01).
> The orocos tests are also not working with this release:
>=20
>     The following tests FAILED:
>         2 - task-test (OTHER-FAULT)
>         3 - event-test (OTHER-FAULT)
>         4 - taskcontext-test (OTHER-FAULT)
>=20
> And we get the the following messages: Killed after a single test. The
> OROCOS messages are the same as with previous versions.
> This time there is no extra information on the serial console after run=
ning
> the orocos tests (accept "cleaning up sem" and "cleaning up mutex").

So your test apps are stopping due to some segfault or so? Over both
kernels the same behaviour? Can you try to catch the problem with gdb
(to see what causes the termination)? That may only make sense with the
kernel bug below is not visible on a specific setup, though.

>=20
> There is however a bug indication on the serial console after loading
> xeno-native (see listing below, complete listing in appendix). Can this=
 have
> anything to do with the failure of the orocos tests?
>=20
> I-pipe: Domain Xenomai registered.
> Xenomai: hal/x86 started.
> I-pipe: Domain IShield registered.
> Xenomai: real-time nucleus v2.4-rc1 (Bells Of Lal) loaded.
> Xenomai: SMI-enabled chipset found, enabling SMI workaround.
> Xenomai: SMI workaround failed!
> Xenomai: starting native API services.
> BUG: sleeping function called from invalid context at mm/slab.c:3024
> in_atomic():0, irqs_disabled():1
>  [<c0103ab8>] show_trace_log_lvl+0x1f/0x35
>  [<c01047fd>] show_trace+0x17/0x19
>  [<c0104911>] dump_stack+0x1a/0x1c
>  [<c0112a2a>] __might_sleep+0xc0/0xd0
>  [<c0158edc>] kmem_cache_alloc+0xbc/0xdb
>  [<c016d206>] d_alloc+0x23/0x190
>  [<c01638ab>] do_lookup+0x117/0x168
>  [<c01651aa>] __link_path_walk+0x7cb/0xcd7
>  [<c01656ff>] link_path_walk+0x49/0xc4
>  [<c0165797>] path_walk+0x1d/0x1f
>  [<c0165945>] do_path_lookup+0x7d/0x1b3
>  [<c016628a>] __user_walk_fd+0x37/0x4f
>  [<c015fbb8>] vfs_lstat_fd+0x1d/0x43
>  [<c015fc58>] vfs_lstat+0x16/0x18
>  [<c015fc73>] sys_lstat64+0x19/0x2d
>  [<c0102979>] sysenter_past_esp+0x6e/0x72
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: at kernel/softirq.c:138 local_bh_enable()
>  [<c0103ab8>] show_trace_log_lvl+0x1f/0x35
>  [<c01047fd>] show_trace+0x17/0x19
>  [<c0104911>] dump_stack+0x1a/0x1c
>  [<c011b2a3>] local_bh_enable+0xa3/0xb2
>  [<c023d6df>] lock_sock_nested+0xbe/0xc6
>  [<c023ae21>] sock_fasync+0x46/0x14d
>  [<c023c2ca>] sock_close+0x1e/0x42
>  [<c015d5fd>] __fput+0x62/0x15c
>  [<c015d759>] fput+0x1d/0x1f
>  [<c015afb2>] filp_close+0x46/0x6c
>  [<c015c0de>] sys_close+0x6f/0xb7
>  [<c0102979>] sysenter_past_esp+0x6e/0x72
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There is a pending Linux-IRQ-state issue for at least 2.6.22. I came
across it 2 weeks ago, but no one had the time to dig deeper so far (see
also xenomai-core). However, I did not see this with 2.6.20. Is your
observation kernel-version-independent? Maybe it's a race that I just
miss with my 2.6.20 kernel (it was already tricky to reproduces with
2.6.22).

Jan


--------------enig4FB43419ECD914D5EC8741DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1Ae3niDOoMHTA+kRAkC7AJ99BwGRThnKoe704t7vgCmCcthjnwCeJT2w
WRCoDTJQz22Z+emsNeCg8Xg=
=meFl
-----END PGP SIGNATURE-----

--------------enig4FB43419ECD914D5EC8741DF--

