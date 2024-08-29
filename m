Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89A18C025
	for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920536; cv=none; b=sJ0vFEmynuCgleLGfYBMw6VgpnpIVkIrNt7c8UCCRxayA/4FdK4o5A8teP/1XmyHNv4uG67JeO8oHZjSQLniCYYi21Wng0MFI218lCF9+/CJwT0VaMasgcWPNFlzmCN60TRz/xAV5pUdLkxlCY3vd6SrmZ7WMITR0mR+ROsaIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920536; c=relaxed/simple;
	bh=QMxSlbag4dHe2jLq8UH9UWy9CLwaeKPRK+EH4btBtkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yy1m5QdrQ+OlFCZNlbeO2TZEO/DVgkuUZlWBorY1lnfIRsPvo53Ot57Jvye3xIXSfDZW8syS4A7lTJifYc6FvfBz1By0uvbMlov9tYrmC/pueuFfsghnSHvvUs//xX0XvmcRPhBexVQhR4VBzZdcUnA50CDUwVln1xVUl6JOXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=oGrKvTDs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="oGrKvTDs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42808071810so3485105e9.1
        for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724920531; x=1725525331; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHVLWbmp62Vj2d/a5Lz2Zs4p6BRtU77YNWRNldN5Qjg=;
        b=oGrKvTDswQtt5jn2/+mFIwfcIdj59zya1z0+dcbx64FF7k0W4CcwiG9T1zhgaCmK2d
         XCUvHhEUvnTpTLyTdAgQq1vEf5j5A953IyMp2JgX0PyYXTTJ97S0S7XsTgRJH3/Tmaat
         CdtJA+Mx56syZi4ygGQlBXC/Wx8mC8YK9Ds8T05DkfCswpVf2o0B0oOQx1iN9Gdb5+8Z
         wURwurrKMWx+K9F8Wc6ClZWk6h9wdZAWt9lHuZeswpcCL3hF1pMlWiD+JDxApVdCknDC
         1BI5Nns8BzciEz+GP4SnD/3fThlC1nngrCxaG/7AY+FpC7tuT97RJCUeHP5RKXNMGYjS
         Ahlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920531; x=1725525331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHVLWbmp62Vj2d/a5Lz2Zs4p6BRtU77YNWRNldN5Qjg=;
        b=YzsnbiU72JvssGNCti9aJmjeWTlsVOYRhnTceyOynheYUcOMmTENg+U6uE6zGd192G
         0Y8KzIjHzp+SBxUGS83Gcv0NH9eKVAWHO/MYvMS+U5WZMOI5yZktSffPjiZIxE/bAKXo
         wOVOh7f+vdsmS5CeMPrxCCihnw0S6bJ97fUrM0FADp2NusxTcUKVFfaVAxo2u6KWqRYg
         uH0HrsFJvIWeoIQK8+gIhOop4vSFRH+emZ1bM186/Mr5dYinmrXOhAvNgYWyi8zrAb4H
         x9V+sbTmSvsodTcEHY2vMseWixDWbPOYhpXeqAaMVMKNjGq2DCX9hNzGfvHZUjvufSFm
         HSsg==
X-Gm-Message-State: AOJu0Yx7ZPPPxQdLxesuPZ1xRVHBBWGbcLGrt8MccC9mufpI0KUhbUVb
	EK6IZj72hypvZ5GYbaPuftiL2fv/YjhrtiSfPAQ/6tedq3i4vc0xyptO4/VSCbZ/ebNywPWTs0F
	Zmlo=
X-Google-Smtp-Source: AGHT+IELqQVqV44ioz+20w0GSVM9Xw9S2yA9DYezUCF9OGPxqs/2Bi0cJp1ZnP28QoYUuO7eAzdsFA==
X-Received: by 2002:a05:600c:1914:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-42bb27a9eedmr17385775e9.29.1724920530824;
        Thu, 29 Aug 2024 01:35:30 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0adbsm9995815e9.15.2024.08.29.01.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:35:30 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 2/4] lib/boilerplate: Get cpu-affinity from env var
Date: Thu, 29 Aug 2024 10:35:24 +0200
Message-ID: <20240829083526.24536-3-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829083526.24536-1-simon.graber@sigma-star.at>
References: <20240829083526.24536-1-simon.graber@sigma-star.at>
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
 lib/boilerplate/setup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 26c8c4cf5..9573a546f 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -383,6 +383,18 @@ void xenomai_usage(void)
         fprintf(stderr, "--help				display help\n");
 }
 
+static int set_affinity_from_env(void)
+{
+	char *affinity_env;
+	int ret = 0;
+
+	affinity_env = getenv("XENO_CPU_AFFINITY");
+	if (affinity_env)
+		ret = collect_cpu_affinity(affinity_env);
+
+	return ret;
+}
+
 static int parse_base_options(int *argcp, char **uargv,
 			      const struct option *options,
 			      int base_opt_start)
@@ -560,6 +572,11 @@ static void __xenomai_init(int *argcp, char *const **argvp, const char *me)
 	/* Retrieve the default CPU affinity. */
 	retrieve_default_cpu_affinity();
 
+	/* Environment variables can be overruled by arguments */
+	ret = set_affinity_from_env();
+	if (ret)
+		goto fail;
+
 	/*
 	 * Parse the base options first, to bootstrap the core with
 	 * the right config values.
-- 
2.46.0

