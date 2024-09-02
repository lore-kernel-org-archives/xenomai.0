Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD771DAC51
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282693; cv=none; b=fE7QK9I+edmBXj1qo1iUlqQFbN04BT1lVB4ar7HWpaUQ1jtGtHKrsiEXZZCUWi01CCvJsL7LDJAm2Y71EyWc8evbDoSQj0ih82r78xuegq4WJGTnu2h8RsuRh8QeVXnAsOBaI8V6dlPlh8pIU/KCqb6imIYVMPV3saa0D+uyBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282693; c=relaxed/simple;
	bh=gWYtlTVjPFKA8VunY7rXTnNpVV7mGeEYUz5arSkKb2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAmEbymZZWUrMbfN5XvvXSvf/Cp+MYUERbfMPalhaQOlyVn8u+2hLAl2OhuPVV3siYbMFBC7F0oPput8leU6nxiIcGymCg13gzKBUJIHVsbw661gHs5REJFTQhtj5Ibi4yh+fRpAjRN/nz7mt2AfJO7kBtIx2O9j/d7e3EpQAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ltuqOohk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ltuqOohk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bb4f8a4bfso22795835e9.1
        for <xenomai@lists.linux.dev>; Mon, 02 Sep 2024 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1725282688; x=1725887488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIcIC9ggulC/nwpNW1to+68MMxPGE5dAXX1NC1qY794=;
        b=ltuqOohkyDKHEugBgB4x6TbpkgDAYQIhefObw8BUULun/INGZg8z+Waxpw7Q3gvvmd
         fbiYErLq6sfy1ZrvWktzpZzgtq9dVp2GcurlRWuc5mPeXuvOHyTt7KdTazSokifSS5IY
         p31knUAYCWAKXIJdwW7GNNKzyrPlQOKPHepSQmt6Nta0eSt/rnTI+Vq1PwhEoAjI6Si9
         Bt7eqr75YpxuevrQudCcoE0hEBGd36xZ2ddjvtYx0bN53Sm1cLelM3bt3bZ75eh2KyQ6
         4X3vEKZUpAf9Ao0EpG8r+EN+8YXr64LuRh6V2TlsUMyWF4pifoLw6zpkVkUnCHh+6/HF
         C7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282688; x=1725887488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIcIC9ggulC/nwpNW1to+68MMxPGE5dAXX1NC1qY794=;
        b=W9bmGUODnHYwAZdOHtL9tnWs4mLKZadWOYcr+ZIidDNEYoxPS45tGF68nKILR02jR/
         k/ENRoJFcgJTz8r8eWh3wDByHbytR1dEEzYFrty9l7Sh9nRFQh82TgZw88oCx4YTB8Y6
         ksCiAEbTbzdx9pxWGuN2pPawwRteTrnDrOaamlMw1Y1dVDpugg9lhcRQ3gn452dP8d+M
         RRoYjZIEtQOB8YeyQqShdetneMqudC8gvmKTQK5a0L/LO6KYCQXTkj5Txntt01g4XQHz
         RJrfudt5SAxRLnfaopHsDnQ8SVdNJrqEGAYlLERw7PsDOo3ummpmd3WykR6DJUETGfWg
         Lf0w==
X-Gm-Message-State: AOJu0Yw2DRjgqsvXobypzXRZUl5hjGxGiwSUPInjPJ0xqXjazcCUZ2TK
	C7Y+PJipdo5bx4OkzL4xN6isGdD4VkMY6ATVZhxRhvoDl7x2PIiL/aVPxGp2zEuzTvU3Jnw70B+
	ahNo=
X-Google-Smtp-Source: AGHT+IHR0wbsYQa+di1u5TbPSTJcpiB6JfHr6xZSQ5e3w1gjoR19nRkTpBUBU5wAjNPmRCDchCF4yA==
X-Received: by 2002:a05:600c:4fcd:b0:427:abfd:4432 with SMTP id 5b1f17b1804b1-42bb4caa1b9mr89897895e9.12.1725282687863;
        Mon, 02 Sep 2024 06:11:27 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba83sm11511430f8f.54.2024.09.02.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:11:27 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v4 1/4] lib/copperplate: Get session name from env var
Date: Mon,  2 Sep 2024 15:11:21 +0200
Message-ID: <20240902131124.37844-2-simon.graber@sigma-star.at>
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

At present, for two Xenomai processes to share resources, they must
be started with identical --session= parameters.
This is cumbersome for extensive projects involving numerous helper
processes. This commit allows the specification of the session name
via a global environment variable, namely XENO_SESSION_NAME.
The --session= parameter overrules the environment variable.

In a later patch, the --vm argument will be passed via an env var too.

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

