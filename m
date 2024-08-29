Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED518C036
	for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920537; cv=none; b=F9JuYPVgYKcSajJHV04RghzCwlP1hODKIFKEs5CQVt7m0YXlcoUq3P31xEKE6f3L3Eg6gC39mrauwcsaZL5cNiAYFt2rJ5F3KNl/QGHDoDLgfSdzTFs721+uSgEmF6hrMVg/p+0eXO0RDfIhq0ORL/CqeSa6zFMR6EG/OPLHsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920537; c=relaxed/simple;
	bh=GkGe2MbLAmBgcVqoW5bbBNHTYIb3EzquREFFmZa7HOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG2Njxk6+hHQpvkhrFZF0kxsG+vTiIFzy09VywnLcCJzRvTYlbHLDoMna4DhXvi5qkNDEZLxaPkBiSJZzG6vMe7U+/iDoKbeMubWqf6oOmNYXpimEeYYxyvwU2uSkTKGaarRVru+0/BGTTiecDDeu+nfvDFmNWL1cJX1fXy0EpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Zbf7knMY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Zbf7knMY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371a6fcd863so265415f8f.1
        for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724920533; x=1725525333; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygUatbpumzocyN/aWwq4fsKNrUZNnY1PLNHUlk8CfxI=;
        b=Zbf7knMYEJhnJfM26Bk8cl0MiJrlSqbY0+QgfUZmfFmAJHQktrlrvT7+4FkE5qrUBx
         9ERdGY19iEU6G0OwvP6qHlac8GFiJLLYzfTSehyiz5FT9lWpbo74N0F3H4xvhtexRskM
         XptMLXkVJZ966UnHnHG8hdeu/tsh2dNFIDXTrf8/Dwqk30jJ7DLLdaoALu9bOym3KKe3
         Nq0sjYKG4WgiEly2XkTZYQkydtLGeUH220Iqqjukrlj4r7hXxF4I244NzrX8mVaaQLe6
         NH+BSLXQJS4feaAaz9dKnc5/UpJioGu0aOlAXcqwToHk/mc2ZdyPwY7iavGDpPhXuizg
         zAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920533; x=1725525333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygUatbpumzocyN/aWwq4fsKNrUZNnY1PLNHUlk8CfxI=;
        b=ohH8VKiIGGxbPVI9gL/gI3nKPCggl8aQhr3Ms7tl29axhhJwUNb8ovDg7FfrtCvKwv
         0qOjLDvcsRhxv/R0XD63Pz3T/MD1ZJ4irFKVNXMsGo0tp6/P2Di8xUpoiwkViuWkXWg9
         VjoqUMYqM7erRjcPM5KLvRJX7o7IklSqrmtzU3OuMamo5y5ANkczW9xSEkVgricCQNuF
         7KlFsoe5q2a6i6cuABr3m40rV0vcl4qW3Sb+CaJQ7Jx7ujlKXoEHN+DzmJlybIkgf9aN
         lZoh1g51WORhCFfWrITwsowGq0Y1uWDj7ZzzBaMTazQXAsaOtZkLhfu7pzskWMUCAkTC
         jJQw==
X-Gm-Message-State: AOJu0Yxn/nWQE+gE11FnGUynVBzsbjlnhhRHrdFEsXutH0NffZ2+W0f3
	kFY9ry6ixFHzMl8mvYZvg+MHvCdiRhNC2WKfqN+kP5mBjhXoS64Mlxof5SWgtPlQh00wdsgA290
	p5Wc=
X-Google-Smtp-Source: AGHT+IGgaAT8dAHghItSisNqE1RL9ad+6T75TvQG3HNVXZxI0hHB4OmvJ7dVBLLVGJdCIpoSTwrRAw==
X-Received: by 2002:adf:e642:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-3749b58728cmr1282825f8f.53.1724920532651;
        Thu, 29 Aug 2024 01:35:32 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0adbsm9995815e9.15.2024.08.29.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:35:32 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 4/4] Add documentation for env vars
Date: Thu, 29 Aug 2024 10:35:26 +0200
Message-ID: <20240829083526.24536-5-simon.graber@sigma-star.at>
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

Usage message in lib/boilerplate/setup.c now prints
XENO_CPU_AFFINITY and XENO_SESSION_NAME.

The usage of the session arg/env var are also
described in README.INSTALL.adoc.

Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
---
 doc/asciidoc/README.INSTALL.adoc |  7 ++++---
 lib/boilerplate/setup.c          | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index d2b7e6f78..52bef566d 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -428,9 +428,10 @@ Generic configuration options (both cores)
 When this option is enabled, the system creates a file hierachy at
 `<user>/<session>/<pid>` under the registry root path, where you
 can access the internal state of the active real-time objects. The
-session label is obtained from the --session runtime switch. If no
-session name is specified, `anon@<pid>` will be used. E.g. looking at
-the properties of a VxWorks task could be done as follows:
+session label is obtained from the `--session` runtime switch, which
+takes precedence over the environment variable `XENO_SESSION_NAME`.
+If neither of these are specified, `anon@<pid>` will be used. E.g.
+looking at the properties of a VxWorks task could be done as follows:
 
 If not specified in the configuration switch, the registry root path
 will be +/var/run/xenomai+.
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 9573a546f..7bb24f6f4 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -370,17 +370,21 @@ void xenomai_usage(void)
 		}
 	}
 
-        fprintf(stderr, "--cpu-affinity=<cpu[,cpu]...>	set CPU affinity of threads\n");
-        fprintf(stderr, "--[no-]sanity			disable/enable sanity checks\n");
-        fprintf(stderr, "--verbose[=level] 		set verbosity to desired level [=1]\n");
-        fprintf(stderr, "--silent, --quiet 		same as --verbose=0\n");
-        fprintf(stderr, "--trace[=level] 		set tracing to desired level [=1]\n");
-        fprintf(stderr, "--version			get version information\n");
-        fprintf(stderr, "--dump-config			dump configuration settings\n");
+	fprintf(stderr, "--session=<label>[/<group>]	enable shared session\n");
+	fprintf(stderr, "--cpu-affinity=<cpu[,cpu]...>	set CPU affinity of threads\n");
+	fprintf(stderr, "--[no-]sanity			disable/enable sanity checks\n");
+	fprintf(stderr, "--verbose[=level]		set verbosity to desired level [=1]\n");
+	fprintf(stderr, "--silent, --quiet		same as --verbose=0\n");
+	fprintf(stderr, "--trace[=level]		set tracing to desired level [=1]\n");
+	fprintf(stderr, "--version			get version information\n");
+	fprintf(stderr, "--dump-config			dump configuration settings\n");
 #ifdef CONFIG_XENO_MERCURY
-        fprintf(stderr, "--no-mlock			do not lock memory at init\n");
+	fprintf(stderr, "--no-mlock			do not lock memory at init\n");
 #endif
-        fprintf(stderr, "--help				display help\n");
+	fprintf(stderr, "--help				display help\n");
+	fprintf(stderr, "\nEnvironment variables (arguments take priority):\n"
+			"XENO_SESSION_NAME=<label>[/<group>]	enable shared session\n"
+			"XENO_CPU_AFFINITY=<cpu[,cpu]...>	set CPU affinity of threads\n");
 }
 
 static int set_affinity_from_env(void)
-- 
2.46.0

