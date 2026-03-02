Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF138F63B
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444303; cv=none; b=lHWLXGOevMcGiJz2hHqn3NWEbynDyKsHKWn1ES1tYOIs6vetwuU9rekPXch5kZmPBxZHZ7hMZldvx087QAV7k8qkfmdhUKCvZkliU9omkMM6ImHYuofH7g/CAg6OQE6qrgS2uW7fCkC+KnccXEQrpwUdAWPPcvLS4Z5PiWPBG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444303; c=relaxed/simple;
	bh=oqsHzH3NE4NRvi5kq9Ji7CguTMBghUja6x8zgSWXAbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ole2f40DQtonEhutKgs31aCDMJMXwSfvC7e/UOOjLG4f10vv3zcEmr2q2XLvqp0M7xwk1cxMYfVBkFWtd8lHH0D3xxpMV6wbIEto/c1OH9DjQQU3EnTkPoIWlfXEvL9H782sp0DtIkZ04dtZyakvZdj3lfBDOCFjCEQ4Ka+d6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cCj6x8Fk; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cCj6x8Fk"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202603020938104cf4f7fdfd000207aa
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=t4jCmeXNQ8savqJQZygrWmFkFz/oVUzKTephYSwiz2M=;
 b=cCj6x8FkLECVFHuuvSdpdrIG3EnOAVVOw5UfOD8FTHxUW6euqtX2UAk3YVjlGIQb5/Ec/0
 H1VwqkISaLxm7Ys+6kpiqIzf8x7jhbU2K/vApFGXli7bvYnBuWPGUsbs1zyLAccI/wsNOfpd
 v0KqE4RHLjjxi1k7m6tmXZAwXKZJ0DB05w5uqYVQXtERMsRFlxhs7UqGjocXfHdphvybUSNF
 2uJPVEw4R9bHgxNWdUwirGy7E6/m6BXlmKCIsOPe5BDl+rXXCE8RXyFQGFgvfPbT2jdbkAmK
 GMwQJk/NbFhXZ8iU//Yyig0YK2VrKtnKx9bXTPqS9t2II4R4C/RfZ8Xg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:15 +0100
Subject: [PATCH v2 16/20] lib/cobalt: timerfd: Move time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-16-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Code movement only.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timerfd.c         | 39 ---------------------------------------
 lib/cobalt/wrappers_time64.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index 70e9a4e0743d503bb4b57d17ed7c77713bebf946..5fa1f1eaa3902293c81600431fb2d97557c671d2 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -17,7 +17,6 @@
  */
 
 #include <errno.h>
-#include <unistd.h>
 #include <sys/timerfd.h>
 #include <asm/xenomai/syscall.h>
 #include "internal.h"
@@ -35,41 +34,3 @@ COBALT_IMPL(int, timerfd_create, (int clockid, int flags))
 	return fd;
 }
 
-COBALT_IMPL_TIME64(int, timerfd_settime, __timerfd_settime64,
-		   (int fd, int flags, const struct itimerspec *new_value,
-		    struct itimerspec *old_value))
-{
-	int ret;
-
-#ifdef XN_USE_TIME64_SYSCALL
-	long sc_nr = sc_cobalt_timerfd_settime64;
-#else
-	long sc_nr = sc_cobalt_timerfd_settime;
-#endif
-
-	ret = -XENOMAI_SYSCALL4(sc_nr, fd, flags, new_value, old_value);
-	if (ret == 0)
-		return ret;
-	
-	errno = ret;
-	return -1;
-}
-
-COBALT_IMPL_TIME64(int, timerfd_gettime, __timerfd_gettime64,
-		   (int fd, struct itimerspec *curr_value))
-{
-	int ret;
-
-#ifdef XN_USE_TIME64_SYSCALL
-	long sc_nr = sc_cobalt_timerfd_gettime64;
-#else
-	long sc_nr = sc_cobalt_timerfd_gettime;
-#endif
-
-	ret = -XENOMAI_SYSCALL2(sc_nr, fd, curr_value);
-	if (ret == 0)
-		return ret;
-	
-	errno = ret;
-	return -1;
-}
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index 138058b55adb0e735452c09a745920726dd6ec0f..cd7f05197dc3a9b8aca71d9e0a7468933a220ebf 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -2,7 +2,7 @@
 
 /*
  * Copyright (C) 2026 Florian Bezdeka <florian.bezdeka@siemens.com>.
- * Copyright (C) 2010 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
+ * Copyright (C) 2010, 2013 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
  * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
  */
 
@@ -1051,3 +1051,42 @@ COBALT_IMPL_TIME64(int, timer_gettime, __timer_gettime64,
 
 	return -1;
 }
+
+COBALT_IMPL_TIME64(int, timerfd_settime, __timerfd_settime64,
+		   (int fd, int flags, const struct itimerspec *new_value,
+		    struct itimerspec *old_value))
+{
+	int ret;
+
+#ifdef XN_USE_TIME64_SYSCALL
+	long sc_nr = sc_cobalt_timerfd_settime64;
+#else
+	long sc_nr = sc_cobalt_timerfd_settime;
+#endif
+
+	ret = -XENOMAI_SYSCALL4(sc_nr, fd, flags, new_value, old_value);
+	if (ret == 0)
+		return ret;
+
+	errno = ret;
+	return -1;
+}
+
+COBALT_IMPL_TIME64(int, timerfd_gettime, __timerfd_gettime64,
+		   (int fd, struct itimerspec *curr_value))
+{
+	int ret;
+
+#ifdef XN_USE_TIME64_SYSCALL
+	long sc_nr = sc_cobalt_timerfd_gettime64;
+#else
+	long sc_nr = sc_cobalt_timerfd_gettime;
+#endif
+
+	ret = -XENOMAI_SYSCALL2(sc_nr, fd, curr_value);
+	if (ret == 0)
+		return ret;
+
+	errno = ret;
+	return -1;
+}

-- 
2.53.0

