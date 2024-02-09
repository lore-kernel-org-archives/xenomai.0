Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655B32C9C
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479481; cv=none; b=UI6ZT+V9fxeb3UOSVi6Gu2XI8gRjv+Y3nTO7SeCh15UUbsbeBfoZe8wSpFevkfV3u+JmCxati2s//BVO0zVrolhb1VmSr0EU3IuODU2BJsvMcMX4Ur8FyuY0Zw82koOfRHKdmLkB/zI/iom1/vCuJ0Ovz2Tan+dfMoSvjTAjRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479481; c=relaxed/simple;
	bh=sV3Kt1mtQSWLKU2PJ5y+Qen5TkPnXhpKG7EGzx5u11M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6v2hoIkeKJBdSP0Iumx/A20c10Lk+68vkp0cO2mhcILz2WLm4S/yT2QsY50wZhxpvBZUh6bXRUeMqzO8vjo14HFsX1QSjHhm/2oOCh4beamfBV5orRgGN70yx0E4bLX8nGF1jdptOqoAxjm2KDJbrRZ7Vh+vVwMt2YDq8Qh3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=ZU6rJoKg; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ZU6rJoKg"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024020911511840be3ae3b75ccfa0f4
        for <xenomai@lists.linux.dev>;
        Fri, 09 Feb 2024 12:51:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QrftBeSkufgUvYczTb13fA4KCpgT3Y9BkgG7Gpp/7vQ=;
 b=ZU6rJoKg7hVTpyZukN+djadl8TY9KARUQxU9Qdjf5HMHR+G3yLhQ5Uz175xobhgsflmLUP
 8egNNzTAigadQOZi3Vfefl4RVsvqzqfk6ENZ/3emUWd1Bs1Ub8nPn5695rOVxwgtgbflgwaT
 gRqSVmqJA384viF+zHT0hVzVwGBpg=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 7/7] compat support: cobalt/arm64: Enable compat support for arm64
Date: Fri,  9 Feb 2024 12:50:25 +0100
Message-Id: <20240209115025.1884451-8-clara.kowalsky@siemens.com>
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

