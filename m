Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE97194135
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615939; cv=none; b=QXmUq9iy//57cD3nSS8JnTSOepqiUgD9cuZPUZJnBKSuIKRUoZVMp6FBJ1wOidBU68w2NCRZkvRrxJLQcxOSUQF2+w23NH6QfSEY9oWpFssf9X3jJPpzQTnO1jo8pD+BuwxM3KlGDwO0agckL9+CR1IO4I8IuJV8kVuYYWA5F8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615939; c=relaxed/simple;
	bh=Yb6A7QpaL1FZANP2Wmroce5tC6zXDpU+RbL6f0LcYUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7B1gxBefBnF4kUMuEoiLn7MdsEMqt+n9a5KTsxe0x+8E1i4ZMK1z8Xr9W322fjqit0k6vSfVR//aB1ad13GcKHOgEN8/0XSfn+4LgvOzqLuoz2/VQbdt6AlBrCfnE9Zw9CX0NfFK/Sk08rbZglJEYHCuCeDo1lgSjYbUxUOpOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=HMVGEOso; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="HMVGEOso"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so40580871fa.2
        for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1718615934; x=1719220734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS+01HYTrzSx6ollIkIdJUXI/687IVP6GbwXs2+k+oQ=;
        b=HMVGEOsof1DHjJHuoD3dvFjlqssqjeoFXSntVr+pU5rXwFBvN9NjA48M8bMLV4i3XM
         PWBoUWUkY5CUpfdE6m/mSEQ0jHWO6V14AlC+LdRY8qqmCH+SIhhQDXZimF0PLNMWvzY2
         ala0Ak/XoBdUFkA9LffdazE1T8/3/+pZ3/8SaNLUfuwv6z1APQLHJ0NeMU3kv5liHDy6
         Ri10IaDtv+AJS3kVdG107pVVS5APfgtsUPoKF682iOrIfYzjyrvmUmzRI+XrXnmbpRqL
         QlDPg/TrQqljSXVlWWGItGAgvi9vxDsWxDZVMBASyqDvEKntwntD+f2L7jXMvLlFrzTV
         a2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615934; x=1719220734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS+01HYTrzSx6ollIkIdJUXI/687IVP6GbwXs2+k+oQ=;
        b=Rd2cvS9qB66S+PmcDRrM7/gSSxFQsQPM+dXICR9VZC7FjApiK6vyxIhTlRULe+16PD
         C3DbYo6K1FztEaE0psgJiiqX+rNpLNm3MXgDT7rV1tX1nR+BglPjnph1Q0Lcjm/SdQ90
         10hwurcU9RVM6mrnR1fSf0Xk8xoxfC4ezeL84o53nJX7/xq/WrKQb/9MMTs54Ymu6OYH
         xMC1xqgi9xA9KsIoGFP8y31c8FqlwhqLEEAxdEfKj/ks2q3M0/ay7b4P6UTNp/dB2bJg
         91vw43xsxW33Tyq4J6r9KhTsLoc/FQoyKofqIcG29XG3QcpI+HScMgoJAyM0by/MVh2s
         thbA==
X-Gm-Message-State: AOJu0YwyhCnvR/fif5hsPM/pl+exatRJStSINpRytKtwtHmn5roeZrOW
	D8b7RhImaxlHihM3bkmzx4iOGVd7HCbxpL2UoTT9uFAz1B7WwLg1GrcPbJrJBNgZPUxMg+6KIEt
	D
X-Google-Smtp-Source: AGHT+IGqFnRPVSMMDEFAtVDPe7aYPUSrTt1GMhUe+W9sl9VEtjbcbN6epoM5m7yia//zDUvi2v2/2A==
X-Received: by 2002:a2e:9ad5:0:b0:2eb:f5ed:4e85 with SMTP id 38308e7fff4ca-2ec0e5c577cmr62112141fa.13.1718615933898;
        Mon, 17 Jun 2024 02:18:53 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eeff53sm75591125ad.181.2024.06.17.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:18:52 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v3 1/4] xnthread_set_periodic: Improve period adjusting support
Date: Mon, 17 Jun 2024 11:16:51 +0200
Message-ID: <20240617091654.66342-2-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
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
 kernel/cobalt/rtdm/drvlib.c |  4 +++-
 kernel/cobalt/thread.c      | 18 ++++++++++++------
 3 files changed, 17 insertions(+), 8 deletions(-)

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
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 7378f2c01..cf03bce13 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -212,7 +212,9 @@ void rtdm_task_set_priority(rtdm_task_t *task, int priority);
  * release point, expressed in nanoseconds.  @a task will be delayed
  * by the first call to rtdm_task_wait_period() until this point is
  * reached. If @a start_date is zero, the first release point is set
- * to @a period nanoseconds after the current date.
+ * to @a period nanoseconds after the current date. If @a start_date
+ * is zero, and the thread is already periodic, the end of the current
+ * period is used for the first release point.
 
  * @param[in] period New period in nanoseconds of a cyclic task, zero
  * to disable cyclic mode for @a task.
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
2.45.1

