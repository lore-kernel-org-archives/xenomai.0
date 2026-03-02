Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021C3016F5
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444298; cv=none; b=Vp7185Qek1t++0HqrKYdykpxQ3q/GXWQtELJWZV7O1JRm3yD/rw08wQeV8qTTNxaT8+pjZwJu9TKedLxINhUEX0IaqIjBZK+KcAdvRDuFc5YLoRDA84Z0o/WUJsmgcrbrDHnlAQ6mz1NNwCulhFcxyu7Y5Cv+MsHjOQilggRhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444298; c=relaxed/simple;
	bh=C0aHAWPdfuL9Y0Lnky0CFHB5Szm4xCph3Sw2zhWslZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWLYfI9GowIWU5953mwy68SlJJWV2/9wIbKn2o9d9/u5cvL7wt9ikFsHDBi752uDQflK74qRId9FMR79QpQXLleAmhKMlgIjMABu7ILs6FISSpyHwlsOkT6FEu9pntUvZAc1b53KhVeUsZVyySa8m7VEzYhaIVJ6uHtFkOQvAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bL9OD5mz; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bL9OD5mz"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260302093805f798ef5b690002079a
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Zy7GeLusv8JaNLIoUSmiITGnarxkyvVf2fDDTMH8KPQ=;
 b=bL9OD5mzY4LE7vpRDkYbK306f1hG96/dtySNXAIkr7NkMfc+5sBmD+X/xnWSrEe9mx7aI7
 sFCGzm8v1sSdQwSwzeqz9AtG25u+L0IjNcndNGrXu6+AmH2NpZS/sN/MkgoOkWyYcEULX6WH
 77C/E2OOYzeTb5PRKNTEZ7BoE87mu3ABaTS5TBJjrZ7fju/uko/2QWLiRrkb36N9axyio2UC
 kzZiBRc4NvTamUHETFvORtp3W5gHDXWyYxA+mHZHdZwZPJLPRn1rffcnpV0bYuttranReW+m
 aerRQxiomAM7tdHFNMGmLl/ZN83OKrzw6u5prPeCcO/VT7RWfe6eGGHQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:00 +0100
Subject: [PATCH v2 01/20] lib/cobalt: Introduce cond.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-1-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some code will be re-used later by the time64_t compile unit. Move that
code into cond.h, so code duplication is avoided.

No modifications to the code itself.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/Makefile.am |  1 +
 lib/cobalt/cond.c      | 67 ++-------------------------------------
 lib/cobalt/cond.h      | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 65 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index ed7e503899f4852388fb3bf204bfe91936009d74..b1098413fbf3a8f6a5f0a85d6aceb9916b14149a 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -1,6 +1,7 @@
 pkgconfigdir = $(libdir)/pkgconfig
 
 noinst_HEADERS =	\
+	cond.h		\
 	current.h	\
 	umm.h		\
 	internal.h
diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 2d11f768edc0fe4e89944a96333d2dd76d174172..7be7fca01f53930f8504945206b2ee6ba6be1ba5 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -20,6 +20,8 @@
 #include <string.h>
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
+
+#include "cond.h"
 #include "current.h"
 #include "internal.h"
 
@@ -147,32 +149,6 @@ COBALT_IMPL(int, pthread_cond_init, (pthread_cond_t *cond,
 	return 0;
 }
 
-static int __attribute__((cold))
-	cobalt_cond_autoinit_type(const pthread_cond_t *cond)
-{
-	static const pthread_cond_t cond_initializer =
-		PTHREAD_COND_INITIALIZER;
-
-	return memcmp(cond, &cond_initializer, sizeof(cond_initializer)) == 0 ?
-		0 : -1;
-}
-
-static int __attribute__((cold))
-	cobalt_cond_doautoinit(union cobalt_cond_union *ucond)
-{
-	if (cobalt_cond_autoinit_type(&ucond->native_cond) < 0)
-		return EINVAL;
-
-	return __COBALT(pthread_cond_init(&ucond->native_cond, NULL));
-}
-
-static inline int cobalt_cond_autoinit(union cobalt_cond_union *ucond)
-{
-	if (ucond->shadow_cond.magic != COBALT_COND_MAGIC)
-		return cobalt_cond_doautoinit(ucond);
-	return 0;
-}
-
 /**
  * @fn int pthread_cond_destroy(pthread_cond_t *cond)
  * @brief Destroy a condition variable
@@ -208,45 +184,6 @@ COBALT_IMPL(int, pthread_cond_destroy, (pthread_cond_t *cond))
 	return -XENOMAI_SYSCALL1( sc_cobalt_cond_destroy, _cond);
 }
 
-struct cobalt_cond_cleanup_t {
-	struct cobalt_cond_shadow *cond;
-	struct cobalt_mutex_shadow *mutex;
-	unsigned count;
-	int err;
-};
-
-static void __pthread_cond_cleanup(void *data)
-{
-	struct cobalt_cond_cleanup_t *c = (struct cobalt_cond_cleanup_t *)data;
-	xnhandle_t cur = cobalt_get_current();
-	int err;
-
-	/* if we still own the mutex, cond_wait_prologue wasn't called yet */
-	if (xnsynch_fast_owner_check(mutex_get_ownerp(c->mutex), cur) == 0)
-		return;
-
-	do {
-		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue,
-				       c->cond, c->mutex);
-	} while (err == -EINTR);
-
-	c->mutex->lockcnt = c->count;
-}
-
-static inline int do_sc_cond_wait_prologue(struct cobalt_cond_shadow *cnd,
-					   struct cobalt_mutex_shadow *mx,
-					   int *err, int timed,
-					   const struct timespec *abstime)
-{
-#ifdef __USE_TIME_BITS64
-	long sc_nr = sc_cobalt_cond_wait_prologue64;
-#else
-	long sc_nr = sc_cobalt_cond_wait_prologue;
-#endif
-
-	return XENOMAI_SYSCALL5(sc_nr, cnd, mx, err, timed, abstime);
-}
-
 /**
  * Wait on a condition variable.
  *
diff --git a/lib/cobalt/cond.h b/lib/cobalt/cond.h
new file mode 100644
index 0000000000000000000000000000000000000000..88b252cb72590b514f95a31c8d8849b3e4f3856f
--- /dev/null
+++ b/lib/cobalt/cond.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: LGPL-2.0-or-later */
+
+/*
+ * Copyright (C) 2026 Florian Bezdeka <florian.bezdeka@siemens.com>.
+ * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
+ */
+
+#ifndef _LIB_COBALT_COND_H
+#define _LIB_COBALT_COND_H
+
+#include "current.h"
+#include "internal.h"
+
+#include <asm/xenomai/syscall.h>
+#include <cobalt/uapi/cond.h>
+
+#include <string.h>
+#include <pthread.h>
+
+struct cobalt_cond_cleanup_t {
+	struct cobalt_cond_shadow *cond;
+	struct cobalt_mutex_shadow *mutex;
+	unsigned count;
+	int err;
+};
+
+static int __attribute__((cold))
+cobalt_cond_autoinit_type(const pthread_cond_t *cond)
+{
+	static const pthread_cond_t cond_initializer = PTHREAD_COND_INITIALIZER;
+
+	return memcmp(cond, &cond_initializer, sizeof(cond_initializer)) == 0 ?
+		       0 :
+		       -1;
+}
+
+static int __attribute__((cold))
+cobalt_cond_doautoinit(union cobalt_cond_union *ucond)
+{
+	if (cobalt_cond_autoinit_type(&ucond->native_cond) < 0)
+		return EINVAL;
+
+	return __COBALT(pthread_cond_init(&ucond->native_cond, NULL));
+}
+
+static inline int cobalt_cond_autoinit(union cobalt_cond_union *ucond)
+{
+	if (ucond->shadow_cond.magic != COBALT_COND_MAGIC)
+		return cobalt_cond_doautoinit(ucond);
+	return 0;
+}
+
+static void __pthread_cond_cleanup(void *data)
+{
+	struct cobalt_cond_cleanup_t *c = (struct cobalt_cond_cleanup_t *)data;
+	xnhandle_t cur = cobalt_get_current();
+	int err;
+
+	/* if we still own the mutex, cond_wait_prologue wasn't called yet */
+	if (xnsynch_fast_owner_check(mutex_get_ownerp(c->mutex), cur) == 0)
+		return;
+
+	do {
+		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, c->cond,
+				       c->mutex);
+	} while (err == -EINTR);
+
+	c->mutex->lockcnt = c->count;
+}
+
+static inline int do_sc_cond_wait_prologue(struct cobalt_cond_shadow *cnd,
+					   struct cobalt_mutex_shadow *mx,
+					   int *err, int timed,
+					   const struct timespec *abstime)
+{
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_cond_wait_prologue64;
+#else
+	long sc_nr = sc_cobalt_cond_wait_prologue;
+#endif
+
+	return XENOMAI_SYSCALL5(sc_nr, cnd, mx, err, timed, abstime);
+}
+
+#endif //_LIB_COBALT_COND_H

-- 
2.53.0

