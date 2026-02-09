Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A534405C
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629636; cv=none; b=rrkT0fkEKtCaeNWHCe0DsZvarjhZIMktBuF4o6a9uZbp/nug8OujjN85JiSb2JfIEJ/pkDz9k/4gPsroJS3IarD7u2BPuAYTXz5M4isPjf+qlEYgXaHMjFDIottaeAN9iCYlRMTFAG/gjMyWzlEjNmxIebwXvMT3OODiEYRcvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629636; c=relaxed/simple;
	bh=drGTNMfZ6Jgww7rO5M9hQaZesKuGLxMVxy7Z8zzoihg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Opc9dGMD/iEEOPWZeOBP5zU9uA0Qql/YXzz2oBcVTKSyO3FzvJdkMz8OKnJC/iZhjoxK1gpG13vX8rXX8cEHQFHEN9j7Gj8YjFJNYgEcVnoi2wFByvR+YVutNHdywpCVchz3pWsa2Y61RMMuLf4xDSmxBhNC6D2gSJYRiKXQvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ryke6qA9; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ryke6qA9"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602090933464ecd41d5ca000207f6
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 10:33:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=FySKfSSJEXcssLgB6oRNnjppoEyUs6p6WaPmxXJaY5U=;
 b=Ryke6qA9v4smNCgovMaYl+JkPTjuNOvcznVGnmeL3f3O49Z4LrxNk+1dq43IIQVdv7TCKf
 IzkTMgGFgAxItpuXWh/m4jBKhHZtHf3NYFA2+6x/z9okZx+OjF9fYav6ysEYmyHKPyoSucPs
 Kf/STxiTGu5Ky05kTBPnWhWfPsAuYUZGOmToXe1r3lYRBYj4FPfvdzyfFxYsMjPUBaaYiFNm
 lHuPnH5bELUCFZSKOyEalzq3Jl6vou6XG44n+gXkLMxskV/s4Xk4JYEQzg3316zQUj+IK4I9
 wjikCT00gc64A+GiBH18aP+fQqInfAS/qVw746w2VGi50io6ZY4yQBfQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.18 v3 0/3] Fix IPI mapping for arm64
Date: Mon, 09 Feb 2026 10:33:34 +0100
Message-Id: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO6piWkC/42OzQ7CIBCEX8VwdhvApLSePPgWxgM/i92kQgOKm
 qbvLvbmSW87k5lvZ2YZE2Fm+83MEhbKFEMVu+2G2UGHCwK5qpnksuWSC3jQBH6M4OmJGXxM0IL
 oQMte9VIp5yyyWjY6I5ikgx1qPdzHsZpTwrVWnRM7xoI3TeMn3TaiY+d6DJRvMb3WOUWsuV+fi
 wAOvUDNlVVoFB4y4RVDbmy8rtAi/wPJCpKd2XFnrHe++wYty/IGk1GTXy4BAAA=
X-Change-ID: 20260201-wip-flo-fixes-for-6-18-a2979277ddce
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

this is the result of a quite longish debugging session revealed by some
sporadic failures seen in CI.

Please review carefully as the code paths around the KGDB and BACKTRACE IPI
are not part of the hot path.

Backporting:
Patches 2 and 3 should go into Dovetail 6.12 as well. Older versions do
not have the BACKTRACE and KGDB IPIs implemented.

Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v3:
- Patch 1: unchanged
- Patch 2: unchanged
- Patch 3: Merged v2 patches 3 und 4
           Change signature of arm64_send_ipi() to catch future calls
           Introduced some clear trace point descriptions for OOB IPIs
- Link to v2: https://lore.kernel.org/r/20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com

Changes in v2:
- Patch 1: Reworked to address the LPI mapping issue only
- Patch 2: Unmodified
- Patch 3: Reworked to address the root cause properly
- Patch 4: New, address wrong IPI reason in tracepoint
- Link to v1: https://lore.kernel.org/r/20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com

---
Florian Bezdeka (3):
      arm64: irq_pipeline: Fix mapping of IPIs in LPI mode
      arm64: irq_pipeline: Fix size of IPI statistics array
      arm64: irq_pipeline: Fix IPI_KGDB_ROUNDUP and IPI_CPU_BACKTRACE IPIs

 arch/arm64/kernel/smp.c | 118 ++++++++++++++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 43 deletions(-)
---
base-commit: c30f265e8ac5feb0b7076141dd8877d0394e1437
change-id: 20260201-wip-flo-fixes-for-6-18-a2979277ddce

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

