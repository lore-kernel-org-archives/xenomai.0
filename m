Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9760241
	for <xenomai@lists.linux.dev>; Wed, 14 Feb 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927689; cv=none; b=HGTdE76P0uFxBeFYlIyfpWc0PHfKF/qTM2VHiaRtjZDmEufFp43B2a8e9m7Z9skTVuY6cafKlmJvr564mVUtEU+gn65gYfyqEu7vkiFE4mxluJCBlaIoKoGxb+bY36R/pO8O37dhtZvAmrNumo0AiXO+3zznadI4oXg/fGllmsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927689; c=relaxed/simple;
	bh=sV3Kt1mtQSWLKU2PJ5y+Qen5TkPnXhpKG7EGzx5u11M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NpLrvpoBi9LvlkO6rmUk957bV+HPV5lJEHpsQ8AS//R9x88Peu8aBHvWWSUW920YokeT4DRAtL9bQ+hMReK3GDsZkrO3GVLwU2t7wqRKozClgR5zELDIMMe+ZT5UT0Q5e61fYmOx/o+9w1rEyscadl4wQkl/DZgcmssivkNLU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=DDRDw5DB; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="DDRDw5DB"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202402141621193baea3289bda50f5b7
        for <xenomai@lists.linux.dev>;
        Wed, 14 Feb 2024 17:21:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QrftBeSkufgUvYczTb13fA4KCpgT3Y9BkgG7Gpp/7vQ=;
 b=DDRDw5DBHJJmJb4O/owW5CutPRFwbatLeCKhnWaSt9hZYeLVU3JB9esfMpYF5x9Jv5Y2yR
 ymCvAeQwbwj0ir1xXy5YtC6G/oLFfctXHqXJ1Iyj8MyVKioGQBaLAUbsbIQsbozzZKEtmZqr
 TslrtJ1fgYb6lm6Wq3vchcCgk1Tqk=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v3 6/6] compat support: cobalt/arm64: Enable compat support for arm64
Date: Wed, 14 Feb 2024 17:20:45 +0100
Message-Id: <20240214162045.2017832-7-clara.kowalsky@siemens.com>
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

This enables the 32-bit EABI compat mode for building the user-space
libraries of arm64. It allows us to run arm(hf) applications on arm64
kernels.
Furthermore, the dependency from XENO_ARCH_SYS3264 to CONFIG_COMPAT_VDSO
is added.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/cobalt/arch/arm64/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/arm64/Kconfig b/kernel/cobalt/arch/arm64/Kconfig
index bdf5f1602..14e5fa1c4 100644
--- a/kernel/cobalt/arch/arm64/Kconfig
+++ b/kernel/cobalt/arch/arm64/Kconfig
@@ -5,7 +5,8 @@ config XENO_ARCH_FPU
 	def_bool y
 
 config XENO_ARCH_SYS3264
-        def_bool n
+        def_bool COMPAT
+        depends on COMPAT_VDSO
 
 config XENO_ARCH_OUTOFLINE_XNLOCK
        bool
-- 
2.39.2

