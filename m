Date: Mon, 26 Jan 2004 19:00:22 -0500
From: Paul Mundt <lethal@domain.hid>
Message-ID: <20040127000022.GA17036@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
Subject: [Adeos-main] [PATCH] armnommu compile fix
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The current kernel-2.4/adeos-common/include/asm-armnommu/adeos.h has a brok=
en
__adeos_clear_irq(). This looks like it was copied from an SMP-able adeos.h
and cleaned up, with only this one line being left over and subsequently
causing the build to fail.

Against current CVS HEAD.

 kernel-2.4/adeos-common/include/asm-armnommu/adeos.h |    1 -
 1 files changed, 1 deletion(-)

Index: kernel-2.4/adeos-common/include/asm-armnommu/adeos.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/adeos/adeos/platforms/linux/kernel-2.4/adeos-common/incl=
ude/asm-armnommu/adeos.h,v
retrieving revision 1.20
diff -u -r1.20 adeos.h
--- kernel-2.4/adeos-common/include/asm-armnommu/adeos.h	9 Jan 2004 10:06:1=
5 -0000	1.20
+++ kernel-2.4/adeos-common/include/asm-armnommu/adeos.h	26 Jan 2004 23:59:=
04 -0000
@@ -204,7 +204,6 @@
     clear_bit(IPIPE_LOCK_FLAG,&(adp)->irqs[irq].control); \
     (adp)->cpudata[0].irq_hits[irq] =3D 0; \
     __adeos_clear_pend(adp,irq); \
-    } \
 } while(0)
=20
 #define adeos_virtual_irq_p(irq) ((irq) >=3D IPIPE_VIRQ_BASE && \

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAFaoW1K+teJFxZ9wRAh1kAKCFMmOT6sr+JXRVMLOT1XO3X3wYZQCfRtiD
XYdyGs5nT0ZjkBsOF2EVRl8=
=T7z+
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


