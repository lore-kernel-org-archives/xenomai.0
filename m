Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7816DC15
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314094; cv=none; b=bweqJv1r7lLG+r+NWPlT5rPoMY4cJj5sWpV4C9Y7eTZWcEX4p15XHxXVMuS5LRsOQm20GMsG3Uc1/waKwmvVO+PNSxA8q4KY1SrWWfhiCMudt3gUVm8Hl82s1bb6TPqizl+cVAtwpUycqxJ8Q0PxpfJAs1I94gINMg9V0/m5cMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314094; c=relaxed/simple;
	bh=JZFlO504hI/6Pun6/PPH9PE3jZJd62gpK8ZppK5n9d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFAnuCZPdIAmVChoee7Gu0WGplnGCxwb5QyPp5aNe0Ff9iIO6bbIwNdKK4jIqQ9E+Y6MOXe4cC8VQEVN6DDeckl8NoOe6rwGtu4Qsx0llKOgzcOCaCI4xY3xZ2NZ6d5DiGpApR9GN23zsIVsWMo4fHlck965ubMtgb3Q1AMN6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=XEVPSyBS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="XEVPSyBS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42808071810so3574125e9.1
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724314090; x=1724918890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nw9pMpFH2PNa1AqDr8SEnzt6ITGtxBQfRHKgKidP60=;
        b=XEVPSyBS/H2T/vpAy7EkK0js9J6nEAHm4VBzNfJADaImyirFEEd0/g963m//t5e+xC
         wHrXLcNo526cp41I+nNvaKvNOs5d3zJl+UJY/6eKEEKFNIgUsLlQJCpqr78y5Kq633yF
         ieErUapUwV2AUFDaExKIB3dZT/gGT/LABOqn8BSCfLtGVn8NFPtEPRZhGbtL/RpYQcRd
         jx2zDdSPjT4J67Gu2+3LcT9+6hJXxnhNDUoMTuQRWfebJJtXDW9+29VTNcTZSVpmhyjr
         A4Iuwe12PCE7zig6liJQRWnVbytkMa4E+0OkWNBDv6fO3C/9xCDjZyuWCnXR+lKzXxEi
         PIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314090; x=1724918890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nw9pMpFH2PNa1AqDr8SEnzt6ITGtxBQfRHKgKidP60=;
        b=OlpXsh1t2ew2lgZMFFf1pjCjhEFgmzMe9Zd1s2N8YKUCttddyZ7p42Pt1BGjvs3rj5
         6Tam3bRugFKrLo7b/b260ZxSa8lBtTNH25hoKGUhznLY04sNpyuG7r2jyTV3suEZHrV4
         YMX8xxw5puJHecEeLVJfzYkdb6wJUK81Z93Bhle2PzNWexBFsbzMTND91GCR6hMN6nPU
         Ak3wZ2JGHWXqlmVCw9jv35lz2zMy48j5EkMPjKuknRC+OBk9KsYN44KJhCcExOwotf7k
         XTMA6D12x8fc7dvC6hOWn7QbYbJRlLK/AzoE3EhAZER0NMTn3JBb6QZUoXCucqskEqJA
         2xmQ==
X-Gm-Message-State: AOJu0YzdNj3VMYmmBX+gdw+OP+zhS1QN0wz7Lh3eX9nzQumLblbupWW1
	LKszJpqCP8mkpYnhK+vCOhEvGxEPkvbzLuaYy8dt7pzVZeqh+M8MfMslkU8m/BJ/TUg4iN1qeod
	YN/Y=
X-Google-Smtp-Source: AGHT+IHZujAuEghy+PTsC0qvjDJ1R5cLrT+12fxym2vJ1luBZ3RvWRnrcPKz8MnXmEQWjjm1D2eYnQ==
X-Received: by 2002:a05:600c:3c9c:b0:428:141b:ddfc with SMTP id 5b1f17b1804b1-42abd253daemr34480045e9.31.1724314089523;
        Thu, 22 Aug 2024 01:08:09 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefd9cd1sm52565255e9.38.2024.08.22.01.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:08:09 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 1/3] lib/copperplate: Get session name from env var
Date: Thu, 22 Aug 2024 10:07:35 +0200
Message-ID: <20240822080737.17939-2-simon.graber@sigma-star.at>
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
index 16fc59f..e695c52 100644
--- a/lib/copperplate/init.c
+++ b/lib/copperplate/init.c
@@ -114,19 +114,28 @@ static int get_session_root(int *regflags_r)
 {
 	char *sessdir, *session;
 	struct passwd *pw;
+	char *sn_env;
 	int ret;
 
 	pw = getpwuid(geteuid());
 	if (pw == NULL)
 		return -errno;
 
+	sn_env = getenv("XENO_SESSION_NAME");
 	if (__copperplate_setup_data.session_label == NULL) {
-		ret = asprintf(&session, "anon@%d", __node_id);
-		if (ret < 0)
-			return -ENOMEM;
-		__copperplate_setup_data.session_label = session;
-		*regflags_r |= REGISTRY_ANON;
-	} else if (strchr(__copperplate_setup_data.session_label, '/')) {
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

