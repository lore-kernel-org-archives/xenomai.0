Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817332938D
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444299; cv=none; b=J0HS8cUI6Z0d4YoLk2yct2R6YZ2pg0bzB6wihonnadxhxc/6v0kJS9nnxA9HLG1z4LwRhODOTp/9R/Z7TqTSHWVmtExJVVg2rIAFxkMlcu37XhmXDH/pQXcMmoXlnXEZMjvsIjgm3oTr1I/JG0AZw/8PZJnv1h/3Kp2oApzqHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444299; c=relaxed/simple;
	bh=gB7fY/Q1UcOPMGUfxeepw+uRgpx5Wd+iqURivkfWp3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ib0TZ2oKBnlhDk1ydZCt1slZzrLHjhZKTGgqV3zw4WD1xy+Ul1aESJ7741ksRakCVanhPn9KnNVZeajl74mw7E3kwX098JxoWBKFtc9podxgi1hDu06xsOW4BrbxpAX7WZp9PHSE5m9rnXNpxcqGwkPlT21XY5zUXuojfUmBVUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Foi+6uwq; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Foi+6uwq"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260302093807d0949bd269000207fc
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eMFUVBP84zgjrdfoVjKUHJpbv/BAc7l9I8qPwDMxVgs=;
 b=Foi+6uwqlISI+DSHcu7VQn94QxEnfl6VuUv+iYUROoBbjNbtGoqcbRHhJy1aZky1YgXrPo
 MVhY7bQjBpwUme0CkYWvBKizbCHFlwDSvU524KoYBDSHLIrvA/BgCQ4sOfbqcQCy5jvq/4kw
 TZmStecSGAdY3SxsuooX4BnPcTD23zVVNDIbV4KxSKqLmPsMCAOUNrJPYCk1t6Y3Oo+2KrOY
 mvjoHM3eA02vDJaLCavyf7OoMjABi9wOD936jHuBN3Wvh8S6MKFLGSlmCMW3HBvZ+plrtgAu
 7/OYcZwM0srLOAap0i28o7MUPz25qZnfoCaJiGggkg2kSQYMUhf3D9JQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:01 +0100
Subject: [PATCH v2 02/20] lib/cobalt: Introduce mq.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-2-7caefce29bcd@siemens.com>
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
 lib/cobalt/mq.c        | 30 ++++--------------------------
 lib/cobalt/mq.h        | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index b1098413fbf3a8f6a5f0a85d6aceb9916b14149a..aa4ba2b92020e661d4906844ddee62aecc30de07 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -3,6 +3,7 @@ pkgconfigdir = $(libdir)/pkgconfig
 noinst_HEADERS =	\
 	cond.h		\
 	current.h	\
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
index 0000000000000000000000000000000000000000..82d18f6fbb1b635bacaaf49356e86a8901c65e9a
--- /dev/null
+++ b/lib/cobalt/mq.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: LGPL-2.0-or-later */
+
+/*
+ * Copyright (C) 2026 Florian Bezdeka <florian.bezdeka@siemens.com>.
+ */
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

