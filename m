Message-ID: <45DEE3D8.9010102@domain.hid>
Date: Fri, 23 Feb 2007 13:53:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45DEDED6.4070202@domain.hid>
In-Reply-To: <45DEDED6.4070202@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig92D48012C8CFF1DA6561430F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [BUG] trunk: oops with Stephan's stress test
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
--------------enig92D48012C8CFF1DA6561430F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi Philippe,
>=20
> this is what I get running Stephan slightly modified test with latest
> 2.6.20 / SVN trunk:
>=20
>> [ 3317.323825] Xenomai: starting native API services.
>> [ 3318.125915]        c125ea70 00003082 007c8af8 00000003 cd6f4830 d08=
61f6c 00000000 d084f9ca
>> [ 3318.134339]        d08466ff 00300188 d086f630 d0861f50 00000001 000=
00001 d0861f50 cf66bab0
>> [ 3318.142913]        000000d8 d0860000 d0861f50 d08624a0 00000200 000=
00000 d084472e cf62f590
>> [ 3318.151478] Call Trace:
>> [ 3318.154144]  [<d084f9ca>] xntimer_tick_aperiodic+0x1aa/0x480 [xeno_=
nucleus]
>> [ 3318.161302]  [<d08466ff>] xnpod_announce_tick+0x5/0xb [xeno_nucleus=
]
>> [ 3318.167737]  [<d084472e>] xnintr_irq_handler+0xec/0x13d [xeno_nucle=
us]
>> [ 3318.174344]  [<c01331c4>] __ipipe_dispatch_wired+0x71/0x90
>> [ 3318.179889]  [<c01092ce>] __ipipe_handle_irq+0x6f/0x171
>> [ 3318.185156]  [<c0132ec0>] __ipipe_restore_pipeline_head+0x5e/0x5f
>> [ 3318.191291]  [<c0102ea1>] common_interrupt+0x21/0x40
>> [ 3318.196307]  [<d085007b>] xntimer_start_aperiodic+0x25/0x6c4 [xeno_=
nucleus]
>> [ 3318.203344]  [<c0132ec0>] __ipipe_restore_pipeline_head+0x5e/0x5f
>> [ 3318.209487]  [<c0133d30>] rthal_apc_schedule+0x57/0x5d
>> [ 3318.214667]  [<d085266d>] xnshadow_relax+0x87/0x17c [xeno_nucleus]
>> [ 3318.220923]  [<d082f21f>] __rt_task_wait_period+0x2b/0x49 [xeno_nat=
ive]
>> [ 3318.227686]  [<d0852cd2>] hisyscall_event+0x1e0/0x230 [xeno_nucleus=
]
>> [ 3318.234120]  [<d0844676>] xnintr_irq_handler+0x34/0x13d [xeno_nucle=
us]
>> [ 3318.240729]  [<d0852af2>] hisyscall_event+0x0/0x230 [xeno_nucleus]
>> [ 3318.246986]  [<c01330b3>] __ipipe_dispatch_event+0x82/0x122
>> [ 3318.252609]  [<c01095e2>] __ipipe_syscall_root+0x6c/0xd2
>> [ 3318.257964]  [<c0102be9>] system_call+0x29/0x41
>> [ 3318.262544]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> [ 3318.266189] Xenomai: fatal: Hardened thread interrupt-creator-task[=
5868] running in Linux domain?! (status=3D0x300188, sig=3D0, prev=3Dinter=
rupt-task[5867])
>> [ 3318.266202]  CPU  PID    PRI      TIMEOUT  STAT      NAME
>> [ 3318.266211] >  0  0      257      0        00500080  ROOT
>> [ 3318.266220]    0  5866    10      0        00300380  maintask
>> [ 3318.266229]    0  5867   257      0        00300380  interrupt-task=

>> [ 3318.266239]    0  5868    50      0        00300188  interrupt-crea=
tor-task
>> [ 3318.266248]    0  5869     1      0        00300380  queue_endtask
>> [ 3318.266253] Master time base: clock=3D2319388776705
>> [ 3318.266262]
>> [ 3318.321884]        cd5b5e84 00000000 00000000 00000000 cf66bab0 c01=
03a75 c02b93ef 000016ec
>> [ 3318.330256]        d086f9a4 d085146c d085b178 cd778000 000016ec 003=
00188 00000000 c125ebfc
>> [ 3318.338822]        000016eb d0861f50 00000001 00000001 00000000 c12=
5ea70 00000000 00000004
>> [ 3318.347394] Call Trace:
>> [ 3318.350052]  [<c0103a75>] show_stack+0x27/0x2b
>> [ 3318.354549]  [<d085146c>] schedule_event+0x181/0x8b1 [xeno_nucleus]=

>> [ 3318.360896]  [<d08512eb>] schedule_event+0x0/0x8b1 [xeno_nucleus]
>> [ 3318.367062]  [<c01330b3>] __ipipe_dispatch_event+0x82/0x122
>> [ 3318.372689]  [<c02862d9>] __sched_text_start+0x409/0x661
>> [ 3318.378052]  [<c01331c4>] __ipipe_dispatch_wired+0x71/0x90
>> [ 3318.383587]  [<c01c3a5d>] rwsem_down_failed_common+0x175/0x18e
>> [ 3318.389476]  [<c0288186>] rwsem_down_write_failed+0x18/0x1f
>> [ 3318.395101]  [<c0288206>] call_rwsem_down_write_failed+0x6/0x10
>> [ 3318.401069]  [<c0127247>] down_write+0x11/0x12
>> [ 3318.405556]  [<c0142ffb>] sys_munmap+0x21/0x3e
>> [ 3318.410053]  [<c0102c1f>] syscall_call+0x7/0xb
>> [ 3318.414541]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> .config and demo attached. This happens while running
>=20
> modprobe xeno_native; ./main; modprobe -r xeno_native
>=20
> in a loop, but only when killing main with CTRL-C. Platform is a 700 MH=
z
> P-III.
>=20
> I'm now going to check if we have an issue over v2.3.x as well.

Yes, we do (with prio-coupling on at least).

Jan


--------------enig92D48012C8CFF1DA6561430F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3uPYniDOoMHTA+kRApPzAJ4r8VRXivo5wXM6EOz9WbWjgZEj5ACfbKyd
ePZ/sAB1cXJ41I5W+nJuFdA=
=6mR0
-----END PGP SIGNATURE-----

--------------enig92D48012C8CFF1DA6561430F--

