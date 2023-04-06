Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA66EDF
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:24 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-501d3943f8eso1245994a12.1
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDkHemsx4WHAryJrPL+derkbnlGSpzqH8ukNPZN7ivc=;
        b=Yz3iIrFEJN+IjVMvWZW+iiD7LjQ6K797bi+Fb3WnimE1vUizM+vgLMoUNyn+JCLA20
         quYZ5K4twVkbD/p/iBAOA8D0np/eRA9ADut/rhhT6Wd1UztAGSh4yuXwhPoqWWTUBnZj
         2kyMPyjnXCLn6hm6cgR83sJ19u4kyqZofXCKGji1dfGoJPvemhxa3OUWsHzwKt1ZM6Vt
         RKFZdHOya31FGJUGnxaNjJ/X+fTaNq8REl69FhwTAPKkUYKbRHHgC1it7/GjSkZ/QE2v
         CdMlYZbxp5Z98m48oV6OeM+hE1KgcEWl9DS2iDVUogQHHH5GDLkY9qV+5nxViydhQ3Bz
         SACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDkHemsx4WHAryJrPL+derkbnlGSpzqH8ukNPZN7ivc=;
        b=emUtXjEcBSdI/HxxFybOUFUmDeD8KYB9Sf2GQgmvb2wu29In/NE6g/2a2QuuILmieL
         vRO+5saNhYqKtQWI6W62mz+YArq1i0M1wkSXtul28MWEAF5JflPoYqdhg/Mc1nPiXgEw
         iuC5oerWXBITXt3ANbvTW7QMssqSk6Q1ALEXpV1AuPX2nkBoL2UNrqA+KNtF49jwH4gH
         nIsPNiQVZswbVCQc4b5SlWldw4nHHia+kAjNuzCNnqc7l7aZtvFCXLTdt7DyiMnZ9UIo
         SsiidZ7j4onxCnVDsWywbD5MAK92ht8Wb2s9EeQEan8qlvbDg/Lftx5cNXhEWBeEhDR+
         Gu+g==
X-Gm-Message-State: AAQBX9fJcJNjOIm6MrtDAqDmyzkGduO2MJwF1kumoHGXGIB/V++hEysr
	D5K1fvZ5FQrr/AQBlZMex0jMBohax4pW5At1zI4=
X-Google-Smtp-Source: AKy350ZifRfXobxqZHwrWI0J4PrOmWQTaIKs07qn+bCVYP2UwXdmpurWaN4SPtB0uYA6tZWL1p6BYQ==
X-Received: by 2002:a05:6402:716:b0:4fe:1b62:4741 with SMTP id w22-20020a056402071600b004fe1b624741mr4912831edx.28.1680777263293;
        Thu, 06 Apr 2023 03:34:23 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:23 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 03/11] testsuite: Add a simple test driver for alchemytests
Date: Thu,  6 Apr 2023 12:33:33 +0200
Message-Id: <20230406103341.2914-4-aaron@sigma-star.at>
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

In their current shape, every alchemy test has to be a single
program and does not use the smokey test framework.

alchemytest_driver uses smokey and runs each test as new process.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/alchemytests/Makefile.am          | 11 +++
 testsuite/alchemytests/alchemytest_driver.c | 84 +++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 testsuite/alchemytests/alchemytest_driver.c

diff --git a/testsuite/alchemytests/Makefile.am b/testsuite/alchemytests/Makefile.am
index 35df0d49c2..9159a0b770 100644
--- a/testsuite/alchemytests/Makefile.am
+++ b/testsuite/alchemytests/Makefile.am
@@ -146,3 +146,14 @@ task10_SOURCES = task-10.c
 task10_CPPFLAGS = $(alchemycppflags)
 task10_LDADD = $(alchemyldadd) -lpthread -lrt -lm
 task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+alchemytest_driver_SOURCES = alchemytest_driver.c
+alchemytest_driver_CPPFLAGS =			\
+	$(XENO_USER_CFLAGS)			\
+	-I$(top_srcdir)/include
+alchemytest_driver_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytest_driver_LDADD =			\
+	../../lib/smokey/libsmokey@CORE@.la	\
+	@XENO_CORE_LDADD@		\
+	@XENO_USER_LDADD@		\
+	-lpthread -lrt
diff --git a/testsuite/alchemytests/alchemytest_driver.c b/testsuite/alchemytests/alchemytest_driver.c
new file mode 100644
index 0000000000..45323507d0
--- /dev/null
+++ b/testsuite/alchemytests/alchemytest_driver.c
@@ -0,0 +1,84 @@
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
+TEST(alarm1)
+TEST(buffer1)
+TEST(event1)
+TEST(heap1)
+TEST(heap2)
+TEST(mq1)
+TEST(mq2)
+TEST(mq3)
+TEST(mutex1)
+TEST(pipe1)
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
+TEST(task10)
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

