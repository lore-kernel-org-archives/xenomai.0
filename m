Message-ID: <449A7261.7040503@domain.hid>
Date: Thu, 22 Jun 2006 12:35:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig26AAD7FE214378C9687BFF0B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] oops on skincall without nucleus being loaded
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26AAD7FE214378C9687BFF0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

wondering why suddenly things crash on invoking the latency test, I
realised that I turned the nucleus into a module which was not yet
loaded. Here is the oops in this case:

[   54.170151] Unable to handle kernel NULL pointer dereference at
virtual address 00000054
[   54.172015]  printing eip:
[   54.172326] c013db2d
[   54.172603] *pde =3D 00000000
[   54.173001] Oops: 0000 [#1]
[   54.173722] PREEMPT
[   54.174121] Modules linked in: ne2k_pci 8390
[   54.174924] CPU:    0
[   54.175027] EIP:    0060:[<c013db2d>]    Not tainted VLI
[   54.175212] EFLAGS: 00000202   (2.6.16.16 #101)
[   54.176141] EIP is at losyscall_event+0xca/0x13c
[   54.176542] eax: 00000000   ebx: 00000001   ecx: fffffffd   edx: 00000=
000
[   54.177019] esi: c7b27fbc   edi: 00000000   ebp: c7b27f80   esp: c7b27=
f6c
[   54.177571] ds: 007b   es: 007b   ss: 0068
[   54.177979] Process latency (pid: 901, threadinfo=3Dc7b26000 task=3Dc1=
1d4580)
[   54.178366] Stack: <0>00000000 00000000 c02a4e00 00000246 c02a4e00
c7b27fa8 c013253a c7b27fbc
[   54.180003]        00000021 c02a4d88 00000001 c02a4e00 5254444d
bffc7b8c 5254444d c7b27fb4
[   54.181557]        c010a422 5254444d c7b26000 c0268750 5254444d
00000002 00000001 bffc7b8c
[   54.183017] Call Trace:
[   54.183415]  [<c0102f96>] show_stack_log_lvl+0xaf/0xba
[   54.184125]  [<c01030dd>] show_registers+0x13c/0x1a8
[   54.184787]  [<c01032be>] die+0x175/0x225
[   54.190610]  [<c010c771>] do_page_fault+0x3e9/0x525
[   54.191307]  [<c010a4e9>] __ipipe_handle_exception+0x61/0x90
[   54.191996]  [<c0102a54>] error_code+0x54/0x70
[   54.192634]  [<c013253a>] __ipipe_dispatch_event+0x5e/0xdc
[   54.193440]  [<c010a422>] __ipipe_syscall_root+0x55/0xbb
[   54.194119]  [<c0268750>] system_call+0x20/0x41
[   54.194829] Code: 8b 00 ff 11 89 c1 83 f8 da 75 18 f6 c3 40 74 13 85
ff 74 0a b8 01 00 00 00 e8 e0 fb ff ff 83 f3 43 eb ad 89 4e 18 a1 bc d4
48 c0 <8b> 40 54 f6 80 32 02 00 00 40 74 41 b8 00 e0 ff ff 21 e0 8b 10

Could someone have a look?

Jan


--------------enig26AAD7FE214378C9687BFF0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEmnJhniDOoMHTA+kRAqVcAJ9dA40wjrTvIq8zAWVOVZ+aYmTEDwCdGCrY
hFHnZJyi7K9D4WPmMp78UD8=
=iBh8
-----END PGP SIGNATURE-----

--------------enig26AAD7FE214378C9687BFF0B--

