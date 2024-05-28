Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0561FE3
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879894; cv=none; b=ZKcNfzD7dd9RxLzxxfAYhUMn0bxI5xalthHSYkQ6MdJn6atHQx3IOp85lvGdmNjQBBSFFRwe6Z3gPwpKpZMs+rPMdaQU8Fz/6xIv7VF/eN0CJE4NiTvrLDmXHmUTq4MjXGRKDF7EmeFJpDG0bhs/iOPzK0cj3rPK7oeKwqJN1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879894; c=relaxed/simple;
	bh=rTTJnxlV27opZuN26wwxjHFLqVQgLsh3wFq8kACOC6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roE+SyBDXqOse3QGLd5wiOYnxZYRyMeY+333h9LhDVimOG2QUwokrT6Tnu0z0z1V6zDY9arKCo9VXAq/yejTB/EgILO9I7+AgQezEFRB5qtlf3VO6mgeyUxfmmQmMq2BVeXALrnnUBX+d3HiCVBbSW7T8mMaOsumaRGzz0ljPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=P9cMNlX4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="P9cMNlX4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42108856c33so20530565e9.1
        for <xenomai@lists.linux.dev>; Tue, 28 May 2024 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1716879891; x=1717484691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ScqFzZNgpF8s3VCqSEDMBADVGcG3o5/aVoYMIgumdg=;
        b=P9cMNlX4wYJypvhtPXtPxCkZJ5s511IorrzTgu4i2iFdgrSmgVzHwNkHjLiwMZbA2Y
         77phnEjXys+sPguYqGhmBI2/GEm7f143PLa3n46J4RLSY4kzOqTjB59ASRN94WuS/1wa
         CGDSV94cEH4Ky3Cq6yjZetWCVKVP9/bOfWUfKueH7CfpemWppWuSeoAJQIu5buWexkSF
         NHCJTMKNLnRECbi//mjFmAHKatCHoPi6s0G2rCHXlncbr7NQXa7PfF7TrXtDwwEJnjpj
         ErqJ0zxD4yBFlpTiXev4mwVcp/I+wm8Yt2euvxZP2qSAXxqHod3dd10yahpRswTbSh6d
         3W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879891; x=1717484691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ScqFzZNgpF8s3VCqSEDMBADVGcG3o5/aVoYMIgumdg=;
        b=jrILbjM8gJQQSp1YyU0IZBYNWKB1mpoJnLj3Pi1dwJ31i15N42QHaOxmnmNtPGiyhb
         sZUtNuOIguNHloSrDRpP1w2zzusAvFKK0UxmFJujyxUV6DgN3RPQAtrA6s590ATwUKIt
         ZaQNU2oMtIl+/i+/9WIFG7Xql2DsDKZsTJOlu4vIWkUwiaP3oHymmHRUEzq48jqz7pQ4
         6ikhdXZXjNmA7J2P7s8fV9N1qEFLZLGbtUQU5jXXeH43+mYIAmYWOv0yXeqCX1DReJ4D
         CRZgdkFQ0pDxJbz23QCLBVRXLM9bHRQgRXLg7O8Oh8UuBFwPkLo51l70yKOcA52mh0bh
         GHVA==
X-Gm-Message-State: AOJu0Yw+d6MtIq/JJylbPY23JbTkNi1XtjjyRa/EJACPB8tscu0PKmfA
	k/Gkeh6IF4qgPmH7+VwIt+DOXaSMZQAxXWJlbMfq2usoo5GiheHyOKok6TTdUucI2M7kr5nTcDS
	9
X-Google-Smtp-Source: AGHT+IHgJdGTvHG98lEJfceAzMFbhoEXPl5kGR5y7GGShTX36aVRg673Ujg8sMC7IY9mOItf/t/tdQ==
X-Received: by 2002:a05:600c:1d19:b0:41c:a9:26b3 with SMTP id 5b1f17b1804b1-421081f1916mr95142345e9.19.1716879891029;
        Tue, 28 May 2024 00:04:51 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100eecbd4sm164340355e9.8.2024.05.28.00.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 00:04:50 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH 4/4] testsuite: smokey - new testcase alchemy/task-11
Date: Tue, 28 May 2024 09:01:40 +0200
Message-ID: <20240528070432.6669-5-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
References: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
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
index 3525dfa09..4beec1226 100644
--- a/testsuite/smokey/alchemytests/Makefile.am
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -32,7 +32,8 @@ test_PROGRAMS =				\
 		alchemytests_task7	\
 		alchemytests_task8	\
 		alchemytests_task9	\
-		alchemytests_task10
+		alchemytests_task10	\
+		alchemytests_task11
 
 alchemycppflags =			\
 	$(XENO_USER_CFLAGS)		\
@@ -133,3 +134,7 @@ alchemytests_task10_SOURCES = task-10.c
 alchemytests_task10_CPPFLAGS = $(alchemycppflags)
 alchemytests_task10_LDADD = $(alchemyldadd)
 alchemytests_task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task11_SOURCES = task-11.c
+alchemytests_task11_CPPFLAGS = $(alchemycppflags)
+alchemytests_task11_LDADD = $(alchemyldadd)
+alchemytests_task11_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index 9a937f3a0..9b2f3e947 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -24,7 +24,8 @@ static const char * const tests[] = {
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

