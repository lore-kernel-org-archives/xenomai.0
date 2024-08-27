Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E65B194AEF
	for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748331; cv=none; b=MhIRDLShlFrA+RKgM3JYkAoMqyqx6HxpzJ68zblU6v1zun65DoWOCPRe7d1okZbadMSQb3C27HONmJ6/Af+Au3mBSiept8HoeDEX2NS6vLlYEuezFruT4uqPEYoWb2fJrrJlRDWo0/iUz55SwjLpazh0o9aXPCa6PmuH/DVSmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748331; c=relaxed/simple;
	bh=Edusv1IJROFa6GN7LspUpuUmbI6FqhK/K5JPcO5gHP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoA6Yqoqer0rxlaWssVKdFZmoD2WGV13J0pNDhs4q/rq2XZiswt2PCMH84XfsBDQrGSvjy3wFAuqGhk2vOo8jLOCHWbUvM+aPVHo205ZeBQnLb4kfOvGrgZ7cYvd5ZRG37SUibVtDYFX2fDvAxWSnSlGqtbAqz9ZJkaNMrb6Rkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=BX0SI72H; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="BX0SI72H"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371a92d8c90so2723947f8f.3
        for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724748327; x=1725353127; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=538a5EClmXwJBADb5a6AtHy+qIS9ahQ56cvZtOXsR2k=;
        b=BX0SI72HxLmx6lF9i18JSYKOkROM0mPJvq4wYKD2XG586VuKeHr1IEOlDagASdBxyU
         P1c772XuYEhI//Y2nMg9M2rklzJd+NgPyJE0Uc2YwkHZcATNa4otxU1MigCl+CG5Gqp2
         ITZJ47dDj4gy/5DIUAbWhmD9OyOTKIuwgLYSTKTIEYx3ZxxI9YEmTt2zQGRy7PsOs6e3
         UfACIwZDWCDZ1gBeXtdTD7d6XgvNGATlGqqgppIW4KzVT2+7Ue6GjyNqrsHWQ95eTQTT
         E8kzoe04PVNMzfGIkA34UB6i9u105GFcUFAuuLocQsOtSvf1kSENbuaKGljK4P4RjhwI
         L0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748327; x=1725353127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=538a5EClmXwJBADb5a6AtHy+qIS9ahQ56cvZtOXsR2k=;
        b=uDA3yjC9hVvCHNxqrGaZ/oHRvXz8KFCl2Tqnembrtjjn9w72/76SIr3QCX8tkn18px
         igTv/qYJJitlGJBv2+z8h7/FYwRTwIfTzHFPhcQthzA1ZtFwHsMeozWqEyV5LvjugFgD
         YDOiOQynBICBs2+lFJjA9qbBgR+c0ipAmaoSovwSHpQZ5G4PH3QG7nJOOs27HVEM/8D4
         n12p0UJyI7Kj4AM6CZqgcXQ+/L9Pqp04dD3uAmcH9pqg4leEd7BJDeGWMP+v8NwT8vb9
         jmmztC8TkvprvrBL1wNc93MxhFr34CSkKP4OoHE6ZkTCPt50OTDXBmBG7ML7vFfMZw8j
         3DFw==
X-Gm-Message-State: AOJu0YydiR6KJnV/681/pVbdCQFjhyVMH+0yQvYkX3Meo+IbOHeVAfLk
	1EGhJIP/NC0yEEojG/Am0eHHNj62g0j+N/DKn4uaXB4M0j74QplMubJs1Eoebskeu9JC2Xzw0f4
	zssk=
X-Google-Smtp-Source: AGHT+IGeX6fB3V/IZbnMIOil/9Y0/LqwKEwp37KrlxAIKZryq+opqe80nEuP7wqn8BzZeSqjvRevAA==
X-Received: by 2002:a05:6000:d47:b0:367:9d2c:95f4 with SMTP id ffacd0b85a97d-3748c81a163mr1340437f8f.47.1724748327269;
        Tue, 27 Aug 2024 01:45:27 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86da6sm211779435e9.17.2024.08.27.01.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:45:27 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v2 4/4] Add documentation for env vars
Date: Tue, 27 Aug 2024 10:45:21 +0200
Message-ID: <20240827084521.13547-5-simon.graber@sigma-star.at>
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
index 4249cd230..652c0c571 100644
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
 
 static int get_affinity_env(void)
-- 
2.46.0

