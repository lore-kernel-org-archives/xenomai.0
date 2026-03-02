Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F62741B5
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444301; cv=none; b=ocjGq4iAdXTMi2VWNnD8h7AMzau3xecTE6d9BXtSDWmDQZnqinST+h02PBlk/eQ2kB5eGkDbfhYDE19ObN/PdPWaNUgUr3H4eUVLAKxMKUfQk00Os+NmV9uobjpLGKsiM3xIUHAAfhksKeVYdkXOwlp8Qopt6MNW2S6UdzTyNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444301; c=relaxed/simple;
	bh=5d0IABdgKq4vh4QFQfvoVorF1jQKwc31WldJGPH7ejg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LY/+JYrReDkux909nsNTjKO97Ugpl08TXcpSHldI+iSB0YZMB05hxqtLZvO/6bLaW/CXcj/swMsOSAv2Ti+4QXImuR2YBHTPdEM5H4Zc1orS0rhRjYpCAC3Jr+phiLjsfd30QttS30hLw/iC6yjeYPl5yDiHs7bdOo42Ls40jDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZqfmQ/t5; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZqfmQ/t5"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202603020938074c261e5f4f000207ce
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=buzcy5UuYOCbJ4nKeMgiVaGn4AOngXFwsjLHDlO3ac0=;
 b=ZqfmQ/t57SthfFiXXJgstlniL2+sIOzbpYzW0v36evh0ffvCwWOLVhrzBXvJlF0eDxD0I5
 2a8vpnY1hTVG9t/5nqnxPeOESk9iOt1wF6FF4ruJrLOXSeoMqG39K458gEt+JzOzGLyMDF0o
 McY1FXGzrUmWtxktRrIS0aVD62WOtuJadNZx8qLooFhHBN6jb99K7iugUzlcc2AevBUTx3Cw
 9ODrN8/syrzWBO2405LEXMSNBpSb94MHy2JC/qwre7rqk/mk6wCL/nK5Jv2irV5VIMnJY2mP
 +wA2kp1UoUojPJ4BLNdJ3UY2IBGwgWrBB7mF17ro6uM8Um9iRi9Vojpw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:02 +0100
Subject: [PATCH v2 03/20] lib/cobalt: Introduce mutex.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-3-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some code will be re-used later by the time64_t compile unit. Move that
code into mutex.h, so code duplication is avoided.

No modifications to the code itself.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/Makefile.am |  1 +
 lib/cobalt/mutex.c     | 82 ++----------------------------------------
 lib/cobalt/mutex.h     | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 79 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index aa4ba2b92020e661d4906844ddee62aecc30de07..576fb980f72b342e118bfacb061b5634bda420a2 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -4,6 +4,7 @@ noinst_HEADERS =	\
 	cond.h		\
 	current.h	\
 	mq.h		\
+	mutex.h		\
 	umm.h		\
 	internal.h
 
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 62cdb462d7b92b177cc44777e07f69459fb6d195..390305cddc94985ebed354c895783e24652c1025 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -20,8 +20,10 @@
 #include <string.h>
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
+
 #include "current.h"
 #include "internal.h"
+#include "mutex.h"
 
 /**
  * @ingroup cobalt_api
@@ -61,7 +63,7 @@
 
 static pthread_mutexattr_t cobalt_default_mutexattr;
 static union cobalt_mutex_union cobalt_autoinit_mutex_union;
-static pthread_mutex_t *const cobalt_autoinit_mutex =
+pthread_mutex_t *const cobalt_autoinit_mutex =
 	&cobalt_autoinit_mutex_union.native_mutex;
 
 void cobalt_mutex_init(void)
@@ -167,84 +169,6 @@ COBALT_IMPL(int, pthread_mutex_init, (pthread_mutex_t *mutex,
 	return err;
 }
 
-/**
- * Test if a mutex structure contains a valid autoinitializer.
- *
- * @return the mutex type on success,
- * @return -1 if not in supported autoinitializer state
- */
-static int __attribute__((cold))
-	cobalt_mutex_autoinit_type(const pthread_mutex_t *mutex)
-{
-	static const pthread_mutex_t mutex_initializers[] = {
-#if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
-		PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,
-#endif
-#if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
-		PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP,
-#endif
-		PTHREAD_MUTEX_INITIALIZER
-	};
-	static const int mutex_types[] = {
-#if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
-		PTHREAD_MUTEX_ERRORCHECK_NP,
-#endif
-#if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
-		PTHREAD_MUTEX_RECURSIVE_NP,
-#endif
-		PTHREAD_MUTEX_DEFAULT
-	};
-	int i;
-
-	for (i = ARRAY_SIZE(mutex_types); i > 0; --i) {
-		if (memcmp(mutex, &mutex_initializers[i - 1],
-				sizeof(mutex_initializers[0])) == 0)
-			return mutex_types[i - 1];
-	}
-	return -1;
-}
-
-static int __attribute__((cold))
-	cobalt_mutex_doautoinit(union cobalt_mutex_union *umutex)
-{
-	struct cobalt_mutex_shadow *_mutex = &umutex->shadow_mutex;
-	int err __attribute__((unused));
-	pthread_mutexattr_t mattr;
-	int ret = 0, type;
-
-	type = cobalt_mutex_autoinit_type(&umutex->native_mutex);
-	if (type < 0)
-		return EINVAL;
-
-	pthread_mutexattr_init(&mattr);
-	pthread_mutexattr_settype(&mattr, type);
-	err = __COBALT(pthread_mutex_lock(cobalt_autoinit_mutex));
-	if (err) {
-		ret = err;
-		goto out;
-	}
-	if (_mutex->magic != COBALT_MUTEX_MAGIC)
-		ret = __COBALT(pthread_mutex_init(&umutex->native_mutex,
-			&mattr));
-	err = __COBALT(pthread_mutex_unlock(cobalt_autoinit_mutex));
-	if (err) {
-		if (ret == 0)
-			ret = err;
-	}
-
-  out:
-	pthread_mutexattr_destroy(&mattr);
-
-	return ret;
-}
-
-static inline int cobalt_mutex_autoinit(union cobalt_mutex_union *umutex)
-{
-	if (umutex->shadow_mutex.magic != COBALT_MUTEX_MAGIC)
-		return cobalt_mutex_doautoinit(umutex);
-	return 0;
-}
-
 /**
  * Destroy a mutex.
  *
diff --git a/lib/cobalt/mutex.h b/lib/cobalt/mutex.h
new file mode 100644
index 0000000000000000000000000000000000000000..728088bf57cf665bcc0fb4aae44561fc131f6790
--- /dev/null
+++ b/lib/cobalt/mutex.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: LGPL-2.0-or-later */
+
+/*
+ * Copyright (C) 2026 Florian Bezdeka <florian.bezdeka@siemens.com>.
+ * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
+ */
+
+#ifndef _LIB_COBALT_MUTEX_H
+#define _LIB_COBALT_MUTEX_H
+
+#include <boilerplate/ancillaries.h>
+#include <cobalt/uapi/mutex.h>
+
+#include <pthread.h>
+
+extern pthread_mutex_t *const cobalt_autoinit_mutex;
+
+/**
+ * Test if a mutex structure contains a valid autoinitializer.
+ *
+ * @return the mutex type on success,
+ * @return -1 if not in supported autoinitializer state
+ */
+static int __attribute__((cold))
+cobalt_mutex_autoinit_type(const pthread_mutex_t *mutex)
+{
+	static const pthread_mutex_t mutex_initializers[] = {
+#if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
+		PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,
+#endif
+#if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
+		PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP,
+#endif
+		PTHREAD_MUTEX_INITIALIZER
+	};
+	static const int mutex_types[] = {
+#if HAVE_DECL_PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
+		PTHREAD_MUTEX_ERRORCHECK_NP,
+#endif
+#if HAVE_DECL_PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
+		PTHREAD_MUTEX_RECURSIVE_NP,
+#endif
+		PTHREAD_MUTEX_DEFAULT
+	};
+	int i;
+
+	for (i = ARRAY_SIZE(mutex_types); i > 0; --i) {
+		if (memcmp(mutex, &mutex_initializers[i - 1],
+			   sizeof(mutex_initializers[0])) == 0)
+			return mutex_types[i - 1];
+	}
+	return -1;
+}
+
+static int __attribute__((cold))
+cobalt_mutex_doautoinit(union cobalt_mutex_union *umutex)
+{
+	struct cobalt_mutex_shadow *_mutex = &umutex->shadow_mutex;
+	int err __attribute__((unused));
+	pthread_mutexattr_t mattr;
+	int ret = 0, type;
+
+	type = cobalt_mutex_autoinit_type(&umutex->native_mutex);
+	if (type < 0)
+		return EINVAL;
+
+	pthread_mutexattr_init(&mattr);
+	pthread_mutexattr_settype(&mattr, type);
+	err = __COBALT(pthread_mutex_lock(cobalt_autoinit_mutex));
+	if (err) {
+		ret = err;
+		goto out;
+	}
+	if (_mutex->magic != COBALT_MUTEX_MAGIC)
+		ret = __COBALT(
+			pthread_mutex_init(&umutex->native_mutex, &mattr));
+	err = __COBALT(pthread_mutex_unlock(cobalt_autoinit_mutex));
+	if (err) {
+		if (ret == 0)
+			ret = err;
+	}
+
+out:
+	pthread_mutexattr_destroy(&mattr);
+
+	return ret;
+}
+
+static inline int cobalt_mutex_autoinit(union cobalt_mutex_union *umutex)
+{
+	if (umutex->shadow_mutex.magic != COBALT_MUTEX_MAGIC)
+		return cobalt_mutex_doautoinit(umutex);
+
+	return 0;
+}
+
+#endif //_LIB_COBALT_MUTEX_H

-- 
2.53.0

