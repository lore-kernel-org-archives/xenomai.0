From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/9] testsuite: Hook up alchemytests
Date: Wed, 13 Apr 2022 23:58:12 +0200
Message-Id: <20220413215819.22954-3-richard@nod.at>
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

Build them using Xenomai's build system.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 configure.ac                       |   1 +
 testsuite/Makefile.am              |   6 +-
 testsuite/alchemytests/Makefile.am | 148 +++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/alchemytests/Makefile.am

diff --git a/configure.ac b/configure.ac
index 019453793..8fd86e5a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1046,6 +1046,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/can/Makefile
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
+	testsuite/alchemytests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 4932f6d33..e027485fb 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -7,7 +7,8 @@ SUBDIRS +=3D 		\
 	gpiotest	\
 	spitest		\
 	switchtest	\
-	xeno-test
+	xeno-test	\
+	alchemytests
 endif
=20
 DIST_SUBDIRS =3D		\
@@ -18,4 +19,5 @@ DIST_SUBDIRS =3D		\
 	smokey		\
 	spitest		\
 	switchtest	\
-	xeno-test
+	xeno-test	\
+	alchemytests
diff --git a/testsuite/alchemytests/Makefile.am b/testsuite/alchemytests/=
Makefile.am
new file mode 100644
index 000000000..35df0d49c
--- /dev/null
+++ b/testsuite/alchemytests/Makefile.am
@@ -0,0 +1,148 @@
+testdir =3D @XENO_TEST_DIR@
+
+CCLD =3D $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS =3D alchemytest_driver \
+		alarm1		   \
+		buffer1		   \
+		event1		   \
+		heap1		   \
+		heap2		   \
+		mq1		   \
+		mq2		   \
+		mq3		   \
+		mutex1		   \
+		pipe1		   \
+		sem1		   \
+		sem2		   \
+		task1		   \
+		task2		   \
+		task3		   \
+		task4		   \
+		task5		   \
+		task6		   \
+		task7		   \
+		task8		   \
+		task9		   \
+		task10
+
+alchemycppflags =3D 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+alchemyldadd =3D 					\
+	../../lib/alchemy/libalchemy@CORE@.la		\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+alarm1_SOURCES =3D alarm-1.c
+alarm1_CPPFLAGS =3D $(alchemycppflags)
+alarm1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+alarm1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+event1_SOURCES =3D event-1.c
+event1_CPPFLAGS =3D $(alchemycppflags)
+event1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+event1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+heap1_SOURCES =3D heap-1.c
+heap1_CPPFLAGS =3D $(alchemycppflags)
+heap1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+heap1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+heap2_SOURCES =3D heap-2.c
+heap2_CPPFLAGS =3D $(alchemycppflags)
+heap2_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+heap2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+buffer1_SOURCES =3D buffer-1.c
+buffer1_CPPFLAGS =3D $(alchemycppflags)
+buffer1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+buffer1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+mutex1_SOURCES =3D mutex-1.c
+mutex1_CPPFLAGS =3D $(alchemycppflags)
+mutex1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+mutex1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+pipe1_SOURCES =3D pipe-1.c
+pipe1_CPPFLAGS =3D $(alchemycppflags)
+pipe1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+pipe1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+mq1_SOURCES =3D mq-1.c
+mq1_CPPFLAGS =3D $(alchemycppflags)
+mq1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+mq1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+mq2_SOURCES =3D mq-2.c
+mq2_CPPFLAGS =3D $(alchemycppflags)
+mq2_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+mq2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+mq3_SOURCES =3D mq-3.c
+mq3_CPPFLAGS =3D $(alchemycppflags)
+mq3_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+mq3_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+sem1_SOURCES =3D sem-1.c
+sem1_CPPFLAGS =3D $(alchemycppflags)
+sem1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+sem1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+sem2_SOURCES =3D sem-2.c
+sem2_CPPFLAGS =3D $(alchemycppflags)
+sem2_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+sem2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task1_SOURCES =3D task-1.c
+task1_CPPFLAGS =3D $(alchemycppflags)
+task1_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task2_SOURCES =3D task-2.c
+task2_CPPFLAGS =3D $(alchemycppflags)
+task2_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task3_SOURCES =3D task-3.c
+task3_CPPFLAGS =3D $(alchemycppflags)
+task3_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task3_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task4_SOURCES =3D task-4.c
+task4_CPPFLAGS =3D $(alchemycppflags)
+task4_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task4_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task5_SOURCES =3D task-5.c
+task5_CPPFLAGS =3D $(alchemycppflags)
+task5_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task5_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task6_SOURCES =3D task-6.c
+task6_CPPFLAGS =3D $(alchemycppflags)
+task6_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task6_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task7_SOURCES =3D task-7.c
+task7_CPPFLAGS =3D $(alchemycppflags)
+task7_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task7_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task8_SOURCES =3D task-8.c
+task8_CPPFLAGS =3D $(alchemycppflags)
+task8_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task8_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task9_SOURCES =3D task-9.c
+task9_CPPFLAGS =3D $(alchemycppflags)
+task9_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task9_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+
+task10_SOURCES =3D task-10.c
+task10_CPPFLAGS =3D $(alchemycppflags)
+task10_LDADD =3D $(alchemyldadd) -lpthread -lrt -lm
+task10_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
--=20
2.34.1


