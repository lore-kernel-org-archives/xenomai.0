Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5938E5F9
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444299; cv=none; b=sLoseiJ74lAS2vrKYCJB15U9dQb+2qiPASuIIlDyTKm09MxHUBmfEThgUzJLnoEJRX4Hh3hUaUPktpZAtv/ixN+/guXMYlVFUCqPZMessY/Ck2JLXvodvb8+/2Ised0Ghn+zJyxr+9+GP/ComrMArKWdKUyRaFbLpZF8fVNpFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444299; c=relaxed/simple;
	bh=Ij84mGZ3+JTk002U7jAQxJG2cLbS8ECX53qWSMe0qDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPxqvk6kPYxyugs6umjgNxoDO6JkqeisMUXmyoUHkFc6TpNrjSYo8WsXWqhzKULdtv7VjD21GBawgmJLMZFWlQIhkBegGyIScsET32Jsh94FS0r/3Kj5riv5MKmMndPGXwIT+6nmvGvsuwvqLPZnH86i3G8ELmzrA1vArl16r3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Thj2xOeB; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Thj2xOeB"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260302093807c5f1ad85ff000207be
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UFtHgCfWTHrvaLTAvCFBHlUkJOhRuFLE42r+DAHX+bY=;
 b=Thj2xOeBV7SttLzUoIs8rNTqtitk5vp1Rx20gOTRLHDkewOAGs4gsfChX8jWyubnAhJey9
 NxXzoEc2L/02EZxWeTrBY+6bbKlmc256kmEGcHqxXme29Fto3/e3yUTMr3jyi54NMexzfeaj
 kAwv4BzFSH1IVPfBQhZZCJV3wXSDi/I9B9d4sDFlLfIWGdnsTWcLcM8v8yibtQWKKmys9/YY
 AamopFNE9bTgzPlrs45F33kbq4vZ1Kk4eppAK+TfaY5OXF5yGt+iqLDbZRAiw7tGsT87wpVo
 EUQb7GBdwtb7dGaakNceobMTJ16qRzUDez+uPiutv97nwtkjdAFg3mAA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:03 +0100
Subject: [PATCH v2 04/20] lib/cobalt: Introduce rtdm.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-4-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some code will be re-used later by the time64_t compile unit. Move that
code into rtdm.h, so code duplication is avoided.

No modifications to the code itself.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/Makefile.am |  1 +
 lib/cobalt/rtdm.c      | 34 ++++++----------------------------
 lib/cobalt/rtdm.h      | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 576fb980f72b342e118bfacb061b5634bda420a2..0a8041dc30efae3eebacd376ac72f4b317f621b3 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -5,6 +5,7 @@ noinst_HEADERS =	\
 	current.h	\
 	mq.h		\
 	mutex.h		\
+	rtdm.h		\
 	umm.h		\
 	internal.h
 
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 119ba3f83dfd023291ad10b5aad496905db36a47..ec950e15db921b32458d746d300ff6c542a8b23b 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -17,34 +17,25 @@
   USA.
  */
 
-#include <errno.h>
+#include "rtdm.h"
+
+#include <asm/xenomai/syscall.h>
+#include <cobalt/uapi/syscall.h>
+#include <rtdm/rtdm.h>
+
 #include <string.h>
 #include <stdarg.h>
 #include <pthread.h>
 #include <fcntl.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <sys/socket.h>
 #include <sys/mman.h>
-#include <rtdm/rtdm.h>
-#include <cobalt/uapi/syscall.h>
-#include <asm/xenomai/syscall.h>
 
 /* support for very old c libraries not supporting O_TMPFILE */
 #ifndef O_TMPFILE
 #define O_TMPFILE (020000000 | 0200000)
 #endif
 
-
-static inline int set_errno(int ret)
-{
-	if (ret >= 0)
-		return ret;
-
-	errno = -ret;
-	return -1;
-}
-
 static int do_open(const char *path, int oflag, mode_t mode)
 {
 	int fd, oldtype;
@@ -160,19 +151,6 @@ COBALT_IMPL(int, close, (int fd))
 	return __STD(close(fd));
 }
 
-static int do_ioctl(int fd, unsigned int request, void *arg)
-{
-	int ret, oldtype;
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-	ret = XENOMAI_SYSCALL3(sc_cobalt_ioctl,	fd, request, arg);
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	return ret;
-}
-
 COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
 {
 	va_list ap;
diff --git a/lib/cobalt/rtdm.h b/lib/cobalt/rtdm.h
new file mode 100644
index 0000000000000000000000000000000000000000..6f3f60ee96d5d474b06b73ee2cb520fa1e846e75
--- /dev/null
+++ b/lib/cobalt/rtdm.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: LGPL-2.0-or-later */
+
+/*
+ * Copyright (C) 2026 Florian Bezdeka <florian.bezdeka@siemens.com>.
+ */
+
+#ifndef _LIB_COBALT_RTDM_H
+#define _LIB_COBALT_RTDM_H
+
+#include <asm/xenomai/syscall.h>
+
+#include <errno.h>
+#include <pthread.h>
+
+static int set_errno(int ret)
+{
+	if (ret >= 0)
+		return ret;
+
+	errno = -ret;
+	return -1;
+}
+
+static int do_ioctl(int fd, unsigned int request, void *arg)
+{
+	int ret, oldtype;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	ret = XENOMAI_SYSCALL3(sc_cobalt_ioctl,	fd, request, arg);
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	return ret;
+}
+
+#endif //_LIB_COBALT_RTDM_H

-- 
2.53.0

