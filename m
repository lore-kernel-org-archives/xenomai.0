Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE438DEA
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 13:53:15 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so214681866b.0
        for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 06:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695217994; x=1695822794; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+M+maJnKF//10+0tzsDj3+FzrVjfCtQdxtJLtaVrvM=;
        b=fDilmp03m/BqQjmppuodL19BePTNz1yFMK9glZLVCuuJQZVQSoY6hCdH64X7y8w0zY
         /IjLXogQTJNhnVJvAoiovIt0ofU5obO6Wzr62PeuwztP46bY2k8yzY9EC78D2hDnlLVu
         ZavBaTtZ0thtw1GTM7DLjBHAEG6IV+ApDEihnDSZP69rncF5rXXYdGAa56K+Z1QrOPxg
         5utLqafZ2msR+/EyVwNJawTvmZOqg1eJZJmBatbyVGhY+vuB39OB9UQuGLjyzsrja5V5
         JRGF5hMHF5xKNHWA5YxYk7Zwykkx3C+ofgxRGb+iTIG/Vi7YFLkh2Vn5RxffEeKeEGHu
         8TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217994; x=1695822794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+M+maJnKF//10+0tzsDj3+FzrVjfCtQdxtJLtaVrvM=;
        b=dnJy9xavWlKBweDUPpMjC3ae6CE28x74hugUkmbpQ26WAMas5yqJ2Ok8wrxjp/DULP
         Zh8ikLcWdp6n0TLs1FcAs6mH/4nTcaHJZX7/ALhFb5BjkJxfOvFESxyvcNI3x3Vmtbsv
         bX/eUBQJELDSPrLwzvsA6s3sOoBdz5P1Hs1LKjXR6QuxRaYBcUjDNU+c3jUb9/ESm1Jv
         pu5UN/kyUVBT63CBQRm7lBVbxAd/Xspktjmxc/D/TbN9cuY4MP1dcyo06g3Xgi0lQzUx
         cCpyYRRW81S45zB9JTHtC2oFmZ+DwW1730a9d+mLwo+xdahhuKqrcLHu1UH/eUTMVjkU
         sxNA==
X-Gm-Message-State: AOJu0YzKTtf0olh6oXj4OsdWhcuF7MKzy56YkmRrQGg9iqYTk0YdnilX
	/jg0o/1+zcUmFa5XIsFcu7nW0Vdqnk0/75iT3zE=
X-Google-Smtp-Source: AGHT+IFw6cqi8BKzzPlQzAHy2OIiuqkyDXdAbbMNeJd5MzpoWyXPempZyJhmtzHxcGHyr7fAKyIZ9Q==
X-Received: by 2002:a17:907:1c8e:b0:9a4:11a3:c32b with SMTP id nb14-20020a1709071c8e00b009a411a3c32bmr8335412ejc.29.1695217994265;
        Wed, 20 Sep 2023 06:53:14 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id mc17-20020a170906eb5100b0098733a40bb7sm9324008ejb.155.2023.09.20.06.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:53:14 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 5/5] testsuite: Drop skin test "drivers"
Date: Wed, 20 Sep 2023 15:52:53 +0200
Message-Id: <20230920135253.5842-6-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230920135253.5842-1-aaron@sigma-star.at>
References: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
 <20230920135253.5842-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each skin-testsuite now has its own respective smokey test case, which runs
all underlying tests and returns appropriately.

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/Makefile.am     | 12 -------
 .../smokey/alchemytests/alchemytests_driver.c | 33 -------------------
 testsuite/smokey/psostests/Makefile.am        | 10 ------
 testsuite/smokey/psostests/psostests_driver.c | 33 -------------------
 testsuite/smokey/vxworkstests/Makefile.am     | 10 ------
 .../smokey/vxworkstests/vxworkstests_driver.c | 33 -------------------
 6 files changed, 131 deletions(-)
 delete mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
 delete mode 100644 testsuite/smokey/psostests/psostests_driver.c
 delete mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c

diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
index 68255b111..3525dfa09 100644
--- a/testsuite/smokey/alchemytests/Makefile.am
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -11,7 +11,6 @@ libalchemytests_a_CPPFLAGS =	\
 CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
 test_PROGRAMS =				\
-		alchemytests		\
 		alchemytests_alarm1	\
 		alchemytests_buffer1	\
 		alchemytests_event1	\
@@ -46,17 +45,6 @@ alchemyldadd = 							\
 	@XENO_USER_LDADD@					\
 	-lpthread -lrt -lm
 
-alchemytests_SOURCES = alchemytests_driver.c
-alchemytests_CPPFLAGS =				\
-	$(XENO_USER_CFLAGS)			\
-	-I$(top_srcdir)/include
-alchemytests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
-alchemytests_LDADD =				\
-	../../../lib/smokey/libsmokey@CORE@.la	\
-	@XENO_CORE_LDADD@			\
-	@XENO_USER_LDADD@			\
-	-lpthread -lrt
-
 alchemytests_alarm1_SOURCES = alarm-1.c
 alchemytests_alarm1_CPPFLAGS = $(alchemycppflags)
 alchemytests_alarm1_LDADD = $(alchemyldadd)
diff --git a/testsuite/smokey/alchemytests/alchemytests_driver.c b/testsuite/smokey/alchemytests/alchemytests_driver.c
deleted file mode 100644
index 7cacbb399..000000000
--- a/testsuite/smokey/alchemytests/alchemytests_driver.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <error.h>
-#include <libgen.h>
-#include <smokey/smokey.h>
-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-int main(int argc, char *const argv[])
-{
-	struct smokey_test *t;
-	int ret, fails = 0;
-
-	if (pvlist_empty(&smokey_test_list))
-		return 0;
-
-	for_each_smokey_test(t) {
-		ret = t->run(t, argc, argv);
-		if (ret) {
-			fails++;
-			if (smokey_keep_going)
-				continue;
-			if (smokey_verbose_mode)
-				error(1, -ret, "test %s failed", t->name);
-			return 1;
-		}
-		smokey_note("%s OK", t->name);
-	}
-
-	return fails != 0;
-}
diff --git a/testsuite/smokey/psostests/Makefile.am b/testsuite/smokey/psostests/Makefile.am
index ef4a23123..10b17d10d 100644
--- a/testsuite/smokey/psostests/Makefile.am
+++ b/testsuite/smokey/psostests/Makefile.am
@@ -11,7 +11,6 @@ libpsostests_a_CPPFLAGS = 	\
 CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
 test_PROGRAMS =			\
-		psostests       \
 		psostests_mq1	\
 		psostests_mq2	\
 		psostests_mq3	\
@@ -48,15 +47,6 @@ psosldadd =							\
 	@XENO_USER_LDADD@					\
 	-lpthread -lrt -lm
 
-psostests_SOURCES = psostests_driver.c
-psostests_CPPFLAGS = $(psoscppflags)
-psostests_LDADD =						\
-	../../../lib/smokey/libsmokey@CORE@.la			\
-	@XENO_CORE_LDADD@ 					\
-	@XENO_USER_LDADD@					\
-	-lpthread -lrt
-psostests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
-
 psostests_mq1_SOURCES = mq-1.c
 psostests_mq1_CPPFLAGS = $(psoscppflags)
 psostests_mq1_LDADD = $(psosldadd)
diff --git a/testsuite/smokey/psostests/psostests_driver.c b/testsuite/smokey/psostests/psostests_driver.c
deleted file mode 100644
index c931d196d..000000000
--- a/testsuite/smokey/psostests/psostests_driver.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <error.h>
-#include <libgen.h>
-#include <smokey/smokey.h>
-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-int main(int argc, char *const argv[])
-{
-       struct smokey_test *t;
-       int ret, fails = 0;
-
-       if (pvlist_empty(&smokey_test_list))
-               return 0;
-
-       for_each_smokey_test(t) {
-               ret = t->run(t, argc, argv);
-               if (ret) {
-                       fails++;
-                       if (smokey_keep_going)
-                               continue;
-                       if (smokey_verbose_mode)
-                               error(1, -ret, "test %s failed", t->name);
-                       return 1;
-               }
-               smokey_note("%s OK", t->name);
-       }
-
-       return fails != 0;
-}
diff --git a/testsuite/smokey/vxworkstests/Makefile.am b/testsuite/smokey/vxworkstests/Makefile.am
index a0aa9df76..3233cf8c7 100644
--- a/testsuite/smokey/vxworkstests/Makefile.am
+++ b/testsuite/smokey/vxworkstests/Makefile.am
@@ -11,7 +11,6 @@ libvxworkstests_a_CPPFLAGS =	\
 CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
 test_PROGRAMS =				\
-		vxworkstests		\
 		vxworkstests_lst1	\
 		vxworkstests_msgQ1	\
 		vxworkstests_msgQ2	\
@@ -36,15 +35,6 @@ vxworksldadd = 							\
 	@XENO_USER_LDADD@					\
 	-lpthread -lrt -lm
 
-vxworkstests_SOURCES = vxworkstests_driver.c
-vxworkstests_CPPFLAGS = $(vxworkscppflags)
-vxworkstests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
-vxworkstests_LDADD =				\
-	../../../lib/smokey/libsmokey@CORE@.la	\
-	@XENO_CORE_LDADD@ 			\
-	@XENO_USER_LDADD@			\
-	-lpthread -lrt
-
 vxworkstests_lst1_SOURCES = lst-1.c
 vxworkstests_lst1_CPPFLAGS = $(vxworkscppflags)
 vxworkstests_lst1_LDADD = $(vxworksldadd)
diff --git a/testsuite/smokey/vxworkstests/vxworkstests_driver.c b/testsuite/smokey/vxworkstests/vxworkstests_driver.c
deleted file mode 100644
index 7cacbb399..000000000
--- a/testsuite/smokey/vxworkstests/vxworkstests_driver.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <error.h>
-#include <libgen.h>
-#include <smokey/smokey.h>
-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-int main(int argc, char *const argv[])
-{
-	struct smokey_test *t;
-	int ret, fails = 0;
-
-	if (pvlist_empty(&smokey_test_list))
-		return 0;
-
-	for_each_smokey_test(t) {
-		ret = t->run(t, argc, argv);
-		if (ret) {
-			fails++;
-			if (smokey_keep_going)
-				continue;
-			if (smokey_verbose_mode)
-				error(1, -ret, "test %s failed", t->name);
-			return 1;
-		}
-		smokey_note("%s OK", t->name);
-	}
-
-	return fails != 0;
-}
-- 
2.35.3

