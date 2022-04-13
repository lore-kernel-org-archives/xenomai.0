From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] debian: Remove --enable-smp
Date: Wed, 13 Apr 2022 14:05:08 +0200
Message-Id: <20220413120509.5637-1-richard@nod.at>
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

SMP is now enabled by default for all architectures.
No need to use --enable-smp anymore.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 debian/rules | 1 -
 1 file changed, 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 3fe6bece93c9..60094734630d 100755
--- a/debian/rules
+++ b/debian/rules
@@ -17,7 +17,6 @@ CONFIG_OPTS =3D --prefix=3D/usr \
             --includedir=3D/usr/include/xenomai \
             --mandir=3D/usr/share/man \
             --with-testdir=3D/usr/lib/xenomai/testsuite \
-            --enable-smp \
             --enable-lazy-setsched \
             --enable-debug=3Dsymbols \
             --enable-dlopen-libs
--=20
2.26.2


