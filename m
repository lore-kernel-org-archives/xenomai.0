Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0C53AC
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282693; cv=none; b=DlwTeUluQ5cHWOo+Yi+RH0Alg9kZ9QG5jct2rlDfw3jYqDLUA/kgf4dVyOwexeIiKJW1/R1Pg1T9e3K5m6ykJLd/eda/tZM6C1uBubCF5I05W3yKcAo+HyGxSOVM3ur47sV6cB8Xui3w/An74gIKOczAnITBog87p6HL1N6XNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282693; c=relaxed/simple;
	bh=QMxSlbag4dHe2jLq8UH9UWy9CLwaeKPRK+EH4btBtkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEAVVNmTxtVu3KdqA0pBq5hgAr66HFBufREtgyq82CYa0PdmbEA2lZn39GN9kZ7++9FZkfcZebqDI5MfWSZbWs19ES+dwMv9f2uJx/bYIaD6DwDJ0dbn975v5J06iJSoeck0VBuzGokAlT2kZQACok3Kg5DlRSfjz3YukrsV9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=kYu2z/YS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="kYu2z/YS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428e1915e18so35188855e9.1
        for <xenomai@lists.linux.dev>; Mon, 02 Sep 2024 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1725282689; x=1725887489; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHVLWbmp62Vj2d/a5Lz2Zs4p6BRtU77YNWRNldN5Qjg=;
        b=kYu2z/YS0nzMxv0zxTsYvsAvZRNT4k5umC/xQRNFfFaE7HdjBjI9b6hlpzGH3cuJ+5
         faqg95ZrgO+V+tZUysm26F0C6pTm3VFuvhf1+qWRCV571DZjPOiCa52E9HYf/3OcfLLX
         B9UVZy/kxdCNJwZ6g30Ni5orLYnwuETssWx4yx/NKqdHuhXscengeeTz+NRsD1ESvE5a
         InQ5awEEIeF/H3OUY/4uU8RLVH9MjbKJITpKa+KKfK4+F1wBmQceFGjMspD9DBcvGJKT
         Cer1OZH/eZxZByQIdigyfLCGxpcX4Se/UI+RDIO4Mt9LR0b9Lh/REAwuVnyR1Tuzt86g
         aVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282689; x=1725887489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHVLWbmp62Vj2d/a5Lz2Zs4p6BRtU77YNWRNldN5Qjg=;
        b=UValp3l1jKAmZi/DUDWyoPGIAfgggCSninmOyEjgZ3ei3Ink7o5monzU9of07NHEt7
         qmlc6ozPGo7Dn3YoDNzmLetbNJORyWF+ypW+ieaDTJcEtHBgSozlVNWgLbLjwnt8sRCG
         t4P/4xhHeL2HZS75j7mG4mqVphcJy9VMhvd0W6IY4ddoobDEL2yTZX9AKC+fyeKHJPIx
         2Ib1RTVQ770/lq8LWX6WGcz7aSSrgqmLY8m3XteXwgmcw9+x1iH7FL4d38Tmmpkxjr+0
         vNw7dtXADjL1esr++DQ84E6FYS4lRoesXDxBKEj0JCvSIpx022FzRLjO3G506pGB+92m
         sAXw==
X-Gm-Message-State: AOJu0Yz6sUJVt/Wyz87aS6yOwX5WIUi4TGY5PuuhyK5q5p7GM+ac+CZV
	tpjJTe1CenujhH1R7gyvEl0nZGJk5D4VCN+vqITT62TsRCFU5ae5Pyu+fgv250sA2u6f/rROcgI
	djuk=
X-Google-Smtp-Source: AGHT+IGvn91J9Pdd2Lp9TehR36ejplGDrn0SUyJCj8ZdxvPgWTu2Qme0xWtSwis0aO+kqXnlOdLouw==
X-Received: by 2002:a5d:6b91:0:b0:367:991d:8b76 with SMTP id ffacd0b85a97d-374bf04f7b7mr3905018f8f.15.1725282689062;
        Mon, 02 Sep 2024 06:11:29 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba83sm11511430f8f.54.2024.09.02.06.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:11:28 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v4 2/4] lib/boilerplate: Get cpu-affinity from env var
Date: Mon,  2 Sep 2024 15:11:22 +0200
Message-ID: <20240902131124.37844-3-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902131124.37844-1-simon.graber@sigma-star.at>
References: <20240902131124.37844-1-simon.graber@sigma-star.at>
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

