Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E031AF33
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578539; cv=none; b=Y+6jUAaIDYfh+pmq6TPHaGC8X5B6J7j53dxqQ9Qmkt0pXjyIvqWYlJPgboKC4CoCj4pta2XyyvjQ4sD+b19v4e6ashY/mQUixjQEI3RPCYk7ug0eKc7fUk3WPOnzMkgJNZ0ZFqA1bEnmsv9OFb7RpJ+5OLlXdNnFcSObZkXLaFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578539; c=relaxed/simple;
	bh=Tx8QMv0XLwTLHZGcRKi/2sOj8VkLDp00GCt9AldTY/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNjlUNvBDkyB05I8IHXXdOXiOoW2vLPVGma/gd5+25OBzZdNEc+EY4ziA9nPz/yGtaFxZVy83Bc2UCnpOYdwQ1qwtgcCiJ7z3bAwyBJ0egBR1xRqzKJrDNh+gK15LKk4SWvxORdlUjO2pPItXa+dmwE1uMIpnbkoCJJdZ9Hw3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Pih1FBjZ; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Pih1FBjZ"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202602200908450a40f5722f00020737
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cj08wcj4liF1F+lT5SBkR6qRF2Gg3PAB9hH1kgs+3MU=;
 b=Pih1FBjZuGMOQZ2CzdJDGKHPr+ECXOklmdhrxerqynrZfjPKfGwwA26lrcqy10TLe4e88d
 yRUSrbn8cKI2z+z+gOjSMq2U1ccdS1iEyd/F10PURE0qefS0GCRhRqdXlISbukjHA6Iln9H+
 XwEVIEfhFUqJ/RdK8m5YlZ8rwsOpleF6UUdo71cLg+zEtv0kshdE6zxIjgt4QT9N06us7l63
 4wCLQH8gRW5jqI9SPWtosSyqFtz+pkXa2i7xQiRtIjQIhnvGVUICT/wMJUT917ffrUBZTaJ+
 notjRgUJVDwhPVsaCxLo1QM8iODzKSue5luTFqixyjjegrIs37nOG1ZA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:45 +0100
Subject: [PATCH 02/20] lib/cobalt: Introduce mutex.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-2-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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
 lib/cobalt/mutex.c     | 82 ++-------------------------------------------
 lib/cobalt/mutex.h     | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 79 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index b1098413fbf3a8f6a5f0a85d6aceb9916b14149a..d913ca02128cd588327c2a728a01fb84d9cee538 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -3,6 +3,7 @@ pkgconfigdir = $(libdir)/pkgconfig
 noinst_HEADERS =	\
 	cond.h		\
 	current.h	\
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
index 0000000000000000000000000000000000000000..2f8eac7d20521517a524770d62e0db52a4113649
--- /dev/null
+++ b/lib/cobalt/mutex.h
@@ -0,0 +1,90 @@
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
+	return 0;
+}
+
+#endif //_LIB_COBALT_MUTEX_H

-- 
2.53.0

