Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313D18C02A
	for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920536; cv=none; b=OXCm6C4pYxEMOYoFJi22L2komjaPLUDBan+1GtE1n1Do/9+1Mvu6bIjVSiIgo8YTfA1nq3p5GOJwWer/R2orLxzJQHvR3G9ae+n2JvrmgexolXolIoUZw5QbZx/HLvFmZd1dCKVIhZNR//33147eOzfLy8bQ4pBTKzCqzTWZo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920536; c=relaxed/simple;
	bh=mRnctUkmMAvgtwJPlMwtryXxP9Ya9hA//xxH72mYafI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG9sMGxDGZaWtK/rxWFtNyMs2/ZoL9KlUq5OtMT6hwy4sbXfGDMncH/qJxpoGSbRts0/MUdQCLftyBR3GK31x3cfmaJm2d5lzlBNtYxcbdvtR/17m5VTn7cMleloRCWESuG0TKcU74cLcFixIkFz9l2rbYseag85JhceY+QsA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=hmzVyHq+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="hmzVyHq+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428243f928cso3274015e9.3
        for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724920530; x=1725525330; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDTV1yeEYhtQzDS7DzzPUceuXthqxBYh8UTl7PRtBns=;
        b=hmzVyHq+GGsNPPHc9tKBWvQId4KeuBJKjLvws9wqCuvC7SAIyZbqnXjlhiBBPaYVm0
         YZX8d3MrZij6pXpaViq8SOXe/Fpl9BcHMVZKwWZLP8defZoWEfPyxDumTv3/nGlUU3/V
         ZmntE6n4If5/Cd8gNQYg8AzQQr2oNLEA28JqQgyeu5TNejOxS2DU3aUH+xPfszdFKvVA
         sTWQbGW8UgmiP98KQMv4+eImtchhKjGI87zjEpHynmnnpFvhvy19VvJjS6DHP4Ba1F+Z
         hjciHdZUZYOMZOm4Sxt4abxbIqbgQEhgjY+fvuJTcjo+QnuRu++xuXqc704raEJ3t8ul
         lQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920530; x=1725525330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDTV1yeEYhtQzDS7DzzPUceuXthqxBYh8UTl7PRtBns=;
        b=DiprZ7jU9Gr90PRAkZ3XqjrZD9nfyja6rudqAGiLM+TbuWnAnPDhS6qB7GU3SUDxxe
         gwMlcwOutKMfIFGWjOzxpV+qy3kUs4dQ8sw8l5g3uuNURaPFOkgJ1po66Gt/8l3XohA7
         s9jFGrZXs8sz2g66uf0mbCstXM0SB1XnNFvM07g4+wGZFxSvrhlyn3xYuILi3Vdfy8s2
         6i0gooKhmVVK7qihv6ktqgtKf5Nh0MY4yLgGwiaWOg+Wglh2+7az9eLdAWa4cAvu7yCi
         ZiXsgXG3Xux/1hjzhUYMj/XF/pX4tm3mBHgvxEfddFEcGcgsOIsjQnUTrurxBYF/ivXe
         lmDw==
X-Gm-Message-State: AOJu0YwSFFp26NYODV39UAZOISCdmdr11nMSkRUiVz/ccEBBsUWfV8bv
	ie33S7iNqCs4jR9FO1hirtsjrJuyKJCXpZ3IC6QJxkiTqGDat4l9tepXb0t9Z0WhyMd5b6YzZDQ
	8YgQ=
X-Google-Smtp-Source: AGHT+IG7vU45jV0/82zutWBPqsRO22Vs+dgLaovpGm8kpEoFlgmlYxIhQcfWdYJVJ5zKb1SBlxfQXw==
X-Received: by 2002:adf:f58e:0:b0:371:a844:d32c with SMTP id ffacd0b85a97d-3749b57c4f1mr1454099f8f.39.1724920530247;
        Thu, 29 Aug 2024 01:35:30 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0adbsm9995815e9.15.2024.08.29.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:35:30 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 1/4] lib/copperplate: Get session name from env var
Date: Thu, 29 Aug 2024 10:35:23 +0200
Message-ID: <20240829083526.24536-2-simon.graber@sigma-star.at>
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

At present, for two Xenomai processes to share resources, they must
be started with identical --session= parameters.
This is cumbersome for extensive projects involving numerous helper
processes. This commit allows the specification of the session name
via a global environment variable, namely XENO_SESSION_NAME.
The --session= parameter overrules the environment variable.

Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
---
 lib/copperplate/init.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
index 16fc59f7a..01969cfea 100644
--- a/lib/copperplate/init.c
+++ b/lib/copperplate/init.c
@@ -114,6 +114,7 @@ static int get_session_root(int *regflags_r)
 {
 	char *sessdir, *session;
 	struct passwd *pw;
+	char *sn_env;
 	int ret;
 
 	pw = getpwuid(geteuid());
@@ -121,12 +122,20 @@ static int get_session_root(int *regflags_r)
 		return -errno;
 
 	if (__copperplate_setup_data.session_label == NULL) {
-		ret = asprintf(&session, "anon@%d", __node_id);
-		if (ret < 0)
-			return -ENOMEM;
-		__copperplate_setup_data.session_label = session;
-		*regflags_r |= REGISTRY_ANON;
-	} else if (strchr(__copperplate_setup_data.session_label, '/')) {
+		sn_env = getenv("XENO_SESSION_NAME");
+		if (sn_env) {
+			__copperplate_setup_data.session_label = strdup(sn_env);
+			if (__copperplate_setup_data.session_label == NULL)
+				return -ENOMEM;
+		} else {
+			ret = asprintf(&session, "anon@%d", __node_id);
+			if (ret < 0)
+				return -ENOMEM;
+			__copperplate_setup_data.session_label = session;
+			*regflags_r |= REGISTRY_ANON;
+		}
+	}
+	if (strchr(__copperplate_setup_data.session_label, '/')) {
 		warning("session name may not contain slashes");
 		return -EINVAL;
 	}
-- 
2.46.0

