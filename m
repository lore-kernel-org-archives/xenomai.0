Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396F31AF31
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578539; cv=none; b=T7xg3Fa3KtJ3ilpscMeDETV0c3ifgslW5gkc1xb+X/HaphTRzacEWM5+YoLSbS8te0RshU8KOKy++CnAQkcKkReliWBH1vOFZDo6wkbd/BxZoy1ziGEZfE/DlSFKLAp3qPopzq5KXgmXcFStmvGPk9il2HkJfsAxAjvzZb7392k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578539; c=relaxed/simple;
	bh=1f0breMgk22Hs7WmTqMx33vFVifH7mOKBsLCg+N2Szo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boeIaMLM3MdB4hb/g1+QEs7KuvVH2UfbwqqIQvlD6hm14Uz4n5ULTTvJwyKxbxcwUh2QHzfqRZ/TcPsvh6a2qeq8uh1C5Dw+sojjhCG+F6cm1Nj5iehBpEkMBgCtVnV0KseEz8JS3z52DhvUGuXJRqRJWDQu2QWFvGG6fHnAq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dXXhMoLE; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dXXhMoLE"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260220090845cf22de8b150002076a
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=K9oJf8A2BtWjQq53M2JulZ5zHpv/YXqF6V7A5+bRq2Q=;
 b=dXXhMoLELwxMWAUK4AIahk84a3Gmw0BqhC4yj4b/JMRX80UF3s1iIfFfaqhEFY8gWKKk/W
 haDJ97rAPxoJ42zbgg3he8apT3/qJnzY6mXnEuZ+lvBSN9or5q7bk6pK/grmliTe1uY5zAx+
 OQJ3TZHVdXrkAmLs/uCktu79xBC1azqGiV/jhFvPsvUeAf/4T3ZgmwCV4XNXkwQVRkKjszQL
 gyzHL5dT5BPt4yOJyhlgGLwKm0STy2p9IRhFbR+KkqkxOQ6P6uztZihnck6wbWtkDQ4oQaDL
 xa1QwtSd51jGdEE+LoTQRWgYc4J9ADgUJuchOqaE3knSMy4e0nzvqDZQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:46 +0100
Subject: [PATCH 03/20] lib/cobalt: Introduce mq.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-3-731c773e72cc@siemens.com>
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
 lib/cobalt/mq.c        | 30 ++++--------------------------
 lib/cobalt/mq.h        | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index d913ca02128cd588327c2a728a01fb84d9cee538..262c9bedb3fbe8edee96353f5a3e6b631c31e81d 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -4,6 +4,7 @@ noinst_HEADERS =	\
 	cond.h		\
 	current.h	\
 	mutex.h		\
+	mq.h		\
 	umm.h		\
 	internal.h
 
diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 88e6e9fbf57a6cc0094d34d3bc9aa0852e82d96c..72d419d6cfac0097ba7ed61941e7b8a92e3bc673 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -16,13 +16,16 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include "mq.h"
+
+#include <asm/xenomai/syscall.h>
+
 #include <errno.h>
 #include <stdarg.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <mqueue.h>
-#include <asm/xenomai/syscall.h>
 
 /**
  * @ingroup cobalt_api
@@ -288,18 +291,6 @@ COBALT_IMPL(int, mq_setattr, (mqd_t mqd,
 	return -1;
 }
 
-static inline int __do_mq_timesend(mqd_t q, const char *buffer, size_t len,
-				   unsigned int prio, const struct timespec *to)
-{
-#ifdef __USE_TIME_BITS64
-	long sc_nr = sc_cobalt_mq_timedsend64;
-#else
-	long sc_nr = sc_cobalt_mq_timedsend;
-#endif
-
-	return XENOMAI_SYSCALL5(sc_nr, q, buffer, len, prio, to);
-}
-
 /**
  * Send a message to a message queue.
  *
@@ -412,19 +403,6 @@ COBALT_IMPL_TIME64(int, mq_timedsend, __mq_timedsend_time64,
 	return -1;
 }
 
-static inline int __do_mq_timedreceive(mqd_t q, char *buffer, ssize_t *len,
-				       unsigned int *prio,
-				       const struct timespec *timeout)
-{
-#ifdef __USE_TIME_BITS64
-	long sc_nr = sc_cobalt_mq_timedreceive64;
-#else
-	long sc_nr = sc_cobalt_mq_timedreceive;
-#endif
-
-	return XENOMAI_SYSCALL5(sc_nr, q, buffer, len, prio, timeout);
-}
-
 /**
  * Receive a message from a message queue.
  *
diff --git a/lib/cobalt/mq.h b/lib/cobalt/mq.h
new file mode 100644
index 0000000000000000000000000000000000000000..f8627c67456dcd4d0716c37051a528243efa33a3
--- /dev/null
+++ b/lib/cobalt/mq.h
@@ -0,0 +1,34 @@
+
+#ifndef _LIB_COBALT_MQ_H
+#define _LIB_COBALT_MQ_H
+
+#include <asm/xenomai/syscall.h>
+
+#include <mqueue.h>
+
+static inline int __do_mq_timedreceive(mqd_t q, char *buffer, ssize_t *len,
+				       unsigned int *prio,
+				       const struct timespec *timeout)
+{
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_mq_timedreceive64;
+#else
+	long sc_nr = sc_cobalt_mq_timedreceive;
+#endif
+
+	return XENOMAI_SYSCALL5(sc_nr, q, buffer, len, prio, timeout);
+}
+
+static inline int __do_mq_timesend(mqd_t q, const char *buffer, size_t len,
+				   unsigned int prio, const struct timespec *to)
+{
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_mq_timedsend64;
+#else
+	long sc_nr = sc_cobalt_mq_timedsend;
+#endif
+
+	return XENOMAI_SYSCALL5(sc_nr, q, buffer, len, prio, to);
+}
+
+#endif //_LIB_COBALT_MQ_H

-- 
2.53.0

