Message-ID: <4E635FD3.3010704@domain.hid>
Date: Sun, 04 Sep 2011 13:24:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CAG0ejMHDxOXE-UTuO-iuE-ZcsN2-bLE+tx3ik6G=t_3HrsR0NA@mail.gmail.com>
	<4E61D028.3000702@domain.hid>
	<CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
In-Reply-To: <CAG0ejMGVMUTCPWvAHGA+kH94M8v-taeeWbvGanCJ3yU_XmEN5g@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8133F552CCC549FC5A821339"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] xenomai-core ftrace
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rainbow <lvqq05@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8133F552CCC549FC5A821339
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2011-09-04 07:10, rainbow wrote:
> Sorry to reply so late, I did a test about install ftrace on xenomai. t=
he
> following is my procedure:
> #git://git.xenomai.org/xenomai-jki.git queues/ftrace
> #git://git.kiszka.org/ipipe-2.6 queues/2.6.35-x86-trace
> #cd queues/ftrace
> #git checkout -b remotes/origin/queues/ftrace
>  origin/queues/2.6.35-x86-trace  //change to the ftrace xenomai branch
> #cd ../2.6.35-x86-trace
> #git checkout
> -b origin/queues/2.6.35-x86-trace origin/queues/2.6.35-x86-trace
> #cd ../ftrace
> #./scripts/prepare-kernel.sh  --arch=3Di386
> --adeos=3Dksrc/arch/x86/patches/adeos-ipipe-2.6.35.9-x86-2.8-04.patch
> --linux=3D../2.6.35-x86-trace/
> #cd /2.6.35-x86-trace/
>=20
> then I compile the kernel but I get the following error message:
> arch/x86/kernel/ipipe.c:851: error: conflicting types for =91update_vsy=
scall=92
> include/linux/clocksource.h:316: note: previous declaration of
> =91update_vsyscall=92 was here
> make[2]: *** [arch/x86/kernel/ipipe.o] Error 1
> make[1]: *** [arch/x86/kernel] Error 2
> make: *** [arch/x86] Error 2

That's a build issues of the underlying old ipipe patch. However, it's
x86-32 only. And as the documentation stated, only x86-64 is supported
by the ftrace patches. So build for 64 bit instead.

Jan


--------------enig8133F552CCC549FC5A821339
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5jX9cACgkQitSsb3rl5xTCxgCeN2w3SJ0r4BMc6lUSvK4IUkad
k84An3tpxcdqasJtJxmf5Rma1AXrdH56
=b5Au
-----END PGP SIGNATURE-----

--------------enig8133F552CCC549FC5A821339--

