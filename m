Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B9136E0E
	for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748330; cv=none; b=Bwwqhi/78qu1MHyfsV6IjUw1YyqhYpa0T5WoOvuonALvBZnlViIpKxY9VuRnpIE6vFiGMWixr7JbqjZeFyzJKB+42lIll7T8MfzVwuAx5MqT0t0qr9FzVDXs7Ik89J3zbvnt04gsU5NWL/wVdqamdU8MJEf/CQeH3KcZ3+uedt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748330; c=relaxed/simple;
	bh=mRnctUkmMAvgtwJPlMwtryXxP9Ya9hA//xxH72mYafI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+WkfVcLsYafv/7Jb3ZGPuckSKNPkxVTGmKfz0BO3ErYgeSm2Gd3CxndOv27E/hnE/P24E4m9tjlrR7NfWGfzf1BtosshxYLs8mZMTi0F6zQQNBbOOYlxs/xuNDj1UhdBVBiCzYBZm7/tW9bTfXTrmbYBLjdcSnJAvQfUoWHyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=OujyyCzs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="OujyyCzs"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53346132365so6086198e87.1
        for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724748325; x=1725353125; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDTV1yeEYhtQzDS7DzzPUceuXthqxBYh8UTl7PRtBns=;
        b=OujyyCzsXidIbqGGn7zpdpAg+n4Y/M1i3NCzf9JmhQPs3FjMGaHdHKtuD+Z+AOOi+3
         hLfeP5LeV2j67/qqqJ3nF/KLm7zSjyPNAW1vz7sCcCPOBfNkqsVyxHIr8zN8uRyB1ecB
         wWQRVW+ieEFAs3oppB+fsR3SqN4vjpQ+/PS2Ty0Lo7289BkLgNQhH/VsjgZ5IDiX0FuJ
         CiZ40JZOUpDEgy2OUDhbMxf1hioV7ZqRYmv0M9TElpCrvMv3T8zN71t2xsFFKfw1SnlX
         R7M6ubtyngYo4mBacb8escJ7K+O6ZOW24gnygfHxNJsdoqF4tfalUxaRRaPvuvpNZy4n
         uUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748325; x=1725353125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDTV1yeEYhtQzDS7DzzPUceuXthqxBYh8UTl7PRtBns=;
        b=Odvriqo7rtSI/Q2H5oXW0BbddYn9lOrcDz5QFPZPX0TmHU5nc+M9RtLlDAjL+oJglx
         7zjpmW/vLMnPFQJyPzqQH9voPAJI0NW/6wpbG/0svyJKi+cFTQcWhgwDeb3kfdLG+gLk
         +rIIGx3ApkU5Ipxej4D6Uiar4V9yZvIVB0XTZ/Mn4xAy8M6rRq6/4+G9TMBZg8KZzjEj
         758GLPuxwHtafvmDtRBWq4p3wZ0JtHQ8F49BvpmcwI+HYbAEPtH59d9PGSgFuGfcVOPk
         ouCBnl2r6/A8xh7DQ/UwuhRb2/wjsWKZD839HPVdhCEe/eKH4MhdXyKLzAUVpP5mdK/e
         ShhA==
X-Gm-Message-State: AOJu0Ywf3dKLPwhzGcQ/yO4J+SUUqk32KXmZSntGk23Kh08SED8l8Nay
	whBOpgTQ8YWIQokuQu/WTwmQZLzZAx/LtusDbrUrX/OiRYxDZLHK7UPXKkrkiMBRqqhIxCmjYie
	+KFw=
X-Google-Smtp-Source: AGHT+IFZ/3ngYcTDgZcrwUvJyNvU8KeYi/S/ms4bP9HS0HynsRt23+rntye+HVCwt7e8oPFM8uK+UQ==
X-Received: by 2002:a05:6512:3d24:b0:533:7ce:20e0 with SMTP id 2adb3069b0e04-5344e3bc071mr1321133e87.8.1724748325262;
        Tue, 27 Aug 2024 01:45:25 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86da6sm211779435e9.17.2024.08.27.01.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:45:24 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v2 1/4] lib/copperplate: Get session name from env var
Date: Tue, 27 Aug 2024 10:45:18 +0200
Message-ID: <20240827084521.13547-2-simon.graber@sigma-star.at>
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

