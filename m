Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556031;
	b=w+ALxHvvON6SCNRO63t+HVepPUIQGr2HpjsQWOXk9xcAiTJ/KQ5RPxuTpNURUA+PoYbf
	 MhekzgXZxipxNpEBWbiRQMTKUrM+drhOhP7oW6KCS4ukIAZ5ccrTOIrlKt1mIn8HW9DEK
	 +1q1Y3mMc6L5M0+xfCpb+OM/wNhvkRHkjxpMAj+aiPEMg6FKXT6f6/KxmGxVMAQVxwSj8
	 xBX0iIl5K+6AAILM2HUEaE951PqxbnieLTDsJzB5sLRzo8J/oa76ydbBTtdiREVLp/K74
	 m+6ukhVZUPZ0yn4e+79zxg5+MwB/pVaPJJAeNSutfUjzBqYidTqSWDeZ97Ywjd/15LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mMGwBNjFp/5Vmcwax/LB/xgQrnnW+OgVSFmOInC3VK8=;
	b=u03v0eQDf50q6Ja5R0HJwemLIU43utq86x44KWioSH/TvNXXO+2xJ7NGE0PQc2oCOsIi
	 sczztj+5YwOlvezBTBI9IltOucJcnzzxsfRoTWr1t9hlyEN9OQpy+5rjTxnKlABuH0aat
	 +4RmTR9YUM/HqZ7cmFau8Q7VnhMvamhn/JPqeEGd1VjbU6d8Sjuf0sZm4J4U5hkZEB7M6
	 2R+fiCPGvmABbXYA1ptc4BXwcOfhRWL4pHViiQoMGJ/UK9JWW6Z8LaPj2P/ByRwTM/gXf
	 uUTrZnx+4kRppnR/6h2KpBXXgIp6LEHdlA9vwp4vzc+PjN+jC/XmKmr/OvcvgNNW9yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1Y3W1h9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3883606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1Y3W1h9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054F31F000CA;
	Tue, 24 Nov 2026 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795556030;
	bh=mMGwBNjFp/5Vmcwax/LB/xgQrnnW+OgVSFmOInC3VK8=;
	h=From:To:Cc:Subject:Date;
	b=j1Y3W1h9xIOfIDIk8C3Mtz/ptcxcns2al3gIeb+11v8ReC3kDTSRPuSIhjPy0LVBa
	 2YpfuZ8pJWXBrckOZhxw9jbK5mHjfLGLXMhvPsfRc/2dKSSGzx8ievUFQbDYP3m2Bp
	 JMHEloekUrDHHxtCwkH/DB3Vn44W1jyUCBil+36JDP5fnwioyjIpxPXvcXQoGQZlhX
	 pan2JPhO+wAmHsdyyOSTeBb2SMK5nDcK4vurm9ij/FD47Bst5+FDL7E+/hNrVnvkt1
	 KquBuoCnWclH9JmrlHdALKvzXhEX8bi8Xe3cEkb94VryruEMEfLZ8mpX35rF2+aalf
	 lS+g2bJkFQfZQ==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] configure.ac: Fix typo
Date: Tue, 24 Nov 2026 22:33:45 +0100
Message-ID: <20261124213345.2245315-1-rw@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

It's XENO_USER_CFLAGS, not XENU_USER_CFLAGS.
With the misnamed variable, xenomai was never built with -O2
on my side and caused funny performance regressions.

Fixes: 89c1436b3 ("configure: Propagate debug build settings also to plain applications")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 0d6dd87b6..d707fb11d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -743,7 +743,7 @@ fi
 if test x$use_assert = x; then
    XENO_USER_CFLAGS_DEBUG="-DNDEBUG $XENO_USER_CFLAGS_DEBUG"
 fi
-XENU_USER_CFLAGS="$XENO_USER_CFLAGS_DEBUG $XENO_USER_CFLAGS"
+XENO_USER_CFLAGS="$XENO_USER_CFLAGS_DEBUG $XENO_USER_CFLAGS"
 
 XENO_USER_CFLAGS_STDLIB="$XENO_USER_CFLAGS"
 XENO_USER_CFLAGS="$XENO_USER_CFLAGS -I$topdir/include/$rtcore_type"
-- 
2.55.0

