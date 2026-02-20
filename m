Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DF31B11E
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578544; cv=none; b=g5M0tmFBvPGN5z9h9GnsVoVb6NBMGA6aFbdHMgR5fgQzy8cFVby1cui4rTO0oP5hD5khCr082/hdEmiR/ADCme/TdzHMSVR6eSHkCXinPKyTk40ZQ6HsxvzA1RFhYkUtGHKM0VALrRnR4rdJeQQky4YBVoLKfcVFnkFDme4Iauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578544; c=relaxed/simple;
	bh=mEcIi+g1gmHytSyXD+gDRzna8WamtQqvZo5GlrlDpRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILPLWeMPLk7op97/E4NiYbBsVUXvOzI3irvzz9u3Lwe0oO/Unq9y4tyT4nD1n6aDVBZYhk4auX7BcxkqIBQeRSMHGlLMjs4DR54rxyquYjYYeA7QerKwzb9hPjKS471iQVhq0uzyNq5UuRueZyJow/mKDjziKGeSpe0YkPbd+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LpT5nbZV; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LpT5nbZV"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026022009084828023e220300020714
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VG8sS0Itq4grRAgSg3yJOxT/2gmuS2TKmbvaceALko4=;
 b=LpT5nbZVydx82V0zpe90v9b3glX1a70MbindUJcqxPHASCJaHKwyrYRo5Kjjmf/fjHfXjB
 cdBcvlnEsmaobONk73WVtsia82QeclMF9p3UFanryR5ZJh1G/ZE4FgYzK0BS5Ew1WkkQCc/r
 Ig4jwLPc94Ck5kLVDWDZnjGlsEOfuBncZ/GtzvxADuTHrwuOXr4Z9AO7FpqKzqryRUBFsZ5S
 ii90nsBBjKVVBxzV62wDD8ncGY8BXS4sMCwfSJaGGE4wFuRyNLpjHR18HeUokM80hzZ/6ygX
 kULVjqHH8W4jiXxhKRe4zFv7D4xsvKh9pTrLgFNLLy1xmEFnhEsXpk+w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:57 +0100
Subject: [PATCH 14/20] lib/cobalt: signal: Move time64 related services to
 wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-14-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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
index 1a4a3c463543e078e43eddd9ccd056ad10f69e97..5219802c408cecde50d4088a8cd692d4354346ab 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -902,3 +902,26 @@ COBALT_IMPL_TIME64(int, sem_timedwait, __sem_timedwait64,
 
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

