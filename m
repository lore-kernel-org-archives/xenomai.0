Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD43224
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:28 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50263dfe37dso5770851a12.0
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gBYseKLA/6syLDb1ZYnwGZFvzuuqBkNN1SjoaMU6xA=;
        b=nvozf3Y/lKCVlrTyaK6JHVOxgAMoDbdapuPEi5VFo36x54jKaMn1CwkHGaFlpG1f50
         vsCcTbjA4X5SizyY1wUAVahudVsE98oGk++3uJO3jDAWPEHlw2VcpALkN9KD/vqCADmd
         k7f3OSZ49zAAHpGE2zAd2jG5CPzWKq4wq7WKMvfBWCDbo4LyQd6eoBMCHSemAtfDTw18
         QNBlNj3o6aP+vn4AYzs0GzdB/E2S+AvKoiNembZ9hTojc9lNZheSlMjT+ulDzfaYTRLm
         TqkZOFFdNAzJcSljY15rsVWOZVfnn3xmhIO6i8rbtJdUer6ZWYVuZi2q1cm2GNVxR1qZ
         24vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gBYseKLA/6syLDb1ZYnwGZFvzuuqBkNN1SjoaMU6xA=;
        b=CxiTwApg4fCUJxAYpMAz5yd+aVM8Hec1EtfErHCw3biiX2DJZtH94xjk2UmIC4j8nZ
         8S3gfDjbchN8jRr81O4WV+qhimIKZQNnEcUV3qiGb4haoK9U1CBf/B68zfS3Fj3aZt0e
         OtODYorAd+AKihACzfMUabIqm4ALtPNKelu38Ogo1MJ1Ajsi9ZHR1w2+5jEHdUa1VvbP
         F0YMmq5Hi9VYcZmr1IjkfRSLeUpdVKPAFjZ4f4HdcUl7wSJwe26Lc7+8+PIq3MJTmMRC
         rknzE32TMT6MOSqIVnGVNXgWwuhZ8MnmQVdW1lMO109M9VbHaxm5laLhQTWTQ+vIbxkL
         y0Xw==
X-Gm-Message-State: AAQBX9cDGTDCZoYo69mf+9YhaQVYc8j09gfKre5BlQthy5nwZ8f5oCQi
	lv/JOwmn0iZ/dP+nCyo4f7+Sa8A2C0xECa//tvs=
X-Google-Smtp-Source: AKy350ZJ8gkvYlyCacIJpoul7vulb4PNDHnStd+blTD86FOAOFBjNQhQb9+/WEnijSUwari9Vof6gg==
X-Received: by 2002:aa7:cb86:0:b0:4fb:5fe1:bc3b with SMTP id r6-20020aa7cb86000000b004fb5fe1bc3bmr4256148edt.0.1680777266835;
        Thu, 06 Apr 2023 03:34:26 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:26 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 08/11] testsuite: Add a simple test driver for psostests
Date: Thu,  6 Apr 2023 12:33:38 +0200
Message-Id: <20230406103341.2914-9-aaron@sigma-star.at>
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

Just like for alchemytests.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/psostests/Makefile.am       | 15 ++++-
 testsuite/psostests/psostest_driver.c | 85 +++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 testsuite/psostests/psostest_driver.c

diff --git a/testsuite/psostests/Makefile.am b/testsuite/psostests/Makefile.am
index 9e8aef62b7..0a069837bc 100644
--- a/testsuite/psostests/Makefile.am
+++ b/testsuite/psostests/Makefile.am
@@ -2,7 +2,8 @@ testdir = @XENO_TEST_DIR@
 
 CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
-test_PROGRAMS = mq1	\
+test_PROGRAMS = psostest_driver \
+		mq1	\
 		mq2	\
 		mq3	\
 		pt1	\
@@ -151,3 +152,15 @@ task9_SOURCES = task-9.c
 task9_CPPFLAGS = $(psoscppflags)
 task9_LDADD = $(psosldadd) -lpthread -lrt -lm
 task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+psostest_driver_SOURCES = psostest_driver.c
+psostest_driver_CPPFLAGS =			\
+	$(XENO_USER_CFLAGS)			\
+	-I$(top_srcdir)/include
+psostest_driver_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+psostest_driver_LDADD =			\
+	../../lib/psos/libpsos@CORE@.la		\
+	../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@		\
+	@XENO_USER_LDADD@		\
+	-lpthread -lrt
diff --git a/testsuite/psostests/psostest_driver.c b/testsuite/psostests/psostest_driver.c
new file mode 100644
index 0000000000..0f076e1bc6
--- /dev/null
+++ b/testsuite/psostests/psostest_driver.c
@@ -0,0 +1,85 @@
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
+TEST(mq1)
+TEST(mq2)
+TEST(mq3)
+TEST(pt1)
+TEST(rn1)
+TEST(sem1)
+TEST(sem2)
+TEST(task1)
+TEST(task2)
+TEST(task3)
+TEST(task4)
+TEST(task5)
+TEST(task6)
+TEST(task7)
+TEST(task8)
+TEST(task9)
+TEST(tm1)
+TEST(tm2)
+TEST(tm3)
+TEST(tm4)
+TEST(tm5)
+TEST(tm6)
+TEST(tm7)
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
-- 
2.35.3

