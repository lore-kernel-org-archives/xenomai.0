Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D63210
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:27 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-4fa3c857b08so1008018a12.2
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Jdmgl/jXmZYd6Ep6qPKqR5UcSKPk/N2eKOA6TX5yqA=;
        b=iugt5ZZhpA1tZW3ELB1ylYQdTP0BcPiqZ2zaBzHX6c6wNwBn57JcpjbY4E0woezB1D
         YQ2YPVg+Jc8iH3QG5ksQenBB91P2ppdKkdvpX/ly68M/aM/jQJNUaORKS2X7qS0PbScC
         PDBxI3qMYEultQ0Z3EawwdfYoVYrT6+JACl/T1aaH0hOYhbHi/MeDX7Cy9rrABWvt8HR
         Cn4L4o9qXGIsr6qh7hjFSUR2hucNahuTsbElHOqLBrHl8PD/UBw/JX+ASJej2YNgWZH0
         TieX33hy0NvhfWorGUX9JxOCrwUHG/jnuxRDVAl3juFGdw0D5yNxur5xmMCo56UqlBZh
         +Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Jdmgl/jXmZYd6Ep6qPKqR5UcSKPk/N2eKOA6TX5yqA=;
        b=qYvz+2+n/OBUq6vO7y5lmcGmj7bj9ZRVQh5BbkRUeSeCNooiRD/+R/txLnkgg3O6If
         fohOqW4zhngbwQnHiGFIKeXr99JFrnSqBgZDiA66A1ZSO17uZRULANE7bmI0ZssNtXNa
         j4euIeJ8hcYn6fW7AZGjKocbPd5xwp0RJF1CUykd8fOBPwTcHKuAIlg0Rzl4q4LVAhr6
         DJGC/umZLMHAnotcC7FJRE5Iru7vfPQOQ9o+A6XDSgt0kmIWfFLYkNEaGxrxddGIjiNf
         4u1GTGoBzpIWGExxDvltAgAAGb5ee9bdHzpAWrL5p1nG8+wgKr5Ti+nCvOga3kctwaGx
         /atQ==
X-Gm-Message-State: AAQBX9dqMan4DsYJYfOP7WxmvIa4T6bRXeYIVm7x0ZVioNqkCMTCaqNw
	sPQzzU97up4Lq7iGv/aHryGZYLsuN63Zx4Pi6Do=
X-Google-Smtp-Source: AKy350brMaVNDDyHN8yv0I88j28sXapbK1ibmcpRqiAtot+PRbkBbCI3nVjfX6wCAzniRTtJuedyLw==
X-Received: by 2002:a05:6402:74a:b0:502:30e6:1e65 with SMTP id p10-20020a056402074a00b0050230e61e65mr4186603edy.12.1680777266105;
        Thu, 06 Apr 2023 03:34:26 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:25 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 07/11] testsuite: Move pSOS tests into testsuite/
Date: Thu,  6 Apr 2023 12:33:37 +0200
Message-Id: <20230406103341.2914-8-aaron@sigma-star.at>
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

Just like for alchemy tests, integrate them into our test suite.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 configure.ac                                  |   1 +
 lib/psos/testsuite/Makefile                   |  49 ------
 testsuite/Makefile.am                         |   6 +-
 testsuite/psostests/Makefile.am               | 153 ++++++++++++++++++
 .../testsuite => testsuite/psostests}/mq-1.c  |   0
 .../testsuite => testsuite/psostests}/mq-2.c  |   0
 .../testsuite => testsuite/psostests}/mq-3.c  |   0
 .../testsuite => testsuite/psostests}/pt-1.c  |   0
 .../testsuite => testsuite/psostests}/rn-1.c  |   0
 .../testsuite => testsuite/psostests}/sem-1.c |   0
 .../testsuite => testsuite/psostests}/sem-2.c |   0
 .../psostests}/task-1.c                       |   0
 .../psostests}/task-2.c                       |   0
 .../psostests}/task-3.c                       |   0
 .../psostests}/task-4.c                       |   0
 .../psostests}/task-5.c                       |   0
 .../psostests}/task-6.c                       |   0
 .../psostests}/task-7.c                       |   0
 .../psostests}/task-8.c                       |   0
 .../psostests}/task-9.c                       |   0
 .../testsuite => testsuite/psostests}/tm-1.c  |   0
 .../testsuite => testsuite/psostests}/tm-2.c  |   0
 .../testsuite => testsuite/psostests}/tm-3.c  |   0
 .../testsuite => testsuite/psostests}/tm-4.c  |   0
 .../testsuite => testsuite/psostests}/tm-5.c  |   0
 .../testsuite => testsuite/psostests}/tm-6.c  |   0
 .../testsuite => testsuite/psostests}/tm-7.c  |   0
 27 files changed, 158 insertions(+), 51 deletions(-)
 delete mode 100644 lib/psos/testsuite/Makefile
 create mode 100644 testsuite/psostests/Makefile.am
 rename {lib/psos/testsuite => testsuite/psostests}/mq-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/mq-2.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/mq-3.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/pt-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/rn-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/sem-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/sem-2.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-2.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-3.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-4.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-5.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-6.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-7.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-8.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-9.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-2.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-3.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-4.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-5.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-6.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-7.c (100%)

diff --git a/configure.ac b/configure.ac
index 36f4aa9933..afb9d89151 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1046,6 +1046,7 @@ AC_CONFIG_FILES([ \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
 	testsuite/alchemytests/Makefile \
+	testsuite/psostests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/lib/psos/testsuite/Makefile b/lib/psos/testsuite/Makefile
deleted file mode 100644
index 3330a617ca..0000000000
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
index e027485fb6..137bfbf31c 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -8,7 +8,8 @@ SUBDIRS += 		\
 	spitest		\
 	switchtest	\
 	xeno-test	\
-	alchemytests
+	alchemytests	\
+	psostests
 endif
 
 DIST_SUBDIRS =		\
@@ -20,4 +21,5 @@ DIST_SUBDIRS =		\
 	spitest		\
 	switchtest	\
 	xeno-test	\
-	alchemytests
+	alchemytests \
+	psostests
diff --git a/testsuite/psostests/Makefile.am b/testsuite/psostests/Makefile.am
new file mode 100644
index 0000000000..9e8aef62b7
--- /dev/null
+++ b/testsuite/psostests/Makefile.am
@@ -0,0 +1,153 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = mq1	\
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
+psoscppflags = 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+psosldadd = 					\
+	../../lib/psos/libpsos@CORE@.la		\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+mq1_SOURCES = mq-1.c
+mq1_CPPFLAGS = $(psoscppflags)
+mq1_LDADD = $(psosldadd) -lpthread -lrt -lm
+mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+mq2_SOURCES = mq-2.c
+mq2_CPPFLAGS = $(psoscppflags)
+mq2_LDADD = $(psosldadd) -lpthread -lrt -lm
+mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+mq3_SOURCES = mq-3.c
+mq3_CPPFLAGS = $(psoscppflags)
+mq3_LDADD = $(psosldadd) -lpthread -lrt -lm
+mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+pt1_SOURCES = pt-1.c
+pt1_CPPFLAGS = $(psoscppflags)
+pt1_LDADD = $(psosldadd) -lpthread -lrt -lm
+pt1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+rn1_SOURCES = rn-1.c
+rn1_CPPFLAGS = $(psoscppflags)
+rn1_LDADD = $(psosldadd) -lpthread -lrt -lm
+rn1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+sem1_SOURCES = sem-1.c
+sem1_CPPFLAGS = $(psoscppflags)
+sem1_LDADD = $(psosldadd) -lpthread -lrt -lm
+sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+sem2_SOURCES = sem-2.c
+sem2_CPPFLAGS = $(psoscppflags)
+sem2_LDADD = $(psosldadd) -lpthread -lrt -lm
+sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+tm1_SOURCES = tm-1.c
+tm1_CPPFLAGS = $(psoscppflags)
+tm1_LDADD = $(psosldadd) -lpthread -lrt -lm
+tm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+tm2_SOURCES = tm-2.c
+tm2_CPPFLAGS = $(psoscppflags)
+tm2_LDADD = $(psosldadd) -lpthread -lrt -lm
+tm2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+tm3_SOURCES = tm-3.c
+tm3_CPPFLAGS = $(psoscppflags)
+tm3_LDADD = $(psosldadd) -lpthread -lrt -lm
+tm3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+tm4_SOURCES = tm-4.c
+tm4_CPPFLAGS = $(psoscppflags)
+tm4_LDADD = $(psosldadd) -lpthread -lrt -lm
+tm4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+tm5_SOURCES = tm-5.c
+tm5_CPPFLAGS = $(psoscppflags)
+tm5_LDADD = $(psosldadd) -lpthread -lrt -lm
+tm5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+tm6_SOURCES = tm-6.c
+tm6_CPPFLAGS = $(psoscppflags)
+tm6_LDADD = $(psosldadd) -lpthread -lrt -lm
+tm6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+tm7_SOURCES = tm-7.c
+tm7_CPPFLAGS = $(psoscppflags)
+tm7_LDADD = $(psosldadd) -lpthread -lrt -lm
+tm7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task1_SOURCES = task-1.c
+task1_CPPFLAGS = $(psoscppflags)
+task1_LDADD = $(psosldadd) -lpthread -lrt -lm
+task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task2_SOURCES = task-2.c
+task2_CPPFLAGS = $(psoscppflags)
+task2_LDADD = $(psosldadd) -lpthread -lrt -lm
+task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task3_SOURCES = task-3.c
+task3_CPPFLAGS = $(psoscppflags)
+task3_LDADD = $(psosldadd) -lpthread -lrt -lm
+task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task4_SOURCES = task-4.c
+task4_CPPFLAGS = $(psoscppflags)
+task4_LDADD = $(psosldadd) -lpthread -lrt -lm
+task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task5_SOURCES = task-5.c
+task5_CPPFLAGS = $(psoscppflags)
+task5_LDADD = $(psosldadd) -lpthread -lrt -lm
+task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task6_SOURCES = task-6.c
+task6_CPPFLAGS = $(psoscppflags)
+task6_LDADD = $(psosldadd) -lpthread -lrt -lm
+task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task7_SOURCES = task-7.c
+task7_CPPFLAGS = $(psoscppflags)
+task7_LDADD = $(psosldadd) -lpthread -lrt -lm
+task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task8_SOURCES = task-8.c
+task8_CPPFLAGS = $(psoscppflags)
+task8_LDADD = $(psosldadd) -lpthread -lrt -lm
+task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task9_SOURCES = task-9.c
+task9_CPPFLAGS = $(psoscppflags)
+task9_LDADD = $(psosldadd) -lpthread -lrt -lm
+task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
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
-- 
2.35.3

