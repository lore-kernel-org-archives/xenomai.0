Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6DD3D5225
	for <xenomai@lists.linux.dev>; Thu, 26 Feb 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117252; cv=none; b=Gt2VqXosipFvo0UQxXhwvQuzaUMz0/JWpkw8f/yxFV7tpxLs4rEvrwS1mwX0Pv2amxQjlPyCd0eQcmWJng+Wkr7YvVTlLSP1nhRyzAe0YSrVbFa1RaCQGPAIQ2QgECyT6q1K4TXeAcfiuuiDNuRPioNIdCSVm0NDu9zSYytxo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117252; c=relaxed/simple;
	bh=vehF9vyCsU7zh97E5pSR0lfFQdIBWyG2wupNPdofl9A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DWny8MREzbv1l5AdLbPTuFdkfBJ1dHaFGkv/a1LxYFnDGJdS80SyWmHVIxrEhsjWLKjOna2rUaxf5UEtYHo2oi1vn44dXm7irskEzbgOHXgfIYwEZCThi5Pij69gBR7hmliIWpoZ4+UEPhKyVZpB9yBV2gN2j0Vl1hAn5StoSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hVt+FJNr; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hVt+FJNr"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202602261437136d4237687300020756
        for <xenomai@lists.linux.dev>;
        Thu, 26 Feb 2026 15:37:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UkMc95PtVeI1Yl34rF0zUeb4jNGWA/pLBFg0iruBxGo=;
 b=hVt+FJNrbLEKJR6i9orDDL5z3GI1/5V8q066a4HhznIdshwZLC5NI4zVciNcsYRwAL9fOx
 CpB1wiqi4xUeLk/zfDnCAeZrDm50hqhdnaVGZHzHsx/zqzYQQVa6OmjGhzIPH43zU6Eg8RLZ
 PJZ25JGpbTzt5BbA3AvqTnmGH4XbKqne55jCXL7CU+kcrWW97ARJs1Lt81BUoaDK1nIzMeEB
 B19B2MH4Tn3fYz8ltZ247R2Ra7RZmHkUBYRR0ac5TL7JSGpu0I3WQLTwg8ng3sxDim91KJO2
 xXUgA2T6Xg2q4ifhNPYOzHUACDFYhJkDLhh9kOAaPzAVGwlodZirAQow==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 0/5] Prepare for Dovetail 6.19
Date: Thu, 26 Feb 2026 15:37:11 +0100
Message-Id: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJdaoGkC/33NwQ6CMAyA4VcxO1uzFRngyfcwHoB10kQY2czUE
 N7dQWKiBz3+Tft1EoE8UxCHzSQ8RQ7shhTZdiParh4uBGxSC5SoJSqEO49grw5GT2PtCazzoEF
 VUFrTmH2bl4i5SOdpwfJjpU/n1B2Hm/PP9VNUy/SN6t9oVCDBFpnG1hjMMzwGpp6GsGtdLxY24
 geF8g+FiUJEsraRqir0NzXP8wuA57SLDQEAAA==
X-Change-ID: 20260212-wip-flo-prepare-for-6-19-8fdbd4c58225
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

This are the necessary changes required for being able to build Xenomai
against the latest Linux / Dovetail versions.

Dovetail 6.19 is currently in the making and already build / tested
against this series. Without this changes the build will simply fail.

CI tested against:
  - Dovetail 6.19 (one other build issue remaining)
  - Dovetail 6.1

To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v3:
- Move all adaptions / wrappers to wrappers.h
- Add patch addressing a include order problem leading to build failures
  on arm64
- Address review comments from Jan
- Reworked some patch descriptions
- Link to v2: https://lore.kernel.org/r/20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com

Changes in v2:
- Rework patch 1, switch to cobalt specific API for newer kernels 
- Link to v1: https://lore.kernel.org/r/20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com

---
Florian Bezdeka (5):
      cobalt: Prepare for new signature of __request_percpu_irq() in 6.19
      cobalt/time: Migrate order of includes to "from global to local"
      cobalt/kernel: Lower impact of wrapping for older kernels
      cobalt/rtdm: Prepare for new signature of mm_get_unmapped_area() in 6.19
      testsuite/switchtest: Add support for Dovetail >= 6.19

 include/cobalt/kernel/dovetail/pipeline/pipeline.h |  8 +++-----
 include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
 .../cobalt/arch/arm/include/asm/xenomai/fptest.h   |  6 ++++--
 .../cobalt/arch/arm64/include/asm/xenomai/fptest.h | 16 ++++++++++-----
 .../cobalt/arch/x86/include/asm/xenomai/fptest.h   |  9 +++++---
 kernel/cobalt/dovetail/tick.c                      |  7 +++----
 .../cobalt/include/asm-generic/xenomai/syscall.h   |  3 ++-
 .../cobalt/include/asm-generic/xenomai/wrappers.h  | 24 ++++++++++++++++++++--
 kernel/cobalt/rtdm/drvlib.c                        |  3 +--
 kernel/cobalt/time.c                               |  3 ++-
 kernel/drivers/testing/switchtest.c                | 18 +++++++++++-----
 11 files changed, 70 insertions(+), 35 deletions(-)
---
base-commit: 363115d15682076ea0766a55c3c5b1eed87e1225
change-id: 20260212-wip-flo-prepare-for-6-19-8fdbd4c58225

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

