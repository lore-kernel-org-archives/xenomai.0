Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C80EDD
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:24 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5027eca217cso1007890a12.0
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpk1G5gCsLhs7eWZpcrp54PXSPXjoMop4HLx28hXuDs=;
        b=cCNG7mesE9LXApbrlzjQE3ZYiwYOUVntbbUspHkKLcK4yt4nzrOANuG1ZuUp63TVHL
         J3iM+uyC9N7Ztg3FetIn6tIfhoUwHNYWU5//jd+ltY3XwDO9papt70iuf9wnQBXOZ5x1
         3IzncPNHgFxiKAIILYNiAdOC9AVgqm0y6ic/84Arz+zKv8F3ogslzzZLgGZ+9m8lXzja
         zrgSQgX5p8P8yxVMb+CoAyWjH6o9yThQtudHpiBpFhvLmwrW9R9ZywPpH/OSKdxM/Jis
         xZuHJhVBd634lX2cBaILc4VPMM+RvnNcaLbTvOxzmw57pbzqHdTptv5tJqI7dTyBSeut
         pLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fpk1G5gCsLhs7eWZpcrp54PXSPXjoMop4HLx28hXuDs=;
        b=jR3TTeINTV+7QxDHBsKiJHhQWXWpDEnXWwbfkxdrje2CKIHtkiaI72O947rEC7PDxx
         idSq8DeHHeaRxs6ETDPWTSBeO9OCrH76/IRsvC6k1bz5xwuQoP/kLNVuFQdNWx9iAO7l
         8IH2c7+59/SJPFVf5pNAtb6SQUegPBiL0X5LbQUEHvGbWGwpQlOp5NkzADAFw3O2WEOh
         7mxXmHJElhkvljJ3Fnm7apWp3Dl2JmL/EN427HfkkToPhLS2Ij4G/dCK1DQYmRGwn1N+
         Qh/aIsBLygdwpPck7aV/lcTRfsb+pvCzwOFUthlMOa2k9rImFTat/0QluL2nOh/0h6jI
         D/wA==
X-Gm-Message-State: AAQBX9frwcS9My06ITZOS/HI42g9UqcePJh5MwVkd6YLIdi/cqgUhz7f
	p25kWVQbuOpx4ZUm5CIFCzGkwSWh4GtzORM850k=
X-Google-Smtp-Source: AKy350acP/VHPcYPZCu7Rlg7MUltmbampUHSrh5xy+Fkco1N1C50mCUAXtj+Uc+F5ZkUP6eDGVJ81A==
X-Received: by 2002:aa7:d5d1:0:b0:4fc:c644:6149 with SMTP id d17-20020aa7d5d1000000b004fcc6446149mr4750907eds.0.1680777262628;
        Thu, 06 Apr 2023 03:34:22 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:22 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 02/11] testsuite: Hook up alchemytests
Date: Thu,  6 Apr 2023 12:33:32 +0200
Message-Id: <20230406103341.2914-3-aaron@sigma-star.at>
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

Build them using Xenomai's build system.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 configure.ac                       |   1 +
 testsuite/Makefile.am              |   6 +-
 testsuite/alchemytests/Makefile.am | 148 +++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/alchemytests/Makefile.am

diff --git a/configure.ac b/configure.ac
index 3ce34048e6..36f4aa9933 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1045,6 +1045,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/x86io/Makefile
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
+	testsuite/alchemytests/Makefile \
 	utils/Makefile \
 	utils/hdb/Makefile \
 	utils/can/Makefile \
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 4932f6d33e..e027485fb6 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -7,7 +7,8 @@ SUBDIRS += 		\
 	gpiotest	\
 	spitest		\
 	switchtest	\
-	xeno-test
+	xeno-test	\
+	alchemytests
 endif
 
 DIST_SUBDIRS =		\
@@ -18,4 +19,5 @@ DIST_SUBDIRS =		\
 	smokey		\
 	spitest		\
 	switchtest	\
-	xeno-test
+	xeno-test	\
+	alchemytests
diff --git a/testsuite/alchemytests/Makefile.am b/testsuite/alchemytests/Makefile.am
new file mode 100644
index 0000000000..35df0d49c2
--- /dev/null
+++ b/testsuite/alchemytests/Makefile.am
@@ -0,0 +1,148 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = alchemytest_driver \
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
+alchemycppflags = 				\
+	$(XENO_USER_CFLAGS)		\
+	-I$(top_srcdir)/include
+
+alchemyldadd = 					\
+	../../lib/alchemy/libalchemy@CORE@.la		\
+	../../lib/copperplate/libcopperplate@CORE@.la	\
+	@XENO_CORE_LDADD@ 			\
+	@XENO_USER_LDADD@			\
+	-lpthread -lrt -lm
+
+alarm1_SOURCES = alarm-1.c
+alarm1_CPPFLAGS = $(alchemycppflags)
+alarm1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+alarm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+event1_SOURCES = event-1.c
+event1_CPPFLAGS = $(alchemycppflags)
+event1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+event1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+heap1_SOURCES = heap-1.c
+heap1_CPPFLAGS = $(alchemycppflags)
+heap1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+heap1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+heap2_SOURCES = heap-2.c
+heap2_CPPFLAGS = $(alchemycppflags)
+heap2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+heap2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+buffer1_SOURCES = buffer-1.c
+buffer1_CPPFLAGS = $(alchemycppflags)
+buffer1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+buffer1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+mutex1_SOURCES = mutex-1.c
+mutex1_CPPFLAGS = $(alchemycppflags)
+mutex1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+mutex1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+pipe1_SOURCES = pipe-1.c
+pipe1_CPPFLAGS = $(alchemycppflags)
+pipe1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+pipe1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+mq1_SOURCES = mq-1.c
+mq1_CPPFLAGS = $(alchemycppflags)
+mq1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+mq2_SOURCES = mq-2.c
+mq2_CPPFLAGS = $(alchemycppflags)
+mq2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+mq3_SOURCES = mq-3.c
+mq3_CPPFLAGS = $(alchemycppflags)
+mq3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+sem1_SOURCES = sem-1.c
+sem1_CPPFLAGS = $(alchemycppflags)
+sem1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+sem2_SOURCES = sem-2.c
+sem2_CPPFLAGS = $(alchemycppflags)
+sem2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task1_SOURCES = task-1.c
+task1_CPPFLAGS = $(alchemycppflags)
+task1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task2_SOURCES = task-2.c
+task2_CPPFLAGS = $(alchemycppflags)
+task2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task3_SOURCES = task-3.c
+task3_CPPFLAGS = $(alchemycppflags)
+task3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task4_SOURCES = task-4.c
+task4_CPPFLAGS = $(alchemycppflags)
+task4_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task5_SOURCES = task-5.c
+task5_CPPFLAGS = $(alchemycppflags)
+task5_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task6_SOURCES = task-6.c
+task6_CPPFLAGS = $(alchemycppflags)
+task6_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task7_SOURCES = task-7.c
+task7_CPPFLAGS = $(alchemycppflags)
+task7_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task8_SOURCES = task-8.c
+task8_CPPFLAGS = $(alchemycppflags)
+task8_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task9_SOURCES = task-9.c
+task9_CPPFLAGS = $(alchemycppflags)
+task9_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+task10_SOURCES = task-10.c
+task10_CPPFLAGS = $(alchemycppflags)
+task10_LDADD = $(alchemyldadd) -lpthread -lrt -lm
+task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
-- 
2.35.3

