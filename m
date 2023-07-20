Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95418AE7
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:06 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b962c226ceso13010811fa.3
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864724; x=1690469524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPb9q+wCnpO2KvysSYwuU6Zw/f0XwoBC/lNTBoNbcP8=;
        b=nBClywWunU/6L3Z9PKFjWnRrvH2sea6vWLiITr4Kyt7t0+ON/bneaM08rcVARtrxmO
         TF8PIWHPIKof+Z/0igRsANeFCv/YlZgtMu52W83LAlfUVIFK0Iu+uODYCrgsdHtX+I6k
         6qOSEtNYgkCKmPGQww1lawADN7sn8/FktbU//2LMTD/C4kG9sRyUWwZ2xay0Zqcg8IrC
         9Ev8tK8xZCIbsfw3e9swJalSnucKRZPkmynUNMFlxJ1RRqmq5iSIIzBkJa8CuUY0/03m
         DipCtm09oGiAlN9moXmArSEQp0zpZZUjLBLUB4LfaOnMKq4BipRj+/aMM6e5og97TwO3
         s1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864724; x=1690469524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPb9q+wCnpO2KvysSYwuU6Zw/f0XwoBC/lNTBoNbcP8=;
        b=aOaxI7VtZK/e9tGwQNSpuxAjCUjAEMCvRbL5UYnVaQCPeA8UyBXAyqOIn4hzpg/iCM
         3zdqGemk3wLM4yHe2lqgLIGWgVyTMvHGu4UXdq8CgGZwh7eOYLh/H9NSKaXzSLjmogOD
         6/tAkmWeSYGXSPbiYtFRfBluWBBw8C2IZxiac3T+4aYrwn3uG4z3k2HyuqBkFhSWILHs
         maxFJAC9Q5gGphdZwWVHkDgbRns27V5z9TW2lvDNYyPQDVGKAT75C07Hz/pnCoAH5ZXn
         I4R822HLn0jsGFB5za8Vs/obkdqCziozsx/635KT0983COGCyoIJ3lnMyrhbxMJtaVfP
         RQAg==
X-Gm-Message-State: ABy/qLbU2LkaaAOO2D0eW6bwi59MAt8JwIMwMlcgYry50n2gQtJXwMeN
	6AGofqNaEBCGYQVzF/0N41M9VlM1X7FVmAIeeHQ=
X-Google-Smtp-Source: APBJJlE9bEjO43US9ku69YbWsm3lS5hQRDYZma1ELUI9TPDozCjI1Vbtj2MED5Mabk0hlCBDVHp+cg==
X-Received: by 2002:a05:651c:201:b0:2b4:65bf:d7b with SMTP id y1-20020a05651c020100b002b465bf0d7bmr2654520ljn.2.1689864724435;
        Thu, 20 Jul 2023 07:52:04 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:04 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 02/10] testsuite: Fully integrate psostests into smokey
Date: Thu, 20 Jul 2023 16:51:42 +0200
Message-Id: <20230720145150.24607-3-aaron@sigma-star.at>
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

Just like for alchemytests, integrate them into our testsuite.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 configure.ac                                  |   2 +-
 lib/psos/testsuite/Makefile                   |  49 ------
 testsuite/Makefile.am                         |   2 -
 testsuite/smokey/Makefile.am                  |   9 +-
 testsuite/smokey/psostests/Makefile.am        | 148 ++++++++++++++++++
 .../smokey/psostests}/mq-1.c                  |   0
 .../smokey/psostests}/mq-2.c                  |   0
 .../smokey/psostests}/mq-3.c                  |   0
 testsuite/smokey/psostests/psostests.c        |  56 +++++++
 testsuite/smokey/psostests/psostests_driver.c |  33 ++++
 .../smokey/psostests}/pt-1.c                  |   0
 .../smokey/psostests}/rn-1.c                  |   0
 .../smokey/psostests}/sem-1.c                 |   0
 .../smokey/psostests}/sem-2.c                 |   0
 .../smokey/psostests}/task-1.c                |   0
 .../smokey/psostests}/task-2.c                |   0
 .../smokey/psostests}/task-3.c                |   0
 .../smokey/psostests}/task-4.c                |   0
 .../smokey/psostests}/task-5.c                |   0
 .../smokey/psostests}/task-6.c                |   0
 .../smokey/psostests}/task-7.c                |   0
 .../smokey/psostests}/task-8.c                |   0
 .../smokey/psostests}/task-9.c                |   0
 .../smokey/psostests}/tm-1.c                  |   0
 .../smokey/psostests}/tm-2.c                  |   0
 .../smokey/psostests}/tm-3.c                  |   0
 .../smokey/psostests}/tm-4.c                  |   0
 .../smokey/psostests}/tm-5.c                  |   0
 .../smokey/psostests}/tm-6.c                  |   0
 .../smokey/psostests}/tm-7.c                  |   0
 30 files changed, 244 insertions(+), 55 deletions(-)
 delete mode 100644 lib/psos/testsuite/Makefile
 create mode 100644 testsuite/smokey/psostests/Makefile.am
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-2.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-3.c (100%)
 create mode 100644 testsuite/smokey/psostests/psostests.c
 create mode 100644 testsuite/smokey/psostests/psostests_driver.c
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/pt-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/rn-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-2.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-2.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-3.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-4.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-5.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-6.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-7.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-8.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-9.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-2.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-3.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-4.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-5.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-6.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-7.c (100%)

diff --git a/configure.ac b/configure.ac
index fe59333ed..9db5438eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1044,9 +1044,9 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/can/Makefile \
 	testsuite/smokey/x86io/Makefile \
 	testsuite/smokey/alchemytests/Makefile \
+	testsuite/smokey/psostests/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
-	testsuite/psostests/Makefile \
 	testsuite/vxworkstests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
diff --git a/lib/psos/testsuite/Makefile b/lib/psos/testsuite/Makefile
deleted file mode 100644
index 3330a617c..000000000
--- a/lib/psos/testsuite/Makefile
+++ /dev/null
@@ -1,49 +0,0 @@
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
-TESTS := \
-	task-1 task-2 task-3 task-4 task-5 task-6 task-7 task-8 task-9 \
-	tm-1 tm-2 tm-3 tm-4 tm-5 tm-6 tm-7 \
-	mq-1 mq-2 mq-3 \
-	sem-1 sem-2 \
-	pt-1 \
-	rn-1
-
-CFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=psos --cflags) -g
-LDFLAGS := $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --skin=psos --ldflags)
-CC = $(shell DESTDIR=$(DESTDIR) $(XENO_CONFIG) --cc)
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
-		sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$$t --cpu-affinity=0 --silent && echo ok || echo BAD; \
-	done
-
-test/%: %
-	sudo LD_LIBRARY_PATH=$(solibs) $(VALGRIND) ./$(@F) --cpu-affinity=0 --silent && echo ok || echo BAD
-
-.PHONY: clean test
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 1be7eaba4..bb94f6ba6 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -8,7 +8,6 @@ SUBDIRS += 		\
 	spitest		\
 	switchtest	\
 	xeno-test	\
-	psostests	\
 	vxworkstests
 endif
 
@@ -21,5 +20,4 @@ DIST_SUBDIRS =		\
 	spitest		\
 	switchtest	\
 	xeno-test	\
-	psostests \
 	vxworkstests
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 633a87387..457e22a84 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -41,13 +41,15 @@ COBALT_SUBDIRS = 	\
 	vdso-access 	\
 	xddp		\
 	y2038 \
-	alchemytests
+	alchemytests \
+	psostests
 
 MERCURY_SUBDIRS =	\
 	memory-heapmem	\
 	memory-tlsf	\
 	memcheck \
-	alchemytests
+	alchemytests \
+	psostests
 
 DIST_SUBDIRS = 		\
 	arith 		\
@@ -83,7 +85,8 @@ DIST_SUBDIRS = 		\
 	vdso-access 	\
 	xddp		\
 	y2038 \
-	alchemytests
+	alchemytests \
+	psostests
 
 if XENO_X86
 DIST_SUBDIRS += x86io
diff --git a/testsuite/smokey/psostests/Makefile.am b/testsuite/smokey/psostests/Makefile.am
new file mode 100644
index 000000000..bd6abc74c
--- /dev/null
+++ b/testsuite/smokey/psostests/Makefile.am
@@ -0,0 +1,148 @@
+testdir = @XENO_TEST_DIR@
+noinst_LIBRARIES = libpsostests.a
+
+libpsostests_a_SOURCES = psostests.c
+libpsostests_a_CPPFLAGS = 		\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include \
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = \
+		psostests       \
+		psostests_mq1	\
+		psostests_mq2	\
+		psostests_mq3	\
+		psostests_pt1	\
+		psostests_rn1	\
+		psostests_sem1	\
+		psostests_sem2	\
+		psostests_tm1	\
+		psostests_tm2	\
+		psostests_tm3	\
+		psostests_tm4	\
+		psostests_tm5	\
+		psostests_tm6	\
+		psostests_tm7	\
+		psostests_task1	\
+		psostests_task2	\
+		psostests_task3	\
+		psostests_task4	\
+		psostests_task5	\
+		psostests_task6	\
+		psostests_task7	\
+		psostests_task8	\
+		psostests_task9
+
+psoscppflags = 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)		\
+	-I$(top_srcdir)/include
+
+psosldadd = 					\
+	../../../lib/psos/libpsos@CORE@.la		\
+	../../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+psostests_SOURCES = psostests_driver.c
+psostests_CPPFLAGS = $(psoscppflags)
+psostests_LDADD = ../../../lib/smokey/libsmokey@CORE@.la -lpthread -lrt
+psostests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+psostests_mq1_SOURCES = mq-1.c
+psostests_mq1_CPPFLAGS = $(psoscppflags)
+psostests_mq1_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_mq2_SOURCES = mq-2.c
+psostests_mq2_CPPFLAGS = $(psoscppflags)
+psostests_mq2_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_mq3_SOURCES = mq-3.c
+psostests_mq3_CPPFLAGS = $(psoscppflags)
+psostests_mq3_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_pt1_SOURCES = pt-1.c
+psostests_pt1_CPPFLAGS = $(psoscppflags)
+psostests_pt1_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_pt1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_rn1_SOURCES = rn-1.c
+psostests_rn1_CPPFLAGS = $(psoscppflags)
+psostests_rn1_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_rn1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_sem1_SOURCES = sem-1.c
+psostests_sem1_CPPFLAGS = $(psoscppflags)
+psostests_sem1_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_sem2_SOURCES = sem-2.c
+psostests_sem2_CPPFLAGS = $(psoscppflags)
+psostests_sem2_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm1_SOURCES = tm-1.c
+psostests_tm1_CPPFLAGS = $(psoscppflags)
+psostests_tm1_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_tm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm2_SOURCES = tm-2.c
+psostests_tm2_CPPFLAGS = $(psoscppflags)
+psostests_tm2_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_tm2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm3_SOURCES = tm-3.c
+psostests_tm3_CPPFLAGS = $(psoscppflags)
+psostests_tm3_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_tm3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm4_SOURCES = tm-4.c
+psostests_tm4_CPPFLAGS = $(psoscppflags)
+psostests_tm4_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_tm4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm5_SOURCES = tm-5.c
+psostests_tm5_CPPFLAGS = $(psoscppflags)
+psostests_tm5_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_tm5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm6_SOURCES = tm-6.c
+psostests_tm6_CPPFLAGS = $(psoscppflags)
+psostests_tm6_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_tm6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_tm7_SOURCES = tm-7.c
+psostests_tm7_CPPFLAGS = $(psoscppflags)
+psostests_tm7_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_tm7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task1_SOURCES = task-1.c
+psostests_task1_CPPFLAGS = $(psoscppflags)
+psostests_task1_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task2_SOURCES = task-2.c
+psostests_task2_CPPFLAGS = $(psoscppflags)
+psostests_task2_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task3_SOURCES = task-3.c
+psostests_task3_CPPFLAGS = $(psoscppflags)
+psostests_task3_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task4_SOURCES = task-4.c
+psostests_task4_CPPFLAGS = $(psoscppflags)
+psostests_task4_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task5_SOURCES = task-5.c
+psostests_task5_CPPFLAGS = $(psoscppflags)
+psostests_task5_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task6_SOURCES = task-6.c
+psostests_task6_CPPFLAGS = $(psoscppflags)
+psostests_task6_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task7_SOURCES = task-7.c
+psostests_task7_CPPFLAGS = $(psoscppflags)
+psostests_task7_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task8_SOURCES = task-8.c
+psostests_task8_CPPFLAGS = $(psoscppflags)
+psostests_task8_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostests_task9_SOURCES = task-9.c
+psostests_task9_CPPFLAGS = $(psoscppflags)
+psostests_task9_LDADD = $(psosldadd) -lpthread -lrt -lm
+psostests_task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
diff --git a/lib/psos/testsuite/mq-1.c b/testsuite/smokey/psostests/mq-1.c
similarity index 100%
rename from lib/psos/testsuite/mq-1.c
rename to testsuite/smokey/psostests/mq-1.c
diff --git a/lib/psos/testsuite/mq-2.c b/testsuite/smokey/psostests/mq-2.c
similarity index 100%
rename from lib/psos/testsuite/mq-2.c
rename to testsuite/smokey/psostests/mq-2.c
diff --git a/lib/psos/testsuite/mq-3.c b/testsuite/smokey/psostests/mq-3.c
similarity index 100%
rename from lib/psos/testsuite/mq-3.c
rename to testsuite/smokey/psostests/mq-3.c
diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
new file mode 100644
index 000000000..66c913213
--- /dev/null
+++ b/testsuite/smokey/psostests/psostests.c
@@ -0,0 +1,56 @@
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
+TEST(psostests)
+TEST(psostests_mq1)
+TEST(psostests_mq2)
+TEST(psostests_mq3)
+TEST(psostests_pt1)
+TEST(psostests_rn1)
+TEST(psostests_sem1)
+TEST(psostests_sem2)
+TEST(psostests_task1)
+TEST(psostests_task2)
+TEST(psostests_task3)
+TEST(psostests_task4)
+TEST(psostests_task5)
+TEST(psostests_task6)
+TEST(psostests_task7)
+TEST(psostests_task8)
+TEST(psostests_task9)
+TEST(psostests_tm1)
+TEST(psostests_tm2)
+TEST(psostests_tm3)
+TEST(psostests_tm4)
+TEST(psostests_tm5)
+TEST(psostests_tm6)
+TEST(psostests_tm7)
+
diff --git a/testsuite/smokey/psostests/psostests_driver.c b/testsuite/smokey/psostests/psostests_driver.c
new file mode 100644
index 000000000..d79e44c74
--- /dev/null
+++ b/testsuite/smokey/psostests/psostests_driver.c
@@ -0,0 +1,33 @@
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
+       struct smokey_test *t;
+       int ret, fails = 0;
+
+       if (pvlist_empty(&smokey_test_list))
+               return 0;
+
+       for_each_smokey_test(t) {
+               ret = t->run(t, argc, argv);
+               if (ret) {
+                       fails++;
+                       if (smokey_keep_going)
+                               continue;
+                       if (smokey_verbose_mode)
+                               error(1, -ret, "test %s failed", t->name);
+                       return 1;
+               }
+               smokey_note("%s OK", t->name);
+       }
+
+       return fails != 0;
+}
+
diff --git a/lib/psos/testsuite/pt-1.c b/testsuite/smokey/psostests/pt-1.c
similarity index 100%
rename from lib/psos/testsuite/pt-1.c
rename to testsuite/smokey/psostests/pt-1.c
diff --git a/lib/psos/testsuite/rn-1.c b/testsuite/smokey/psostests/rn-1.c
similarity index 100%
rename from lib/psos/testsuite/rn-1.c
rename to testsuite/smokey/psostests/rn-1.c
diff --git a/lib/psos/testsuite/sem-1.c b/testsuite/smokey/psostests/sem-1.c
similarity index 100%
rename from lib/psos/testsuite/sem-1.c
rename to testsuite/smokey/psostests/sem-1.c
diff --git a/lib/psos/testsuite/sem-2.c b/testsuite/smokey/psostests/sem-2.c
similarity index 100%
rename from lib/psos/testsuite/sem-2.c
rename to testsuite/smokey/psostests/sem-2.c
diff --git a/lib/psos/testsuite/task-1.c b/testsuite/smokey/psostests/task-1.c
similarity index 100%
rename from lib/psos/testsuite/task-1.c
rename to testsuite/smokey/psostests/task-1.c
diff --git a/lib/psos/testsuite/task-2.c b/testsuite/smokey/psostests/task-2.c
similarity index 100%
rename from lib/psos/testsuite/task-2.c
rename to testsuite/smokey/psostests/task-2.c
diff --git a/lib/psos/testsuite/task-3.c b/testsuite/smokey/psostests/task-3.c
similarity index 100%
rename from lib/psos/testsuite/task-3.c
rename to testsuite/smokey/psostests/task-3.c
diff --git a/lib/psos/testsuite/task-4.c b/testsuite/smokey/psostests/task-4.c
similarity index 100%
rename from lib/psos/testsuite/task-4.c
rename to testsuite/smokey/psostests/task-4.c
diff --git a/lib/psos/testsuite/task-5.c b/testsuite/smokey/psostests/task-5.c
similarity index 100%
rename from lib/psos/testsuite/task-5.c
rename to testsuite/smokey/psostests/task-5.c
diff --git a/lib/psos/testsuite/task-6.c b/testsuite/smokey/psostests/task-6.c
similarity index 100%
rename from lib/psos/testsuite/task-6.c
rename to testsuite/smokey/psostests/task-6.c
diff --git a/lib/psos/testsuite/task-7.c b/testsuite/smokey/psostests/task-7.c
similarity index 100%
rename from lib/psos/testsuite/task-7.c
rename to testsuite/smokey/psostests/task-7.c
diff --git a/lib/psos/testsuite/task-8.c b/testsuite/smokey/psostests/task-8.c
similarity index 100%
rename from lib/psos/testsuite/task-8.c
rename to testsuite/smokey/psostests/task-8.c
diff --git a/lib/psos/testsuite/task-9.c b/testsuite/smokey/psostests/task-9.c
similarity index 100%
rename from lib/psos/testsuite/task-9.c
rename to testsuite/smokey/psostests/task-9.c
diff --git a/lib/psos/testsuite/tm-1.c b/testsuite/smokey/psostests/tm-1.c
similarity index 100%
rename from lib/psos/testsuite/tm-1.c
rename to testsuite/smokey/psostests/tm-1.c
diff --git a/lib/psos/testsuite/tm-2.c b/testsuite/smokey/psostests/tm-2.c
similarity index 100%
rename from lib/psos/testsuite/tm-2.c
rename to testsuite/smokey/psostests/tm-2.c
diff --git a/lib/psos/testsuite/tm-3.c b/testsuite/smokey/psostests/tm-3.c
similarity index 100%
rename from lib/psos/testsuite/tm-3.c
rename to testsuite/smokey/psostests/tm-3.c
diff --git a/lib/psos/testsuite/tm-4.c b/testsuite/smokey/psostests/tm-4.c
similarity index 100%
rename from lib/psos/testsuite/tm-4.c
rename to testsuite/smokey/psostests/tm-4.c
diff --git a/lib/psos/testsuite/tm-5.c b/testsuite/smokey/psostests/tm-5.c
similarity index 100%
rename from lib/psos/testsuite/tm-5.c
rename to testsuite/smokey/psostests/tm-5.c
diff --git a/lib/psos/testsuite/tm-6.c b/testsuite/smokey/psostests/tm-6.c
similarity index 100%
rename from lib/psos/testsuite/tm-6.c
rename to testsuite/smokey/psostests/tm-6.c
diff --git a/lib/psos/testsuite/tm-7.c b/testsuite/smokey/psostests/tm-7.c
similarity index 100%
rename from lib/psos/testsuite/tm-7.c
rename to testsuite/smokey/psostests/tm-7.c
-- 
2.35.3

