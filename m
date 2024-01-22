Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288974CB56
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939313; cv=none; b=nSUkN1Z71fdEtae2R+4TdAKFx5OBEMpvT2O3xSQQWEHocFEnJ4WBYHIhl69r2PNi9G+WibnMJAD6XkMXIfV+T/MP38I/2YsCM/JcpVbsW47EBYy8/FI3r8TiQgZba/NTRNknwfFaRsXOeMqaf5r2aoSbfHKSUN7xT8MzhRpzuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939313; c=relaxed/simple;
	bh=apqbQ+MUcLeUgyirMQFUwV95MP16avxXUv2g20yTHXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBs6LAOidQdVhLnl4zWIvU/R8/yK2MFacnAQ+FCQIJyvKVAk1Sy+tTI665OHRCksb8Yq0AoWd6X4OdIxLAXMkNbKE2DFHp1/heBGFnaxuwkBI8OPMHfHCPQ5vx7/qMFPcDsUfkdRWVpS3iYuSh2Q+BKfbx5Qv9jVLPYSRxj/46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=KuS52el2; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="KuS52el2"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024012216014261bd07e14cc50b9a43
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jan 2024 17:01:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=u22knRVoB4CF9IFg1+Tfu/pESd1w5xUSNcr93GCBiC4=;
 b=KuS52el24LPxGUHMfRZMq/zezY5U8TqDaDnoOEa+3cxA9uhgnkuy+ZEobRoZIW5/O6cFlS
 DQ/brDFAuQvlkRRYOovh0TdAGoRT/uoLfO3TNginTsUrRMgcUCOqi6sWmXLyYnigKSIbWxfa
 XVYuEbvvAyC3y1lcTtnY1e7wp5quo=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v1 5/7] compat support: cobalt/posix/syscall: Use syscall_get_arguments()
Date: Mon, 22 Jan 2024 17:01:03 +0100
Message-Id: <20240122160105.2452024-6-clara.kowalsky@siemens.com>
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

Use the generic implementation for fetching the syscall arguments.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/cobalt/posix/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 6e1f15ea5..1d37cb279 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -584,7 +584,7 @@ restart:
 	 */
 
 	p = current;
-	pipeline_get_syscall_args(p, regs, args);
+	syscall_get_arguments(p, regs, args);
 
 	ret = handler(args[0], args[1], args[2], args[3], args[4]);
 	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
@@ -733,7 +733,7 @@ restart:
 	}
 
 	p = current;
-	pipeline_get_syscall_args(p, regs, args);
+	syscall_get_arguments(p, regs, args);
 
 	ret = handler(args[0], args[1], args[2], args[3], args[4]);
 	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
-- 
2.39.2

