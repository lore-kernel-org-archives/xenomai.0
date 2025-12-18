Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC71230264
	for <xenomai@lists.linux.dev>; Thu, 18 Dec 2025 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088138; cv=none; b=XYg7X1Y12DUvDYiCwl+1kCV4KVNirNzwoxEjOeH8OML3gsfRQW0Ahx9Y8BNitIEttlEV1kDJvjf18UmFH9B+Q/jGHi8jYdqocsNbSM+psAYY+E7qQjKOqVY84myyf8ypiArYJQLG75bqW5TyQc4i/KvzblDV7K1t1sI+MWLBKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088138; c=relaxed/simple;
	bh=jvu2dFgTZIqr79SG5WjQoK6VwOc5NhQuOBRgO16GcMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPeR7gKrUQ7H5aYzF6dFJflOtNGQRkuwfsY1sHaGYv/wgTOBdISeWEQ87Bo77LiST4HXcEIFur9rJx7thNU/SKxLaED8C7D6sjBfa9wJWzS0dfLJdayCMRwqfL7O6r+dzv69eH4IfNkLDgLGHtzHPtrljnqDXPzbxj2xn5UHWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YevrlaG3; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YevrlaG3"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251218200207760ee767010002076c
        for <xenomai@lists.linux.dev>;
        Thu, 18 Dec 2025 21:02:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=F6ZmGNMfPtxPMogjXTXijt4Za6u/3BcdZM93DZRzW8U=;
 b=YevrlaG3GfxWIvnhg+zIKgQ81RDjQIra4uqr7unYpwGIliOrMaWxpDrH7dP7nHsrOw7CY8
 pURwlbl/U+lr/xauCyhV4DYOEAJAfsdUTKGY+LpeZEbz0Kijw7Bl8nX8ggTCyO2FqfyUibtv
 Ccoew3Upr4EPrgfocMRRNX/f79VpHbnICpSbWeCTvQ8lFuOTGRfsln4l3Omu7jnhL7JMlyjz
 lGTh/dQzb+MTJaEFkgh2d0AHDwQiy93yC0CEz7MsJs4CuSW9iFMRxZ7gYIcRJ+zP6Vw91sT0
 HN9Rczr9uRgKpgcLr1FhaIjxBzT2i/rtL8S3WhBnQ2JCdDetXqt4nrXQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Dec 2025 21:02:01 +0100
Subject: [PATCH v2 1/6] y2038: lib/cobalt: select: Normalize timeout value
 in the y2038 case
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-flo-fix-select-syscall-v2-1-f606e54e8d57@siemens.com>
References: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
In-Reply-To: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Andreas discovered a difference in the timeout value handling between
the native and compat + time64_t (= y2038 support) cases.

The time64_t based select() service is internally routed to the
pselect() service. Linux does a normalization step for the timeout
values of select() and so does cobalt. Both, Linux and cobalt skip this
step for the pselect() syscall. That means that we were missing one
normalization step for select() in the y2038 case.

Reported-by: Andreas Ziegler <ziegler.andreas@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/select.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index be8cf34b2..611994d17 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -22,6 +22,10 @@
 #include <asm/xenomai/syscall.h>
 
 #if __USE_TIME_BITS64 && __TIMESIZE == 32
+
+#define USEC_PER_SEC	1000000L
+#define NSEC_PER_USEC	1000L
+
 /*
  * The time64 wrapper for select() is a little different:
  * There is no y2038 safe syscall for select() itself, but we have pselect()
@@ -36,8 +40,10 @@ static inline int do_select(int __nfds, fd_set *__restrict __readfds,
 	int err, oldtype;
 
 	if (__timeout) {
-		to.tv_sec = __timeout->tv_sec;
-		to.tv_nsec = __timeout->tv_usec * 1000;
+		to.tv_sec =
+			__timeout->tv_sec + (__timeout->tv_usec / USEC_PER_SEC);
+		to.tv_nsec =
+			(__timeout->tv_usec % USEC_PER_SEC) * NSEC_PER_USEC;
 	}
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);

-- 
2.39.5

