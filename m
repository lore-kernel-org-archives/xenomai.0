From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [PATCH v2 1/3] lib/cobalt: Rename cobalt_check_features to
 cobalt_arch_check_features
Date: Mon, 16 Nov 2020 14:07:16 +0000
Message-ID: <20201116140641.72027-2-florian.bezdeka@siemens.com>
References: <157dbba3-5d17-7f84-6319-9ea9eae35854@tj.kylinos.cn>+EDAFE494B95437A7>
 <20201116140641.72027-1-florian.bezdeka@siemens.com>
In-Reply-To: <20201116140641.72027-1-florian.bezdeka@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, song <chensong@tj.kylinos.cn>

From: Florian Bezdeka <florian.bezdeka@siemens.com>

cobalt_check_features is implemented for each architecture. As
further feature initialization will arrive the name of the function
should clarify that.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/arch/arm/features.c     | 2 +-
 lib/cobalt/arch/arm64/features.c   | 2 +-
 lib/cobalt/arch/powerpc/features.c | 2 +-
 lib/cobalt/arch/x86/features.c     | 2 +-
 lib/cobalt/init.c                  | 2 +-
 lib/cobalt/internal.h              | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/cobalt/arch/arm/features.c b/lib/cobalt/arch/arm/features.=
c
index edabcf25b..d7b50f73f 100644
--- a/lib/cobalt/arch/arm/features.c
+++ b/lib/cobalt/arch/arm/features.c
@@ -37,7 +37,7 @@ struct __xn_full_tscinfo __xn_tscinfo =3D {
 	},
 };
=20
-void cobalt_check_features(struct cobalt_featinfo *finfo)
+void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
 	unsigned long phys_addr;
 	unsigned page_size;
diff --git a/lib/cobalt/arch/arm64/features.c b/lib/cobalt/arch/arm64/featu=
res.c
index 254c8aeae..8b85a27ea 100644
--- a/lib/cobalt/arch/arm64/features.c
+++ b/lib/cobalt/arch/arm64/features.c
@@ -37,7 +37,7 @@ struct __xn_full_tscinfo __xn_tscinfo =3D {
 	},
 };
=20
-void cobalt_check_features(struct cobalt_featinfo *finfo)
+void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
 	unsigned long phys_addr;
 	unsigned page_size;
diff --git a/lib/cobalt/arch/powerpc/features.c b/lib/cobalt/arch/powerpc/f=
eatures.c
index 6fc7afa64..d795a198a 100644
--- a/lib/cobalt/arch/powerpc/features.c
+++ b/lib/cobalt/arch/powerpc/features.c
@@ -19,6 +19,6 @@
 #include <asm/xenomai/syscall.h>
 #include "internal.h"
=20
-void cobalt_check_features(struct cobalt_featinfo *finfo)
+void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
 }
diff --git a/lib/cobalt/arch/x86/features.c b/lib/cobalt/arch/x86/features.=
c
index f8ba4ee2c..e7e62da39 100644
--- a/lib/cobalt/arch/x86/features.c
+++ b/lib/cobalt/arch/x86/features.c
@@ -25,7 +25,7 @@
 #include <asm/xenomai/uapi/fptest.h>
 #include "internal.h"
=20
-void cobalt_check_features(struct cobalt_featinfo *finfo)
+void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
 {
 #if defined(__i386__) && defined(CONFIG_XENO_X86_VSYSCALL)
 	size_t n =3D confstr(_CS_GNU_LIBPTHREAD_VERSION, NULL, 0);
diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 9b506d872..6907ace36 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -177,7 +177,7 @@ static void low_init(void)
 		early_panic("mlockall: %s", strerror(errno));
=20
 	trace_me("memory locked");
-	cobalt_check_features(f);
+	cobalt_arch_check_features(f);
 	cobalt_init_umm(f->vdso_offset);
 	trace_me("memory heaps mapped");
 	cobalt_init_current_keys();
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index c45a54d9f..4ca99d927 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -88,7 +88,7 @@ int cobalt_init(void);
=20
 struct cobalt_featinfo;
=20
-void cobalt_check_features(struct cobalt_featinfo *finfo);
+void cobalt_arch_check_features(struct cobalt_featinfo *finfo);
=20
 extern struct sigaction __cobalt_orig_sigdebug;
=20
--=20
2.26.2

