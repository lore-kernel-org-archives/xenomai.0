From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [PATCH v2 2/3] lib/cobalt: Introduce generic feature initialization
 and check API
Date: Mon, 16 Nov 2020 14:07:17 +0000
Message-ID: <20201116140641.72027-3-florian.bezdeka@siemens.com>
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

The feature initialization was arch specific up to now and the
available features (=3D features offered by the currently running kernel)
were no longer accessible once the bind syscall finished.

This patch introduces a simple API for fetching the offered features
during runtime.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/init.c     |  2 +-
 lib/cobalt/internal.c | 10 ++++++++++
 lib/cobalt/internal.h | 39 +++++++++++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 6907ace36..20e28ccb0 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -177,7 +177,7 @@ static void low_init(void)
 		early_panic("mlockall: %s", strerror(errno));
=20
 	trace_me("memory locked");
-	cobalt_arch_check_features(f);
+	cobalt_features_init(f);
 	cobalt_init_umm(f->vdso_offset);
 	trace_me("memory heaps mapped");
 	cobalt_init_current_keys();
diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index 43330060a..303d86f99 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -565,3 +565,13 @@ void cobalt_assert_nrt(void)
 	if (cobalt_should_warn())
 		pthread_kill(pthread_self(), SIGDEBUG);
 }
+
+unsigned int cobalt_features;
+
+void cobalt_features_init(struct cobalt_featinfo *f)
+{
+	cobalt_features =3D f->feat_all;
+
+	/* Trigger arch specific feature initialization */
+	cobalt_arch_check_features(f);
+}
\ No newline at end of file
diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index 4ca99d927..a0dff30cd 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -19,6 +19,7 @@
 #define _LIB_COBALT_INTERNAL_H
=20
 #include <limits.h>
+#include <stdbool.h>
 #include <boilerplate/ancillaries.h>
 #include <cobalt/sys/cobalt.h>
 #include "current.h"
@@ -86,10 +87,6 @@ int cobalt_xlate_schedparam(int policy,
 			    struct sched_param *param);
 int cobalt_init(void);
=20
-struct cobalt_featinfo;
-
-void cobalt_arch_check_features(struct cobalt_featinfo *finfo);
-
 extern struct sigaction __cobalt_orig_sigdebug;
=20
 extern int __cobalt_std_fifo_minpri,
@@ -98,4 +95,38 @@ extern int __cobalt_std_fifo_minpri,
 extern int __cobalt_std_rr_minpri,
 	   __cobalt_std_rr_maxpri;
=20
+extern unsigned int cobalt_features;
+
+struct cobalt_featinfo;
+
+/**
+ * Arch specific feature initialization
+ *
+ * @param finfo
+ */
+void cobalt_arch_check_features(struct cobalt_featinfo *finfo);
+
+/**
+ * Initialize the feature handling.
+ *
+ * @param f Feature info that will be cached for future feature checks
+ */
+void cobalt_features_init(struct cobalt_featinfo *f);
+
+/**
+ * Check if a given set of features is available / provided by the kernel
+ *
+ * @param feat_mask A bit mask of features to check availability for. See
+ * __xn_feat_* macros for a list of defined features
+ *
+ * @return true if all features are available, false otherwise
+ */
+static inline bool cobalt_features_available(unsigned int feat_mask)
+{
+	if ((cobalt_features & feat_mask) =3D=3D feat_mask)
+		return true;
+
+	return false;
+}
+
 #endif /* _LIB_COBALT_INTERNAL_H */
--=20
2.26.2

