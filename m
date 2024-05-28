Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993934D13F
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879893; cv=none; b=O9xofrCU7GniVITitmtHV0z2BYDiwiQRH9MP5Es5nkuVxWHOT9tKepXnmdn5UwPwA++SGD3lwzpRuvZXOJ7OfZfZaRuxw9aXLqIDN/hVr7wKxWS/QcGAmDn50LeDbTXoImCjVqttxX1WhyeiXz1FrngBNsf3VMGB7ki4G2hAbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879893; c=relaxed/simple;
	bh=7AJmuDaTYwQ4IHQxsJT9UdmGNPjkUmvgncmDhRKmM1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM5Jj9i/VublVdQxtfEIqcelHjrc8tESchtFge1WXMBT09MimGN9JqVVlowkmgoLD/W8WiYCkcJ/p33mFvOzDyS2wFmLxjyzq/IPy1BpDMqekAjv3IqzTbYsICiaYbVKo/tus7R6vs8J9GCxnx0OdSSjsi5ZRsGzkT+oTBWEy0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ddK2sB1I; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ddK2sB1I"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42108822e3cso20547925e9.0
        for <xenomai@lists.linux.dev>; Tue, 28 May 2024 00:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1716879889; x=1717484689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzzlxu2OgsKlC7Atcgrlw4XFxHiL/HQNDDyOC2uHo+w=;
        b=ddK2sB1I94aTB3sYWQSjOVgmwIsJGYQJiJ2tP8Jjvi82A+UztD3oAAljDUW2n/7qYA
         4wx6sxfCjfD+o5oCvd0tgGoSeJ3Dxw/Y+0qtKRcHOUAG9fttOsAEysjb3OhYP2KYWUez
         Mh2EKuzSn6UPUfa8Sue/Yecgupg/xbgtUu08gHbgBHLsvbiKgR1eG0EKbLtdkewWIlH/
         P9EIyBWrGdAFnx/90y+xug5BJfg1SIdshfFBh0rFSwacO02zCd3rmgqEexDkJ3tRC6a2
         lZTta0S/SMAcY5y4SjZUeR9u9roI77EL4PO7NJozHpK1hQRdUgBkX6/hdUrG/XUpTq4W
         ggnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879889; x=1717484689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nzzlxu2OgsKlC7Atcgrlw4XFxHiL/HQNDDyOC2uHo+w=;
        b=pFYQb+DjbHzjH14d79UskvEuyugrYmczZ343LIMaYK/0PybYh1l41+AMNk5cVFCQoy
         yo+KgcFIlkiIBW4MLsp3HGQkVSTgHe/L/Puj74cy5ghoAHSHNTQmMsdUOvyK+9SFrVn5
         3jVoxZa+lEcOqJLMN5Vr8d3ZYlGy+BC0WZXtYrm1+RU6fef4LG30WU+aDVI3rNBeu3co
         yIbb9Uqq8mtGh6PRQ+sBkMG51YS661X4TaBu/Q/yQYFAQ2kkoe47jFkH7fnhXXmWKUjw
         NVJ5CDJzpk42uXvS4OZxg0261y913iHdAaJMEqeF/xmwB8Nk6QCrmCPEPjydQVeYIzrG
         sEFA==
X-Gm-Message-State: AOJu0YzdLHPxdu6Dy/2s8xIxjF78RaeT58xsvF4soFegP+ykT2cKK+2N
	+DRHDs+HKTrYqNMnvllF6ej0ePqPB1vTq47TuTotuDl8mkAIgrUJ/j/UOxLTzWpkqdu40QoWjeh
	R
X-Google-Smtp-Source: AGHT+IFRhnHs6JmlAGKUsNZPInX65jUBT7t1yK4I6dgxVM6YE97DM/zTukedQvkBCRYV3J19vOiMZQ==
X-Received: by 2002:a05:600c:4f92:b0:418:3ea8:46c0 with SMTP id 5b1f17b1804b1-421015eccddmr115301365e9.13.1716879888602;
        Tue, 28 May 2024 00:04:48 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100eecbd4sm164340355e9.8.2024.05.28.00.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 00:04:48 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH 1/4] xnthread_set_periodic: Improve period adjusting support
Date: Tue, 28 May 2024 09:01:37 +0200
Message-ID: <20240528070432.6669-2-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
References: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
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
 kernel/cobalt/thread.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index cf3b4dbb0..de97b7e70 100644
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
+		xnticks_t start = period;
+
+		if (xntimer_running_p(&thread->ptimer))
+			start = __xntimer_get_timeout(&thread->ptimer);
+
+		xntimer_start(&thread->ptimer, start, period, XN_RELATIVE);
+	} else {
 		if (timeout_mode == XN_REALTIME)
 			idate -= xnclock_get_offset(xntimer_clock(&thread->ptimer));
 		else if (timeout_mode != XN_ABSOLUTE) {
-- 
2.45.0

