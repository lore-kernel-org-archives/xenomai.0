Message-ID: <4656EABD.60601@domain.hid>
Date: Fri, 25 May 2007 15:55:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4656E62F.3090603@domain.hid> <4656E887.7040406@domain.hid>
In-Reply-To: <4656E887.7040406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig48D36D991ABAE108B093C649"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] recursive fault on cyclictest termination
 --	scalable sched?
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
--------------enig48D36D991ABAE108B093C649
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> People, we have some new troubles:
>>
>> I'm reproducibly getting recursive faults on termination of cyclictest=

>> via ^C. It's all standard here: ipipe 1.8-02, Xenomai trunk #2469, no
>> weird patches of mine.
>>
>> Something goes utterly wrong, the debugger currently points into
>> xnshadow_relax->rpi_push, and there into some queuing operation. Note
>> that I have XENO_OPT_SCALABLE_SCHED on in my config, also
>> XENO_OPT_PRIOCPL. Without XENO_OPT_SCALABLE_SCHED, things seems to wor=
k
>> find. Who did last work on this? What was fixed?
>=20
> Looking at svn log, you did the last modification. What about activatin=
g
> queue debugging ?
>=20

Well, I remember that 64-bit issue now, but it was my patch IIRC.

Anyway, good suggestion:

T: 0 (  824) P:99 I:    1000 C:    1483 Min:       3 Act:     349 Avg:   =
 1602 Max:    3240
[  474.912841] Xenomai: fatal: corrupted queue, qslot->elems=3D0, qslot=3D=
c0614a28 at include/xenomai/nucleus/queue.h:684
[  474.912921]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[  474.912941]    0  0       -1      0        00500088  ROOT
[  474.912960]    0  823      0      0        00300380  cyclictest
[  474.912980] >  0  824      0      0        00300180  cyclictest
[  474.913000] Master time base: clock=3D1043585105469
[  474.913017]=20
[  474.915241]        c11e7eb4 00000000 00000000 c0614a28 c11e7ed8 c0104c=
6e c033f860 00000000=20
[  474.915762]        00000103 c11e7f18 c0154f02 c033fd86 c115c000 c0614a=
28 c03428c4 000002ac=20
[  474.916378]        c015657d 00000000 c1180b30 ffffffff c1180d94 000000=
00 c1180b30 00000000=20
[  474.916874] Call Trace:
[  474.917034]  [<c010451a>] show_trace_log_lvl+0x1a/0x30
[  474.917422]  [<c01045e1>] show_stack_log_lvl+0xb1/0xe0
[  474.917693]  [<c0104c6e>] show_stack+0x2e/0x40
[  474.917920]  [<c0154f02>] rpi_push+0x192/0x3a0
[  474.918146]  [<c0156a30>] xnshadow_relax+0x50/0x1c0
[  474.918394]  [<c01570c0>] hisyscall_event+0xd0/0x290
[  474.918647]  [<c0142a2e>] __ipipe_dispatch_event+0x8e/0x140
[  474.918917]  [<c010d97e>] __ipipe_syscall_root+0x3e/0xf0
[  474.919292]  [<c0102e59>] system_call+0x29/0x41
[  474.919534]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Any comment?

Jan


--------------enig48D36D991ABAE108B093C649
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVuq9niDOoMHTA+kRAi2NAJ44Zabno1GH2cpTo4K/wHmKING8jACaA38k
ptHfDyj7X0/+ESuLMFMB8so=
=014m
-----END PGP SIGNATURE-----

--------------enig48D36D991ABAE108B093C649--

