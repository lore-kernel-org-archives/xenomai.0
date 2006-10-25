Message-ID: <453F9EF2.3020703@domain.hid>
Date: Wed, 25 Oct 2006 19:29:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Licensing issues
References: <54b161f50610250007t1387a163l33a44d30f27dbfcc@domain.hid>
	<1161788591.5114.47.camel@domain.hid>
In-Reply-To: <1161788591.5114.47.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C589801FB57984A81E2E1F2"
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
To: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C589801FB57984A81E2E1F2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Schl=E4gl Manfred jun. wrote:
> Its a very difficult question. I'm also interestet in it.
>=20
> Adeos is under GPL.
> Xenomai-code in ksrc is under GPL;=20
> userspace Xenomai-code is under LGPL
>=20
> Kernel-sources are under GPL, because several functions of the kernel c=
an only be used by GPL-licensed modules.=20

Additionally, it is The Right Thing that when you modify such common
infrastructure like the Xenomai core, you should be urged to provide the
same freedom to users of your modifications. This can best be reached by
contributing them back to mainstream.

> Userspace code is under LGPL, but the kernel-code is used by syscalls .=
=2E.
>=20
> So it's really hard to determine if applications have to be GPLed or LG=
PLed at this point...
>=20
>=20
> BUT!=20
>=20
> The header-files are GPLed with following exception:
>=20
> COPYING:
> ...
> As a special exception to the following license, the Xenomai
> project gives permission for additional uses of the header files
> contained in this directory.
>=20
> The exception is that, if you include these header files unmodified to
> produce application programs executing in user-space that use
> Xenomai services by normal Xenomai system calls, this does not
> by itself cause the resulting executable to be covered by the GNU
> General Public License. This is merely considered normal use of the
> Xenomai system, and does not fall under the heading of "derived
> work".
>=20
> This exception does not however invalidate any other reasons why the
> executable file might be covered by the GNU General Public License. In
> any case, this exception never applies when the application code is
> built as a static or dynamically loadable portion of the Linux kernel.
>=20
> This exception applies only to the code released by the Xenomai
> project under the name Xenomai and bearing this exception notice.
> If you copy code from other sources into a copy of Xenomai, the
> exception does not apply to the code that you add in this way.
> ...
>=20
>=20
> But is this exception airtight? Is it hard enought to stand a court-cas=
e? I don't know.
>=20

Legal question are always tricky. My believe as a non-lawyer is that
Xenomai's license terms are fairly clear in that they allow user-space
development _against_ libs/headers/syscalls under any license. Working
_inside_ the user libs or even the Xenomai core is of course governed by
LGPL and GPL, respectively.

Writing non-GPL kernel space applications or drivers is a far trickier
question. Any such "program" is never only a Xenomai user, it's first of
all a kernel module. And the "trend" in the kernel community clearly
goes towards GPL-only. Some developers (i.e. copyright holders) already
consider ANY non-GPL module an infringement today. Xenomai cannot (and
doesn't want to) put any escape-door against this legitimate decision.
Xenomai is just an (out-of-tree) subsystem of Linux.

Regarding RTDM drivers: My believe is that any potential non-GPL driver
publisher should better consult a layer. I would rather try (harder) to
partition the system in a way that relevant intellectual properties are
always in hardware/firmware or user-space. In the end this makes life
easier - and saves us from seeing more and more lawyers hanging around
;). The roadmap of RTDM contains one topic that aims at helping driver
developers here (user-space driver API), but it's an extension not yet
backed up with concrete resources.

Jan


--------------enig2C589801FB57984A81E2E1F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFP57yniDOoMHTA+kRAjAOAJ9Ratboz6FKaPDkMIJc+NimSShHLwCfUo4O
N5SJg3hdv0aPgQ9cGn+1cB4=
=NLEC
-----END PGP SIGNATURE-----

--------------enig2C589801FB57984A81E2E1F2--

