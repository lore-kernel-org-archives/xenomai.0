Message-ID: <45CF951B.8080404@domain.hid>
Date: Sun, 11 Feb 2007 23:13:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8EA809F8304A5097B6F072B1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] trunk: screwed Linux irq state
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
--------------enig8EA809F8304A5097B6F072B1
Content-Type: multipart/mixed; boundary="------------040109000300090602000103"

This is a multi-part message in MIME format.
--------------040109000300090602000103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

while testing 2.6.20 with RTnet, I got this kernel BUG during the slave
startup procedure:

<4>[  137.799234] TDMA: calibrated master-to-slave packet delay: 34 us (m=
in/max: 33/38 us)
<4>[  142.291455] BUG: at kernel/fork.c:993 copy_process()
<4>[  142.291585]  [<c0103a8f>] show_trace_log_lvl+0x1f/0x40
<4>[  142.291767]  [<c0104237>] show_trace+0x17/0x20
<4>[  142.291896]  [<c010432b>] dump_stack+0x1b/0x20
<4>[  142.292026]  [<c0111e94>] copy_process+0x914/0x13d0
<4>[  142.292190]  [<c0112b80>] do_fork+0x70/0x1b0
<4>[  142.292323]  [<c0101078>] sys_clone+0x38/0x40
<4>[  142.292620]  [<c010320f>] syscall_call+0x7/0xb
<4>[  142.292747]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
<3>[  142.292860] BUG: sleeping function called from invalid context at m=
m/slab.c:3034
<4>[  142.293052] in_atomic():0, irqs_disabled():1
<4>[  142.293152] no locks held by init/1.
<4>[  142.293244] irq event stamp: 500992
<4>[  142.293335] hardirqs last  enabled at (500991): [<c010b77c>] __ipip=
e_handle_exception+0xdc/0x188
<4>[  142.293737] hardirqs last disabled at (500992): [<c010306e>] ret_fr=
om_exception+0xe/0x20
<4>[  142.293967] softirqs last  enabled at (500868): [<c01189ab>] __do_s=
oftirq+0xab/0xc0
<4>[  142.294189] softirqs last disabled at (500861): [<c0118a55>] do_sof=
tirq+0x95/0xa0
<4>[  142.294562]  [<c0103a8f>] show_trace_log_lvl+0x1f/0x40
<4>[  142.294743]  [<c0104237>] show_trace+0x17/0x20
<4>[  142.294897]  [<c010432b>] dump_stack+0x1b/0x20
<4>[  142.295050]  [<c010f35d>] __might_sleep+0xcd/0x100
<4>[  142.295220]  [<c017d771>] kmem_cache_alloc+0xa1/0xc0
<4>[  142.295527]  [<c0110f89>] dup_fd+0x29/0x2d0
<4>[  142.295689]  [<c0111279>] copy_files+0x49/0x70
<4>[  142.295851]  [<c0111c2f>] copy_process+0x6af/0x13d0
<4>[  142.296019]  [<c0112b80>] do_fork+0x70/0x1b0
<4>[  142.296178]  [<c0101078>] sys_clone+0x38/0x40
<4>[  142.296326]  [<c010320f>] syscall_call+0x7/0xb
<4>[  142.296641]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

I'm seeing this with Xenomai trunk + the xnpod_suspend_thread patch. I
attached my .config. The interesting thing is that this doesn't show up
with v2.3.x head (kernel & config identical). Switching back to 2.6.19
doesn't change the picture.

Anyone any idea? No-COW is now both in trunk and 2.3.x, right?

Jan


--------------040109000300090602000103
Content-Type: application/x-bzip;
 name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.bz2"

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
--------------040109000300090602000103--

--------------enig8EA809F8304A5097B6F072B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFz5UeniDOoMHTA+kRAj0YAJ4w/zFHHPrxXGbGLUz2OU7/LP5OjwCZAQE8
rL/i/KzTrll2z/sj96cmmO0=
=SQZd
-----END PGP SIGNATURE-----

--------------enig8EA809F8304A5097B6F072B1--

