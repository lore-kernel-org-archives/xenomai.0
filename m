From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 9/9] testsuite: Integrate vwworks tests into testsuite/
Date: Wed, 13 Apr 2022 23:58:19 +0200
Message-Id: <20220413215819.22954-10-richard@nod.at>
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

Same as for alchemy and pSOS.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 configure.ac                                  |   1 +
 lib/vxworks/testsuite/Makefile                |  43 --------
 testsuite/Makefile.am                         |   6 +-
 testsuite/vxworkstests/Makefile.am            | 100 ++++++++++++++++++
 .../vxworkstests}/lst-1.c                     |   0
 .../vxworkstests}/msgQ-1.c                    |   0
 .../vxworkstests}/msgQ-2.c                    |   0
 .../vxworkstests}/msgQ-3.c                    |   0
 .../vxworkstests}/rng-1.c                     |   0
 .../vxworkstests}/sem-1.c                     |   0
 .../vxworkstests}/sem-2.c                     |   0
 .../vxworkstests}/sem-3.c                     |   0
 .../vxworkstests}/sem-4.c                     |   0
 .../vxworkstests}/task-1.c                    |   0
 .../vxworkstests}/task-2.c                    |   0
 testsuite/vxworkstests/vxworkstest_driver.c   |  74 +++++++++++++
 .../vxworkstests}/wd-1.c                      |   0
 17 files changed, 179 insertions(+), 45 deletions(-)
 delete mode 100644 lib/vxworks/testsuite/Makefile
 create mode 100644 testsuite/vxworkstests/Makefile.am
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/lst-1.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/msgQ-1.c (100=
%)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/msgQ-2.c (100=
%)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/msgQ-3.c (100=
%)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/rng-1.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/sem-1.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/sem-2.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/sem-3.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/sem-4.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/task-1.c (100=
%)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/task-2.c (100=
%)
 create mode 100644 testsuite/vxworkstests/vxworkstest_driver.c
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/wd-1.c (100%)

diff --git a/configure.ac b/configure.ac
index 0cd2b2408..801252d7c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1048,6 +1048,7 @@ AC_CONFIG_FILES([ \
 	testsuite/xeno-test/Makefile \
 	testsuite/alchemytests/Makefile \
 	testsuite/psostests/Makefile \
+	testsuite/vxworkstests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/lib/vxworks/testsuite/Makefile b/lib/vxworks/testsuite/Makef=
ile
deleted file mode 100644
index 648c9be90..000000000
--- a/lib/vxworks/testsuite/Makefile
+++ /dev/null
@@ -1,43 +0,0 @@
-ifeq ($(DESTDIR),)
-XENO_CONFIG=3Dxeno-config
-else
-XENO_CONFIG=3D$(DESTDIR)/bin/xeno-config
-endif
-
-prefix :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --prefix)
-solibs :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --libdir)
-
-ifeq ($(prefix),)
-$(error Please add <xenomai-install-path>/bin to your PATH variable or s=
pecify DESTDIR)
-endif
-
-TESTS :=3D task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem=
-4 lst-1 rng-1
-
-CFLAGS :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --skin=3Dvxworks=
 --cflags) -g
-LDFLAGS :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --skin=3Dvxwork=
s --ldflags)
-CC =3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --cc)
-
-all: $(TESTS)
-
-%: %.c
-	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
-
-install: all
-	install -d $(prefix)/testsuite/vxworks
-	install -t $(prefix)/testsuite/vxworks $(TESTS)
-
-clean:
-	$(RM) $(TESTS) *~
-
-# Run the test suite. We pin all tests to CPU #0, so that SMP does not
-# alter the execution sequence we expect from them.
-test: all
-	@for t in $(TESTS); do \
-		echo -n $$t...; \
-		sudo LD_LIBRARY_PATH=3D$(solibs) $(VALGRIND) ./$$t --cpu-affinity=3D0 =
--silent && echo ok || echo BAD; \
-	done
-
-test/%: %
-	sudo LD_LIBRARY_PATH=3D$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=3D0=
 --silent && echo ok || echo BAD
-
-.PHONY: clean test
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index cea688199..843983ddd 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -9,7 +9,8 @@ SUBDIRS +=3D 		\
 	switchtest	\
 	xeno-test	\
 	alchemytests	\
-	psostests
+	psostests	\
+	vxworkstests
 endif
=20
 DIST_SUBDIRS =3D		\
@@ -22,4 +23,5 @@ DIST_SUBDIRS =3D		\
 	switchtest	\
 	xeno-test	\
 	alchemytests	\
-	psostests
+	psostests	\
+	vxworkstests
diff --git a/testsuite/vxworkstests/Makefile.am b/testsuite/vxworkstests/=
Makefile.am
new file mode 100644
index 000000000..39cdd043b
--- /dev/null
+++ b/testsuite/vxworkstests/Makefile.am
@@ -0,0 +1,100 @@
+testdir =3D @XENO_TEST_DIR@
+
+CCLD =3D $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS =3D vxworkstest_driver \
+		lst1	\
+		msgQ1	\
+		msgQ2	\
+		msgQ3	\
+		rng1	\
+		sem1	\
+		sem2	\
+		sem3	\
+		sem4	\
+		wd1	\
+		task1	\
+		task2
+
+vxworkscppflags =3D 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+vxworksldadd =3D 					\
+	../../lib/vxworks/libvxworks@CORE@.la		\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+lst1_SOURCES =3D lst-1.c
+lst_CPPFLAGS =3D $(vxworkscppflags)
+lst1_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+lst1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task1_SOURCES =3D task-1.c
+task1_CPPFLAGS =3D $(vxworkscppflags)
+task1_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+task1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task2_SOURCES =3D task-2.c
+task2_CPPFLAGS =3D $(vxworkscppflags)
+task2_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+task2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+msgQ1_SOURCES =3D msgQ-1.c
+msgQ1_CPPFLAGS =3D $(vxworkscppflags)
+msgQ1_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+msgQ1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+msgQ2_SOURCES =3D msgQ-2.c
+msgQ2_CPPFLAGS =3D $(vxworkscppflags)
+msgQ2_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+msgQ2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+msgQ3_SOURCES =3D msgQ-3.c
+msgQ3_CPPFLAGS =3D $(vxworkscppflags)
+msgQ3_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+msgQ3_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+rng1_SOURCES =3D rng-1.c
+rng1_CPPFLAGS =3D $(vxworkscppflags)
+rng1_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+rng1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+sem1_SOURCES =3D sem-1.c
+sem1_CPPFLAGS =3D $(vxworkscppflags)
+sem1_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+sem1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+sem2_SOURCES =3D sem-2.c
+sem2_CPPFLAGS =3D $(vxworkscppflags)
+sem2_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+sem2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+sem3_SOURCES =3D sem-3.c
+sem3_CPPFLAGS =3D $(vxworkscppflags)
+sem3_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+sem3_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+sem4_SOURCES =3D sem-4.c
+sem4_CPPFLAGS =3D $(vxworkscppflags)
+sem4_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+sem4_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+wd1_SOURCES =3D wd-1.c
+wd1_CPPFLAGS =3D $(vxworkscppflags)
+wd1_LDADD =3D $(vxworksldadd) -lpthread -lrt -lm
+wd1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+vxworkstest_driver_SOURCES =3D vxworkstest_driver.c
+vxworkstest_driver_CPPFLAGS =3D			\
+	$(XENO_USER_CFLAGS)			\
+	-I$(top_srcdir)/include
+vxworkstest_driver_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+vxworkstest_driver_LDADD =3D			\
+	../../lib/vxworks/libvxworks@CORE@.la		\
+	../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@		\
+	@XENO_USER_LDADD@		\
+	-lpthread -lrt
diff --git a/lib/vxworks/testsuite/lst-1.c b/testsuite/vxworkstests/lst-1=
.c
similarity index 100%
rename from lib/vxworks/testsuite/lst-1.c
rename to testsuite/vxworkstests/lst-1.c
diff --git a/lib/vxworks/testsuite/msgQ-1.c b/testsuite/vxworkstests/msgQ=
-1.c
similarity index 100%
rename from lib/vxworks/testsuite/msgQ-1.c
rename to testsuite/vxworkstests/msgQ-1.c
diff --git a/lib/vxworks/testsuite/msgQ-2.c b/testsuite/vxworkstests/msgQ=
-2.c
similarity index 100%
rename from lib/vxworks/testsuite/msgQ-2.c
rename to testsuite/vxworkstests/msgQ-2.c
diff --git a/lib/vxworks/testsuite/msgQ-3.c b/testsuite/vxworkstests/msgQ=
-3.c
similarity index 100%
rename from lib/vxworks/testsuite/msgQ-3.c
rename to testsuite/vxworkstests/msgQ-3.c
diff --git a/lib/vxworks/testsuite/rng-1.c b/testsuite/vxworkstests/rng-1=
.c
similarity index 100%
rename from lib/vxworks/testsuite/rng-1.c
rename to testsuite/vxworkstests/rng-1.c
diff --git a/lib/vxworks/testsuite/sem-1.c b/testsuite/vxworkstests/sem-1=
.c
similarity index 100%
rename from lib/vxworks/testsuite/sem-1.c
rename to testsuite/vxworkstests/sem-1.c
diff --git a/lib/vxworks/testsuite/sem-2.c b/testsuite/vxworkstests/sem-2=
.c
similarity index 100%
rename from lib/vxworks/testsuite/sem-2.c
rename to testsuite/vxworkstests/sem-2.c
diff --git a/lib/vxworks/testsuite/sem-3.c b/testsuite/vxworkstests/sem-3=
.c
similarity index 100%
rename from lib/vxworks/testsuite/sem-3.c
rename to testsuite/vxworkstests/sem-3.c
diff --git a/lib/vxworks/testsuite/sem-4.c b/testsuite/vxworkstests/sem-4=
.c
similarity index 100%
rename from lib/vxworks/testsuite/sem-4.c
rename to testsuite/vxworkstests/sem-4.c
diff --git a/lib/vxworks/testsuite/task-1.c b/testsuite/vxworkstests/task=
-1.c
similarity index 100%
rename from lib/vxworks/testsuite/task-1.c
rename to testsuite/vxworkstests/task-1.c
diff --git a/lib/vxworks/testsuite/task-2.c b/testsuite/vxworkstests/task=
-2.c
similarity index 100%
rename from lib/vxworks/testsuite/task-2.c
rename to testsuite/vxworkstests/task-2.c
diff --git a/testsuite/vxworkstests/vxworkstest_driver.c b/testsuite/vxwo=
rkstests/vxworkstest_driver.c
new file mode 100644
index 000000000..a356f7e07
--- /dev/null
+++ b/testsuite/vxworkstests/vxworkstest_driver.c
@@ -0,0 +1,74 @@
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
+TEST(lst1)
+TEST(msgQ1)
+TEST(msgQ2)
+TEST(msgQ3)
+TEST(rng1)
+TEST(sem1)
+TEST(sem2)
+TEST(sem3)
+TEST(sem4)
+TEST(wd1)
+TEST(task1)
+TEST(task2)
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
diff --git a/lib/vxworks/testsuite/wd-1.c b/testsuite/vxworkstests/wd-1.c
similarity index 100%
rename from lib/vxworks/testsuite/wd-1.c
rename to testsuite/vxworkstests/wd-1.c
--=20
2.34.1


