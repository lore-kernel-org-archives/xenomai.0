Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFD3F8E1
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939916; cv=none; b=Of0WZXvhBXSVgepwRcbbfRcs+5dm+fJ7Be9VAFgEjq3kXGRW4DWkgBIsSKpuWSMSnnMB99/ORpy6QrilpzYfdb1XcsQO1+TbUlEgs6j7GuN5Ys0bIl3aL1vxJr8pwNlK62LwYMCkrs7RIW5b2WjBn1c8pyifv+YAC6Yw4XFdHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939916; c=relaxed/simple;
	bh=iw48FkoW7wCbjX0z4LDKhWTIGdFN/xMlgPJ1cZzbJsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMVV9NxCEHxKvMd7MHY9bqjIKvVnQphc0BBQ/JeNAFtNRWQPB/rhP2PjxyYjhqQrRh9ZY3Va/yWjBeD+LbH/od/LGclN76Eb3pYvNcDAsnj1mRjybhCETQzOlvTXt4vgbe344JsNCyyvsLZVb8SUD363svvQyvGjPnsRZ6vDTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=M3BWhEby; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="M3BWhEby"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240122160145bd03d97bdcf6858fab
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jan 2024 17:01:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KIbUaKEcgJZIpC5ds+1DXqvRHfkuJKffgkxcKpIHUAI=;
 b=M3BWhEbynKS4+sgsSxNwzASPmQPoD8W9a02zVjGd/C+6SvOsGyiEDeFaJdkOGfucVY5+Ft
 0Ju9vJcWcdB/dC2yiBmI3wj9M/S2YLAopydofZa5MYodKWOZDRlld1hoeb2HuVSymiWRBogC
 8Un35WlfsLZgxoV+spRXrZgbm9zZo=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v1 7/7] compat support: cobalt/arm64: Enable compat support for arm64
Date: Mon, 22 Jan 2024 17:01:05 +0100
Message-Id: <20240122160105.2452024-8-clara.kowalsky@siemens.com>
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

This enables the 32-bit EABI compat mode for building the user-space
libraries of arm64. It allows us to run arm(hf) applications on arm64
kernels.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/cobalt/arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/arm64/Kconfig b/kernel/cobalt/arch/arm64/Kconfig
index bdf5f1602..2d7b204d4 100644
--- a/kernel/cobalt/arch/arm64/Kconfig
+++ b/kernel/cobalt/arch/arm64/Kconfig
@@ -5,7 +5,7 @@ config XENO_ARCH_FPU
 	def_bool y
 
 config XENO_ARCH_SYS3264
-        def_bool n
+        def_bool COMPAT
 
 config XENO_ARCH_OUTOFLINE_XNLOCK
        bool
-- 
2.39.2

