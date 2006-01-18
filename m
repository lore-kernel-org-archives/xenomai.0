Message-ID: <43CEA441.8060409@domain.hid>
Date: Wed, 18 Jan 2006 21:25:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Scheduling while atomic
References: <fd6a47a90601171559x13acf2c2m@domain.hid>	<43CE9FCB.2070305@domain.hid>
	<43CEA1B4.4010104@domain.hid>
In-Reply-To: <43CEA1B4.4010104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig51824F3B2A33C76E02981262"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51824F3B2A33C76E02981262
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> ...
>> [Update] While writing this mail and letting your test run for a while=
,
>> I *did* get a hard lock-up. Hold on, digging deeper...
>>
>=20
> And here are its last words, spoken via serial console:
>=20
> c31dfab0 00000086 c30d1a90 c02a2500 c482a360 00000001 00000001 00200000=

>        c012e564 00000022 ffffffff 00000246 c30d1a90 c4866ce0 00000033
> c4820000
>        c482a360 c4866ca0 ffffffff c48293a4 c48524e1 00000000 00000000
> 00000002
> Call Trace:
>  [<c012e564>] __ipipe_dispatch_event+0x56/0xdd
>  [<c4820000>] e100_hw_init+0x3ad/0xa81 [e100]
>  [<c48524e1>] xnpod_suspend_thread+0x714/0x76d [xeno_nucleus]
>  [<c4856946>] xnsynch_sleep_on+0x76d/0x7a7 [xeno_nucleus]
>  [<c4a09b29>] rt_sem_p+0xa6/0x10a [xeno_native]
>  [<c4a03c62>] __rt_sem_p+0x5d/0x66 [xeno_native]
>  [<c485b207>] hisyscall_event+0x1cb/0x2d3 [xeno_nucleus]
>  [<c012e564>] __ipipe_dispatch_event+0x56/0xdd
>  [<c010b3ea>] __ipipe_syscall_root+0x53/0xbe
>  [<c01029c0>] system_call+0x20/0x41
> Xenomai: fatal: blocked thread main[863] rescheduled?! (status=3D0x3000=
82,
> sig=3D0, prev=3Dgatekeeper/0[809])
>  CPU  PID    PRI  TIMEOUT  STAT      NAME
>>  0  0      30   0        00500080  ROOT
>    0  864    30   0        00300180  task0
>    0  865    29   0        00300288  task1
>    0  863    1    0        00300082  main
> Timer: oneshot [tickval=3D1 ns, elapsed=3D175144731477]
>=20
> c31e1f14 c4860572 c3188000 c31dfab0 00300082 c02a2500 00000286 c02a2500=

>        c030cbec c012e564 00000022 c02a2500 c30d1a90 c30d1a90 00000022
> 00000001
>        c02a2500 c30d1a90 c08e4623 00000028 c31e1fa0 c0266ed5 0000f610
> c030cd80
> Call Trace:
>  [<c012e564>] __ipipe_dispatch_event+0x56/0xdd
>  [<c0266ed5>] schedule+0x3ef/0x5ed
>  [<c485a27c>] gatekeeper_thread+0x0/0x179 [xeno_nucleus]
>  [<c485a316>] gatekeeper_thread+0x9a/0x179 [xeno_nucleus]
>  [<c010dd8b>] default_wake_function+0x0/0x12
>  [<c0124fbc>] kthread+0x68/0x95
>  [<c0124f54>] kthread+0x0/0x95
>  [<c0100d71>] kernel_thread_helper+0x5/0xb
>=20
> Any bells already ringing?
>=20
> Will try Gilles' patch now...
>=20

Nope, this didn't help.

Ok, this is migration magic. Someone around who hacks this part blindly?

Jan


--------------enig51824F3B2A33C76E02981262
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzqRBniDOoMHTA+kRAs6nAJ98cFHqmEq3NCymiuvTLh0JVV/fJgCfcUBR
5cZ8/Nt+WXU9cjAmUHEjRw8=
=NhD5
-----END PGP SIGNATURE-----

--------------enig51824F3B2A33C76E02981262--

