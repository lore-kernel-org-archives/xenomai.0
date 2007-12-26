Message-ID: <47727556.4090201@domain.hid>
Date: Wed, 26 Dec 2007 16:37:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37DA328393CAD4BD0296A1DF"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 2/4] x86_64: fix TRACE_IRQS_OFF regression
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37DA328393CAD4BD0296A1DF
Content-Type: multipart/mixed;
 boundary="------------070805080201010806070507"

This is a multi-part message in MIME format.
--------------070805080201010806070507
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

We need to save rax across the IRQ exit tracing, as it carries
information about how to return from interrupt.

Jan



--------------070805080201010806070507
Content-Type: text/x-patch;
 name="fix-irqtrace-thunk-x86_64.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-irqtrace-thunk-x86_64.patch"

---
 arch/x86_64/kernel/entry.S |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.23.12-xeno_64/arch/x86_64/kernel/entry.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.12-xeno_64.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.23.12-xeno_64/arch/x86_64/kernel/entry.S
@@ -567,10 +567,12 @@ END(stub_rt_sigreturn)
=20
 	popq %rbp
 	pushq %rbp
+	pushq %rax
 	movq 8-ARGOFFSET+ORIG_RAX(%rbp), %rdi
 	leaq 8-ARGOFFSET+RIP-8(%rbp), %rbp
 	notq %rdi
 	call ipipe_trace_end
+	popq %rax
 	popq %rbp
 	pushq %rbp
 #else



--------------070805080201010806070507--

--------------enig37DA328393CAD4BD0296A1DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHcnVWniDOoMHTA+kRAphFAJ9IgqoJjBF7KOq3bY4MH+1coYPzYQCfWt4N
d4zvsB2oYckXtOl767QJMYA=
=IUiK
-----END PGP SIGNATURE-----

--------------enig37DA328393CAD4BD0296A1DF--

