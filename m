Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99A38F630
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444306; cv=none; b=UANKmnHA9sdb8jDmGVGlEKwPgv+vjRnQM2nYCxOSsW0uEh6eVVFGsw0c70qurrfF+vk5/AZrWvKgGNkfl0GG5Y1Ljrk5h6SquAYV1SY7S9X6tnzFgkMmRWzREOjtcI7MJ+3QYqXQxvNx2pozga4VsRQNKmBjNPNqzGc0OvwSESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444306; c=relaxed/simple;
	bh=mZItG9CkuczRE4opym2quO+j4kbUpq4JGCrOqDAEvIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjO+kbe3azTzUbh9sAvL6maouCrcEqfA8BRLW1P7yM9q92TwKWDFJ0yzEPWIkQLlb2BMUi8HJ3wuNn1WVVWAtk2ERxgbWCeMGrC5sXwZeFumZVjnrX04fWszQX+w6rT/yrhbylkQfjRu96QrAWYNuVN0QVB1ZY2NBJU1mfuPXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=iAjKfkFZ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="iAjKfkFZ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260302093809cf3902a823000207c3
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2xndbXgPkV+qLb2ZWhVXtBGhPY0jRvgsAFPD1PFo11M=;
 b=iAjKfkFZZiNx29ppPBbYoc351B4qJWu0trbcgi2yxHwZuvZeT2M6BzlnYIp5CqVhogRSpK
 6KyAIOfjU+14dV76YskNfdbiUg7tHPfJdPGTKh+37f+GaR/ynoAA5UoVNngSY/CmtEi5wFy6
 rHWMAg89mov3VxbwgIU+P8u5vbXLI4bdnPU+ejoF+YaCa0YUQ7WEAAhr5cfPe2vynKuiQZX4
 ZazZpSuxJWgjX6sAfDaVOVA6Dd8wS4zoCoERRhkrWI2nXl/elUaM47oLJZbs/Px4c1+BVszo
 nf5czExlFX/37GX340aD0GNXgroeUgUsIene+Avxx5lntJ5RCNpQDN8w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:13 +0100
Subject: [PATCH v2 14/20] lib/cobalt: signal: Move time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-14-7caefce29bcd@siemens.com>
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
 lib/cobalt/signal.c          | 26 ++------------------------
 lib/cobalt/wrappers_time64.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index 6e40a36803190ad05b7b4a1ce4fab9108b59c56d..b5c0865e95eb571f3bbf67ce29ffc73b9ddf11ef 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -16,12 +16,13 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <asm/xenomai/syscall.h>
+
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <signal.h>
-#include <asm/xenomai/syscall.h>
 
 COBALT_IMPL(int, sigwait, (const sigset_t *set, int *sig))
 {
@@ -53,29 +54,6 @@ COBALT_IMPL(int, sigwaitinfo, (const sigset_t *set, siginfo_t *si))
 	return ret;
 }
 
-COBALT_IMPL_TIME64(int, sigtimedwait, __sigtimedwait64,
-		   (const sigset_t *set, siginfo_t *si,
-		    const struct timespec *timeout))
-{
-	int ret, oldtype;
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-#ifdef __USE_TIME_BITS64
-	ret = XENOMAI_SYSCALL3(sc_cobalt_sigtimedwait64, set, si, timeout);
-#else
-	ret = XENOMAI_SYSCALL3(sc_cobalt_sigtimedwait, set, si, timeout);
-#endif
-	if (ret < 0) {
-		errno = -ret;
-		ret = -1;
-	}
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	return ret;
-}
-
 COBALT_IMPL(int, sigpending, (sigset_t *set))
 {
 	int ret;
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index fd5ee105aa03c1e9d5b3c80236aa3a789656bfda..42f8088922286ed991a8ba9bdb3f63c19e51a0ee 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -910,3 +910,26 @@ COBALT_IMPL_TIME64(int, sem_timedwait, __sem_timedwait64,
 
 	return 0;
 }
+
+COBALT_IMPL_TIME64(int, sigtimedwait, __sigtimedwait64,
+		   (const sigset_t *set, siginfo_t *si,
+		    const struct timespec *timeout))
+{
+	int ret, oldtype;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sigtimedwait64, set, si, timeout);
+#else
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sigtimedwait, set, si, timeout);
+#endif
+	if (ret < 0) {
+		errno = -ret;
+		ret = -1;
+	}
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	return ret;
+}

-- 
2.53.0

