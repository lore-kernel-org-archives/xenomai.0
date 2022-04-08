From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] configure.ac: Enable SMP by default
Date: Fri,  8 Apr 2022 10:59:09 +0200
Message-Id: <20220408085909.26395-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>

In 2022 it is hard to find ARM or x86 systems without SMP.
Other CPU architectures are no longer supported by Xenomai.
So, make SMP support opt-out.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 configure.ac | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 019453793..867fc4636 100644
--- a/configure.ac
+++ b/configure.ac
@@ -385,12 +385,9 @@ if test x$use_registry =3D xy; then
 fi
 AM_CONDITIONAL(XENO_REGISTRY,[test x$use_registry =3D xy])
=20
-dnl SMP support (default: on for cobalt/x86, off otherwise)
+dnl SMP support (default: on)
=20
-CONFIG_SMP=3D
-if test $target_cpu_arch =3D x86 -a $rtcore_type =3D cobalt; then
-	CONFIG_SMP=3Dy
-fi
+CONFIG_SMP=3Dy
 AC_MSG_CHECKING(for SMP support)
 AC_ARG_ENABLE(smp,
 	AS_HELP_STRING([--enable-smp], [Enable SMP support]),
--=20
2.34.1


