Message-ID: <45D5F0AD.9010404@domain.hid>
Date: Fri, 16 Feb 2007 18:58:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid>	<45CC68F3.1000003@domain.hid>		<45D1C033.9010002@domain.hid>	<45D1C61B.7030503@domain.hid>		<1171376742.885.3.camel@domain.hid>	<45D1CAFA.6050408@domain.hid>		<1171385716.885.17.camel@domain.hid>	<45D200C3.1030001@domain.hid>	<1171393088.885.37.camel@domain.hid>	<45D59F98.8020006@domain.hid>
	<45D5E493.4080405@domain.hid>
In-Reply-To: <45D5E493.4080405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2871697B0326BA7397308C72"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2871697B0326BA7397308C72
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> /me now watching what happens at 10 kHz...

Bad news are sometimes good news:

# ./main
# rmmod xeno_native
# modprobe xeno_native
# ./main

> [  629.916921] Xenomai: stopping RTDM services.
> [  632.954058] Xenomai: stopping native API services.
> [  641.763276] Xenomai: starting native API services.
> [  643.849294] BUG: unable to handle kernel paging request at virtual a=
ddress c484eb58
> [  643.857099]  printing eip:
> [  643.859835] c013a173
> [  643.862050] *pde =3D 03fdb067
> [  643.864868] *pte =3D 00000000
> [  643.867696] Oops: 0000 [#1]
> [  643.870517] PREEMPT
> [  643.872747] Modules linked in: xeno_native 8139too eepro100 sd_mod s=
csi_mod
> [  643.879873] CPU:    0
> [  643.879884] EIP:    0060:[<c013a173>]    Not tainted VLI
> [  643.879904] EFLAGS: 00013046   (2.6.19.3 #28)
> [  643.891932] EIP is at xnheap_init_mapped+0x144/0x1a8
> [  643.896944] eax: c484eb58   ebx: 00000000   ecx: c48e2458   edx: 000=
00000
> [  643.903787] esi: c480f000   edi: 00004000   ebp: c1311eb8   esp: c13=
11e9c
> [  643.910620] ds: 007b   es: 007b   ss: 0068
> [  643.914763] Process interrupt-task (pid: 955, ti=3Dc1310000 task=3Dc=
13d6a90 task.ti=3Dc1310000)
> [  643.922808] Stack: 00001000 00000000 c48e2458 00000000 00004000 c131=
1fbc ffffffff c1311ee4
> [  643.931373]        c4861edb c0137176 00000060 00003246 c0139d1b c131=
1f04 c48e2420 c48e2420
> [  643.939942]        c1311fbc 00000200 c1311f40 c485ee54 000fa000 0000=
0200 c13d6a90 00002710
> [  643.948522] Call Trace:
> [  643.951232]  [<c4861edb>] rt_queue_create+0x9f/0x24a [xeno_native]
> [  643.957870]  [<c485ee54>] __rt_queue_create+0xa5/0x101 [xeno_native]=

> [  643.964579]  [<c0142ed0>] hisyscall_event+0x13f/0x238
> [  643.969744]  [<c013738e>] __ipipe_dispatch_event+0x82/0x118
> [  643.975421]  [<c010a001>] __ipipe_syscall_root+0x73/0xd8
> [  643.980827]  [<c0102dc0>] system_call+0x20/0x38
> [  643.985462]  [<b7e2953a>] 0xb7e2953a
> [  643.989100]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> [  643.992707] Code: 55 e8 8b 45 ec 89 90 8c 00 00 00 89 98 90 00 00 00=
 fa a1 04 d2 2e c0 0f ba 68 08 00 19 d2 a1 84
> d4 46 c0 89 d3 8b 4d ec 83 e3 01 <8b> 10 89 41 04 89 11 89 4a 04 89 08 =
8b 0d 04 d2 2e c0 ff 05 88
> [  644.012858] EIP: [<c013a173>] xnheap_init_mapped+0x144/0x1a8 SS:ESP =
0068:c1311e9c

Should be fixable - once we understood what happens here. :)

Jan


PS: Xenomai v2.3.x, kernel 2.6.19, ipipe-1.6-06


--------------enig2871697B0326BA7397308C72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1fCtniDOoMHTA+kRAqTFAJwN+CoOZyk0vHahcHY5B2OjS6kOhgCfX91N
EL6FQqeBnmw9hXXyxgFkIcM=
=qAHs
-----END PGP SIGNATURE-----

--------------enig2871697B0326BA7397308C72--

