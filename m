Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6E60254
	for <xenomai@lists.linux.dev>; Wed, 14 Feb 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927682; cv=none; b=aqou5yY19ElcA+Ja22QfefndFo0ykpODPpDWlDWv1QQjzrlct2kezayWkhH8TcgskXyXaULFTUPjOuGTqzgtfki1ELDWlYoNvZckA3cEyORicbXRi4jkRBRThNH0ozfmuwa76QNsC0EMdS042/c1+JsdPXO4HzG9YfjQcmzBGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927682; c=relaxed/simple;
	bh=7aI8xxWhoRMTHs3rdc+rjmsFcnDWniy2PJGpIitrQeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3PRvv0NS5BP0+dgzV9yWbvNR0IATfDZIb8FauV7Lt1Xwnru3WoIrog1DYWfF/osNaSl6xPzB4Hg2qR/9TO9Gwez4VKCOQ1t4csYufc41yNtvukz+jDNoRjr3Z0e/KthifHhn5bX3oSaqt5v9yUjIy7E4qrxDA8bLLvqkUpB2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=ccLieWwa; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ccLieWwa"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202402141621165411107c0eff1e2c72
        for <xenomai@lists.linux.dev>;
        Wed, 14 Feb 2024 17:21:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Twi2qB+kK23bAPhO7juzw62weyUnpClFTu3qq8xTGA8=;
 b=ccLieWwaXLJZ3TZjE329aeVobbPFtOGQvFP6gBNti2dOOH0e2GYVxeDNC6rMWToLN/4qlA
 RavWZ7LFeusyX2sADeAiuruHrwvtz3pPd3Hye3lQWNj2hqBxlKtEmeI0bWjMMxpd5gc627zC
 Dw6nSslbwS+8GGB3kJJQxSi75sfYs=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v3 5/6] compat support: lib/cobalt: Fix VFP detection for arm on arm64
Date: Wed, 14 Feb 2024 17:20:44 +0100
Message-Id: <20240214162045.2017832-6-clara.kowalsky@siemens.com>
In-Reply-To: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
References: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

In arm64 the floating point feature is fp and not vfp as in arm.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 lib/cobalt/arch/arm/features.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/arch/arm/features.c b/lib/cobalt/arch/arm/features.c
index c91886102..707c87c7c 100644
--- a/lib/cobalt/arch/arm/features.c
+++ b/lib/cobalt/arch/arm/features.c
@@ -52,6 +52,11 @@ int cobalt_fp_detect(void)
 			features |= __COBALT_HAVE_VFP;
 			break;
 		}
+		/* arm on arm64 */
+		if (strstr(buffer, "fp")) {
+			features |= __COBALT_HAVE_VFP;
+			break;
+		}
 	}
 
 	fclose(fp);
-- 
2.39.2

