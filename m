Message-ID: <4AF87D53.9090102@domain.hid>
Date: Mon, 09 Nov 2009 21:36:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig447E8E86DCEE58F0937C2DD0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [pull request] heap reference and trivial build fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig447E8E86DCEE58F0937C2DD0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6d7d6bc436ef3d1fb51fa8de06d4ecf004e3b6=
a5:
  Gilles Chanteperdrix (1):
        nucleus: defer selector block deletion to an APC.

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (2):
      nucleus: Track heap mapping on to mm-clone
      nucleus: Fix trivial build warning

 ksrc/nucleus/heap.c   |   12 +++++++++++-
 ksrc/nucleus/module.c |    2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

---

[PATCH] nucleus: Track heap mapping on to mm-clone

When the mm is cloned (due to fork), the heap mapping counter need to be
updated as well. Register an open callback with the vm-ops for this
purpose.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/heap.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
index b5fb1cd..27a4ad7 100644
--- a/ksrc/nucleus/heap.c
+++ b/ksrc/nucleus/heap.c
@@ -1017,6 +1017,15 @@ static void __unreserve_and_free_heap(void *ptr, s=
ize_t size, int kmflags)
 	}
 }
=20
+static void xnheap_vmopen(struct vm_area_struct *vma)
+{
+	xnheap_t *heap =3D vma->vm_private_data;
+
+	spin_lock(&kheapq_lock);
+	heap->archdep.numaps++;
+	spin_unlock(&kheapq_lock);
+}
+
 static void xnheap_vmclose(struct vm_area_struct *vma)
 {
 	xnheap_t *heap =3D vma->vm_private_data;
@@ -1037,7 +1046,8 @@ static void xnheap_vmclose(struct vm_area_struct *v=
ma)
 }
=20
 static struct vm_operations_struct xnheap_vmops =3D {
-      .close =3D &xnheap_vmclose
+	.open =3D &xnheap_vmopen,
+	.close =3D &xnheap_vmclose
 };
=20
 static int xnheap_open(struct inode *inode, struct file *file)
--=20
1.6.0.2


--------------enig447E8E86DCEE58F0937C2DD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkr4fVQACgkQitSsb3rl5xSYKwCgjuU0N4oX9+NhzXn17Wu8kK+M
SQ8AoMjFIylKGezjI6JdkLLx2XcAPheR
=r9hI
-----END PGP SIGNATURE-----

--------------enig447E8E86DCEE58F0937C2DD0--

