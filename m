Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085343F8DB
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424506; cv=none; b=MhY1qvkcCgae0LGXb1FUZTlS0NCYa2fFaM2NR3G/e1p0/ffYcTwzF+CAJTXEFiCUePNf0PIsWRRBiRQu1W7E00d9KXyprsoBscHiuyyK2QeS8clC0anG3aYeyDH7u/dA7gvSby988xcM2nMqE1Lc9rxheHr/Z62A2+QiE/wgD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424506; c=relaxed/simple;
	bh=zLyIGE6IFEl5ip0M+O9AA0e1dsi+lIaSWVxkQ+cf+xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njkRfCBke/tHtxO/AGGBIz7TRnH3C/KbFUG+sid79HC05gZIA1dpf6gfUFI8tgZujNrs5V7pfbdJd1D3sDsXJQSoQdkgfCjdJgWXmiAmwV/73Yn+LpNVosa96iMVtsYJzZn7LyO9xt9BRguLAyQZPoTZkQVymKiHz+rpGFMVNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=WOl0ych7; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="WOl0ych7"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260903083453cfd9494c4e000207ae
        for <xenomai@lists.linux.dev>;
        Thu, 03 Sep 2026 10:34:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/mz3QZAMMFYCrClENh1wgjnlOxt3Sz5iLsEEHuFacIs=;
 b=WOl0ych7SEZQIcIJWMxl7nc67IXqBLJcx4sooSLM2GBjGUSFdP3iFSaUG/jFtAq/BGg0RK
 /413iYUcpzqaJJ8ig3S5CUMVFfjahRLWV87Yi/5USLiiwOX5q6r4xGUfOr4iA5Sh3rf4tOK8
 AQ5/IfRRrq8SuRyeIHQ75k0/FwB8FAxXkRpFCz9xg+S3ApjNVmV6eUTZGK4n4hIqpcvRswtB
 HvdTVPpr/ORIkU6Aek2vgDDIp/jUoHtM7AAkAADBsZ2krWHTJAQglwBa02UA/109npemfOui
 VOfq10AcE17O5SF8VuWIGkoCv5h1jvsaykl+0u9deKTRTbymYp3/Yr8A==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH 1/3] docs(xeno3): Fix doxygen parsing of COBALT_IMPL_TIME64 wrappers
Date: Thu,  3 Sep 2026 10:34:45 +0200
Message-ID: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The doxygen configuration lacks a definition for COBALT_IMPL_TIME64().
Therefore doxygen does not see the expanded wrapper prototype in
wrappers_time64.c and instead tries to match @param entries against the
macro call.

This raises warnings at doc build such as

lib/cobalt/wrappers_time64.c:42: warning: argument 'clock_id' of command @param is not found in the argument list of COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,(clockid_t clock_id, struct timespec *tp))

as doxygen is seeing the raw macro form

COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
          (clockid_t clock_id, struct timespec *tp))

With the fix, doxygen rewrites the macro to

int clock_getres(clockid_t clock_id, struct timespec *tp)

It uses the first macro argument (return type), the second (function
name) and fourth (parameter list), but ignores the third (alternate
function name, unneeded).
By this, doxygen sees the actual public function prototype.
See #18.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 doc/doxygen/xeno3prm-common.conf.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
index 71db05686..ee4ede10d 100644
--- a/doc/doxygen/xeno3prm-common.conf.in
+++ b/doc/doxygen/xeno3prm-common.conf.in
@@ -647,6 +647,7 @@ PREDEFINED = DOXYGEN_CPP			\
         "EXPORT_SYMBOL_GPL(symbol)=//"		\
         "DECLARE_BITMAP(symbol, nr)=unsigned long symbol[BITS_TO_LONGS(nr)]" \
 	"COBALT_IMPL(T,I,A)=T I A"		\
+	"COBALT_IMPL_TIME64(T,I,N,A)=T I A"	\
 	"COBALT_DECL(T,P)=T P"			\
 	"COBALT_SYSCALL(N,M,T,A)=T N A"		\
 	"COBALT_SYSCALL_DECL(N,T,A)=T N A"
-- 
2.55.0

