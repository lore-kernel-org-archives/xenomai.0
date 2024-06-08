Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9953A1CD31
	for <xenomai@lists.linux.dev>; Sat,  8 Jun 2024 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717876427; cv=none; b=Brwvbtw7D1cCokeAuRxjiXtAEPU3FcFQ+tqwbJmhBbW3t0CQSrvB2tmGOyZvI1NP2FXW5OR3qm8MplFpnt5Eih6o0yUxEoSVmHiZY32meqdukl+M/L51VoMeoxM84EJGYrG1B9u1as6zq9rY8UhEi4xtwKnl73RX2FttCudvwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717876427; c=relaxed/simple;
	bh=/m3OnG1M+6q6gSgPDsN0srRCax72/gmNwbSLxzUXetA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o14vs+EJioxMplaNx/zGj7YChbqfpU8rGFvjQ37xai5dRZuGWyodSFQXMHul0uZk4W/Q43N1n1FrTU7aS4HhL4DlKFpuyZFYqPt7V2GnUBANQm1YDDTMJuenfsPp5uvkD5JrKsbwaKNWVYKSyrPRM4PL33lbw5E7Il2XmADvwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=jtPBA140; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="jtPBA140"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1cb7a40fso232143f8f.0
        for <xenomai@lists.linux.dev>; Sat, 08 Jun 2024 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1717876424; x=1718481224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amJiYbGasPHj6GUK6eQHOJXz8aeg8xcdHveRBE3LCUg=;
        b=jtPBA140GUTRRMepRPdsRdjRMnxW+aWhZklM2LyXh+0VAumvZbJ822/oSwqxbny0C7
         iL670YfG+dc3+Hj0BnPKKA9hpKEGooRxM3+dbUSE1gSgJRGFgAgt/fZ0x6bxEWUhDe4d
         WWlHMFvAbaOSDZBVlDIuhr/xJIXJsdyjBKy7kN8Bte2kTBwG8wYfBXNuCMbxcEekhnEz
         DKOaSdrHBi30tBOkqAx0faD+cigbK57StN47bUnPTJDwt70skV6yrOM4APBWrgWKaa92
         to+K0Lj5PSSsIkQXLP/Sp+ouC9vgMs0AovwSlnDG8AE7dlILbZaGjTIxfVQI6o6KEvR7
         7PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717876424; x=1718481224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amJiYbGasPHj6GUK6eQHOJXz8aeg8xcdHveRBE3LCUg=;
        b=iYdIgzKlVwuP/hB+l6h2SqOaNotypAJus3huRMmf8GynhplovjM8Oc10acfO6EjPOc
         FqD/If/8yOsWdBcwHBTForJ9pW4snOndrv4Sbp+mTG3fwTWqJSZMhm2TuVKigfm6OjlV
         9vjX5ongX9MPLO5AO80GW0oCKPHnQuU38auIROrACDuGGHLDRkxLdbtfDb0bKcbw4hf3
         wWhHZicHl499iYTTIo//DoM/Brloe9InhnmQL/yKkAUcLSrVoW61zrfjqMHe65hQvVrj
         gz4c/fejY4+HpwH9ndo+1I8XLUTNQs0BAK1RL6cmXlABxea+RoT/TBCOHm07MmkM+9+U
         yuLA==
X-Gm-Message-State: AOJu0YwIJJNrMSJGtkA3s/4Pq9bnFNcTmd7omBIbvYo3QsVojAbe+Mmq
	vPvm7K9ZXQWq1vXAwROQ2yfpNTHWLgteFoXprPx4/Xmp2nzGYtOIGI7DDXszKA3RxV3Yk9pQPjX
	z
X-Google-Smtp-Source: AGHT+IGRUbuZUDZO1S+Z85QBxn05emfhUToTLvtm9jp06LEIx7qe8wT/7dVQ9Q/rqxVcoB1a6Woo1Q==
X-Received: by 2002:adf:f292:0:b0:35b:1d7a:4868 with SMTP id ffacd0b85a97d-35efed1d4c1mr3373714f8f.6.1717876423663;
        Sat, 08 Jun 2024 12:53:43 -0700 (PDT)
Received: from localtoast.asozial.it-syndikat.org (212-186-38-205.cable.dynamic.surfer.at. [212.186.38.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c423932sm1149608f8f.114.2024.06.08.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 12:53:43 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v2 2/4] lib/copperplate: Add threadobj_get_periodic
Date: Sat,  8 Jun 2024 21:52:50 +0200
Message-ID: <20240608195337.11137-3-david.oberhollenzer@sigma-star.at>
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

This function serves as a counterpart to threadobj_set_periodic,
allowing us to obtain the expiration time and interval of a
periodic thread.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 include/copperplate/threadobj.h |  4 ++++
 lib/copperplate/threadobj.c     | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/copperplate/threadobj.h b/include/copperplate/threadobj.h
index c8363415b..bf57cf6f7 100644
--- a/include/copperplate/threadobj.h
+++ b/include/copperplate/threadobj.h
@@ -365,6 +365,10 @@ int threadobj_set_periodic(struct threadobj *thobj,
 			   const struct timespec *__restrict__ idate,
 			   const struct timespec *__restrict__ period);
 
+int threadobj_get_periodic(struct threadobj *thobj,
+			   struct timespec *__restrict__ idate,
+			   struct timespec *__restrict__ period);
+
 int threadobj_wait_period(unsigned long *overruns_r) __must_check;
 
 void threadobj_spin(ticks_t ns);
diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 0782ffb11..91b7c41fb 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1661,6 +1661,27 @@ int threadobj_set_periodic(struct threadobj *thobj,
 	return 0;
 }
 
+int threadobj_get_periodic(struct threadobj *thobj,
+			   struct timespec *__restrict__ idate,
+			   struct timespec *__restrict__ period)
+{				/* thobj->lock held */
+	struct itimerspec its;
+	int ret;
+
+	__threadobj_check_locked(thobj);
+
+	if (!(thobj->status & __THREAD_S_PERIODIC))
+		return __bt(-EINVAL);
+
+	ret = __RT(timer_gettime(thobj->periodic_timer, &its));
+	if (ret)
+		return __bt(-errno);
+
+	*idate = its.it_value;
+	*period = its.it_interval;
+	return 0;
+}
+
 int threadobj_wait_period(unsigned long *overruns_r)
 {
 	struct threadobj *current = threadobj_current();
-- 
2.45.0

