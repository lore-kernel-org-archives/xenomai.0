Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A451DE4C7
	for <xenomai@lists.linux.dev>; Wed,  6 Nov 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892468; cv=none; b=N+S6nHAN6vTxJReQ2Pi3fIcU3sxo9xth8HDikTG1EdMI165j2Is2ccVjHDkVOJaE3zwBM88+escxDcKUj5LJiMf6pHuQGvKazR7jfl7FXS3uqbw8hEWQJo2Ww8n6xuaxgK9Midtc87lxM2lH9ExIrw3BcFos2syby7ww5obz7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892468; c=relaxed/simple;
	bh=XPN+g51tOpT69SqmSRRr/YY6q4xxTBg1IzYtSsrK7Ro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3bugKgU3ZFmtjguypMHykgDvq0P3bJsdi6MQ5uOqmDNbaqFy1pVJTT37ru5dCbq1xKQ3a2ZWI9mX/6qYy7wio1H/qfCOFgFT5/H4Bw4OPwMFn+MSGe68byt8V48Nf1vtcE8e6Aw8iK3Cpy3VyJLYPlhle4Ikb64aTBLpx6Z/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=bYCY4Rhu; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="bYCY4Rhu"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241106112741580ac3f94f2c88fa72
        for <xenomai@lists.linux.dev>;
        Wed, 06 Nov 2024 12:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=sofr94Ha3QnBBBQurxi0m5JX2QB5PlCYEmtOokEvMRE=;
 b=bYCY4RhuA26nfjpU2qZ0OI3gDmFRPqvDLdf8ZGcUVLYXsm7B5BxrexWez+R4AnB11+ZJ93
 K6ulUe+nCPU+hW6IHMA+xPeZBHCpvACOvf8JtFqbVIlIizcTUjhuLyZOlWahpNUHTWU/3Rkr
 WvTzRUKZIYXETcLFbAWY9KnyLRjfzI8rgT0JP4FGYqw4gqIcF1RIpChnZ5nnOfWXj88ejY21
 8Nsf0kDcSniHUh0wmwRQ9DvbLoGkK9OtiEJkXHoj/bwvd1LwG+gpH2oHuDSut8FYI0J+mHu0
 HBU0J1DCU5bZEhbIQIoVos/KmyvlihksHX5L3XXXi4f5cYxeyaAvu5UA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/3] ci: Add missing kernel cache tag to compat jobs
Date: Wed,  6 Nov 2024 12:27:38 +0100
Message-ID: <34d30627963f6719f92bc19d7b1e9f2580603df7.1730892460.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730892460.git.jan.kiszka@siemens.com>
References: <cover.1730892460.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Was forgotten in 032db1abc4b0.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/compat_jobs.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
index d8ee86b..93cae2f 100644
--- a/ci/compat_jobs.yml
+++ b/ci/compat_jobs.yml
@@ -16,6 +16,7 @@ build-5.15-compat:x86-64-efi:
   variables:
     LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
     KERNEL_VERSION: "5.15"
+    CACHE_KERNEL: dovetail
 
 lava-test-5.15-compat:x86-64-efi:
   needs: [ "build-5.15-compat:x86-64-efi" ]
-- 
2.43.0

