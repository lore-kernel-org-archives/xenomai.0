Message-ID: <4455E720.70509@domain.hid>
Date: Mon, 01 May 2006 12:46:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] UVM build error in todays head of SVN
References: <4455E3D4.8060007@domain.hid>
In-Reply-To: <4455E3D4.8060007@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig48A67BC8ECFF38CA1FA9C57C"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig48A67BC8ECFF38CA1FA9C57C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> I just checked out Xenomai and realized the UVM build error below (whil=
e
> building for PPC 405 with IPIPE tracer).  "xnlock_put/get" seems not to=

> be dummy without SMP.
>=20
> Wolfgang.
>=20

Try this patch. It fixes the problem and also appears to me as the
correct way to solve it (UVM is a UP-machine, spinlocks are void).

Jan


--- include/asm-uvm/system.h    (Revision 1022)
+++ include/asm-uvm/system.h    (Arbeitskopie)
@@ -67,6 +67,8 @@ typedef unsigned long xnlock_t;
 #define XNARCH_LOCK_UNLOCKED 0

 #define xnlock_init(lock)              do { } while(0)
+#define xnlock_get(lock)               do { } while(0)
+#define xnlock_put(lock)               do { } while(0)
 #define xnlock_get_irqsave(lock,x)     ((x) =3D xnarch_lock_irq())
 #define xnlock_put_irqrestore(lock,x)  xnarch_unlock_irq(x)
 #define xnlock_clear_irqoff(lock)      xnarch_lock_irq()



--------------enig48A67BC8ECFF38CA1FA9C57C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEVecjniDOoMHTA+kRAntXAJ9rSXdVKTv5C69tlJboVkk25cSSVwCeKb4i
bQQ+Ib888jP2YOYfVWOVCCs=
=0Erb
-----END PGP SIGNATURE-----

--------------enig48A67BC8ECFF38CA1FA9C57C--

