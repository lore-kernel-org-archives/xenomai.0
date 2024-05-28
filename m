Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E35339B
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879893; cv=none; b=jx/dqSHHea3CEioUs+Mw8QoyVBW0WtDF1Q5uy9LkV4XL3UP8v8LPWB48GDvvbddtg0nKYgjy3lJ8g3F/LC6n5ZziR/NuYvBc262sdWP6NKBI6HwvAGVRuJ/TFBuP5TKIBsO5zTCeoUxA9jHEyPgo1IYx/WsCvy2r80Qz4vdmAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879893; c=relaxed/simple;
	bh=/m3OnG1M+6q6gSgPDsN0srRCax72/gmNwbSLxzUXetA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrDvoRmuTp1dF+hMO934XHbtlrLNcLx+ogiSMDa4mND6kV0J3jZaP9OyA+cX9KJ04ZNKOMJDdB2H3oZg6ymkcO7SX0pOb0+BvChqGUof6k56XLtNGK790kdmKUw5zQaZzrUx+yuv6JZ2IgH9inB/vCJkUKHou9ymqoW+feE0tbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Qhzt34YC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Qhzt34YC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420180b58c3so3595375e9.2
        for <xenomai@lists.linux.dev>; Tue, 28 May 2024 00:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1716879889; x=1717484689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amJiYbGasPHj6GUK6eQHOJXz8aeg8xcdHveRBE3LCUg=;
        b=Qhzt34YCFUI/4Vsn2YKI6Eb3MImJxcGCuJw2pQcQ43TJAIU1Ot3tZvj+1lO9oQgpY7
         yHJElW60/wSuVgB/XJ1LUChEysgbJ3DBX7lYVrJeuwhPqdiBMKvcjY0dqNkR1EMoD+pI
         cncK990sCixWIGWsSLFr/umU+98CKjOBgrR4qBA3VB7DMt7PImM9lwa+aFyh40sXccLp
         hEmM5Qewju7k4yZBUE8ktrmtXOjlOpb0oR0IrNf+lO6ett4m0lXYs9gGpbDv8EjUcY8m
         3/mFDNdTeFrTB9z3WuMKREnslOzP6xsHL583hYXmnd+aHQ32Mg/Tn+GxGQE4px2AoJ/B
         E/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879889; x=1717484689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amJiYbGasPHj6GUK6eQHOJXz8aeg8xcdHveRBE3LCUg=;
        b=ifqH8uYfa1a/cpRLTcaf3NspyromT4HjrBx1NUVWCdciPfIsqg6vvJdVYtzG5l0RRf
         eCw7CRECrvd61CHUajULBtrCM95ICa2whXBVBuyXonPctOuj3ZCpmQcFAKWehzIzBnRU
         K+2F8HaK+t01ODc5Oo2Xs1qE4d1lvvg2sTOjB6Bd2aUQnHas0e/HCj1+e0K/nxwwrFTO
         v5QgJ89xDhsiEmfn+nkcIunDnU7mtvLrO5hvJMdbjIljKRcPkqE2Re3nwlf1DsYx/A5r
         La3Yfr67aRHb4VIg3FmNoG/ybPMTvOqabDqPSco5MHfOLz/Qivbko67nLVVt3LzjFMhX
         eHTQ==
X-Gm-Message-State: AOJu0YzbxOAjhEMOSa70b+OihgmNfVg2smM9/p3KD31ql6uz778urusx
	RVpNR7bHZAMUcGj9+x9jHyDTNuEUcjca/EDqf8hb0JPPVnURTcXhRN7SBuIwKVq6jMcNsUbYYZy
	z
X-Google-Smtp-Source: AGHT+IHYirk8FIyIJA62TFuhxz2dQjpnQdRbj8Omen56dQ4CieVV0rZC6pJOLr6Pd4e9Szuyu6MLdQ==
X-Received: by 2002:a05:600c:2282:b0:416:bc18:2a00 with SMTP id 5b1f17b1804b1-42108aba991mr91826615e9.38.1716879889331;
        Tue, 28 May 2024 00:04:49 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100eecbd4sm164340355e9.8.2024.05.28.00.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 00:04:49 -0700 (PDT)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	lorenz@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH 2/4] lib/copperplate: Add threadobj_get_periodic
Date: Tue, 28 May 2024 09:01:38 +0200
Message-ID: <20240528070432.6669-3-david.oberhollenzer@sigma-star.at>
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

