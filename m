Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6B17A926
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013151; cv=none; b=ZE17JWjy86Xz3ocBWwGxdo5PrwaRoFR8SMmbkVM1SR5mCZC0Bw9JVlBhlZJ5tLXCateb41A3eZNiA1cLJkSbaUPq6QGJpbLgfV6QF60pLtsX28WXr3t1O1yY0mFhp/Qntktt4Qd6Gyf7aQziiTMZJ/pRzVenQwdZ+Vt+SI7zflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013151; c=relaxed/simple;
	bh=2a3SRYl3VBMyXsb67EdgVQARreUJBCE8x2/nkmaJ8k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4lgHggoIhY0iJlgbPnj8hTPYg990mq7XkUZKqgqE8w0t7nyEUDn5edPK803//YHWbUrGbDd+X4qduOgKSLmhSNZrCbaZwDmVinmb7ys0jGqfZp2qB08cngXS876aFi04LytHvR1JP9TiOp5BV4YSeydY/EguJP4914V0ER5uus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=q+3/zAE6; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="q+3/zAE6"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024070313254787bfac3c51994fc1c4
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hn8TFX00kYh/IRrKZh+5bJxUHH2UA1+cdvTcjwWfgs4=;
 b=q+3/zAE6YtZJI28Az4x6Nmyi9jv2dlcNBNa5+qxYzZjHHqAnaB7k7m/VLXL5uhZCfInY8k
 cAL9Fus6KnJdUYp6bVzGxf95os0NXXc1O/uGX9UpISBt8AStooDA15SRT8C92JOV/RY5zY54
 Fo/qoEOHGKs1APd58bF6Z+WJI+lg4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:47 +0200
Subject: [PATCH 24/33] drivers/r8169: Rework assert()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-24-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Surround the condition check with a do{} while (0) block and reformat
according to coding style.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/r8169.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index 295e34a60..7fd60dff2 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -95,13 +95,18 @@ RTL8169_VERSION "2.2"	<2004/08/09>
 #undef RTL8169_DYNAMIC_CONTROL
 #undef RTL8169_USE_IO
 
-
 #ifdef RTL8169_DEBUG
-	#define assert(expr) \
-		if(!(expr)) { pr_err("Assertion failed! %s,%s,%s,line=%d\n", #expr,__FILE__,__FUNCTION__,__LINE__); }
+#define assert(expr)                                                          \
+	do {                                                                  \
+		if (!(expr))                                                  \
+			pr_err("Assertion failed! %s,%s,%s,line=%d\n", #expr, \
+			       __FILE__, __FUNCTION__, __LINE__);             \
+	} while (0)
 #else
-	#define assert(expr) do {} while (0)
-#endif	// end of #ifdef RTL8169_DEBUG
+#define assert(expr) \
+	do {         \
+	} while (0)
+#endif /* ! RTL8169_DEBUG */
 
 /* media options */
 #define MAX_UNITS 8

-- 
2.39.2

