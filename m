Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089520B210
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636683; cv=none; b=D6WfpgCTXI/iD9feZzJAJT322q2wbEm3e7fL4mFQT62ioAUrdIREd5rIIK2+d3cePu9zaE9yf1eYpGTOnJLh0ZadabYgJSR2C09q6nMQxogdJFH65qgrwXvYAz81+YgClukmOiir4VBuQuP2/HtFhjo6cefzMC0St0g3gaT4SZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636683; c=relaxed/simple;
	bh=18b4DPWMOdAkICUFSN4eR230R5O0L5KrTGhEHTx4Coc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCOMpKN5dFkezDlXKO7BdWC4k4TykhX8iZaZQB3afx1vHj/IJQUuveLXDJZz0OxmtseFNA0GT80VAeUMc427ZkCQ6PWHgNoyEw86Mjh5WZ+n6sDGq4elVL97qdwKjDQML2YU4+di0hzk/Weh4Ngh1GgBSPF9yzGetMkGjqGlnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=aExYffPw; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="aExYffPw"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241011085117744b040b8c08292740
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 10:51:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vb1Cem8qGsYbr32AngMK5ysQDiBO7nGMNHo8AKw8PdU=;
 b=aExYffPwL/kD7PEf+yRyKuVFIoz6CpcxralbbPKnURtaGaV35YMCLGAgxtaf4yHokx5lm1
 aHgISQz66FHDnaQTzWgE4VbDQ6hBiQdBymmSu4lkozLW2PYFCETeboxCqqoBQ8f5CRvdS1zA
 SkOPZtu/fDFnEI8DnhZSlxres71PLUfzh45Q7ny6J17a+hpb92BqnrXfYzOIZN3NGCVh7Rb8
 p7t1FNO+5dzIpFyl308JfT6CmXdMilV8xwCI4KXXWQsNVu9/V/1syJx4w67d2iQfApk2Jd80
 1dsoRWrlXM3g6mLMgArj7du9lIV9fRGO3z50d/fLkZshg+h2v8w1+6Ug==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Oct 2024 10:51:17 +0200
Subject: [PATCH v3 3/4] y2038: lib/cobalt: vdso: Fix runtime error detected
 on Debian 13
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-flo-cleanup-y2038-v3-3-2657330fad19@siemens.com>
References: <20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com>
In-Reply-To: <20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com>
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

