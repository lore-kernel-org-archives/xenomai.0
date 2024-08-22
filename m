Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE316D9AE
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314096; cv=none; b=u6+d8J/mR4Gqw+KmizNKF1lgaFGvl1CO1GjmsQWrsXRMKjkIrpFamp9LPUDa505XMpF1dU73w6LrtUD9zsn3b+vnENsRmBAYx2w/PfKKYY41oUAksZAx0qiID9HjTqgD4iEOKPerzZzLdbwUcCGSdVzjABF1WSjrKUx1qeDAWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314096; c=relaxed/simple;
	bh=Hkbis8BMhDvSHq4yDdRLiAo2+1YctPZ7r+3en7XPIwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ3jiz+4l6ufnrnHWFnlhSRtVExM5Kcw1kD49oIiOTm9wnlpB6bz/YOwOw4yW+7VwXEcjWvjcLxIOkR+scUcfL30MU1m7BendeM0oaX9GBT/cGLpc+27P66zqnkMQL74p6PiyLOzLqepljhuQxnRauqZkhc78YjcLygboB1cVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=lYy4KpZj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="lYy4KpZj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso3185475e9.1
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724314092; x=1724918892; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VWd0TgelW1Z/QTz3ewwsxKSUBEDRBhqEo5zsaohzI0=;
        b=lYy4KpZjLqpkQuNdUzXQO9hyNGWbTrhyrpAc0iwsprQ64stsMGSk1ps4WKNdjfR5W9
         VHspV2PbwtnYPy66ZZp8NTXFrKTEYY9UdO6WeI2fh2EEA/WClm9XvanalowL3df2XW4I
         9PLYmbaoOQ6HxZTFraRI66rDZjoja1aW1ziQRDrHyjVoPc6uAKKgnMygF2QCmHg9SAf7
         sNVyO+E5LTGcmWd2cA2U7eRayqwNgGPheiK8pD3mA/WIKQoHqypTuT0rhRU/DueEyDN/
         AhQ36EUeiyjbawEvvfIhPYDmhfmn4gK/kHz0vcHeJVr8BYA1eE3mgu1pXILd5xr3kpOP
         4TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314092; x=1724918892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VWd0TgelW1Z/QTz3ewwsxKSUBEDRBhqEo5zsaohzI0=;
        b=ORUQa2Ha4u+MWB3a27ZIQxU2HTQnZvOb0jHsFn7zN8lkwC/XLMsfGAOZjMVgu+v4p7
         0dMAvzjKsM86+qVBozTpJco6l9UJlACUUqBqOa0Ya9ZCRz88RD01L3f1BO265h3RY8CA
         zRx+GXu6TWnE2mBn1yPX6B/X3RChHlPcrSVjkrNvdPbJlIui7KRiclCeQ6wbHh/Vadbr
         2SKa1ZXAme3v2u9YWVOgKUq1TfKb2h3BQoS5JKWtvX5LE8nWENagM+FtmWoA8yK7V96j
         Oz039WJTr8bBQYBq1yQ9n5OCuvN6Fy37ru7cuKS/cjeMdxSk7Xa1bQ9+Hz7eAiMuraIp
         2S0A==
X-Gm-Message-State: AOJu0YwLgsOyfxgWj1IyKqdIemOElVARq/wfC5i7redUoYi8sddfaZ0y
	K4LYEC7fRoQrZXN6O2P47ZwYBDWIbuxvyJD5fH5z9zlQCzrOZTbTMmuDusxDEDPg42gmhWtCo9s
	PvGc=
X-Google-Smtp-Source: AGHT+IF8vQVwdwTBqygh9XFCUPDq03SDnarsxxVZjWbnyYML1BKZkXteCQb+Y5TAz3Z9BoL11XtzCA==
X-Received: by 2002:a05:600c:5247:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-42abd23c28cmr30571865e9.19.1724314091936;
        Thu, 22 Aug 2024 01:08:11 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefd9cd1sm52565255e9.38.2024.08.22.01.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:08:11 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 2/3] lib/boilerplate: Get cpu-affinity from env var
Date: Thu, 22 Aug 2024 10:07:36 +0200
Message-ID: <20240822080737.17939-3-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822080737.17939-1-simon.graber@sigma-star.at>
References: <20240822080737.17939-1-simon.graber@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It might be helpful to specify the cpu-affinity via an env var,
XENO_CPU_AFFINITY.
This commit adds a helper function, called in __xenomai_init.
The --cpu-affinity= parameter overrules the environment variable.

Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
---
 lib/boilerplate/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 26c8c4c..4249cd2 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -383,6 +383,19 @@ void xenomai_usage(void)
         fprintf(stderr, "--help				display help\n");
 }
 
+static int get_affinity_env(void)
+{
+	char *affinity_env;
+
+	int ret = 0;
+
+	affinity_env = getenv("XENO_CPU_AFFINITY");
+	if (affinity_env) {
+		ret = collect_cpu_affinity(affinity_env);
+	}
+	return ret;
+}
+
 static int parse_base_options(int *argcp, char **uargv,
 			      const struct option *options,
 			      int base_opt_start)
@@ -560,6 +573,9 @@ static void __xenomai_init(int *argcp, char *const **argvp, const char *me)
 	/* Retrieve the default CPU affinity. */
 	retrieve_default_cpu_affinity();
 
+	/* Environment variables can be overruled by arguments */
+	get_affinity_env();
+
 	/*
 	 * Parse the base options first, to bootstrap the core with
 	 * the right config values.
-- 
2.46.0

