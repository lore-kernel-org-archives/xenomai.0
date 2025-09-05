Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC936CDFF
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082397; cv=none; b=h+8or6gAJzPqa+wKIzL9d45Ult9dDHvhhYVsqIlyqAxy62E6Zt/7FGh5BNb5K1A/eqtQf6HL7Bk5y+dXUCjh1USjOBGQKqNkI9b2hq01JfFhASOJCp8s9ShLGtKy7c1D8I9Gd65XSYEnDG5yhG7B2/+XMbq/fueEyPHSdGsgY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082397; c=relaxed/simple;
	bh=9zJlzyNltSX4c/TpRaLew8gSeS1F5n5ytcHsqMwO6uI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ajbL+wkW74VgDiOzYw3ikX4rAJrOQ93qWKr8lC+1qEbT9nhpHXruXpMe72BjPLGEHINW+1eVVg37xNdD821zE2O6/UbEjN5L+TfncR9gLHJ5xUqjO35r9Z9pdXpJaCUwgbIFdpfInnWN+PAHjAzRRY/hNTKeG5OovHB+cryUjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=sXVo5Qx8; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="sXVo5Qx8"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250905142629134f06cade0002073f
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 16:26:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XDeTCAlo99k8hyk8ht/kRu8Lo4kSUcuO5xOkNMU0EZQ=;
 b=sXVo5Qx8uJDue8vWTemQ+nlYOcBuC1o7WP5l0H+4usibxxMcqBz4QNTaCopsPiUMg+tYWs
 8K9nrbrtaUDQTXzHBnt95gkOxYiDll7muSb3DSASo+XFUcohhofQ1NPjEqlZij3iarvjdy2E
 2/j1W4p/kmO7OusZTThyB/Ay/WD8aGXy0s2XV6zTzztORZ0cPfi5CvXYF7OpaZ7eHoRt8ltr
 ihMq4A76AGPT/7FpxmaQpqmKrbcVop4a70uJMhhiEAQTNGAA4oFHAOGVnKa77jVZG7yb85Ui
 VhO0TX1U4R85+Uf1M43NOLdkDWOII6RhMJuNZh2V64/C/vbpjV2EQ8LA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.16 v3 0/3] Dovetail 6.16: Fix some regressions
 introduced during last forward port
Date: Fri, 05 Sep 2025 16:26:24 +0200
Message-Id: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDzumgC/5WOwQ7CIBBEf6Xh7DZACzWePPgXxgO0i92kQgOKG
 tN/lzRevOlxZnbe7IsljISJ7aoXi5gpUfBFNJuK9aPxZwQaimaSS8W3ksOdZnBTAEcPTOBChCF
 kvBqaQINQIBq9dZ3TyK1ghWJNQrDR+H4sHH+bpmLOEdd+cY7s8OlXuhaanUo8UrqG+FyfymI9+
 nk/C+AwtK1TvLet5XafCC/oU92Hy0rP8k+iLETVKGydaZRy3TdxWZY3znMYykYBAAA=
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

seems the last forward port to 6.16 introduced some regressions.
Please review carefully, thanks!

With that applied I have two open problems:
  - Running dmesg kills the system, no idea yet
    Requires at least 3 CPUs on my qemu system to reproduce.
    Update: I know how to fix that, but not fully understood yet.
    Update: Fix posted to ML.

  - I'm able to reproduce [1] on 6.16 now
    Update: This one is understood now. Xenomai 3 bug.
    Tests already ongoing.
    Update: Fix posted to ML and merged into Xenomai next.

Cc: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

[1] https://lore.kernel.org/xenomai/6fcb3f9830056d99161ea8f50a016b99d98a7c71.camel@siemens.com/T/

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v3:
- Rework patch 1: Move preemption marker to thread local flags
- Added patch 2: Align arm64 and x86 fpu preemption code
- Patch 3: was Patch 2 in v2, updated to match latest Linux code
- Link to v2: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v2-0-535e4fa355f7@siemens.com

Changes in v2:
- Patch 1: Reworked as discussed on the list
           Following the same pattern as for arm64 
- Link to v1: https://lore.kernel.org/r/20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com

---
Florian Bezdeka (3):
      x86/fpu: dovetail: Fix FPU corruption
      arm64: fpsimd: dovetail: Align with x86 implementation
      irq_pipeline: Fix pipelining code for level triggered IRQs

 arch/arm64/include/asm/thread_info.h | 10 +++++-----
 arch/arm64/kernel/fpsimd.c           |  7 +++++--
 arch/x86/include/asm/fpu/sched.h     | 17 ++++-------------
 arch/x86/include/asm/fpu/types.h     | 12 ------------
 arch/x86/include/asm/thread_info.h   |  9 +++++----
 arch/x86/kernel/fpu/core.c           | 13 +++++--------
 kernel/irq/chip.c                    | 22 ++++++++++++++++++++--
 7 files changed, 44 insertions(+), 46 deletions(-)
---
base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
change-id: 20250820-wip-flo-fixes-for-dovetail-6-15-1368f7f6e0b1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

