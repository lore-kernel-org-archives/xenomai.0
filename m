Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29591F5F6
	for <xenomai@lists.linux.dev>; Sat,  8 Jun 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717876429; cv=none; b=j7a4GU0CJC34NrFUemn54PQkWye0hNfECULOkxz45HYBODSPAnq+33dJ1M2vd1Ha75wTQI1zB5yV1dQxtsqZUGaoSyxiPuwKVcjr5rC8D9FS634QQSNEZpFkoGSXGAkSJI32XIpxMOw3pZjSP97AfIIOCg4fvAD/AFsS0JGh7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717876429; c=relaxed/simple;
	bh=6ZqURra2qTTJc8FuYfq3kclZQGiFowOzaZoqKkvoIh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st6KBsegpMHnSH4rPSS9twAMhwxc/myXFEWL9QtA3i0OfWzkKAEQfBy9ZAcKefUuRIK2EnuGDYXnQpyo1DikK52dMRHhdBXxQ22PkXBAMG59weKuw6BYFsmRmZaqcsm3dvav6uQ/o7Z2WtOo5Qt6tN4ATGmGBCLlXYEIitkttUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=RmHFNGEX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="RmHFNGEX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f089e35e7so1229500f8f.0
        for <xenomai@lists.linux.dev>; Sat, 08 Jun 2024 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1717876425; x=1718481225; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gANKBntAtGK5wT3dq5JQDnUQmkGPnqRpbW4Oq9gxkU=;
        b=RmHFNGEXan/kIGJn2q6LbU3Hy6RFkhaEOVN7f+cB6uEqIFcWmt595Oe1/8Mqj/vdjH
         eh3et6W7L9Q97nJyqG50qpaeNxOWjpnFa9Ms6QNvGypKgR0Lt4/OmROdzMSTwq3qOq89
         X+OQtPQoHcu/4MGvlxkBSnYlJWohZW3hUHD1PEn0sv+Gb+dXjEqDL0mDoOxtpO//gH2b
         sFVKEOohHbtWvXl8YujW8PgTZUsKBWmlGuOwwdYpIApaf/MecK9J1cOL3MR4wy4CrUqP
         30er4yy9fEZv7oyqUyACs9PDqIaUw/gGBnrSieKdNCX6RAShGH7y2jxe8FnCo/7SrqQC
         PpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717876425; x=1718481225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gANKBntAtGK5wT3dq5JQDnUQmkGPnqRpbW4Oq9gxkU=;
        b=WjmMRKwP+//IgEq65NegIR3kyA2dWZt6B03tUlz0ZD+TuQ+ml3JEMOMVR0vLZG0Gz7
         LN43Ekjmn/eun+zBpSmz6Yr6zpX0L5SMXe+UicP7QrofJr7HsWmaLCaNZH90v/oB3tAU
         MGIJnJ6wAeLHTbyjsdZdWZWCjDZV4SAMZJsQHIW44UOtKqQFavfqQrtYBCGoTuVGqfzf
         BkJX02lcMpoih1/7jBSMdocqS/rZQezOKzAa+msR6BG5e6L3ekrk3E3FrSOrpbcZbQAz
         kPaVXDE8kiCO+KIqgkclc+uaeAX99wJqElRKKUxMkTkHhkKBA4/6QAmSJ+vRHJ7ShZgp
         f11A==
X-Gm-Message-State: AOJu0YzHI2nyvhp1DYVnf4vzgwqVeAcXpAGC/n2jeu3lpFhmtAsh1zGR
	E0CCxzv5CVQTvzjAAqDWJxy/eiW2YQ0K+SiEnJpcpwIyNAIPEeoojg1yFgYqdguOrJU8AwTe0YF
	5
X-Google-Smtp-Source: AGHT+IEMPY0Unul636zVpsL5r64bMmFNeL4PKHWtgDdV3medJKWyjUV187fPX4/OAJP+T9lrg6eH7g==
X-Received: by 2002:a05:6000:a84:b0:35f:1f3c:b637 with SMTP id ffacd0b85a97d-35f1f3cb6f8mr89240f8f.3.1717876425124;
        Sat, 08 Jun 2024 12:53:45 -0700 (PDT)
Received: from localtoast.asozial.it-syndikat.org (212-186-38-205.cable.dynamic.surfer.at. [212.186.38.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c423932sm1149608f8f.114.2024.06.08.12.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 12:53:44 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v2 4/4] testsuite: smokey - new testcase alchemy/task-11
Date: Sat,  8 Jun 2024 21:52:52 +0200
Message-ID: <20240608195337.11137-5-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
References: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The testcase ensures the correct switching of the task period. If we
switch the period after a number of iterations, the current iteration
still needs to complete with the old period. The iterations following
that need to complete with the new period.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 testsuite/smokey/alchemytests/Makefile.am    |   7 +-
 testsuite/smokey/alchemytests/alchemytests.c |   3 +-
 testsuite/smokey/alchemytests/task-11.c      | 101 +++++++++++++++++++
 3 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/task-11.c

diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
index eba82f8ec..5fe481c29 100644
--- a/testsuite/smokey/alchemytests/Makefile.am
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -33,7 +33,8 @@ test_PROGRAMS =				\
 		alchemytests_task7	\
 		alchemytests_task8	\
 		alchemytests_task9	\
-		alchemytests_task10
+		alchemytests_task10	\
+		alchemytests_task11
 
 alchemycppflags =			\
 	$(XENO_USER_CFLAGS)		\
@@ -138,3 +139,7 @@ alchemytests_task10_SOURCES = task-10.c
 alchemytests_task10_CPPFLAGS = $(alchemycppflags)
 alchemytests_task10_LDADD = $(alchemyldadd)
 alchemytests_task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task11_SOURCES = task-11.c
+alchemytests_task11_CPPFLAGS = $(alchemycppflags)
+alchemytests_task11_LDADD = $(alchemyldadd)
+alchemytests_task11_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index 947fa37b9..177d59b9c 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -25,7 +25,8 @@ static const char * const tests[] = {
 	"alchemytests_task7",
 	"alchemytests_task8",
 	"alchemytests_task9",
-	"alchemytests_task10"
+	"alchemytests_task10",
+	"alchemytests_task11"
 };
 
 static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
diff --git a/testsuite/smokey/alchemytests/task-11.c b/testsuite/smokey/alchemytests/task-11.c
new file mode 100644
index 000000000..062c24219
--- /dev/null
+++ b/testsuite/smokey/alchemytests/task-11.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <copperplate/traceobj.h>
+#include <alchemy/task.h>
+#include <alchemy/timer.h>
+
+#define TEST_ITERATIONS (10)
+#define PERIOD_SWITCH_ITERATION (5)
+
+#define PERIOD_INITIAL (2000 * 1000)
+#define PERIOD_SWITCH (1000 * 1000)
+#define PERIOD_ERROR_MAX (5)
+
+static RT_TASK t_test;
+static ticks_t duration[TEST_ITERATIONS];
+
+static struct traceobj trobj;
+
+static int tseq[] = {
+	1, 2,
+	3, 4, 3, 4, 3, 4, 3, 4, 3, 4,
+	3, 4, 3, 4, 3, 4, 3, 4, 3, 4,
+	5, 6, 7
+};
+
+static void test_task(void *arg)
+{
+	(void)arg;
+
+	traceobj_enter(&trobj);
+
+	traceobj_mark(&trobj, 2);
+
+	rt_task_set_periodic(NULL, TM_NOW, PERIOD_INITIAL);
+
+	for (size_t i = 0; i < TEST_ITERATIONS; ++i) {
+		ticks_t start, end;
+		int ret;
+
+		traceobj_mark(&trobj, 3);
+
+		start = clockobj_get_time(&alchemy_clock);
+
+		if (i == PERIOD_SWITCH_ITERATION)
+			rt_task_set_periodic(NULL, TM_NOW, PERIOD_SWITCH);
+
+		ret = rt_task_wait_period(NULL);
+		traceobj_check(&trobj, ret, 0);
+
+		end = clockobj_get_time(&alchemy_clock);
+
+		duration[i] = end - start;
+
+		traceobj_mark(&trobj, 4);
+	}
+
+	traceobj_mark(&trobj, 5);
+
+	traceobj_exit(&trobj);
+}
+
+int main(int argc, char *const argv[])
+{
+	int ret;
+
+	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
+
+	ret = rt_task_create(&t_test, "test_task", 0, 99, 0);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 1);
+
+	ret = rt_task_start(&t_test, test_task, NULL);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_join(&trobj);
+
+	traceobj_mark(&trobj, 6);
+
+	for (size_t i = 0; i < TEST_ITERATIONS; ++i) {
+		ticks_t value, expect, diff, error;
+
+		expect = PERIOD_INITIAL;
+		if (i > PERIOD_SWITCH_ITERATION)
+			expect = PERIOD_SWITCH;
+
+		value = duration[i];
+
+		diff = value < expect ? (expect - value) : (value - expect);
+		error = (100 * diff) / expect;
+
+		traceobj_assert(&trobj, error <= PERIOD_ERROR_MAX);
+	}
+
+	traceobj_mark(&trobj, 7);
+
+	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
+
+	exit(0);
+}
-- 
2.45.0

