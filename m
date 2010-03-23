Message-ID: <4BA8F517.3060705@domain.hid>
Date: Tue, 23 Mar 2010 18:06:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BA39C3D.1040802@domain.hid> <4BA4EF75.7010202@domain.hid>
	<4BA74820.2090401@domain.hid> <4BA8752E.8090407@domain.hid>
	<4BA8C15E.5050707@domain.hid>
In-Reply-To: <4BA8C15E.5050707@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig85C9007074BB411C922F7200"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] crash after termination
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85C9007074BB411C922F7200
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stefan Kisdaroczi wrote:
> Hi Jan,
>=20
> Only user space using the native skin. Some additional notes:
> I'm using the freepascal compiler and link against libnative, i dont us=
e gcc.
> There is one process starting the other ten processes using fork() & ex=
ecl().
> The tasks do a lot of mode switching between primary/secondary.
> The stacksize for the tasks is 1MB. We only use between 4K-16K of stack=
 in our
> applications. So there should be still a bit less than 1 MB for socket =
calls
> and printf, is this to low ?

Also stack overflows must not crash the kernel, they may only cause
application crashes.

>=20
> I rebuilt the kernel without arcnet and isdn and disabled smp too, usin=
g 2.5.1.
> It still crashes every time on termination. If I pull the network conne=
ctor,
> I could start and shutdown the applications 5 times without problem. If=
 the
> network is connected, as soon as there is some network activity like ss=
h/samba
> on termination the box crashes. Sometimes it gets even back to the prom=
pt before
> crashing. Its a rtl8139 network card, but happens in a virtualbox-vm wi=
th a pcnet
> card too. In the traces is always a "do_IRQ+0x...", so I think the prob=
lem is
> related to IRQ-handling.

That sounds promising! If you can provide your test case to us (or me
privately), we could try to reproduce - inside a proper hypervisor which
has proper debugging facilities. :)

Jan


--------------enig85C9007074BB411C922F7200
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuo9RcACgkQitSsb3rl5xQTxQCgm3sNo5nIrEopyaeZLaevBjyZ
zwIAn3/Ko2BlzL6QqX34waJNxwZE1YQw
=m/jH
-----END PGP SIGNATURE-----

--------------enig85C9007074BB411C922F7200--

