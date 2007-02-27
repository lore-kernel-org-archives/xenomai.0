Message-ID: <45E456EC.2090207@domain.hid>
Date: Tue, 27 Feb 2007 17:06:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Compile-time error with xenomai x86_64
	port	(probably dualcore related)
References: <45E45506.10208@domain.hid>
In-Reply-To: <45E45506.10208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4242D5D463036EB8E7292363"
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
To: Matthias Scheer <scheer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4242D5D463036EB8E7292363
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Matthias Scheer wrote:
> Dear developers,
>=20
> I'm trying to compile the latest /trunk version together with the adeos=

> x86_64 patch v1.00.04. The kernel version is 2.6.19.5. The compiling is=

> done on an Athlon 64 X2 and stops with these error messages:
>=20
>   CC      kernel/xenomai/nucleus/pod.o
> kernel/xenomai/nucleus/pod.c:944:48: error: macro "cpus_equal" passed 3=

> arguments, but takes just 2
> kernel/xenomai/nucleus/pod.c: In function =E2=80=98xnpod_start_thread=E2=
=80=99:
> kernel/xenomai/nucleus/pod.c:944: error: =E2=80=98cpus_equal=E2=80=99 u=
ndeclared (first
> use in this function)
> kernel/xenomai/nucleus/pod.c:944: error: (Each undeclared identifier is=

> reported only once
> kernel/xenomai/nucleus/pod.c:944: error: for each function it appears i=
n.)
>=20
> Notice the _macro "cpus_equal"_ error, which eventually uses the
> identifier CPU_MASK_ALL which contains more than one element on a
> dualcore system. Does this explanation make sense? And is there a easy
> way to fix it? (maybe with a variable number of arguments)
>=20

Does this help?

--- include/asm-generic/system.h        (Revision 2262)
+++ include/asm-generic/system.h        (Arbeitskopie)
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/cpumask.h>
 #include <asm/uaccess.h>
 #include <asm/param.h>
 #include <asm/mmu_context.h>

[At least it is cleaner than relying on cpumask.h being implicitly
included.]

Jan


--------------enig4242D5D463036EB8E7292363
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5FbsniDOoMHTA+kRAgB5AJ9igKz0TzP0G2uiBhTfm+3DLzdMZwCeJQz7
1c2tGmzrYB+D3xsQsUVmKZA=
=ENR7
-----END PGP SIGNATURE-----

--------------enig4242D5D463036EB8E7292363--

