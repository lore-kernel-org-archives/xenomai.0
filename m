From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 7/9] testsuite: Move pSOS tests into testsuite/
Date: Wed, 13 Apr 2022 23:58:17 +0200
Message-Id: <20220413215819.22954-8-richard@nod.at>
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

Just like for alchemy tests, integrate them into our test suite.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 configure.ac                                  |   1 +
 lib/psos/testsuite/Makefile                   |  49 ------
 testsuite/Makefile.am                         |   6 +-
 testsuite/psostests/Makefile.am               | 153 ++++++++++++++++++
 .../testsuite =3D> testsuite/psostests}/mq-1.c  |   0
 .../testsuite =3D> testsuite/psostests}/mq-2.c  |   0
 .../testsuite =3D> testsuite/psostests}/mq-3.c  |   0
 .../testsuite =3D> testsuite/psostests}/pt-1.c  |   0
 .../testsuite =3D> testsuite/psostests}/rn-1.c  |   0
 .../testsuite =3D> testsuite/psostests}/sem-1.c |   0
 .../testsuite =3D> testsuite/psostests}/sem-2.c |   0
 .../psostests}/task-1.c                       |   0
 .../psostests}/task-2.c                       |   0
 .../psostests}/task-3.c                       |   0
 .../psostests}/task-4.c                       |   0
 .../psostests}/task-5.c                       |   0
 .../psostests}/task-6.c                       |   0
 .../psostests}/task-7.c                       |   0
 .../psostests}/task-8.c                       |   0
 .../psostests}/task-9.c                       |   0
 .../testsuite =3D> testsuite/psostests}/tm-1.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-2.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-3.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-4.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-5.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-6.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-7.c  |   0
 27 files changed, 158 insertions(+), 51 deletions(-)
 delete mode 100644 lib/psos/testsuite/Makefile
 create mode 100644 testsuite/psostests/Makefile.am
 rename {lib/psos/testsuite =3D> testsuite/psostests}/mq-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/mq-2.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/mq-3.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/pt-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/rn-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/sem-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/sem-2.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-2.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-3.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-4.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-5.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-6.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-7.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-8.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-9.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-2.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-3.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-4.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-5.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-6.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-7.c (100%)

diff --git a/configure.ac b/configure.ac
index 8fd86e5a1..0cd2b2408 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1047,6 +1047,7 @@ AC_CONFIG_FILES([ \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
 	testsuite/alchemytests/Makefile \
+	testsuite/psostests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/lib/psos/testsuite/Makefile b/lib/psos/testsuite/Makefile
deleted file mode 100644
index 3330a617c..000000000
--- a/lib/psos/testsuite/Makefile
+++ /dev/null
@@ -1,49 +0,0 @@
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
-TESTS :=3D \
-	task-1 task-2 task-3 task-4 task-5 task-6 task-7 task-8 task-9 \
-	tm-1 tm-2 tm-3 tm-4 tm-5 tm-6 tm-7 \
-	mq-1 mq-2 mq-3 \
-	sem-1 sem-2 \
-	pt-1 \
-	rn-1
-
-CFLAGS :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --skin=3Dpsos --=
cflags) -g
-LDFLAGS :=3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --skin=3Dpsos -=
-ldflags)
-CC =3D $(shell DESTDIR=3D$(DESTDIR) $(XENO_CONFIG) --cc)
-
-all: $(TESTS)
-
-%: %.c
-	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
-
-install: all
-	install -d $(prefix)/testsuite/psos
-	install -t $(prefix)/testsuite/psos $(TESTS)
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
index e027485fb..cea688199 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -8,7 +8,8 @@ SUBDIRS +=3D 		\
 	spitest		\
 	switchtest	\
 	xeno-test	\
-	alchemytests
+	alchemytests	\
+	psostests
 endif
=20
 DIST_SUBDIRS =3D		\
@@ -20,4 +21,5 @@ DIST_SUBDIRS =3D		\
 	spitest		\
 	switchtest	\
 	xeno-test	\
-	alchemytests
+	alchemytests	\
+	psostests
diff --git a/testsuite/psostests/Makefile.am b/testsuite/psostests/Makefi=
le.am
new file mode 100644
index 000000000..9e8aef62b
--- /dev/null
+++ b/testsuite/psostests/Makefile.am
@@ -0,0 +1,153 @@
+testdir =3D @XENO_TEST_DIR@
+
+CCLD =3D $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS =3D mq1	\
+		mq2	\
+		mq3	\
+		pt1	\
+		rn1	\
+		sem1	\
+		sem2	\
+		tm1	\
+		tm2	\
+		tm3	\
+		tm4	\
+		tm5	\
+		tm6	\
+		tm7	\
+		task1	\
+		task2	\
+		task3	\
+		task4	\
+		task5	\
+		task6	\
+		task7	\
+		task8	\
+		task9
+
+psoscppflags =3D 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+psosldadd =3D 					\
+	../../lib/psos/libpsos@CORE@.la		\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+mq1_SOURCES =3D mq-1.c
+mq1_CPPFLAGS =3D $(psoscppflags)
+mq1_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+mq1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+mq2_SOURCES =3D mq-2.c
+mq2_CPPFLAGS =3D $(psoscppflags)
+mq2_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+mq2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+mq3_SOURCES =3D mq-3.c
+mq3_CPPFLAGS =3D $(psoscppflags)
+mq3_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+mq3_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+pt1_SOURCES =3D pt-1.c
+pt1_CPPFLAGS =3D $(psoscppflags)
+pt1_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+pt1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+rn1_SOURCES =3D rn-1.c
+rn1_CPPFLAGS =3D $(psoscppflags)
+rn1_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+rn1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+sem1_SOURCES =3D sem-1.c
+sem1_CPPFLAGS =3D $(psoscppflags)
+sem1_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+sem1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+sem2_SOURCES =3D sem-2.c
+sem2_CPPFLAGS =3D $(psoscppflags)
+sem2_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+sem2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+tm1_SOURCES =3D tm-1.c
+tm1_CPPFLAGS =3D $(psoscppflags)
+tm1_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+tm1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+tm2_SOURCES =3D tm-2.c
+tm2_CPPFLAGS =3D $(psoscppflags)
+tm2_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+tm2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+tm3_SOURCES =3D tm-3.c
+tm3_CPPFLAGS =3D $(psoscppflags)
+tm3_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+tm3_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+tm4_SOURCES =3D tm-4.c
+tm4_CPPFLAGS =3D $(psoscppflags)
+tm4_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+tm4_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+tm5_SOURCES =3D tm-5.c
+tm5_CPPFLAGS =3D $(psoscppflags)
+tm5_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+tm5_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+tm6_SOURCES =3D tm-6.c
+tm6_CPPFLAGS =3D $(psoscppflags)
+tm6_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+tm6_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+tm7_SOURCES =3D tm-7.c
+tm7_CPPFLAGS =3D $(psoscppflags)
+tm7_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+tm7_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task1_SOURCES =3D task-1.c
+task1_CPPFLAGS =3D $(psoscppflags)
+task1_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task2_SOURCES =3D task-2.c
+task2_CPPFLAGS =3D $(psoscppflags)
+task2_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task3_SOURCES =3D task-3.c
+task3_CPPFLAGS =3D $(psoscppflags)
+task3_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task3_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task4_SOURCES =3D task-4.c
+task4_CPPFLAGS =3D $(psoscppflags)
+task4_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task4_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task5_SOURCES =3D task-5.c
+task5_CPPFLAGS =3D $(psoscppflags)
+task5_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task5_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task6_SOURCES =3D task-6.c
+task6_CPPFLAGS =3D $(psoscppflags)
+task6_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task6_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task7_SOURCES =3D task-7.c
+task7_CPPFLAGS =3D $(psoscppflags)
+task7_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task7_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task8_SOURCES =3D task-8.c
+task8_CPPFLAGS =3D $(psoscppflags)
+task8_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task8_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task9_SOURCES =3D task-9.c
+task9_CPPFLAGS =3D $(psoscppflags)
+task9_LDADD =3D $(psosldadd) -lpthread -lrt -lm
+task9_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
diff --git a/lib/psos/testsuite/mq-1.c b/testsuite/psostests/mq-1.c
similarity index 100%
rename from lib/psos/testsuite/mq-1.c
rename to testsuite/psostests/mq-1.c
diff --git a/lib/psos/testsuite/mq-2.c b/testsuite/psostests/mq-2.c
similarity index 100%
rename from lib/psos/testsuite/mq-2.c
rename to testsuite/psostests/mq-2.c
diff --git a/lib/psos/testsuite/mq-3.c b/testsuite/psostests/mq-3.c
similarity index 100%
rename from lib/psos/testsuite/mq-3.c
rename to testsuite/psostests/mq-3.c
diff --git a/lib/psos/testsuite/pt-1.c b/testsuite/psostests/pt-1.c
similarity index 100%
rename from lib/psos/testsuite/pt-1.c
rename to testsuite/psostests/pt-1.c
diff --git a/lib/psos/testsuite/rn-1.c b/testsuite/psostests/rn-1.c
similarity index 100%
rename from lib/psos/testsuite/rn-1.c
rename to testsuite/psostests/rn-1.c
diff --git a/lib/psos/testsuite/sem-1.c b/testsuite/psostests/sem-1.c
similarity index 100%
rename from lib/psos/testsuite/sem-1.c
rename to testsuite/psostests/sem-1.c
diff --git a/lib/psos/testsuite/sem-2.c b/testsuite/psostests/sem-2.c
similarity index 100%
rename from lib/psos/testsuite/sem-2.c
rename to testsuite/psostests/sem-2.c
diff --git a/lib/psos/testsuite/task-1.c b/testsuite/psostests/task-1.c
similarity index 100%
rename from lib/psos/testsuite/task-1.c
rename to testsuite/psostests/task-1.c
diff --git a/lib/psos/testsuite/task-2.c b/testsuite/psostests/task-2.c
similarity index 100%
rename from lib/psos/testsuite/task-2.c
rename to testsuite/psostests/task-2.c
diff --git a/lib/psos/testsuite/task-3.c b/testsuite/psostests/task-3.c
similarity index 100%
rename from lib/psos/testsuite/task-3.c
rename to testsuite/psostests/task-3.c
diff --git a/lib/psos/testsuite/task-4.c b/testsuite/psostests/task-4.c
similarity index 100%
rename from lib/psos/testsuite/task-4.c
rename to testsuite/psostests/task-4.c
diff --git a/lib/psos/testsuite/task-5.c b/testsuite/psostests/task-5.c
similarity index 100%
rename from lib/psos/testsuite/task-5.c
rename to testsuite/psostests/task-5.c
diff --git a/lib/psos/testsuite/task-6.c b/testsuite/psostests/task-6.c
similarity index 100%
rename from lib/psos/testsuite/task-6.c
rename to testsuite/psostests/task-6.c
diff --git a/lib/psos/testsuite/task-7.c b/testsuite/psostests/task-7.c
similarity index 100%
rename from lib/psos/testsuite/task-7.c
rename to testsuite/psostests/task-7.c
diff --git a/lib/psos/testsuite/task-8.c b/testsuite/psostests/task-8.c
similarity index 100%
rename from lib/psos/testsuite/task-8.c
rename to testsuite/psostests/task-8.c
diff --git a/lib/psos/testsuite/task-9.c b/testsuite/psostests/task-9.c
similarity index 100%
rename from lib/psos/testsuite/task-9.c
rename to testsuite/psostests/task-9.c
diff --git a/lib/psos/testsuite/tm-1.c b/testsuite/psostests/tm-1.c
similarity index 100%
rename from lib/psos/testsuite/tm-1.c
rename to testsuite/psostests/tm-1.c
diff --git a/lib/psos/testsuite/tm-2.c b/testsuite/psostests/tm-2.c
similarity index 100%
rename from lib/psos/testsuite/tm-2.c
rename to testsuite/psostests/tm-2.c
diff --git a/lib/psos/testsuite/tm-3.c b/testsuite/psostests/tm-3.c
similarity index 100%
rename from lib/psos/testsuite/tm-3.c
rename to testsuite/psostests/tm-3.c
diff --git a/lib/psos/testsuite/tm-4.c b/testsuite/psostests/tm-4.c
similarity index 100%
rename from lib/psos/testsuite/tm-4.c
rename to testsuite/psostests/tm-4.c
diff --git a/lib/psos/testsuite/tm-5.c b/testsuite/psostests/tm-5.c
similarity index 100%
rename from lib/psos/testsuite/tm-5.c
rename to testsuite/psostests/tm-5.c
diff --git a/lib/psos/testsuite/tm-6.c b/testsuite/psostests/tm-6.c
similarity index 100%
rename from lib/psos/testsuite/tm-6.c
rename to testsuite/psostests/tm-6.c
diff --git a/lib/psos/testsuite/tm-7.c b/testsuite/psostests/tm-7.c
similarity index 100%
rename from lib/psos/testsuite/tm-7.c
rename to testsuite/psostests/tm-7.c
--=20
2.34.1


