Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E6322755
	for <xenomai@lists.linux.dev>; Thu, 11 Sep 2025 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594773; cv=none; b=D8iAVi9EruD3KO1M7DLuHqihJ1JlnPUqOjyU/20PdZL9eVqm5t3o7N5YxuFK/Q53vr/dV++IIVNPycwlN5PHrvwiX1+o2iWuxL3HMSuwSDfyZ/ASl3TSNXMa8nmNnxlnjg7MsrTz/B2tS8ufPEaWMcaa5VEkhk1THjajoyQX2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594773; c=relaxed/simple;
	bh=1HoOUEqxxFGCiUWD40x2PW5HvqcOxSDBXSGP3+HHe2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nKJSB5TdFaHg2LbPHhvsI/aV1RepITUm3ZmFJt+Xogvb54S0+Dzpd6LUbTM1Qu9Cd3AWcbflCn0sHVmWICL/Rm3Q3E8hOp6snDEM9b6xv9JukZf94n+DRLVek95dn+m374RWdx+NmFRhPnmxDv8g+Bro8Ee6glTqR08t08SVcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FAaCQRuy; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FAaCQRuy"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250911124600a779ccd76d0002079e
        for <xenomai@lists.linux.dev>;
        Thu, 11 Sep 2025 14:46:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=d+Ugobou8ry/h9tq6rKqrhVHIJHCoQC5htL03s8m4/w=;
 b=FAaCQRuyscVdUuXDA9hMjBg89igV+2VoPoxU7jc11cR3qDupxRqYS6PU8dbPFsy9HH9yJk
 1L7op2TpEi5o2v7VaRqcDz/aTAewhg9ApRafQtNeMDkhWwSlFlI8/b0glxFWIO8rH3PZokfi
 pqER+UAvSnNrNWPrqOkpo3uoJdWKurtP/Ud9UGnOoklaw/hmXvx5fmV/nOp7xOz7csfGYvEL
 Yx/YT3jmBZ78itwO6SPwvYKTmcAjH6LH39QWKvMfsV6HFHCRG5j573oFKdND9s7WMfK0QHZY
 7T+xHf8W/vMzxDX8e/h1Q8xSl+au+zv0q1CtFXNKqc47ErdrFvBpWKxw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.16 v5 0/3] Dovetail 6.16: Fix some regressions
 introduced during last forward port
Date: Thu, 11 Sep 2025 14:45:58 +0200
Message-Id: <20250911-wip-flo-fixes-for-dovetail-6-16-v5-0-4c54bbcfe6b5@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbEwmgC/y2MQQrDIBAAvyJ77haVRkjP/UXpwaxrsyAaNE0LI
 X+vlB5nYGaHxlW4wVXtUHmTJiV3GE4KaPb5ySihM1htBz0ag29ZMKaCUT7cMJaKoWy8ekno0Dg
 kIiZ7iTqGEfpl8o1xqj7T3D/5lVKXS+Vf380dbv9eubNx8DiOL2L8W1aVAAAA
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

seems that I screwed v4 up, so I have to send v5 after merge.
Philippe has to fix the rebase branch.

Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Changes in v5:
- Patch 1: 
    - Fix build failure for !CONFIG_DOVETAIL
    - Use the correct struct thread_info instance in oob_fpu_preempted
- Link to v4: https://lore.kernel.org/xenomai/875xdrwxja.fsf@xenomai.org/T/#t

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      x86/fpu: dovetail: Fix FPU corruption
      arm64: fpsimd: dovetail: Align with x86 implementation
      irq_pipeline: Fix pipelining code for level triggered IRQs

 arch/arm64/include/asm/thread_info.h | 10 +++++-----
 arch/arm64/kernel/fpsimd.c           |  7 +++++--
 arch/x86/include/asm/fpu/sched.h     | 19 +++++--------------
 arch/x86/include/asm/fpu/types.h     | 12 ------------
 arch/x86/include/asm/thread_info.h   | 10 ++++++----
 arch/x86/kernel/fpu/core.c           | 13 +++++--------
 kernel/irq/chip.c                    | 22 ++++++++++++++++++++--
 7 files changed, 46 insertions(+), 47 deletions(-)
---
base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
change-id: 20250911-wip-flo-fixes-for-dovetail-6-16-cccec24f0fd9

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

