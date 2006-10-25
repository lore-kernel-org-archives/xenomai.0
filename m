From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <54b161f50610250007t1387a163l33a44d30f27dbfcc@domain.hid>
References: <54b161f50610250007t1387a163l33a44d30f27dbfcc@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-WAH3NPUusmYLmtu1E5TZ"
Date: Wed, 25 Oct 2006 17:03:11 +0200
Message-Id: <1161788591.5114.47.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] Re: Licensing issues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--=-WAH3NPUusmYLmtu1E5TZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Its a very difficult question. I'm also interestet in it.

Adeos is under GPL.
Xenomai-code in ksrc is under GPL;=20
userspace Xenomai-code is under LGPL

Kernel-sources are under GPL, because several functions of the kernel can o=
nly be used by GPL-licensed modules.=20
Userspace code is under LGPL, but the kernel-code is used by syscalls ...

So it's really hard to determine if applications have to be GPLed or LGPLed=
 at this point...


BUT!=20

The header-files are GPLed with following exception:

COPYING:
...
As a special exception to the following license, the Xenomai
project gives permission for additional uses of the header files
contained in this directory.

The exception is that, if you include these header files unmodified to
produce application programs executing in user-space that use
Xenomai services by normal Xenomai system calls, this does not
by itself cause the resulting executable to be covered by the GNU
General Public License. This is merely considered normal use of the
Xenomai system, and does not fall under the heading of "derived
work".

This exception does not however invalidate any other reasons why the
executable file might be covered by the GNU General Public License. In
any case, this exception never applies when the application code is
built as a static or dynamically loadable portion of the Linux kernel.

This exception applies only to the code released by the Xenomai
project under the name Xenomai and bearing this exception notice.
If you copy code from other sources into a copy of Xenomai, the
exception does not apply to the code that you add in this way.
...


But is this exception airtight? Is it hard enought to stand a court-case? I=
 don't know.

	- Manfred

--=-WAH3NPUusmYLmtu1E5TZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFP3yvbMvu5jIEpfsRAoUmAJ9u7TApLOd4GwUC86z0yuHboplSsQCdE3BM
hoLnDxGyD4wJrZWNmsKbw4c=
=DJSJ
-----END PGP SIGNATURE-----

--=-WAH3NPUusmYLmtu1E5TZ--


