Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0671C172A
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599452; cv=none; b=ne8FBcQc9QzW/VUb1Uq7f3IMNGpaY1qMVs9LQBIeCIZw/h4VFtFFbgNtx2TG5J9WHROxUPbv/L1VKa3p3YsOR9O11kEcQT9JxQ6ZsvYiq3li8V0mc/1Ntv2rRT3vJExDgoCG96mKFsk1w1P1vOyadsYW/gS31Z8YjFylKTYahe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599452; c=relaxed/simple;
	bh=18b4DPWMOdAkICUFSN4eR230R5O0L5KrTGhEHTx4Coc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+uEOKDK6Ei8zXAPLxBPiUTx/1PYrXyzHsDFBAI2rOL9XXWP7tbh1aEKlHWCmAlfFdwqD+kaO0PBm0YWshdPQgAPBQDKpw8pe1pL8J7EyiegwH903vT3gnZMUOOI4y12lq0mWM6OA5rVoAPKIZvKkV5yYiqz+G8bQ/eUurkgXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MfioZHe1; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MfioZHe1"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202410102230467b907aedf5162fe30a
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 00:30:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vb1Cem8qGsYbr32AngMK5ysQDiBO7nGMNHo8AKw8PdU=;
 b=MfioZHe1iFhRqsvzcbZ7rnYTNnDi12O9wO0N2MOx6W0IHyrVz7vvr1S/gmQY+3CZ3fjwFa
 lEq/mVeAYFPqbwcCwjOgeYjl5F//WLbxrt1oDzDPlKvayYuoZkpzCzxeVyAJqQO72LYO0mNo
 JqHOvS8yNyIqS0ZnjHa4hly3kAmWo0NzbxYUgTZpT/TbUBAD/lO9FzdMxte9mueKZcBb5P/w
 NE0RhxRQVXtO3iGF3MNxgBlOAVqCBdfJxca8KjnjHq3sLcU+NKpf+wXqvpOXEstnWAzruzCP
 3+ofXPx8ELakJ77y87qgS+N64u2Cl6sXk/5zGXsZN7Y2fjO+1JrjBUSg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 00:30:47 +0200
Subject: [PATCH v2 3/4] y2038: lib/cobalt: vdso: Fix runtime error detected
 on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-flo-cleanup-y2038-v2-3-0ef0d52cf9c1@siemens.com>
References: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Runtime error on a 64 bit application:
testsuite/smokey/.libs/smokey: __vdso_clock_gettime64 not found in vDSO: No such file or directory

Reason: Due to the changed __USE_TIME_BITS64 behavior the vDSO init
fails. __vdso_clock_gettime64 is only defined for compat applications.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/arch/x86/include/asm/xenomai/time.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/time.h b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
index 18eb76697..36e027329 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/time.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
@@ -12,7 +12,7 @@
 
 #define COBALT_VDSO_VERSION	"LINUX_2.6"
 
-#ifdef __USE_TIME_BITS64
+#if __USE_TIME_BITS64 && __TIMESIZE == 32
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
 #else
 #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"

-- 
2.39.5

