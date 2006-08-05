Message-ID: <44D4CC6C.1020709@domain.hid>
Date: Sat, 05 Aug 2006 18:50:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe and rt_queue problems
References: 00608021808.18076@domain.hid> <200608021808.18076@domain.hid>
	<44D0F72E.3020406@domain.hid> <200608031628.31584@domain.hid>
	<44D26C1C.5040506@domain.hid> <200608041345.6449@domain.hid>
In-Reply-To: <200608041345.6449@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig009351469C8A226428D2EB54"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig009351469C8A226428D2EB54
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:

> ...
> I made a reduced example and the error was still there. So I tried a co=
uple of things and I found out, that new interface rt_queue_write/rt_queu=
e_read is faulty (perhaps only rt_queue_read) or I misused it. I used the=
se functions to speed up the trasfer from rt_pipes/linux devices. "Zero-c=
opy" optimization should come somewhere in near future (or never) ;-)
> When I tried to use rt_queue_alloc/rt_queue_send/rt_queue_receive/rt_qu=
eue_free, everything was fine.
> Xenomai version: 2.2.0 with any patches
> Linux: 2.6.17.7, adeos: 2.6.17-i386-1.3-09
> Petr
>
>  =20
I quick run of your program confirmed that there is something fishy:

[  277.130780] Xenomai: Switching consumer to secondary mode after except=
ion #14 in kernel-space at 0xc01cb6dc (pid 907)
[  277.131489] I-pipe tracer log (30 points):
[  277.131571] func                    0 ipipe_trace_panic_freeze+0x8 (xn=
pod_fault_handler+0xe1)
[  277.131757] func                  -15 xnpod_fault_handler+0xd (xnpod_t=
rap_fault+0x32)
[  277.131921] func                  -29 xnpod_trap_fault+0x8 (xnarch_tra=
p_fault+0x1f)
[  277.132083] func                  -35 xnarch_trap_fault+0xb (exception=
_event+0x2d)
[  277.132347] func                  -46 exception_event+0x9 (__ipipe_dis=
patch_event+0x5e)
[  277.132547] func                  -50 __ipipe_dispatch_event+0xe (__ip=
ipe_handle_exception+0x4d)
[  277.132746] func                  -54 __ipipe_handle_exception+0xb (er=
ror_code+0x54)
[  277.132937] func                  -68 __copy_from_user_ll+0xa (__rt_qu=
eue_read+0x87)
[  277.133128] func                  -81 __ipipe_restore_pipeline_head+0x=
8 (xnregistry_fetch+0x79)
[  277.133326] func                  -83 xnregistry_fetch+0x9 (__rt_queue=
_read+0x44)
[  277.133515] func                  -87 __copy_from_user_ll+0xa (__rt_qu=
eue_read+0x3c)
[  277.133855] func                  -96 __rt_queue_read+0xe (hisyscall_e=
vent+0x140)
[  277.134047] func                 -107 hisyscall_event+0xe (__ipipe_dis=
patch_event+0x5e)
[  277.134241] func                 -108 __ipipe_dispatch_event+0xe (__ip=
ipe_syscall_root+0x55)
[  277.134437] func                 -110 __ipipe_syscall_root+0x9 (system=
_call+0x20)
[  277.134626] func                 -172 ipipe_unstall_pipeline_head+0x8 =
(xnshadow_harden+0x118)
[  277.134823] func                 -178 xnpod_switch_fpu+0xa (xnshadow_h=
arden+0x105)
[  277.135012] func                 -181 __switch_to+0xe (schedule+0x4b2)=


Philippe, can you comment on this?

Jan



--------------enig009351469C8A226428D2EB54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE1MxsniDOoMHTA+kRAvKmAJ9MbOoC8nl6giAJvMFRdIv5mYJehgCfS1QW
UlOdWViYHNnoahA+0TajE1g=
=6PyY
-----END PGP SIGNATURE-----

--------------enig009351469C8A226428D2EB54--

