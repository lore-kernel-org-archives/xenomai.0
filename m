Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1E31AF36
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578540; cv=none; b=jJFiK1K96mgdZ83n5SCfMfE+PLZH2jpYdI6++5w+MNWuAkyoQNtRbR9Xv4ZMOC42KhCRCpF0wFje0vfge2OtyYqJ52WfWYRyOY67rbd+aw4vMe5o52q6zYGXtV+J9wNL92YJ0BokERcnsl+hvYqfcoAfod+YvL92LDaxNSUDrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578540; c=relaxed/simple;
	bh=n2zh0UYIxUYMdYJ/CuZxYlSp2idRDl4Bep/BDv//F5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQs6xXYSlOxuzv49vqHbJI/8/zp5MaRwZPcma81lnickMLhLPT/1RW/aRtkJuhH1SfqxNkPeK7KfYbrBNccj5Zd6JLSmYRMzlsxHYS3zRV0+2DpwN/ms8wJV2F/AKbyGE8X7x/GP2WG+Wkb6Hy98Z1H5GCrUezJFBx+DIzJW84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TcwhG+gW; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TcwhG+gW"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202602200908456f74f92e0200020715
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5CT5cmh3HuiOUJ//I4GW+6Ef+8lpHjGqW0fgMJVjB9Q=;
 b=TcwhG+gWFgvcJynivYY41g7WF5PHxep8U93dL/X/PuNBpqiTFpV7oudqRAztE6+4JwnriY
 0u/LZ6AuIdt/Mknz9NnQAxbRjywF6ZtiHR5+5N3lijvj1QtlHc38wTKeJgzbTiO6UPYf2Nhq
 f1HXRevgpqOLmdO+fbPQ7V0d2Vx4yDKXHuNR2c3wTHbUm/k9Tw4AlVnxuBXtiMd3RlxY52Qb
 rmRII3v2/Jy9GTr+0aR61CL9z2IZ7JZ2Od20PoGAL6CW6swL+uUlbbVSSfPfI5/XLaKcv1Xs
 wwOsvWBSZkBCmPoi5ox/gTIRyMkHNJza+zknpa5OWvkaZ1n4rittiOhw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:47 +0100
Subject: [PATCH 04/20] lib/cobalt: Introduce rtdm.h
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-4-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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
 lib/cobalt/rtdm.h      | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 262c9bedb3fbe8edee96353f5a3e6b631c31e81d..f461e570ed42a0d5cbc43eabb373c3c9edd83bad 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -5,6 +5,7 @@ noinst_HEADERS =	\
 	current.h	\
 	mutex.h		\
 	mq.h		\
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
index 0000000000000000000000000000000000000000..f16d79835361a20a754c6532101e60667cafee3c
--- /dev/null
+++ b/lib/cobalt/rtdm.h
@@ -0,0 +1,32 @@
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

