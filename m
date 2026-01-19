Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19862DB79F
	for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818856; cv=none; b=DU7mr8VOlnKxDrimgodrHv0QYezPqJcb8wglUa43/Lo1zX4oygvkBIJqGIw2CgB/2b/ee6k86f9BXL+ouo8Qbfd60k5Q7kEgxQdARXFsDY3x4IQqiZvO2ieV7woV8rD6bDhrctiYy+NKuJIT1Ue0AFIFU2yHmPMC/WeLYHRYfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818856; c=relaxed/simple;
	bh=h8YL51hHJ+M4xaRYqmlMOUz95ZI8WmSc6zxja9A+Ato=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lk63GfxxoMAubwN6ArZHDwIZuJLaNPjn4MQGuN3ZKLnyrH9o/lUfDQuSNcmIQe3z8wvzRpxmvELUjPMDRudcEd/5p7BCHzqA7iaw4mPSDklTjtcomlJYiWm4/1ONNKyZDtntN7WwiyBGZc5HyUm/A8WZy9DpuyGZkSAF4y72d4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dtZYT2F2; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dtZYT2F2"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260119103410c9ac3b98430002071f
        for <xenomai@lists.linux.dev>;
        Mon, 19 Jan 2026 11:34:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yQSknHorZWfK9gTOy0NP1/oOJ55qputGDnuj2Z7LPwI=;
 b=dtZYT2F24e5SQcAMzQ07+OHa/CcBPh9ukt3BGhdTTSqE0gnsoqSW7Uj7lRXhgFWGzhC9iQ
 Tyc8q7S5U9TJAnxjprdMdCCjvHxKFNe5QKZLtGYPZC0DV2zqhMeLVv+zIVqNggsqca021qww
 TjLbVKp/e9pOEDHLDJJvrrK07Lrrh+zfHsiB1kRp/nZ7+nsPSGIjkrsHhQ1REPYZJlSBje6W
 /tSPnBdin/9vzh8o8J2ttdqY2XS98rNqnjiOfqh1LfP0L0/QsxtFOEQwE4v9eHIEPEVbQmlR
 4AYzWL1ttmL6DCo8/RBuwChSB1Pj96U5p9k81VmNRkNLzVMBy16ukNfg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 19 Jan 2026 11:34:06 +0100
Subject: [PATCH 3/3] cobalt/arm64: switchtest: Enable fpsimd testing
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-wip-flo-test-improvements-v1-3-b70e8726ec0b@siemens.com>
References: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
In-Reply-To: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Dovetail for arm64 is able to deal with in-kernel FPU preemption.
Enable the fpsimd tests on arm64 to get better test coverage.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
index 0958d5e2a..520cd3851 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
@@ -7,19 +7,22 @@
 #ifndef _COBALT_ARM64_FPTEST_H
 #define _COBALT_ARM64_FPTEST_H
 
-#include <linux/errno.h>
 #include <asm/xenomai/uapi/fptest.h>
 #include <asm/hwcap.h>
+#include <asm/neon.h>
 
 #define have_fp (ELF_HWCAP & HWCAP_FP)
 
 static inline int fp_linux_begin(void)
 {
-	return -ENOSYS;
+	kernel_neon_begin();
+
+	return 0;
 }
 
 static inline void fp_linux_end(void)
 {
+	kernel_neon_end();
 }
 
 static inline int fp_detect(void)

-- 
2.39.5

