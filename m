Message-ID: <4469AF8B.2040400@domain.hid>
Date: Tue, 16 May 2006 12:55:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [RTDM] best strategy for periodic reading
References: <e4c3bv$829$1@domain.hid> <44699D5A.9070806@domain.hid>
	<4546494d0605160315x2fad7c74ge8133057446d5f6b@domain.hid>
In-Reply-To: <4546494d0605160315x2fad7c74ge8133057446d5f6b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4DA96E84427C202B59509733"
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
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: Marco Jackel <ich@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4DA96E84427C202B59509733
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Li Yi (Adam) wrote:
> Hi Jan,
>=20
> Quick questions:

=2E..long answer. ;)

> 1. What is the problem with "xntimer_init()"? The timerbench.c use it t=
o
> create timers? You are going to write a RTDM implementation?

Not an implementation but rather a thin wrapper.

The aim of RTDM is to remain independent of the actual RT-Linux
implementation. We already have RTDM support in recent RTAI, the future
may bring ports to RTLinux/GPL (as long as this project keeps alive) and
preempt-rt. Sebastian's SJA1000 CAN driver is e.g. RTDM-based and can be
recompiled for RTAI without using tons of #ifdefs. RTnet does this even
longer.

So, by using Xenomai nucleus services directly you make your driver
harder to port. The timerbench-way is only an intermediate solution
until we have a real abstraction (see also comments in the code).

> 2.  What is  general program model for Xenomai application like data
> acquisition? What I am thinking is to start the RT task in user space (=
via
> POSIX skin), and implement the read funtion in kernel space using RTDM.=


Unless you have specific requirements, putting the (common) hardware
interface into an RTDM driver and leaving the rest to the application is
the preferred way (it's nothing Xenomai-specific, is it?).

If a RTDM driver always has to be in kernel space is a different
question. I have some weird ideas about (widely) seamless user space
migration (and vice versa), either into the process context of an
exclusive device user (kind of library) or even shared between multiple
processes (device servers, microkernel-like, probably at similar costs).
Anyway, the goal is to keep the RTDM interfaces for both domains widely
identical, and this will require some more work (and thus time, which
I'm always lacking).

Userspace drivers are not the ultimate answer to all questions (that's
42 anyway), but they can open certain new possibilities, both
technically and legally.

Jan


--------------enig4DA96E84427C202B59509733
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEaa+LniDOoMHTA+kRArFlAJ4gE+AGuhQqSxSBF8af7GlTAHTedACaA2hE
HNiloC8SA8qIZsD5hwmrO6w=
=ku85
-----END PGP SIGNATURE-----

--------------enig4DA96E84427C202B59509733--

