Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56689216A3B
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653876; cv=none; b=KkCwSNx7L9cQBvnZXST8VTzyvXq4GQ+dnO81k/uJB0zRnkKTq7muUBowlDO/keGt/6rwKDpGkYWnwjBv4C6kMdy2f4vpvIJzgWcGUkbNYxkrIE/7hdaqXQU55gafYfmnulufTLrXC3uXFFvZU6LFCe34XB94YC77nnzGAe7kq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653876; c=relaxed/simple;
	bh=vKRgiWlmptn9cNDZWOHdfg6C9ijyKPyOlgeAkK9KUj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I89CfwFw42+OT1iUOiqggOU1co9Juk/w3NaB85mEzmQEunbFH/xz0qTVZ/6WGB80oLXn1jG6k/XE4XrlAw6ZgsOwX9v7DOvIjiSr86Zw6+9UjxajqHcDtvlJp8e9oSAI5JrUCHvnpKFr6kiMI08c3ONRbiR9vkyBY5W6h+tTVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Yaggfo3i; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Yaggfo3i"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20241011133751a41cce8870e306c499
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 15:37:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IydkgDXrFOy44A+jpcmiPYnMpRsIjcmzKrOOud8DRGU=;
 b=Yaggfo3iNlqVIIMAb6o6rv+lnyo/UOscZXx5j9Z4JC+ol70xAdFHjZB3FVnItZdoyWzK/a
 GiDv2qFougBuu/WQtL1CfiO0lO5XqL2wQuN/Dy1w9jW1wIRquxvrH1eTlY27diI2RZISlts9
 HY27A7Dy/7ZOk86XTb5KlOk6BlmU36TYEYLdZ400BihjE4MBkkVB5hxxr/ywDmHtFWoR0hs1
 TngmSFInX9xe8/KoLA+0gKYzSBylpz2jC2tzg6pAIupQV/+YufxHizMqTB30nrrwvq/V4w/D
 VrVLPBAujscVsI35P/4/aibYanSs8tWlH0O7aV+25S90mFNLzeVlrT/g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 15:37:51 +0200
Subject: [PATCH v4 3/4] y2038: lib/cobalt: vdso: Fix runtime error detected
 on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-flo-cleanup-y2038-v4-3-788b3a4bf3cc@siemens.com>
References: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Runtime error on a 64 bit application:
testsuite/smokey/.libs/smokey: __vdso_clock_gettime64 not found in vDSO: No such file or directory

Reason: Due to the changed __USE_TIME_BITS64 behavior the vDSO init
fails. __vdso_clock_gettime64 is only part of the vDSO for compat
tasks.

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

