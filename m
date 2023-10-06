Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21D11730
	for <xenomai@lists.linux.dev>; Fri,  6 Oct 2023 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="hNB9imCV"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023100610433589bf399fa9a097d32e
        for <xenomai@lists.linux.dev>;
        Fri, 06 Oct 2023 12:43:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zqHqf9tftLKyczSIMPJvi/RxX/43SWaCpzJr5DNhKOA=;
 b=hNB9imCVK/vtLSlFpKBAt0/jXNW0YzTvCc00JvxN5NFvg7qzFkrRU/WC/+nNawl2wz7jXh
 a6jZF7Ava+RmkorNs1aYC1BIOlrB6vm3o6W6Kg+FZ9+RgMOwQPA+kKA78MXIy9gjnHiraKXF
 FmtF4nlAXcJuWzLvEUlX2B5VddvV0=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [RFC PATCH v2 2/2] arm64: dovetail: Fix armv8 SWP{B} instruction handling
Date: Fri,  6 Oct 2023 12:43:04 +0200
Message-Id: <20231006104304.3813326-3-clara.kowalsky@siemens.com>
In-Reply-To: <20231006104304.3813326-1-clara.kowalsky@siemens.com>
References: <20231006104304.3813326-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The emulation of the deprecated armv8 SWP{B} instruction cannot be done
from the out-of-band stage. The core is notified before handling the SWP
emulation.

Reported-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 arch/arm64/include/asm/dovetail.h    | 1 +
 arch/arm64/kernel/armv8_deprecated.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/dovetail.h b/arch/arm64/include/asm/dovetail.h
index f7a672c750a9..f83f736747f8 100644
--- a/arch/arm64/include/asm/dovetail.h
+++ b/arch/arm64/include/asm/dovetail.h
@@ -19,6 +19,7 @@
 #define ARM64_TRAP_SVE		7	/* SVE access trap */
 #define ARM64_TRAP_BTI		8	/* Branch target identification */
 #define ARM64_TRAP_SME		9	/* SME access trap */
+#define ARM64_TRAP_SWP		10	/* Emulation of deprecated armv8 SWP{B} instruction */
 
 #ifdef CONFIG_DOVETAIL
 
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index e459cfd33711..755e0785fcf4 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -232,6 +232,8 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
 
 static bool try_emulate_swp(struct pt_regs *regs, u32 insn)
 {
+	int rc;
+
 	/* SWP{B} only exists in ARM state and does not exist in Thumb */
 	if (!compat_user_mode(regs) || compat_thumb_mode(regs))
 		return false;
@@ -239,7 +241,11 @@ static bool try_emulate_swp(struct pt_regs *regs, u32 insn)
 	if ((insn & 0x0fb00ff0) != 0x01000090)
 		return false;
 
-	return swp_handler(regs, insn) == 0;
+	mark_trap_entry(ARM64_TRAP_SWP, regs);
+	rc = swp_handler(regs, insn) == 0;
+	mark_trap_exit(ARM64_TRAP_SWP, regs);
+
+	return rc;
 }
 
 static struct insn_emulation insn_swp = {
-- 
2.39.2

