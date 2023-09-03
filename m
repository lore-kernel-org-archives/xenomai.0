Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E63D70
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202309031505006572753ae911f8aa08
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=C3U37rcc/Bj3r6AV7V6R5bkLYN9QPJBS62IGsShPJ/U=;
 b=OKeZS0hXUDp7OiZiQhfng6xYIk5KX3IC7RzBS4tX5RVgWz0n7Fg4XHWWYFlB89IoyDR9dx
 r+cpaUsm1qUw5GOfisXPFHZOvlngWtaQMhhfo3fxoN3Xc/e5tYMCvWRwlAzqyDjE0fpFT1cy
 7h2cQvbfA0kl9PZymtlSnGF7dMDvs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 06/20] testsuite/smokey: Remove VDSO test
Date: Sun,  3 Sep 2023 17:04:43 +0200
Message-Id: <f85ac99ca00533c6abf5933b8c9a9b533a8dfa56.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The Xenomai VDSO is about to be removed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                               |  1 -
 testsuite/smokey/Makefile.am               |  2 --
 testsuite/smokey/vdso-access/Makefile.am   |  9 -------
 testsuite/smokey/vdso-access/vdso-access.c | 31 ----------------------
 4 files changed, 43 deletions(-)
 delete mode 100644 testsuite/smokey/vdso-access/Makefile.am
 delete mode 100644 testsuite/smokey/vdso-access/vdso-access.c

diff --git a/configure.ac b/configure.ac
index a601f94cd3..86dd8ba4f8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1015,7 +1015,6 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/sched-tp/Makefile \
 	testsuite/smokey/setsched/Makefile \
 	testsuite/smokey/rtdm/Makefile \
-	testsuite/smokey/vdso-access/Makefile \
 	testsuite/smokey/posix-cond/Makefile \
 	testsuite/smokey/posix-mutex/Makefile \
 	testsuite/smokey/posix-clock/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index b7654682d5..c49a5d77f0 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -38,7 +38,6 @@ COBALT_SUBDIRS = 	\
 	sigdebug	\
 	timerfd		\
 	tsc		\
-	vdso-access 	\
 	xddp		\
 	y2038		\
 	alchemytests	\
@@ -84,7 +83,6 @@ DIST_SUBDIRS = 		\
 	sigdebug	\
 	timerfd		\
 	tsc		\
-	vdso-access 	\
 	xddp		\
 	y2038		\
 	alchemytests	\
diff --git a/testsuite/smokey/vdso-access/Makefile.am b/testsuite/smokey/vdso-access/Makefile.am
deleted file mode 100644
index 250ef08400..0000000000
--- a/testsuite/smokey/vdso-access/Makefile.am
+++ /dev/null
@@ -1,9 +0,0 @@
-
-noinst_LIBRARIES = libvdso-access.a
-
-libvdso_access_a_SOURCES = vdso-access.c
-
-libvdso_access_a_CPPFLAGS = 	\
-	@XENO_USER_CFLAGS@	\
-	-I$(top_srcdir)		\
-	-I$(top_srcdir)/include
diff --git a/testsuite/smokey/vdso-access/vdso-access.c b/testsuite/smokey/vdso-access/vdso-access.c
deleted file mode 100644
index 42c1b28f72..0000000000
--- a/testsuite/smokey/vdso-access/vdso-access.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * VDSO feature set testcase
- * by Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
- */
-#include <stdio.h>
-#include <time.h>
-#include <boilerplate/atomic.h>
-#include <cobalt/uapi/kernel/vdso.h>
-#include <smokey/smokey.h>
-
-smokey_test_plugin(vdso_access,
-		   SMOKEY_NOARGS,
-		   "Check VDSO access."
-);
-
-extern void *cobalt_umm_shared;
-
-extern struct xnvdso *cobalt_vdso;
-
-int run_vdso_access(struct smokey_test *t, int argc, char *const argv[])
-{
-	if (cobalt_umm_shared == NULL) {
-		warning("could not determine position of the VDSO segment");
-		return 1;
-	}
-
-	smokey_trace("VDSO: features detected: %llx",
-		     (long long)cobalt_vdso->features);
-
-	return 0;
-}
-- 
2.35.3

