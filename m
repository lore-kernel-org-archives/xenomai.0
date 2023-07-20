Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4818AE4
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:04 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-991da766865so154200566b.0
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864723; x=1690469523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJevMzx+RKpccV4ErbC8LN9/pVzRRWQ5zsxK/cUjx8g=;
        b=aqrqU+1mKl8k70QjaU0SsnRSndu/9iWXv4Q8aie0+RPzeTEjXppPlB/rGCV0+yPn5d
         znpZJz0EB6fIRYNRt6tl3rCzccmWqm1Kc2IDVXU/vHZVGTsPsalAGHqw9OgcN/MwVXwM
         2P4HKL4dDfIgFr993F+EG9hf6X3AyCI3P6GNGyLXRDNZpy/+VPdh/l8B45uf4W1Nsjom
         ycl7qd+PtYlbzLYXxBtWsJF/1wMN4m8fFq1O0eAde25j1P6OcC1bZGWw37MMrHPS5fga
         3XO1H+MpwI+f3gIpU7ikbHClgcgCdXPP8VuN7sMGCiSFrcnGs3SvxQO4SQD958rjnQpa
         Qa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864723; x=1690469523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJevMzx+RKpccV4ErbC8LN9/pVzRRWQ5zsxK/cUjx8g=;
        b=A547IaqC6IZfgJmo4KN2ilYD/VNbQdVvqNGqd4MBJbkxBveoHPr6oJiqq2iu6J8HHe
         UviOKfOpH0b+b5OnSJLFNKQUZJ2dY5CJYevWq2tg0h8yV0mVHsEVO9hLPR7kcAmftrED
         aXgXCwN3xAaQR0yElM8qeTl4nBdD1brUZT82AEPQjT5CcAhgLmlhcDkcHy0o1xgozmiy
         gYKt542o9S0VpHKz19VM9g1CLhaB7Bg9N5vmKeqccNXasbbGRJfj4vxFIXDBm0v2++//
         SZwTdvVFIElXF9wtWnSPpXwkzjI3zVt1xN3850KgKWE8AozY5bPyAU7VUe1vcBiWiNih
         KUnw==
X-Gm-Message-State: ABy/qLYiJzfYAkEWPVlC3l0ly63LcXp91SB0TNLXwQT3s+OcZa+WNGPa
	akr16Tf15yckT6e7WH72C+VdxXpBcO7vn5Lb0AI=
X-Google-Smtp-Source: APBJJlFrXJJBgNsl3YCC9Zs1Y7kf2EJLRezl5vdNLSB3Y7ensvvlsAobicmE72n+T0RxgZvHU+2eFg==
X-Received: by 2002:a17:906:328a:b0:982:c8d0:683f with SMTP id 10-20020a170906328a00b00982c8d0683fmr5632251ejw.18.1689864722694;
        Thu, 20 Jul 2023 07:52:02 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:02 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Date: Thu, 20 Jul 2023 16:51:41 +0200
Message-Id: <20230720145150.24607-2-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230720145150.24607-1-aaron@sigma-star.at>
References: <20230406103341.2914-1-aaron@sigma-star.at>
 <20230720145150.24607-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the very first step to have the alchemy tests embedded
into our testsuite.

Build them using Xenomai's build system and hook them up using
Smokey. Every test binary has it's own respective testcase in the
testsuite.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 configure.ac                                  |   7 +-
 testsuite/Makefile.am                         |   8 +-
 testsuite/smokey/Makefile.am                  |   9 +-
 testsuite/smokey/alchemytests/Makefile.am     | 148 ++++++++++++++++++
 .../smokey/alchemytests}/alarm-1.c            |   0
 testsuite/smokey/alchemytests/alchemytests.c  |  55 +++++++
 .../smokey/alchemytests/alchemytests_driver.c |  32 ++++
 .../smokey/alchemytests}/buffer-1.c           |   0
 .../smokey/alchemytests}/event-1.c            |   0
 .../smokey/alchemytests}/heap-1.c             |   0
 .../smokey/alchemytests}/heap-2.c             |   0
 .../smokey/alchemytests}/mq-1.c               |   0
 .../smokey/alchemytests}/mq-2.c               |   0
 .../smokey/alchemytests}/mq-3.c               |   0
 .../smokey/alchemytests}/mutex-1.c            |   0
 .../smokey/alchemytests}/pipe-1.c             |   0
 .../smokey/alchemytests}/sem-1.c              |   0
 .../smokey/alchemytests}/sem-2.c              |   0
 .../smokey/alchemytests}/task-1.c             |   0
 .../smokey/alchemytests}/task-10.c            |   0
 .../smokey/alchemytests}/task-2.c             |   0
 .../smokey/alchemytests}/task-3.c             |   0
 .../smokey/alchemytests}/task-4.c             |   0
 .../smokey/alchemytests}/task-5.c             |   0
 .../smokey/alchemytests}/task-6.c             |   0
 .../smokey/alchemytests}/task-7.c             |   0
 .../smokey/alchemytests}/task-8.c             |   0
 .../smokey/alchemytests}/task-9.c             |   0
 28 files changed, 252 insertions(+), 7 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/Makefile.am
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (100%)
 create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
 create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (100%)

diff --git a/configure.ac b/configure.ac
index 3ce34048e..fe59333ed 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1041,10 +1041,13 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/cpu-affinity/Makefile \
 	testsuite/smokey/gdb/Makefile \
 	testsuite/smokey/y2038/Makefile \
-	testsuite/smokey/can/Makefile
-	testsuite/smokey/x86io/Makefile
+	testsuite/smokey/can/Makefile \
+	testsuite/smokey/x86io/Makefile \
+	testsuite/smokey/alchemytests/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
+	testsuite/psostests/Makefile \
+	testsuite/vxworkstests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 4932f6d33..1be7eaba4 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -7,7 +7,9 @@ SUBDIRS += 		\
 	gpiotest	\
 	spitest		\
 	switchtest	\
-	xeno-test
+	xeno-test	\
+	psostests	\
+	vxworkstests
 endif
 
 DIST_SUBDIRS =		\
@@ -18,4 +20,6 @@ DIST_SUBDIRS =		\
 	smokey		\
 	spitest		\
 	switchtest	\
-	xeno-test
+	xeno-test	\
+	psostests \
+	vxworkstests
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 79dc61e9f..633a87387 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -40,12 +40,14 @@ COBALT_SUBDIRS = 	\
 	tsc		\
 	vdso-access 	\
 	xddp		\
-	y2038
+	y2038 \
+	alchemytests
 
 MERCURY_SUBDIRS =	\
 	memory-heapmem	\
 	memory-tlsf	\
-	memcheck
+	memcheck \
+	alchemytests
 
 DIST_SUBDIRS = 		\
 	arith 		\
@@ -80,7 +82,8 @@ DIST_SUBDIRS = 		\
 	tsc		\
 	vdso-access 	\
 	xddp		\
-	y2038
+	y2038 \
+	alchemytests
 
 if XENO_X86
 DIST_SUBDIRS += x86io
diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
new file mode 100644
index 000000000..9da3a98f3
--- /dev/null
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -0,0 +1,148 @@
+testdir = @XENO_TEST_DIR@
+noinst_LIBRARIES = libalchemytests.a
+
+libalchemytests_a_SOURCES = alchemytests.c
+libalchemytests_a_CPPFLAGS = 		\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include \
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = \
+		alchemytests \
+		alchemytests_alarm1		   \
+		alchemytests_buffer1		   \
+		alchemytests_event1		   \
+		alchemytests_heap1		   \
+		alchemytests_heap2		   \
+		alchemytests_mq1		   \
+		alchemytests_mq2		   \
+		alchemytests_mq3		   \
+		alchemytests_mutex1		   \
+		alchemytests_pipe1		   \
+		alchemytests_sem1		   \
+		alchemytests_sem2		   \
+		alchemytests_task1		   \
+		alchemytests_task2		   \
+		alchemytests_task3		   \
+		alchemytests_task4		   \
+		alchemytests_task5		   \
+		alchemytests_task6		   \
+		alchemytests_task7		   \
+		alchemytests_task8		   \
+		alchemytests_task9		   \
+		alchemytests_task10
+
+alchemycppflags = 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+alchemyldadd = 					\
+	../../../lib/alchemy/libalchemy@CORE@.la		\
+	../../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+alchemytests_SOURCES = alchemytests_driver.c
+alchemytests_CPPFLAGS =			\
+	$(XENO_USER_CFLAGS)			\
+	-I$(top_srcdir)/include
+alchemytests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_LDADD =			\
+	../../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@		\
+	@XENO_USER_LDADD@		\
+	-lpthread -lrt
+
+alchemytests_alarm1_SOURCES = alarm-1.c
+alchemytests_alarm1_CPPFLAGS = $(alchemycppflags)
+alchemytests_alarm1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_alarm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_event1_SOURCES = event-1.c
+alchemytests_event1_CPPFLAGS = $(alchemycppflags)
+alchemytests_event1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_event1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_heap1_SOURCES = heap-1.c
+alchemytests_heap1_CPPFLAGS = $(alchemycppflags)
+alchemytests_heap1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_heap1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_heap2_SOURCES = heap-2.c
+alchemytests_heap2_CPPFLAGS = $(alchemycppflags)
+alchemytests_heap2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_heap2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_buffer1_SOURCES = buffer-1.c
+alchemytests_buffer1_CPPFLAGS = $(alchemycppflags)
+alchemytests_buffer1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_buffer1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mutex1_SOURCES = mutex-1.c
+alchemytests_mutex1_CPPFLAGS = $(alchemycppflags)
+alchemytests_mutex1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_mutex1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_pipe1_SOURCES = pipe-1.c
+alchemytests_pipe1_CPPFLAGS = $(alchemycppflags)
+alchemytests_pipe1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_pipe1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mq1_SOURCES = mq-1.c
+alchemytests_mq1_CPPFLAGS = $(alchemycppflags)
+alchemytests_mq1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mq2_SOURCES = mq-2.c
+alchemytests_mq2_CPPFLAGS = $(alchemycppflags)
+alchemytests_mq2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mq3_SOURCES = mq-3.c
+alchemytests_mq3_CPPFLAGS = $(alchemycppflags)
+alchemytests_mq3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_sem1_SOURCES = sem-1.c
+alchemytests_sem1_CPPFLAGS = $(alchemycppflags)
+alchemytests_sem1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_sem2_SOURCES = sem-2.c
+alchemytests_sem2_CPPFLAGS = $(alchemycppflags)
+alchemytests_sem2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task1_SOURCES = task-1.c
+alchemytests_task1_CPPFLAGS = $(alchemycppflags)
+alchemytests_task1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task2_SOURCES = task-2.c
+alchemytests_task2_CPPFLAGS = $(alchemycppflags)
+alchemytests_task2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task3_SOURCES = task-3.c
+alchemytests_task3_CPPFLAGS = $(alchemycppflags)
+alchemytests_task3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task4_SOURCES = task-4.c
+alchemytests_task4_CPPFLAGS = $(alchemycppflags)
+alchemytests_task4_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task5_SOURCES = task-5.c
+alchemytests_task5_CPPFLAGS = $(alchemycppflags)
+alchemytests_task5_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task6_SOURCES = task-6.c
+alchemytests_task6_CPPFLAGS = $(alchemycppflags)
+alchemytests_task6_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task7_SOURCES = task-7.c
+alchemytests_task7_CPPFLAGS = $(alchemycppflags)
+alchemytests_task7_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task8_SOURCES = task-8.c
+alchemytests_task8_CPPFLAGS = $(alchemycppflags)
+alchemytests_task8_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task9_SOURCES = task-9.c
+alchemytests_task9_CPPFLAGS = $(alchemycppflags)
+alchemytests_task9_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task10_SOURCES = task-10.c
+alchemytests_task10_CPPFLAGS = $(alchemycppflags)
+alchemytests_task10_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alchemytests_task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
diff --git a/lib/alchemy/testsuite/alarm-1.c b/testsuite/smokey/alchemytests/alarm-1.c
similarity index 100%
rename from lib/alchemy/testsuite/alarm-1.c
rename to testsuite/smokey/alchemytests/alarm-1.c
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
new file mode 100644
index 000000000..8dea068bc
--- /dev/null
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -0,0 +1,55 @@
+#include <error.h>
+#include <libgen.h>
+#include <smokey/smokey.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#define TEST(name)								   \
+	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
+	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
+	{									   \
+		return __run_extprog(t, argc, argv);				   \
+	}
+
+static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
+{
+	int ret;
+	char *tst_path;
+
+	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
+	if (ret == -1)
+		return -ENOMEM;
+
+	ret = system(tst_path);
+	free(tst_path);
+
+	return ret;
+}
+
+TEST(alchemytests)
+TEST(alchemytests_alarm1)
+TEST(alchemytests_buffer1)
+TEST(alchemytests_event1)
+TEST(alchemytests_heap1)
+TEST(alchemytests_heap2)
+TEST(alchemytests_mq1)
+TEST(alchemytests_mq2)
+TEST(alchemytests_mq3)
+TEST(alchemytests_mutex1)
+TEST(alchemytests_pipe1)
+TEST(alchemytests_sem1)
+TEST(alchemytests_sem2)
+TEST(alchemytests_task1)
+TEST(alchemytests_task2)
+TEST(alchemytests_task3)
+TEST(alchemytests_task4)
+TEST(alchemytests_task5)
+TEST(alchemytests_task6)
+TEST(alchemytests_task7)
+TEST(alchemytests_task8)
+TEST(alchemytests_task9)
+TEST(alchemytests_task10)
+
diff --git a/testsuite/smokey/alchemytests/alchemytests_driver.c b/testsuite/smokey/alchemytests/alchemytests_driver.c
new file mode 100644
index 000000000..cf9045bb5
--- /dev/null
+++ b/testsuite/smokey/alchemytests/alchemytests_driver.c
@@ -0,0 +1,32 @@
+#include <error.h>
+#include <libgen.h>
+#include <smokey/smokey.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(int argc, char *const argv[])
+{
+	struct smokey_test *t;
+	int ret, fails = 0;
+
+	if (pvlist_empty(&smokey_test_list))
+		return 0;
+
+	for_each_smokey_test(t) {
+		ret = t->run(t, argc, argv);
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
+	return fails != 0;
+}
diff --git a/lib/alchemy/testsuite/buffer-1.c b/testsuite/smokey/alchemytests/buffer-1.c
similarity index 100%
rename from lib/alchemy/testsuite/buffer-1.c
rename to testsuite/smokey/alchemytests/buffer-1.c
diff --git a/lib/alchemy/testsuite/event-1.c b/testsuite/smokey/alchemytests/event-1.c
similarity index 100%
rename from lib/alchemy/testsuite/event-1.c
rename to testsuite/smokey/alchemytests/event-1.c
diff --git a/lib/alchemy/testsuite/heap-1.c b/testsuite/smokey/alchemytests/heap-1.c
similarity index 100%
rename from lib/alchemy/testsuite/heap-1.c
rename to testsuite/smokey/alchemytests/heap-1.c
diff --git a/lib/alchemy/testsuite/heap-2.c b/testsuite/smokey/alchemytests/heap-2.c
similarity index 100%
rename from lib/alchemy/testsuite/heap-2.c
rename to testsuite/smokey/alchemytests/heap-2.c
diff --git a/lib/alchemy/testsuite/mq-1.c b/testsuite/smokey/alchemytests/mq-1.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-1.c
rename to testsuite/smokey/alchemytests/mq-1.c
diff --git a/lib/alchemy/testsuite/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-2.c
rename to testsuite/smokey/alchemytests/mq-2.c
diff --git a/lib/alchemy/testsuite/mq-3.c b/testsuite/smokey/alchemytests/mq-3.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-3.c
rename to testsuite/smokey/alchemytests/mq-3.c
diff --git a/lib/alchemy/testsuite/mutex-1.c b/testsuite/smokey/alchemytests/mutex-1.c
similarity index 100%
rename from lib/alchemy/testsuite/mutex-1.c
rename to testsuite/smokey/alchemytests/mutex-1.c
diff --git a/lib/alchemy/testsuite/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
similarity index 100%
rename from lib/alchemy/testsuite/pipe-1.c
rename to testsuite/smokey/alchemytests/pipe-1.c
diff --git a/lib/alchemy/testsuite/sem-1.c b/testsuite/smokey/alchemytests/sem-1.c
similarity index 100%
rename from lib/alchemy/testsuite/sem-1.c
rename to testsuite/smokey/alchemytests/sem-1.c
diff --git a/lib/alchemy/testsuite/sem-2.c b/testsuite/smokey/alchemytests/sem-2.c
similarity index 100%
rename from lib/alchemy/testsuite/sem-2.c
rename to testsuite/smokey/alchemytests/sem-2.c
diff --git a/lib/alchemy/testsuite/task-1.c b/testsuite/smokey/alchemytests/task-1.c
similarity index 100%
rename from lib/alchemy/testsuite/task-1.c
rename to testsuite/smokey/alchemytests/task-1.c
diff --git a/lib/alchemy/testsuite/task-10.c b/testsuite/smokey/alchemytests/task-10.c
similarity index 100%
rename from lib/alchemy/testsuite/task-10.c
rename to testsuite/smokey/alchemytests/task-10.c
diff --git a/lib/alchemy/testsuite/task-2.c b/testsuite/smokey/alchemytests/task-2.c
similarity index 100%
rename from lib/alchemy/testsuite/task-2.c
rename to testsuite/smokey/alchemytests/task-2.c
diff --git a/lib/alchemy/testsuite/task-3.c b/testsuite/smokey/alchemytests/task-3.c
similarity index 100%
rename from lib/alchemy/testsuite/task-3.c
rename to testsuite/smokey/alchemytests/task-3.c
diff --git a/lib/alchemy/testsuite/task-4.c b/testsuite/smokey/alchemytests/task-4.c
similarity index 100%
rename from lib/alchemy/testsuite/task-4.c
rename to testsuite/smokey/alchemytests/task-4.c
diff --git a/lib/alchemy/testsuite/task-5.c b/testsuite/smokey/alchemytests/task-5.c
similarity index 100%
rename from lib/alchemy/testsuite/task-5.c
rename to testsuite/smokey/alchemytests/task-5.c
diff --git a/lib/alchemy/testsuite/task-6.c b/testsuite/smokey/alchemytests/task-6.c
similarity index 100%
rename from lib/alchemy/testsuite/task-6.c
rename to testsuite/smokey/alchemytests/task-6.c
diff --git a/lib/alchemy/testsuite/task-7.c b/testsuite/smokey/alchemytests/task-7.c
similarity index 100%
rename from lib/alchemy/testsuite/task-7.c
rename to testsuite/smokey/alchemytests/task-7.c
diff --git a/lib/alchemy/testsuite/task-8.c b/testsuite/smokey/alchemytests/task-8.c
similarity index 100%
rename from lib/alchemy/testsuite/task-8.c
rename to testsuite/smokey/alchemytests/task-8.c
diff --git a/lib/alchemy/testsuite/task-9.c b/testsuite/smokey/alchemytests/task-9.c
similarity index 100%
rename from lib/alchemy/testsuite/task-9.c
rename to testsuite/smokey/alchemytests/task-9.c
-- 
2.35.3

