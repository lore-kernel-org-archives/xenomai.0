Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695414AB1
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:05 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9928abc11deso884169666b.1
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273804; x=1690878604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg1jmi4S4xgnJWr9joNVMzMBVSMjk7V1sOkER9KWiGI=;
        b=mSsVZFg9VO2qtDttuYrn5gLYQFVK7C+ef1dGeQ8QyhSsxRN56A6GnDF2uUFHFcs2aO
         I9OUwG82uRdHKI5iT7k1/SNdoAet1tu6mGLhJK4JnbGL4wJRJnA/l/BlYJGI42TBaULx
         I2dhsralR9ejqQ5FG24bojDsfszh906JnaSLb3ONquKN3YI98YOJ7CZvywE3B420MREf
         MGWzotczv/U+A9llvoOKLU87LGj4Sw5q9HGuwyZUhXqBPZzQnwAMVhWBD9JbKH+n2gkT
         heqsZ5yXuggfzQNMzewGwfGgfJ/7Fvq5tZ6S4C/MT+Rdmw6KHA8MlitTZKn0ynOVi8eb
         Xamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273804; x=1690878604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg1jmi4S4xgnJWr9joNVMzMBVSMjk7V1sOkER9KWiGI=;
        b=dLb+ZofeQrFCHxbehu2hXvo7sZK0eiTJ9ON96Vq1NuQHLlSHLEmQCbDB53eelxQfDY
         1LcewZu6DV29eELrHL+5YoBRfJPA9uMPCfkyHWcwFSYbX2zN8RlZcwEesRbHBqG6DJOG
         LDZUGWzxJwQtXIukgVir+EU97XifgUONWsEY69VMD3xq32fDVQJ3XyTyxJf+ycPdTJZG
         +vKuLEApYsRkMNxpOqSuj/gjvFC+QdbnBJfZ7IawmUNj7Xs7wZlOKOsZAQWvyfXeMjcS
         axjajWkCjU/RhsTdr0r/glpR045jqYwvKqsP0F26Cy+Oewk91lJifQ90CatBis+6ABdO
         QiKQ==
X-Gm-Message-State: ABy/qLalgbDj17zmTW1QfaR3pQ36NkZrYi2488D17PZuF/03cOIywVWz
	UWmm+WPCfmhPzhrHyUtHMaLdUS37FIa9prUHBfg=
X-Google-Smtp-Source: APBJJlFo7F5LCOPvhv7YdQNo1vnb7lzeotKlStorW4x9ZaJBj8fFnJ7a6B973cnM9A69tNDqLPTWpg==
X-Received: by 2002:a17:906:518e:b0:994:9ed:300b with SMTP id y14-20020a170906518e00b0099409ed300bmr12850848ejk.16.1690273803834;
        Tue, 25 Jul 2023 01:30:03 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:03 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Date: Tue, 25 Jul 2023 10:29:50 +0200
Message-Id: <20230725082959.5144-2-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
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
 .../smokey/alchemytests}/alarm-1.c            |   1 +
 testsuite/smokey/alchemytests/alchemytests.c  |  56 +++++++
 .../smokey/alchemytests/alchemytests_driver.c |  33 ++++
 .../smokey/alchemytests}/buffer-1.c           |   1 +
 .../smokey/alchemytests}/event-1.c            |   1 +
 .../smokey/alchemytests}/heap-1.c             |   1 +
 .../smokey/alchemytests}/heap-2.c             |   1 +
 .../smokey/alchemytests}/mq-1.c               |   1 +
 .../smokey/alchemytests}/mq-2.c               |   1 +
 .../smokey/alchemytests}/mq-3.c               |   1 +
 .../smokey/alchemytests}/mutex-1.c            |   1 +
 .../smokey/alchemytests}/pipe-1.c             |   1 +
 .../smokey/alchemytests}/sem-1.c              |   1 +
 .../smokey/alchemytests}/sem-2.c              |   1 +
 .../smokey/alchemytests}/task-1.c             |   1 +
 .../smokey/alchemytests}/task-10.c            |   1 +
 .../smokey/alchemytests}/task-2.c             |   1 +
 .../smokey/alchemytests}/task-3.c             |   1 +
 .../smokey/alchemytests}/task-4.c             |   1 +
 .../smokey/alchemytests}/task-5.c             |   1 +
 .../smokey/alchemytests}/task-6.c             |   1 +
 .../smokey/alchemytests}/task-7.c             |   1 +
 .../smokey/alchemytests}/task-8.c             |   1 +
 .../smokey/alchemytests}/task-9.c             |   1 +
 28 files changed, 276 insertions(+), 7 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/Makefile.am
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (97%)
 create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
 create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (94%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (97%)

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
similarity index 97%
rename from lib/alchemy/testsuite/alarm-1.c
rename to testsuite/smokey/alchemytests/alarm-1.c
index 29b3bbe74..eb6c5310a 100644
--- a/lib/alchemy/testsuite/alarm-1.c
+++ b/testsuite/smokey/alchemytests/alarm-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
new file mode 100644
index 000000000..ee8d1703b
--- /dev/null
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
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
index 000000000..7cacbb399
--- /dev/null
+++ b/testsuite/smokey/alchemytests/alchemytests_driver.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
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
similarity index 98%
rename from lib/alchemy/testsuite/buffer-1.c
rename to testsuite/smokey/alchemytests/buffer-1.c
index d6d1d9ad7..fdcb5e8d7 100644
--- a/lib/alchemy/testsuite/buffer-1.c
+++ b/testsuite/smokey/alchemytests/buffer-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <memory.h>
diff --git a/lib/alchemy/testsuite/event-1.c b/testsuite/smokey/alchemytests/event-1.c
similarity index 98%
rename from lib/alchemy/testsuite/event-1.c
rename to testsuite/smokey/alchemytests/event-1.c
index 0893df36d..9ce679c71 100644
--- a/lib/alchemy/testsuite/event-1.c
+++ b/testsuite/smokey/alchemytests/event-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/heap-1.c b/testsuite/smokey/alchemytests/heap-1.c
similarity index 98%
rename from lib/alchemy/testsuite/heap-1.c
rename to testsuite/smokey/alchemytests/heap-1.c
index 48bc4a56e..f0904439f 100644
--- a/lib/alchemy/testsuite/heap-1.c
+++ b/testsuite/smokey/alchemytests/heap-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/heap-2.c b/testsuite/smokey/alchemytests/heap-2.c
similarity index 98%
rename from lib/alchemy/testsuite/heap-2.c
rename to testsuite/smokey/alchemytests/heap-2.c
index ad67afb2f..1f80db80c 100644
--- a/lib/alchemy/testsuite/heap-2.c
+++ b/testsuite/smokey/alchemytests/heap-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/mq-1.c b/testsuite/smokey/alchemytests/mq-1.c
similarity index 98%
rename from lib/alchemy/testsuite/mq-1.c
rename to testsuite/smokey/alchemytests/mq-1.c
index ac9801e72..952ff6448 100644
--- a/lib/alchemy/testsuite/mq-1.c
+++ b/testsuite/smokey/alchemytests/mq-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
similarity index 98%
rename from lib/alchemy/testsuite/mq-2.c
rename to testsuite/smokey/alchemytests/mq-2.c
index 9fea471b7..acc6ec051 100644
--- a/lib/alchemy/testsuite/mq-2.c
+++ b/testsuite/smokey/alchemytests/mq-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/mq-3.c b/testsuite/smokey/alchemytests/mq-3.c
similarity index 98%
rename from lib/alchemy/testsuite/mq-3.c
rename to testsuite/smokey/alchemytests/mq-3.c
index 7fcae020a..cb4c77d43 100644
--- a/lib/alchemy/testsuite/mq-3.c
+++ b/testsuite/smokey/alchemytests/mq-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/mutex-1.c b/testsuite/smokey/alchemytests/mutex-1.c
similarity index 98%
rename from lib/alchemy/testsuite/mutex-1.c
rename to testsuite/smokey/alchemytests/mutex-1.c
index ef58a2c86..f08665254 100644
--- a/lib/alchemy/testsuite/mutex-1.c
+++ b/testsuite/smokey/alchemytests/mutex-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
similarity index 98%
rename from lib/alchemy/testsuite/pipe-1.c
rename to testsuite/smokey/alchemytests/pipe-1.c
index 4202be2ba..4011f9c8a 100644
--- a/lib/alchemy/testsuite/pipe-1.c
+++ b/testsuite/smokey/alchemytests/pipe-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
diff --git a/lib/alchemy/testsuite/sem-1.c b/testsuite/smokey/alchemytests/sem-1.c
similarity index 98%
rename from lib/alchemy/testsuite/sem-1.c
rename to testsuite/smokey/alchemytests/sem-1.c
index 3e526eddf..080bcea9a 100644
--- a/lib/alchemy/testsuite/sem-1.c
+++ b/testsuite/smokey/alchemytests/sem-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/sem-2.c b/testsuite/smokey/alchemytests/sem-2.c
similarity index 97%
rename from lib/alchemy/testsuite/sem-2.c
rename to testsuite/smokey/alchemytests/sem-2.c
index c01f6a431..74cce2b7d 100644
--- a/lib/alchemy/testsuite/sem-2.c
+++ b/testsuite/smokey/alchemytests/sem-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-1.c b/testsuite/smokey/alchemytests/task-1.c
similarity index 94%
rename from lib/alchemy/testsuite/task-1.c
rename to testsuite/smokey/alchemytests/task-1.c
index 34a6c22fd..d3d9a6f7f 100644
--- a/lib/alchemy/testsuite/task-1.c
+++ b/testsuite/smokey/alchemytests/task-1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-10.c b/testsuite/smokey/alchemytests/task-10.c
similarity index 97%
rename from lib/alchemy/testsuite/task-10.c
rename to testsuite/smokey/alchemytests/task-10.c
index 58f4cb035..c4a29ae76 100644
--- a/lib/alchemy/testsuite/task-10.c
+++ b/testsuite/smokey/alchemytests/task-10.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-2.c b/testsuite/smokey/alchemytests/task-2.c
similarity index 98%
rename from lib/alchemy/testsuite/task-2.c
rename to testsuite/smokey/alchemytests/task-2.c
index e751ddd34..592f2ed20 100644
--- a/lib/alchemy/testsuite/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-3.c b/testsuite/smokey/alchemytests/task-3.c
similarity index 97%
rename from lib/alchemy/testsuite/task-3.c
rename to testsuite/smokey/alchemytests/task-3.c
index 06f235af9..eb24935a4 100644
--- a/lib/alchemy/testsuite/task-3.c
+++ b/testsuite/smokey/alchemytests/task-3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-4.c b/testsuite/smokey/alchemytests/task-4.c
similarity index 98%
rename from lib/alchemy/testsuite/task-4.c
rename to testsuite/smokey/alchemytests/task-4.c
index eba7fbb86..90e0236be 100644
--- a/lib/alchemy/testsuite/task-4.c
+++ b/testsuite/smokey/alchemytests/task-4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-5.c b/testsuite/smokey/alchemytests/task-5.c
similarity index 98%
rename from lib/alchemy/testsuite/task-5.c
rename to testsuite/smokey/alchemytests/task-5.c
index 3c0fa427c..b9075945d 100644
--- a/lib/alchemy/testsuite/task-5.c
+++ b/testsuite/smokey/alchemytests/task-5.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-6.c b/testsuite/smokey/alchemytests/task-6.c
similarity index 97%
rename from lib/alchemy/testsuite/task-6.c
rename to testsuite/smokey/alchemytests/task-6.c
index 7c88fde9c..fa58d0fdc 100644
--- a/lib/alchemy/testsuite/task-6.c
+++ b/testsuite/smokey/alchemytests/task-6.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-7.c b/testsuite/smokey/alchemytests/task-7.c
similarity index 98%
rename from lib/alchemy/testsuite/task-7.c
rename to testsuite/smokey/alchemytests/task-7.c
index 1350bb39c..d118abf42 100644
--- a/lib/alchemy/testsuite/task-7.c
+++ b/testsuite/smokey/alchemytests/task-7.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-8.c b/testsuite/smokey/alchemytests/task-8.c
similarity index 97%
rename from lib/alchemy/testsuite/task-8.c
rename to testsuite/smokey/alchemytests/task-8.c
index bb6dfff06..959b3d3c4 100644
--- a/lib/alchemy/testsuite/task-8.c
+++ b/testsuite/smokey/alchemytests/task-8.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <copperplate/traceobj.h>
diff --git a/lib/alchemy/testsuite/task-9.c b/testsuite/smokey/alchemytests/task-9.c
similarity index 97%
rename from lib/alchemy/testsuite/task-9.c
rename to testsuite/smokey/alchemytests/task-9.c
index e358154c5..56cc7bfeb 100644
--- a/lib/alchemy/testsuite/task-9.c
+++ b/testsuite/smokey/alchemytests/task-9.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
-- 
2.35.3

