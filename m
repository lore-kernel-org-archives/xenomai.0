From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] doc: Remove references to --enable-smp
Date: Wed, 13 Apr 2022 14:05:09 +0200
Message-Id: <20220413120509.5637-2-richard@nod.at>
In-Reply-To: <20220413120509.5637-1-richard@nod.at>
References: <20220413120509.5637-1-richard@nod.at>
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

SMP is enabled by default, remove usage of --enable-smp
and document how to disable SMP, if needed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 doc/asciidoc/README.INSTALL.adoc | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTA=
LL.adoc
index c0f4c12e99b4..d2b7e6f782eb 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -538,9 +538,9 @@ only reason to turn this feature on would be aimed at=
 cancelling
 threads which run significantly long, syscall-less busy loops with no
 explicit exit condition, which should probably be revisited anyway.
=20
-*--enable-smp*::
+*--disable-smp*::
=20
-	Turns on SMP support for Xenomai libraries.
+	Turns off SMP support for Xenomai libraries.
=20
 [CAUTION]
 SMP support must be enabled in Xenomai libraries when the
@@ -671,9 +671,6 @@ The examples in following sections use the following =
conventions:
  the host immediately updates the target system with the installed
  programs and libraries.
=20
-CAUTION: In the examples below, make sure to add `--enable-smp` to the
-_configure_ script options if building for a SMP-enabled kernel.
-
 Building the x86 libraries (32/64bit)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
@@ -683,7 +680,7 @@ typically run:
=20
 ------------------------------------------------------------------------=
------
 $ mkdir $build_root && cd $build_root
-$ $xenomai_root/configure --with-core=3Dmercury --enable-smp --enable-ps=
hared
+$ $xenomai_root/configure --with-core=3Dmercury --enable-pshared
 $ make install
 ------------------------------------------------------------------------=
------
=20
@@ -692,7 +689,7 @@ same feature set, for running on x86_32 could be:
=20
 ------------------------------------------------------------------------=
------
 $ mkdir $build_root && cd $build_root
-$ $xenomai_root/configure --with-core=3Dcobalt --enable-smp --enable-psh=
ared \
+$ $xenomai_root/configure --with-core=3Dcobalt --enable-pshared \
   --host=3Di686-linux CFLAGS=3D"-m32 -O2" LDFLAGS=3D"-m32"
 $ make install
 ------------------------------------------------------------------------=
------
@@ -743,10 +740,10 @@ for the supported SOCs:
 		gcc versions the flag for armv7
 		may be `-march=3Darmv7-a` or
 		`-march=3Darmv7a`]|
-|imx6q	     | `-march=3Darmv7-a -mfpu=3Dvfp3` footnoteref:[armv7] | --en=
able-smp
+|imx6q	     | `-march=3Darmv7-a -mfpu=3Dvfp3` footnoteref:[armv7] |
 |ixp4xx      | `-march=3Darmv5 -msoft-float`         | `--enable-arm-tsc=
=3Dixp4xx`
 |omap3       | `-march=3Darmv7-a -mfpu=3Dvfp3` footnoteref:[armv7] |
-|omap4       | `-march=3Darmv7-a -mfpu=3Dvfp3` footnoteref:[armv7] | --e=
nable-smp
+|omap4       | `-march=3Darmv7-a -mfpu=3Dvfp3` footnoteref:[armv7] |
 |orion       | `-march=3Darmv5 -mfpu=3Dvfp`            |
 |pxa         | `-march=3Darmv5 -msoft-float`         |
 |pxa3xx      | `-march=3Darmv5 -msoft-float`         | --enable-arm-quir=
ks=3Dxscale3
--=20
2.26.2


