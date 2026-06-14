Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2712F8E96
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781428668; cv=none; b=oqw4WvAnDwYL1y4kY80c26Uzz80X6J+YTamqOoOkLehbJ410KSwsOkwZULZ2gdz9kI+iqqn7/3L86NgV/Pn23f4AyzS3zJzFAorlUlinBPW5nBLPbGc7kB//ycqq0WLSK8Db4CgUZMXhox+4hynE5mIhBwun4INYozKF4teFcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781428668; c=relaxed/simple;
	bh=vUcX1+kqasPV9GFhQ+XxifuAu+QEdfXtApJHgyihEKA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maQFZdg2w4OQ2gC3TZ3AHB8vX+NMxZ8IZTAlpenVKBoQ8abzS39CkuM4hT3H2PMznXiLLueEHVPV8aYwHTeOBjlEDShrY/MXj0zAn6rytfM46xjlHZ89WCeXANHUyPI2/Bh1Aooi7jKku45RTjpVTbC/2kz1GntJVB8PSiNaU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=jWq7d0Wa; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="jWq7d0Wa"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026061409173553acb9899100020706
        for <xenomai@lists.linux.dev>;
        Sun, 14 Jun 2026 11:17:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xxVQkb+P+htqyrDIKtPyHwYGj1YwNKEB2zWGEmdXYG8=;
 b=jWq7d0WagdknFZgGeeBna0SVHZ+DKMsDehysj0M1hkDudL84iWjE2LYcLJ/ZTtMcBIaWaR
 HhMJPTtSJWYpdBerOuJ5eXCTQPAFAFgQFGpl3hvbVm3FFFRrZPtFMNKGIDJ0Aq+NBbLfahgC
 Q22a15ijPGNtzw90qDKUzAlAFf0j559XaUfU7FVTwm9a2fkCZjyZ0sCWwxEIrVBJUhSVrcOS
 urA5fDPQ9Vp69AYGzon5CU9pEbNUrsG1PmDoiR+VXJXlfVh7FMEVz08zLuLgyA4H6TgCJalW
 5K6HwEdwEnc9irDUbc+eOfpql0z261bbsCfhM6oWtcA7ZEhANF7rPqsQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 1/6] Kconfig: Permit to enable debug mode for Xenomai 4
Date: Sun, 14 Jun 2026 11:17:29 +0200
Message-ID: <f4ff8f75dd3ae44a85beb8f38391720e8760108f.1781428654.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1781428654.git.jan.kiszka@siemens.com>
References: <cover.1781428654.git.jan.kiszka@siemens.com>
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

No reason to limit this feature to Xenomai 3 configs. The compat mode,
though, will remain 3-only.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/Kconfig b/Kconfig
index 98cbfeb..dc79700 100644
--- a/Kconfig
+++ b/Kconfig
@@ -201,31 +201,6 @@ config KAS_INCLUDE_KERNEL
 	default "kas/opt/linux-4.19-head.yaml" if KERNEL_4_19_HEAD
 	default "kas/opt/linux-4.19.yaml" if KERNEL_4_19
 
-comment "Features"
-
-config DEBUG
-	bool "Build debug version"
-	help
-	  This enables various debug options in the kernel that can help to
-	  validate the correctness of a particular Xenomai version and kernel
-	  patch.
-
-	  However, these options also significantly degrade the performance and
-	  maximum latencies, so don't use such a configuration for
-	  benchmarking!
-
-config KAS_INCLUDE_DEBUG
-	string
-	default "kas/opt/debug.yaml" if DEBUG
-
-config COMPAT
-	bool "Build 32 bit Xenomai userspace"
-	depends on (XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
-
-config KAS_INCLUDE_COMPAT
-	string
-	default "kas/opt/compat.yaml" if COMPAT
-
 endif	# if XENOMAI3
 
 if XENOMAI4
@@ -292,3 +267,29 @@ config KAS_INCLUDE_LIBEVL
 	default "kas/opt/libevl-latest-release.yaml" if LIBEVL_RELEASE
 
 endif	# if XENOMAI4
+
+comment "Features"
+
+config DEBUG
+	bool "Build debug version"
+	help
+	  This enables various debug options in the kernel that can help to
+	  validate the correctness of a particular Xenomai version and kernel
+	  patch.
+
+	  However, these options also significantly degrade the performance and
+	  maximum latencies, so don't use such a configuration for
+	  benchmarking!
+
+config KAS_INCLUDE_DEBUG
+	string
+	default "kas/opt/debug.yaml" if DEBUG
+
+config COMPAT
+	bool "Build 32 bit Xenomai userspace"
+	depends on XENOMAI3
+	depends on (XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
+
+config KAS_INCLUDE_COMPAT
+	string
+	default "kas/opt/compat.yaml" if COMPAT
-- 
2.47.3

