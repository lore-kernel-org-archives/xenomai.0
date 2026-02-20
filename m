Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF731AAAF
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578543; cv=none; b=GXdBXekP7t9e62m75h0Kbnm7zdlOaB/otwNCClSJCW8IoEJXTo7Y7cXUpTYWu1Q7RZa7OLJgzBkwZCydkE7QDSSK5pbO+fWD3/MHvAHcGkCUB3fdMyCkTCtBMVAdhFnNNvZQTdxrRrT8m0eGdv7EPToI72YUrs2S7gUfqws4jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578543; c=relaxed/simple;
	bh=RbcBuhYiGMvlnPlo3ZZngFfLZbuBFSAi+kBZYZOqK0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urPPEQJbJYPx4421UbW09HuoqspnFESi/aQ8E0ooOPZqrD/Z8TP0NtcRBwNMz40pgEpeS/1xEPVd/Vs1IF5K97tfhtG6qYoqciiMq1H0OKEnDeTB7QDarz4Wh6j+KrvdIr7/XDMXNC1j+emLcv4612IXZJwDD5qjSGjq4bOAcIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=X+Yw1TvV; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="X+Yw1TvV"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602200908450914dd51d90002075f
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LyG5hv/A1T5aZkZGVoSc5u/vXBUmTTN4C1aLZ/jVvyw=;
 b=X+Yw1TvVn7cGtemh8O9hU6NufqDTaJpRPj0T4ILdtYUju+chBh1V9IWegyzxjsHKcWvStI
 fXePBr5VxwpC1WDAbQFbb5TWbm/4VREQegrh/A8aTq/TGuqTXVjuSrm8rhnNZkJ0UflM3CHI
 WiUxzLfpdktcKan8T8N2bhI4tVnjuGTxtuoty3D1IT5lc8auXavN5Ljv214o3mFX2/qSt6nW
 byg4mD+x397pCVU7Cxcohhd2F1NVxBcsbpzQf9Wr+Q4ohoIJ6HEXxGwmBZ/DWWVvuOUnpD4d
 GkVfjpsklgfMvjr7I5gci+WJj6jucxhv6Jzbl1sNXU7SGm+PgS/svztQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:44 +0100
Subject: [PATCH 01/20] lib/cobalt: Introduce cond.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-1-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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
 lib/cobalt/cond.c      | 67 ++-----------------------------------------
 lib/cobalt/cond.h      | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 65 deletions(-)

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
index 0000000000000000000000000000000000000000..fbb7a02149ddfa0858def5e8741d5b044afc17b7
--- /dev/null
+++ b/lib/cobalt/cond.h
@@ -0,0 +1,78 @@
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

