Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91648134C6
	for <xenomai@lists.linux.dev>; Sat,  8 Jun 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717876428; cv=none; b=pHbd5MpG2p82y/QtpIuuslbW+yy63JjBMjAtRrox0lX+qEeZH6tnNxe7kN0yl/DFEK5QVtxMYfjvEhp9Iw8BRQI8GKbrRxBIWhjI4ZxhNk7FNinUjPrtr9jlmSWuCvLSNsKM3do1mrYkxdpXxkPhLHUh7gi2Fa1Z4Mjk4KfXvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717876428; c=relaxed/simple;
	bh=wTOdcgmoSYSTGTDdvq0ryu54cWuN42Ejfp3rIgBtHlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkfR/Z4AFF3YJbol0+BzXwn4vypV7GiRxXA8VbkrKDSIMmDesR6JjG52kIvLbzrmKVQUdYwdTmB+Pu06Z9AhCDSS8+0ePH3UkzLNP5/6NPRBUofKTMntSU4H95v8ZLjxqdxz6GqSWLaYGGIQ50cBN63NOaxFC8FkcPZQwhRCwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=uprV6ebV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="uprV6ebV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42136faf3aeso18955635e9.2
        for <xenomai@lists.linux.dev>; Sat, 08 Jun 2024 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1717876424; x=1718481224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrcCekVD0gl3+OYlStx3tXHkGj3iHIBZZoNIG/mm/UY=;
        b=uprV6ebVUfJAodqN+S2NH4dQ6sop60Mpr6kTp58039jQEUF6Dvu2IXzB7Me/0AKOfx
         ik3omu5sk8DVNeRUXIM7pQXziuUscdIuZn7nUHWqSuigos3e/hOQMaZXU+4V3xoK36GM
         zBTrlsuMYrUoBMccw8gCJbsWzZJSubHhod1Xf8X/YwqFz3VLJdvjAze8yplUiAC8RAAg
         5pfxihcywtzRWQxA/CtWfX6nIoXQPQ4uuPcdsGWvnwj7gNuD0ifnko4W+4j65qGncBHV
         MPuad9wFkebZ59yEiTzPVrGg/V4uFQSv7R9EAabQmlAxtYCrIKbyYEI2ZjS8HVKN2rnA
         0cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717876424; x=1718481224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrcCekVD0gl3+OYlStx3tXHkGj3iHIBZZoNIG/mm/UY=;
        b=n7GPzJhEDY7yjzcksu2pyKN8iIU13oikpxTCSy/5efWnB4xnA+nmTWUk/TDvMOERnW
         o28YBDf+pSimqYszOfGnYFSwEhAZ93MA1HtBfVNfpxYzZWYFrdxM0QytCJzlrPegocwa
         u9UIQb9YEyTCntU+ziuhAyW2Zwlb5ycydDjX1gGKzFDd4+slvaVTLubesm/fdA2qH77+
         DgtQfnhYVF5jwI1i+I5DO61gJ0isSGBk9iRL2L09FvhDbysSdxM+sN9W8/xxlSPzxz9V
         iuM1kdIYc9Ehk+oD0vK/9/u8d/86nMh2pQhBfrw64QQAzqj0+yhRUXrVtnvbBtwgPHdZ
         YbWA==
X-Gm-Message-State: AOJu0YwzrwYFkITZGuRTWM7Ywaub5jSXMcs97LOyNh35CD4Gb/ZFNDql
	t3ZrSnht7lQJ9SGlYFvDLFV+BS1zrYJG2EeVU86JDe9/15qP05SPXDAn40LjFW/r/Qc4VAL0Jxl
	b
X-Google-Smtp-Source: AGHT+IH4292LpbZfZLJZRkWfDlRu1MevSrpCCiq1YUr6QpAwArIWPZOaIu2+i6oW0Fg7GTktVymhIA==
X-Received: by 2002:a05:600c:4752:b0:421:182d:9232 with SMTP id 5b1f17b1804b1-42164a031c2mr47630645e9.18.1717876422932;
        Sat, 08 Jun 2024 12:53:42 -0700 (PDT)
Received: from localtoast.asozial.it-syndikat.org (212-186-38-205.cable.dynamic.surfer.at. [212.186.38.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c423932sm1149608f8f.114.2024.06.08.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 12:53:42 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v2 1/4] xnthread_set_periodic: Improve period adjusting support
Date: Sat,  8 Jun 2024 21:52:49 +0200
Message-ID: <20240608195337.11137-2-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
References: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when a periodic task invokes xnthread_set_periodic() multiple
times, the timer is reset each time. Consequently, the period drifts
because the elapsed time is not taken into consideration.

To improve the situation, this patch alters the behavior when idate
is XN_INFINITE, to keep the current timeout value and alter the period
only after the current period expires.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 doc/asciidoc/MIGRATION.adoc |  3 ++-
 kernel/cobalt/thread.c      | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
index 7a32b9921..2a46b43fe 100644
--- a/doc/asciidoc/MIGRATION.adoc
+++ b/doc/asciidoc/MIGRATION.adoc
@@ -756,7 +756,8 @@ upon notification, which therefore applies to RTDM tasks as well.
 - +rtdm_task_set_period()+ now accepts a start date for the periodic
 timeline. Zero can be passed to emulate the previous call form,
 setting the first release point when the first period after the
-current date elapses.
+current date elapses. If the thread is already periodic, the end of
+the current period is used for the first release point.
 
 - +rtdm_task_wait_period()+ now copies back the count of overruns into
 a user-provided variable if -ETIMEDOUT is returned. NULL can be passed
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index cf3b4dbb0..8738fadfc 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1273,9 +1273,10 @@ EXPORT_SYMBOL_GPL(xnthread_unblock);
  * point, expressed in nanoseconds. The affected thread will be
  * delayed by the first call to xnthread_wait_period() until this
  * point is reached. If @a idate is equal to XN_INFINITE, the first
- * release point is set to @a period nanoseconds after the current
- * date. In the latter case, @a timeout_mode is not considered and can
- * have any valid value.
+ * release point is set to the end of the current period, or to
+ * @a period nanoseconds after the current date, if thread was not
+ * periodic before. For XN_INFINITE, @a timeout_mode is not considered
+ * and can have any valid value.
  *
  * @param timeout_mode The mode of the @a idate parameter. It can
  * either be set to XN_ABSOLUTE or XN_REALTIME with @a idate different
@@ -1336,9 +1337,14 @@ int xnthread_set_periodic(struct xnthread *thread, xnticks_t idate,
 
 	xntimer_set_affinity(&thread->ptimer, thread->sched);
 
-	if (idate == XN_INFINITE)
-		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
-	else {
+	if (idate == XN_INFINITE) {
+		idate = period;
+
+		if (xntimer_running_p(&thread->ptimer))
+			idate = __xntimer_get_timeout(&thread->ptimer);
+
+		xntimer_start(&thread->ptimer, idate, period, XN_RELATIVE);
+	} else {
 		if (timeout_mode == XN_REALTIME)
 			idate -= xnclock_get_offset(xntimer_clock(&thread->ptimer));
 		else if (timeout_mode != XN_ABSOLUTE) {
-- 
2.45.0

