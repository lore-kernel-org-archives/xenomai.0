Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA64F61C
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939915; cv=none; b=St7/bOAvuz+YY8Kxnin8PPulXfWdL7x5deZPtiCxlsLhNQXQPvsw5PS6m8j5Ev2BFe4UTCxEIarWJ0RPGYnvUe+T4a4NHfksxFSl7w9FyNTS/EheyBQSERDQyhN9HsptRNPJef01UWUhAEvKHodzOJFEG8MxZlpBhnuiznBdo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939915; c=relaxed/simple;
	bh=JkTx/r49+vaovO0U/x119MANtBRBzjb0v+SZGoRHEyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5aNDv1Jo7kp1s9oeASG0tPo7dZeo19BNGnU3QdnQVUv/X59QNbMqk3SxX9MG5Ujkv2g5gmZTYc2uBLfvQWCxXAF6342KbLidi0EqmnDWFe/H0s8YY3+6CQVKtYYFMTm2L/Kr5iDz2SbGHgXNF28KCdY+Wglm2Gdd8EpYoXG+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=L2aa5UXV; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="L2aa5UXV"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240122160141b8419ea804db3891fc
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jan 2024 17:01:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=x3NpzB42DoAzSZiPzlj67IrYqxSKOhjRYZKn3zEGl/s=;
 b=L2aa5UXVTszAP5/dOwk/bSLa23ox6ENz7m+12CmwzW0It7cu5zicqX5caE0An7hfiC8ZKF
 6nko4BvsPfrMujAcyoFxMK/fz0Lir4WNWq+l85wuGubV/E+tAEy4udKBnc7R2XS8OzhC0sy5
 TSrPgQFe8ScYux6/Vl80oA684Y39Q=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v1 4/7] compat support: cobalt/arm64: Update ABI revision level
Date: Mon, 22 Jan 2024 17:01:02 +0100
Message-Id: <20240122160105.2452024-5-clara.kowalsky@siemens.com>
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

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
index fba1db391..3060bcfae 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
@@ -22,7 +22,7 @@
 #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
 
 /* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   3UL
+#define XENOMAI_ABI_REV   19UL
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
-- 
2.39.2

