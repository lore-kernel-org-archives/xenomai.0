Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF2158D66
	for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748330; cv=none; b=d7xk48DZIuQ+e05FByaiYlV0teujZ4hjtNKTL6tFAsdUMfmsZv3b+JFKYa5AHoVIg34xb/8WIuxc7xjCPHEwleP1VzceM6n2M7Sm2tKQa0qjtvP9kcIYQsZBeTootRWGvYUbMa4opolGBq5BN0M7kgyVLte0JHYnvPgD9snWa3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748330; c=relaxed/simple;
	bh=XXcegJozZVgSOBp2cW1A08mw18GfKXL8oV/zfGzvwVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0Ov6zddjl9JC9FqSqvAJone5Fa3AEz/14OCYBNPQGMoQS5Ekwy6EYm47jHUxiOEcaNCXJwNCCoOqFF8Xr/lCEXURZlkAIAShVk0quxSLi2AVYhCluXxHKf+8irhsqAix6S24523II5Jcr+yosJjFPomHB5w+ScJwOT/lQUmFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=pEHOzn9I; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="pEHOzn9I"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428163f7635so44552495e9.2
        for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724748326; x=1725353126; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ploWiWn+iSW34oezfGMq2K2fi+e5KkbYotP7KFPbSyY=;
        b=pEHOzn9IgMYukcDZi7wHhUA8sPB+Kzft0N9QJxQQPmpg4b6Rt5xwVi+eq1OpDrX43a
         PHt7XOw1cNNrk8ZPhH9Bl3dvySVECn7qA2ueUD+VZzyjW68+Ur1DE/i9Fnz4hEqyoiY6
         U9OIxK0KsbqiKJBKAFeyB3nEKBv3GjXKW4i9f9zrWfhnq2PM2DijCz7tA+FTsUsZ/X34
         ShZe9/x/tK7Foi9qHXnHjDX3NHj0n/xYHZVqAnQBAyrR5QEqSHgQO+Y/jX+u+RumeH1V
         OXEg4RpNP1h7lw3LDxYFvfeWEumtlHNoRHHWxHvs7OXypkNudOZNYh/aywkxVPF1zTl9
         Aksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748326; x=1725353126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ploWiWn+iSW34oezfGMq2K2fi+e5KkbYotP7KFPbSyY=;
        b=AJAcAeYa/ahWkcMcxVsgGNPVn2QglpIIYbvnf/XFPpQT7UR0dw2Hff5BbF8TgdNjsG
         2JtjnnqOjNhBNYlcF72xiIyLyj2a5PH+gREapVQ/h/Mxs2kYhuLXiA6XfxGn2OV6Fp4x
         U4KNJYnJ9HjHHDslpQoL2iTrPNuvYStZdzqLdvS9CTsKc44Y0yGDqs4nlfLRbfarV8uR
         c2ep1aWxvzmhAXo78nbMXLFiZLCXIGPWcFA319bgbk2TwSMtfBYniTaEywlBRmCUQXC/
         HazrfsbPBdelPeNJbwlVMiFS2ilDgKVIWrIZDPcVssz+uoiNd+Vca7wbYjV2EBVYIcho
         O+DQ==
X-Gm-Message-State: AOJu0YxKxiLduXCV9OCGFmhdVLe44uPQbpjZIKnrtb3Csu6269PVpmOU
	7Kk0HSKrGj6bHJl+v8XhhQAzaXaHErnRxaosqgv+ced9K0Y5ZqvvoXIL5WUECoLH0Rh9l9uKMsE
	mp+w=
X-Google-Smtp-Source: AGHT+IEsovcRVZ4UV8x/+8RMRxThVJwBfGY8wwx29HH5LYBoqKHQGOdL6eqOer+0CzVqL/1T44O3XQ==
X-Received: by 2002:a05:600c:a04:b0:426:5f7d:addc with SMTP id 5b1f17b1804b1-42acca022b7mr69946155e9.37.1724748326131;
        Tue, 27 Aug 2024 01:45:26 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86da6sm211779435e9.17.2024.08.27.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:45:25 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v2 2/4] lib/boilerplate: Get cpu-affinity from env var
Date: Tue, 27 Aug 2024 10:45:19 +0200
Message-ID: <20240827084521.13547-3-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827084521.13547-1-simon.graber@sigma-star.at>
References: <20240827084521.13547-1-simon.graber@sigma-star.at>
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
index 26c8c4cf5..4249cd230 100644
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

