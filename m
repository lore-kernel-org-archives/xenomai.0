From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 8/9] testsuite: Add a simple test driver for psostests
Date: Wed, 13 Apr 2022 23:58:18 +0200
Message-Id: <20220413215819.22954-9-richard@nod.at>
In-Reply-To: <20220413215819.22954-1-richard@nod.at>
References: <20220413215819.22954-1-richard@nod.at>
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

Just like for alchemytests.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 testsuite/psostests/Makefile.am       | 15 ++++-
 testsuite/psostests/psostest_driver.c | 85 +++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 testsuite/psostests/psostest_driver.c

diff --git a/testsuite/psostests/Makefile.am b/testsuite/psostests/Makefi=
le.am
index 9e8aef62b..0a069837b 100644
--- a/testsuite/psostests/Makefile.am
+++ b/testsuite/psostests/Makefile.am
@@ -2,7 +2,8 @@ testdir =3D @XENO_TEST_DIR@
=20
 CCLD =3D $(top_srcdir)/scripts/wrap-link.sh $(CC)
=20
-test_PROGRAMS =3D mq1	\
+test_PROGRAMS =3D psostest_driver \
+		mq1	\
 		mq2	\
 		mq3	\
 		pt1	\
@@ -151,3 +152,15 @@ task9_SOURCES =3D task-9.c
 task9_CPPFLAGS =3D $(psoscppflags)
 task9_LDADD =3D $(psosldadd) -lpthread -lrt -lm
 task9_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+psostest_driver_SOURCES =3D psostest_driver.c
+psostest_driver_CPPFLAGS =3D			\
+	$(XENO_USER_CFLAGS)			\
+	-I$(top_srcdir)/include
+psostest_driver_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+psostest_driver_LDADD =3D			\
+	../../lib/psos/libpsos@CORE@.la		\
+	../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@		\
+	@XENO_USER_LDADD@		\
+	-lpthread -lrt
diff --git a/testsuite/psostests/psostest_driver.c b/testsuite/psostests/=
psostest_driver.c
new file mode 100644
index 000000000..0f076e1bc
--- /dev/null
+++ b/testsuite/psostests/psostest_driver.c
@@ -0,0 +1,85 @@
+#include <error.h>
+#include <libgen.h>
+#include <smokey/smokey.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static char *mydir;
+
+#define TEST(name)								   \
+	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
+	static int run_##name(struct smokey_test *t, int argc, char *const argv=
[]) \
+	{									   \
+		return __run_extprog(t, argc, argv);				   \
+	}
+
+static int __run_extprog(struct smokey_test *t, int argc, char *const ar=
gv[])
+{
+	int ret;
+	char *tst_path;
+
+	ret =3D asprintf(&tst_path, "%s/%s --cpu-affinity=3D0", mydir, t->name)=
;
+	if (ret =3D=3D -1)
+		return -ENOMEM;
+
+	ret =3D system(tst_path);
+	free(tst_path);
+
+	return ret;
+}
+
+TEST(mq1)
+TEST(mq2)
+TEST(mq3)
+TEST(pt1)
+TEST(rn1)
+TEST(sem1)
+TEST(sem2)
+TEST(task1)
+TEST(task2)
+TEST(task3)
+TEST(task4)
+TEST(task5)
+TEST(task6)
+TEST(task7)
+TEST(task8)
+TEST(task9)
+TEST(tm1)
+TEST(tm2)
+TEST(tm3)
+TEST(tm4)
+TEST(tm5)
+TEST(tm6)
+TEST(tm7)
+
+int main(int argc, char *const argv[])
+{
+	struct smokey_test *t;
+	int ret, fails =3D 0;
+
+	if (argc > 0)
+		mydir =3D dirname(argv[0]);
+	else
+		mydir =3D ".";
+
+	if (pvlist_empty(&smokey_test_list))
+		return 0;
+
+	for_each_smokey_test(t) {
+		ret =3D t->run(t, argc, argv);
+		if (ret) {
+			fails++;
+			if (smokey_keep_going)
+				continue;
+			if (smokey_verbose_mode)
+				error(1, -ret, "test %s failed", t->name);
+			return 1;
+		}
+		smokey_note("%s OK", t->name);
+	}
+
+	return fails !=3D 0;
+}
--=20
2.34.1


