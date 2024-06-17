Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB8192B7A
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615949; cv=none; b=TZpmA8b4JoacsPlyp2XziSF/cPk/LCNUviRAFwFV4G/PKen/CptZ5Ai0dBeq+jM1KDi/GRC6NIyhlg5fwhEi0um08U34seSeGxlVhkYV6Lj/yXCN2YgWHT6zZmTOfx1zLCGkruWAg7DEwCaN4LULTJZTzZL+boHCasls20bzuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615949; c=relaxed/simple;
	bh=qHjPUtns6gJQ4hg5abMb7wMeGs2Ir9aA2fKCFavCgR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0tEA82F8G47EgIlRD7n+v+dAc+qHyFcuqQmu7yZW9/Mu0/FPIlI6q5giDjYVfRzCCTftnzYgmb32pSrDfojkHPl79uRtMk0cAZm4dFsikL4pwKaNCoIsClvFdXdBiSZ3ZGWptVsm33uGbt657WhctvwSpengBe7Wzd5A/dJnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=joO5Yh8M; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="joO5Yh8M"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebdfe26242so47475651fa.0
        for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1718615946; x=1719220746; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IrlTA6TypBaD1KUVeoVcO3IiqlYgNmMXGEm04El5FE=;
        b=joO5Yh8Ml7odJWTZF53slOfVGlGKayLlhWK4y3tCtiy8ZJ0Nh3woAj19mmHwIATe1H
         ZQhNEdjnWnn3ANs4ccB6Y/aP6LCutEZjWQmA53xrMNnGz/J6copQx9gvrY8yZfYPxL35
         XbcQxvt3ld2zHev5QMxGcv33CMKLT3bbu4HjOXJukEPl6ayNWi8/Bw/WjoW+eJ9yCPsR
         gyXa3LJS+7fv3XYOxY5PiRfa55FiX2pA/3HzphqFPRHcgq19UPREAWynS1qiCp+Fn4x6
         7J+i4yzNnoc0W9LX54ln4VoTtLSLqvlegntXsZtbCAsP8IPhooFe61SrXu1DK/he5ACq
         AZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615946; x=1719220746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IrlTA6TypBaD1KUVeoVcO3IiqlYgNmMXGEm04El5FE=;
        b=YJxlq3XCz2t/Oh5GAXrVKFKyu+wL3LeX1kfg7uR/MdYpzm7+AkSxMVojUyUH6jOV/R
         9jtQuJbgjQjuPbHq6Ht3NtsyUUuxMiXEEXVJqc6G0UB7ON5Qz/s5NonRo5DaBa0vjoe8
         rMjkH3l4BcV+8xS6rZtV2fb2vXGWUvjnslX9F5yUxvCQ4fyxI79j5mtvfsxDUA+iBluF
         UhxwJCSvh6FwINcuVvu/fTeUFRl/h3JrjsQwDgVwqiM1TNngAq7HMsvNUDyVfAYMS22D
         sY2mEeT6OcVBo6rjDyE5GboXkbfUyImstxc0Z2DnmwupQ0RothT0EEXF2Cky2kLNV0hM
         AIbA==
X-Gm-Message-State: AOJu0YwP73ddFF9AVXChcpmTrG2/93d7LM9ya28Gep+mTtxVkMj6v3zP
	MPWATmZF68sR9KE3E5GreYs+sUjMuU8yXZesAG+6lYidcL42CBXPMs2X8+JNvC4p+vhOAXM7EZr
	F
X-Google-Smtp-Source: AGHT+IFMn2X9sqCC7biScCDgWLwcbGQn1w70n2tQq/GwbMgBNJTw/Yx+2VoH32WntvwfG0jvn5oIWQ==
X-Received: by 2002:a2e:7a01:0:b0:2ec:27e6:39ba with SMTP id 38308e7fff4ca-2ec27e63bc6mr28229011fa.53.1718615945805;
        Mon, 17 Jun 2024 02:19:05 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eeff53sm75591125ad.181.2024.06.17.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:19:05 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 4/4] testsuite: smokey - new testcase alchemy/task-11
Date: Mon, 17 Jun 2024 11:16:54 +0200
Message-ID: <20240617091654.66342-5-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
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
2.45.1

