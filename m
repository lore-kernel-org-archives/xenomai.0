Message-ID: <451D1DAB.8040803@domain.hid>
Date: Fri, 29 Sep 2006 15:20:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] SH4 port
References: <001f01c6e491$c384f7e0$1501a8c0@domain.hid>
In-Reply-To: <001f01c6e491$c384f7e0$1501a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigACBBA88729F71FDC34EF2830"
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
To: Kiichi Kameda <k-kameda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigACBBA88729F71FDC34EF2830
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kiichi Kameda wrote:
> After long break, I started testing SH4 port of Xenomai based on Xenoma=
i
> 2.2.0

Nice to hear.

>=20
> My realtime test program is a user space program using POSIX skin , and=

> runs periodically (1ms interval)
>=20
> It works well when the load is light.
> But with very heavy load such as continuous FTP, the system hangs in se=
veral
> minutes,
> due to panic.
>=20
> the stack trace shows as follows
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Unable to handle kernel NULL pointer dereference. at virtual address
> 00000000
> pc =3D 8c0104a6 <-- dequeue_task
> *pde =3D 00000000
> Oops: 0000 [#1]
>=20
> Pid : 944, Comm:              in.ftpd
> PC  : 8c0104a6 SP  : 8d631c00 SR  : 40008101 .TEA : c0198044    .Not
> tainted
> R0  : 8c19a928 R1  : 8c0104a0 R2  : 00000000 R3  : 8d5db680
> R4  : 8d5db680 R5  : 00000000 R6  : 00000000 R7  : 8d5db788
> R8  : 8d5db680 R9  : fffffffb R10 : 8d631c9c R11 : 8d5db680
> R12 : e9bbfd00 R13 : 000f422e R14 : 8d631c08
> MACH: 0000027f MACL: 5c28f7f2 GBR : 29568be0 PR  : 8c0107b6.
> Call trace:
> =3D=3D=3Dtop of stack(8d631c00)
> [<8c0107b6>] deactivate_task
> [<8c14d616>] schedule
> [<8c14e38c>] io_schedule
> [<8c035106>] sync_page
> [<8c14e776>] __wait_on_bit_lock
> [<8c035a64>] __lock_page
> [<8c036d10>] filemap_nopage
> [<8c04306a>] __handle_mm_fault
> [<8c0d98ee>] ide_set_handler
> [<8c00e750>] do_page_fault
> [<8c0ac7dc>] csum_partial_copy_generic
> [<8c122d04>] tcp_sendmsg
> [<8c0d79f2>] ide_do_request
> [<8c13ed74>] inet_sendmsg
> [<8c0f69f6>] do_sock_write
> [<8c04cc00>] wait_on_retry_sync_kiocb
> [<8c0f6aec>] sock_aio_write
> [<8c04cf1a>] do_sync_write
> [<8c033024>] __ipipe_sync_stage
> [<8c02a320>] autoremove_wake_function
> [<8c033136>] __ipipe_dispatch_event
> [<8c04cfea>] vfs_write
> [<8c04d134>] sys_write
> [<8c0062bc>] syscall_call
> [<8c04d100>] sys_write
> =3D=3D=3Dbottom of stack
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> After tough investigation, I think I found some clues such as:
> While in.ftpd runs hard, a "write" system call was issued and Linux
> kernel was processing its request.
>  But weird __ipipe_dispatch_event and __ipipe_sync_stage was recorded.
>=20
> I think the problem originates from a Xenomai context switch(which
> overwrites "current"), while Linux is processing  system call.

If I interpret linux/include/asm-sh/current.h correctly, current is
derived from the stack on your platform (like on most archs) and cannot
be "overwritten". True is that the stack may change, making current
invalid, when running a Xenomai kernel-space task. But this is something
both I-pipe and Xenomai has to take into account (and do so on other arch=
s).

> and I am sure that some tricks (preventing such case) must be included
> on other platforms.
>=20
> Any suggestions on preventing such panic?

I guess you have to understand it more thoroughly first - or I'm not yet
getting the generic part of your problem.

However, did you try the switchtest already? It performs all kind of
switches to trigger potential issues with saving/restoring contexts.

And finally: Do we have a chance to see your patch soon? Even if it's
not mature yet, it helps to look at the code when we shall help you
analysing the issues. Don't forget good open source is based on peer
review, and I can only recommend to make use of this mechanism early
(the many-eyes principle...).

Jan


--------------enigACBBA88729F71FDC34EF2830
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFHR2rniDOoMHTA+kRAp5LAJ9MCTEZIzX6fSsOc4y2lMVZI2XeigCdE1em
g5hK8ChwlcX2M/NcNCwOwIY=
=CuUu
-----END PGP SIGNATURE-----

--------------enigACBBA88729F71FDC34EF2830--

