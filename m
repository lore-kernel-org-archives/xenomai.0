Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97E323C
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:29 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-932072d4c00so134401066b.1
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNR8S9hkNQlOsrfh2ozdX6sJWNSQMyF3ogEk8dWyHpk=;
        b=ZNNm1kwq+a4cd0onMED77+QBMpnEmlGuPma5MJjgUb2Gg0oWUxzWOIIg3NksZHyN9s
         5CTn6GHFcqTEyDAJFTRYPL25fS4UheV1jQsb0yqiNMo6MBvhD0qaEOS4BIWb5+mrpbRV
         EZ5BOJ5Uad95/nInvYK4GP2Q9/qvI7VCWiejoAQ+5FTn5LFv5AUABYV8Nqd+WotQij3j
         2uwhwnFbsVJnAsaGQebYPFlySqiR/jlHGl6xt/BLF2vZyKF8y+Mm/ceqDMeBC06tdRaA
         SHDgctWoj/HZuzzMbPYK0KPCfqyNSdIGEXHB9JoELVE7W7+WXmyGoNjoMjq8FoxDLmzd
         Pdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNR8S9hkNQlOsrfh2ozdX6sJWNSQMyF3ogEk8dWyHpk=;
        b=Gv/HiPdZbU1g1UtHy0RXnz9TQuYujXAca7cQNad/twNYvjJx8ueZ8AQdqiwRCcA1+D
         RAC2EpNfmGNMiEqnOS6SJOh6Q3ByTMJdwXCLCrZEebWw82mH0gYlfEHs/D3SfXhKyQEi
         s46zeXlx/WlAfI1RLU832xZgcdqmOO9OD47v9t/HS1SaTHgVsUjjLobtFLBIDOdmxEz0
         Mdh2WjqGywqDAvG3eASzUsNPLOFKHQd+Y9IMgDsw5AX8IJex9IWLMXG/ugJ1gQXUV9wA
         YwFw0XxAy4pQgvwMKU0PH0N07IzBY9ahMCez240/Kv90MeIlnFIwz4xUFZxS787gzphV
         mUKQ==
X-Gm-Message-State: AAQBX9cfJHTd548Xhj/e2ncW6NeI11WwPdB3NDG7Pq66+MRrnL4dVCbA
	5BqzGPzIdKTMYxMhddp1EaPlm08y6Rz0q86Rbe4=
X-Google-Smtp-Source: AKy350acETJDKwPRVrUE1RAF2pqmizOPM5OhNZZiGMcJi6YiPoJXImMfpt3+VXPvXTPeTF2gC3byxA==
X-Received: by 2002:a05:6402:1b01:b0:500:4e0c:2b08 with SMTP id by1-20020a0564021b0100b005004e0c2b08mr5346887edb.4.1680777267519;
        Thu, 06 Apr 2023 03:34:27 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:27 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 09/11] testsuite: Integrate vwworks tests into testsuite/
Date: Thu,  6 Apr 2023 12:33:39 +0200
Message-Id: <20230406103341.2914-10-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230406103341.2914-1-aaron@sigma-star.at>
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

Same as for alchemy and pSOS.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
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
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/lst-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/msgQ-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/msgQ-2.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/msgQ-3.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/rng-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/sem-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/sem-2.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/sem-3.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/sem-4.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/task-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/task-2.c (100%)
 create mode 100644 testsuite/vxworkstests/vxworkstest_driver.c
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/wd-1.c (100%)

diff --git a/configure.ac b/configure.ac
index afb9d89151..4d10acc973 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1047,6 +1047,7 @@ AC_CONFIG_FILES([ \
 	testsuite/xeno-test/Makefile \
 	testsuite/alchemytests/Makefile \
 	testsuite/psostests/Makefile \
+	testsuite/vxworkstests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/lib/vxworks/testsuite/Makefile b/lib/vxworks/testsuite/Makefile
deleted file mode 100644
index 648c9be90a..0000000000
--- a/lib/vxworks/testsuite/Makefile
+++ /dev/null
@@ -1,43 +0,0 @@
-ifeq ($(DESTDIR),)
-XENO_CONFIG=xeno-config
-else
-XENO_CONFIG=$(DESTDIR)/bin/xeno-config
-endif
-
-prefix := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --prefix)
-solibs := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --libdir)
-
-ifeq ($(prefix),)
-$(error Please add <xenomai-install-path>/bin to your PATH variable or specify DESTDIR)
-endif
-
-TESTS := task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4 lst-1 rng-1
-
-CFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=vxworks --cflags) -g
-LDFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=vxworks --ldflags)
-CC = $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --cc)
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
-		sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$$t --cpu-affinity=0 --silent && echo ok || echo BAD; \
-	done
-
-test/%: %
-	sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=0 --silent && echo ok || echo BAD
-
-.PHONY: clean test
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 137bfbf31c..c4de671c06 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -9,7 +9,8 @@ SUBDIRS += 		\
 	switchtest	\
 	xeno-test	\
 	alchemytests	\
-	psostests
+	psostests	\
+	vxworkstests
 endif
 
 DIST_SUBDIRS =		\
@@ -22,4 +23,5 @@ DIST_SUBDIRS =		\
 	switchtest	\
 	xeno-test	\
 	alchemytests \
-	psostests
+	psostests \
+	vxworkstests
diff --git a/testsuite/vxworkstests/Makefile.am b/testsuite/vxworkstests/Makefile.am
new file mode 100644
index 0000000000..39cdd043b3
--- /dev/null
+++ b/testsuite/vxworkstests/Makefile.am
@@ -0,0 +1,100 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = vxworkstest_driver \
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
+vxworkscppflags = 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+vxworksldadd = 					\
+	../../lib/vxworks/libvxworks@CORE@.la		\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+lst1_SOURCES = lst-1.c
+lst_CPPFLAGS = $(vxworkscppflags)
+lst1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+lst1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task1_SOURCES = task-1.c
+task1_CPPFLAGS = $(vxworkscppflags)
+task1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task2_SOURCES = task-2.c
+task2_CPPFLAGS = $(vxworkscppflags)
+task2_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+msgQ1_SOURCES = msgQ-1.c
+msgQ1_CPPFLAGS = $(vxworkscppflags)
+msgQ1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+msgQ1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+msgQ2_SOURCES = msgQ-2.c
+msgQ2_CPPFLAGS = $(vxworkscppflags)
+msgQ2_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+msgQ2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+msgQ3_SOURCES = msgQ-3.c
+msgQ3_CPPFLAGS = $(vxworkscppflags)
+msgQ3_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+msgQ3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+rng1_SOURCES = rng-1.c
+rng1_CPPFLAGS = $(vxworkscppflags)
+rng1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+rng1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+sem1_SOURCES = sem-1.c
+sem1_CPPFLAGS = $(vxworkscppflags)
+sem1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+sem2_SOURCES = sem-2.c
+sem2_CPPFLAGS = $(vxworkscppflags)
+sem2_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+sem3_SOURCES = sem-3.c
+sem3_CPPFLAGS = $(vxworkscppflags)
+sem3_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+sem3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+sem4_SOURCES = sem-4.c
+sem4_CPPFLAGS = $(vxworkscppflags)
+sem4_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+sem4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+wd1_SOURCES = wd-1.c
+wd1_CPPFLAGS = $(vxworkscppflags)
+wd1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
+wd1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+vxworkstest_driver_SOURCES = vxworkstest_driver.c
+vxworkstest_driver_CPPFLAGS =			\
+	$(XENO_USER_CFLAGS)			\
+	-I$(top_srcdir)/include
+vxworkstest_driver_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+vxworkstest_driver_LDADD =			\
+	../../lib/vxworks/libvxworks@CORE@.la		\
+	../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@		\
+	@XENO_USER_LDADD@		\
+	-lpthread -lrt
diff --git a/lib/vxworks/testsuite/lst-1.c b/testsuite/vxworkstests/lst-1.c
similarity index 100%
rename from lib/vxworks/testsuite/lst-1.c
rename to testsuite/vxworkstests/lst-1.c
diff --git a/lib/vxworks/testsuite/msgQ-1.c b/testsuite/vxworkstests/msgQ-1.c
similarity index 100%
rename from lib/vxworks/testsuite/msgQ-1.c
rename to testsuite/vxworkstests/msgQ-1.c
diff --git a/lib/vxworks/testsuite/msgQ-2.c b/testsuite/vxworkstests/msgQ-2.c
similarity index 100%
rename from lib/vxworks/testsuite/msgQ-2.c
rename to testsuite/vxworkstests/msgQ-2.c
diff --git a/lib/vxworks/testsuite/msgQ-3.c b/testsuite/vxworkstests/msgQ-3.c
similarity index 100%
rename from lib/vxworks/testsuite/msgQ-3.c
rename to testsuite/vxworkstests/msgQ-3.c
diff --git a/lib/vxworks/testsuite/rng-1.c b/testsuite/vxworkstests/rng-1.c
similarity index 100%
rename from lib/vxworks/testsuite/rng-1.c
rename to testsuite/vxworkstests/rng-1.c
diff --git a/lib/vxworks/testsuite/sem-1.c b/testsuite/vxworkstests/sem-1.c
similarity index 100%
rename from lib/vxworks/testsuite/sem-1.c
rename to testsuite/vxworkstests/sem-1.c
diff --git a/lib/vxworks/testsuite/sem-2.c b/testsuite/vxworkstests/sem-2.c
similarity index 100%
rename from lib/vxworks/testsuite/sem-2.c
rename to testsuite/vxworkstests/sem-2.c
diff --git a/lib/vxworks/testsuite/sem-3.c b/testsuite/vxworkstests/sem-3.c
similarity index 100%
rename from lib/vxworks/testsuite/sem-3.c
rename to testsuite/vxworkstests/sem-3.c
diff --git a/lib/vxworks/testsuite/sem-4.c b/testsuite/vxworkstests/sem-4.c
similarity index 100%
rename from lib/vxworks/testsuite/sem-4.c
rename to testsuite/vxworkstests/sem-4.c
diff --git a/lib/vxworks/testsuite/task-1.c b/testsuite/vxworkstests/task-1.c
similarity index 100%
rename from lib/vxworks/testsuite/task-1.c
rename to testsuite/vxworkstests/task-1.c
diff --git a/lib/vxworks/testsuite/task-2.c b/testsuite/vxworkstests/task-2.c
similarity index 100%
rename from lib/vxworks/testsuite/task-2.c
rename to testsuite/vxworkstests/task-2.c
diff --git a/testsuite/vxworkstests/vxworkstest_driver.c b/testsuite/vxworkstests/vxworkstest_driver.c
new file mode 100644
index 0000000000..a356f7e07a
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
+	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", mydir, t->name);
+	if (ret == -1)
+		return -ENOMEM;
+
+	ret = system(tst_path);
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
+	int ret, fails = 0;
+
+	if (argc > 0)
+		mydir = dirname(argv[0]);
+	else
+		mydir = ".";
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
diff --git a/lib/vxworks/testsuite/wd-1.c b/testsuite/vxworkstests/wd-1.c
similarity index 100%
rename from lib/vxworks/testsuite/wd-1.c
rename to testsuite/vxworkstests/wd-1.c
-- 
2.35.3

