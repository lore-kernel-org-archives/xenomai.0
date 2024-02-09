Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD233219F
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479479; cv=none; b=QNkxgeqh65F2gixo7VAOfkhmwWuJg/QiKkeNhOGB/GNElyTCj2lhZqpDTffMxI0hb4xttHnmPzMSo6wD53KAOe6QbFMTqH6wWyuZ3O+p+CX3r8C2sUb1Hfzv4eug9jF4yMmCVQ56xjPuj6ZHKC5kdirzIovb+EYe67ODl09m+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479479; c=relaxed/simple;
	bh=7aI8xxWhoRMTHs3rdc+rjmsFcnDWniy2PJGpIitrQeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bG/7szzWz/zvIVKaNnUgtpASFQ+na5JEVDOaZ+bTBmLwS+vJfkFvGFKzP3Fh4NDfbOyHc7Rg0IAKd3xOLob3UaQmWG3IYM1f30N3nTqB6H/dvtESVb2Nb+nT/9vvJfKiOw3cuDmwNcWJxoeesvlBQT0YOkHRRiUCH/+UKpk7jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=YFTg9B7F; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="YFTg9B7F"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024020911511792fcdb35666be93ec5
        for <xenomai@lists.linux.dev>;
        Fri, 09 Feb 2024 12:51:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Twi2qB+kK23bAPhO7juzw62weyUnpClFTu3qq8xTGA8=;
 b=YFTg9B7FMVeX/3HIbXjB/xUYn810F/leD23dfF8XogS8H1zKVsC5/9LFzMVRxRHhXooSqx
 NoBjTACUHkN47XqXHUJ4Cc2TsD1pDP3u9a1PjfeNt62gv0KDha+0IOPPTt1KbFIr0gEj7vJa
 ZB+gbyIS+S3y9N+FLADMGoRV37+DE=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 6/7] compat support: lib/cobalt: Fix VFP detection for arm on arm64
Date: Fri,  9 Feb 2024 12:50:24 +0100
Message-Id: <20240209115025.1884451-7-clara.kowalsky@siemens.com>
In-Reply-To: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
References: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
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

