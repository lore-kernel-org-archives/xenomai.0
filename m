Message-ID: <4776D47C.5090005@domain.hid>
Date: Sun, 30 Dec 2007 00:13:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC7BB5570A0E87E0E20C0AF57"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 3/5] avoid naming conflict around
	__ipipe_irq_handler
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
--------------enigC7BB5570A0E87E0E20C0AF57
Content-Type: multipart/mixed;
 boundary="------------050905040004050301040300"

This is a multi-part message in MIME format.
--------------050905040004050301040300
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

There is already a definition of __ipipe_irq_handler. So, we either need
to more the real ipipe_irq_handler_t into ipipe_base.h, or rename this
local variant to __ipipe_irq_handler_t, or simple drop this refactoring.
This patch starts with applying the latter - the easiest one :->

Jan

--------------050905040004050301040300
Content-Type: text/x-patch;
 name="avoid-naming-conflict.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="avoid-naming-conflict.patch"

---
 include/asm-x86/ipipe_32.h |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6.24-rc6-xeno/include/asm-x86/ipipe_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno.orig/include/asm-x86/ipipe_32.h
+++ linux-2.6.24-rc6-xeno/include/asm-x86/ipipe_32.h
@@ -125,11 +125,8 @@ static inline unsigned long __ipipe_ffnz
=20
 DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
=20
-typedef void (__ipipe_irq_handler)(unsigned irq,
-				   void *cookie);
-
 static inline void __ipipe_call_root_xirq_handler(unsigned irq,
-						  __ipipe_irq_handler *handler)
+						  void (*handler)(unsigned, void *))
 {
 	struct pt_regs *regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
=20
@@ -161,7 +158,7 @@ void irq_enter(void);
 void irq_exit(void);
=20
 static inline void __ipipe_call_root_virq_handler(unsigned irq,
-						  __ipipe_irq_handler *handler,
+						  void (*handler)(unsigned, void *),
 						  void *cookie)
 {
 	irq_enter();

--------------050905040004050301040300--

--------------enigC7BB5570A0E87E0E20C0AF57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdtR8niDOoMHTA+kRApz9AJ9Ad0OI4Ur7FM+X4j0pGe3/90W0bACbBGzw
oKICxKd94chckUGanT0rZ88=
=rfUc
-----END PGP SIGNATURE-----

--------------enigC7BB5570A0E87E0E20C0AF57--

