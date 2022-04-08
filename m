From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/6] testsuite: Add a simple test driver for alchemytests
Date: Fri,  8 Apr 2022 10:03:58 +0200
Message-Id: <20220408080401.22235-4-richard@nod.at>
In-Reply-To: <20220408080401.22235-1-richard@nod.at>
References: <20220408080401.22235-1-richard@nod.at>
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

In their current shape, every alchemy test has to be a single
program and does not use the smokey test framework.

alchemytest_driver uses smokey and runs each test as new process.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 testsuite/alchemytests/Makefile.am          | 11 +++
 testsuite/alchemytests/alchemytest_driver.c | 84 +++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 testsuite/alchemytests/alchemytest_driver.c

diff --git a/testsuite/alchemytests/Makefile.am b/testsuite/alchemytests/=
Makefile.am
index 35df0d49c..9159a0b77 100644
--- a/testsuite/alchemytests/Makefile.am
+++ b/testsuite/alchemytests/Makefile.am
@@ -146,3 +146,14 @@ task10_SOURCES =3D task-10.c
 task10_CPPFLAGS =3D $(alchemycppflags)
 task10_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
 task10_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+alchemytest_driver_SOURCES =3D alchemytest_driver.c
+alchemytest_driver_CPPFLAGS =3D			\
+	$(XENO_USER_CFLAGS)			\
+	-I$(top_srcdir)/include
+alchemytest_driver_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+alchemytest_driver_LDADD =3D			\
+	../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@		\
+	@XENO_USER_LDADD@		\
+	-lpthread -lrt
diff --git a/testsuite/alchemytests/alchemytest_driver.c b/testsuite/alch=
emytests/alchemytest_driver.c
new file mode 100644
index 000000000..45323507d
--- /dev/null
+++ b/testsuite/alchemytests/alchemytest_driver.c
@@ -0,0 +1,84 @@
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
+TEST(alarm1)
+TEST(buffer1)
+TEST(event1)
+TEST(heap1)
+TEST(heap2)
+TEST(mq1)
+TEST(mq2)
+TEST(mq3)
+TEST(mutex1)
+TEST(pipe1)
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
+TEST(task10)
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


