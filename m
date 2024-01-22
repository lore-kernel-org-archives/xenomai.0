Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33463EA81
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939308; cv=none; b=nkBfKsVcbTQ1/55BZD5LHtngTR2Bkd8z/kuQLc884ZzfA3LDJ73rETAtOomu74+UlIlSPY1jD0kQ6/Dlw4wdnMtiSPbzCHrjXR1yBMWtb8EYHwAmAV0ZP+vCleG7wD1xzF785Unj5ZVwmTAC8DtKb8OTBu5fBgCEHtuNlCgNdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939308; c=relaxed/simple;
	bh=7aI8xxWhoRMTHs3rdc+rjmsFcnDWniy2PJGpIitrQeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqPy1GfIVX6gWN7VJWWgb58jh9SrxVCq99++XE4dYoMcedICfGv8OEHKc8dvRd71rzoDLowgEsd/1wlwwz+G4jTUJRlIBwbvgtjtg+W+9JI7M1kGNm18ch9XmzmVYuRglqHFCKOJz0zUi4RES6JYfjvR5hRP+qGPdUucelm5tHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=Sc71gH1n; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="Sc71gH1n"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240122160143cbb19c79be43e66ac1
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jan 2024 17:01:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Twi2qB+kK23bAPhO7juzw62weyUnpClFTu3qq8xTGA8=;
 b=Sc71gH1neFc0br3GxvzWyVUjxZcYf+sETmRuYQzcsRsg7PbiZiZL1SUm2bTzZYA6m0dxHS
 uBK02nsDiKJpZ1rdNPyuZ+bjRIeJvr75EJCiM4WHimbcFuwy3z+ORAnjl5m/3CzlizqpWzMB
 vG7SRMwrNoTmAWkAfqlZjJzjJr+/I=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v1 6/7] compat support: lib/cobalt: Fix VFP detection for arm on arm64
Date: Mon, 22 Jan 2024 17:01:04 +0100
Message-Id: <20240122160105.2452024-7-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
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

