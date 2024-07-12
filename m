Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0915B0FE
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781342; cv=none; b=EI77fQnsRqZ0ntvs4NBycRxE3MlhUPA+9irxrbW9l/5tCLOEjWAuuEmrc0JVw6YK66FkkjFKHdvk3FBdxiBv+wLrJlj7vSAjRSXqPvd40p+VIHHj2wmC+3MDhhLgx5kQJjKMSafEi4ew0h1QoegY/Qf2vaw1v6bluslDh4lx/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781342; c=relaxed/simple;
	bh=2a3SRYl3VBMyXsb67EdgVQARreUJBCE8x2/nkmaJ8k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBwn6YjvtS1aqzNPcVAwVkUkY6IcexsBdvMZHei0avixzsVgxNEucV8Ga0jDUN0JJHrLZ8QYFhXASV6Q9HXPChyOx3c37iiwQSFsPl4Q4mn+ut8vPiK6okp5xtTI60ZB8Zt5XvFzjf1jAgTAZ8Mbn+T0VgLJe3JAgaiKZRIXsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LcfaxTks; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LcfaxTks"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202407121048589af57861f02448b01f
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hn8TFX00kYh/IRrKZh+5bJxUHH2UA1+cdvTcjwWfgs4=;
 b=LcfaxTksTWG8OTL+o3qRU6j1N10MhrS2UoNYuVqKkhUfPOUoDEvG5VT76HSrzLK/82JFWu
 UeEizlsttChyCscMw9wllteGyNvYrTEsjH3icn8uC+tOKYPKyPqq+0CybjCduh3dbAdaXWbZ
 bfXM+KCMfUNvpNkcjcTnw0e8MX7gY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:10 +0200
Subject: [PATCH v2 24/33] drivers/r8169: Rework assert()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-24-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
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

