Message-ID: <465ED475.30700@domain.hid>
Date: Thu, 31 May 2007 15:58:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>	<465D664E.3040700@domain.hid>
	<465E8FA8.4030507@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>	<465EC7C1.5080300@domain.hid>
	<465ECDEC.1030109@domain.hid>	<465ECFCA.1070801@domain.hid>
	<7289437c0705310645w5e8bf8dfg6ed75d777d5b5ed9@domain.hid>
In-Reply-To: <7289437c0705310645w5e8bf8dfg6ed75d777d5b5ed9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig392D5485F1E3E116D6AC5C63"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] =?iso-8859-15?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig392D5485F1E3E116D6AC5C63
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
> All compile fine.
> But now I have a problem when I launch my application on my board :
>=20
> can't resolve symbol '__real_sem_init'
> I don't see the reason.
>=20

Same program as you posted earlier?

I compiled it here with

#> arm-linux-gcc `.../xeno-config --posix-cflags --posix-ldflags` \
-o posix-demo posix-demo.c

The generated binary shows no trace of __real_whatever:

#> objdump -R posix-demo

posix-demo:     file format elf32-littlearm

DYNAMIC RELOCATION RECORDS
OFFSET   TYPE              VALUE
00011274 R_ARM_COPY        stderr
000111fc R_ARM_JUMP_SLOT   __wrap_pthread_mutex_unlock
00011200 R_ARM_JUMP_SLOT   printf
00011204 R_ARM_JUMP_SLOT   sigemptyset
00011208 R_ARM_JUMP_SLOT   strerror
0001120c R_ARM_JUMP_SLOT   pthread_attr_init
00011210 R_ARM_JUMP_SLOT   pthread_exit
00011214 R_ARM_JUMP_SLOT   puts
00011218 R_ARM_JUMP_SLOT   sleep
0001121c R_ARM_JUMP_SLOT   sigaddset
00011220 R_ARM_JUMP_SLOT   abort
00011224 R_ARM_JUMP_SLOT   __wrap_pthread_setschedparam
00011228 R_ARM_JUMP_SLOT   __wrap_pthread_mutex_lock
0001122c R_ARM_JUMP_SLOT   fprintf
00011230 R_ARM_JUMP_SLOT   pthread_attr_setinheritsched
00011234 R_ARM_JUMP_SLOT   signal
00011238 R_ARM_JUMP_SLOT   pthread_attr_setstacksize
0001123c R_ARM_JUMP_SLOT   pthread_sigmask
00011240 R_ARM_JUMP_SLOT   __wrap_pthread_mutex_init
00011244 R_ARM_JUMP_SLOT   __wrap_pthread_create
00011248 R_ARM_JUMP_SLOT   pthread_self
0001124c R_ARM_JUMP_SLOT   pthread_attr_setschedpolicy
00011250 R_ARM_JUMP_SLOT   __uClibc_start_main
00011254 R_ARM_JUMP_SLOT   pthread_attr_setschedparam
00011258 R_ARM_JUMP_SLOT   pthread_attr_setdetachstate
0001125c R_ARM_JUMP_SLOT   pthread_join
00011260 R_ARM_JUMP_SLOT   mlockall
00011264 R_ARM_JUMP_SLOT   __wrap_pthread_mutex_destroy

Can you confirm the issue with this procedure? Also make sure that your
rebuild and re-installed the Xenomai user space part cleanly ("make
clean; make install").

Jan


--------------enig392D5485F1E3E116D6AC5C63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGXtR1niDOoMHTA+kRAq+FAJ4vM+L1hOlteM9M3oSFt1eMZRTgGACfXa4K
fwEzJ6klG8dz1WMPg2aErFE=
=gJZ9
-----END PGP SIGNATURE-----

--------------enig392D5485F1E3E116D6AC5C63--

