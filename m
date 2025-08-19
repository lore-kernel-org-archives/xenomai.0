Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9D24466C
	for <xenomai@lists.linux.dev>; Tue, 19 Aug 2025 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644032; cv=none; b=dwNdPMBBY+DvdFquvIHK4O0XhK0krucofvR6UgBKIP6S4DQU8Jjz0pJ73rHHSeTl/iva3qbfWzWjJVD0EBpSs79ABf1fQrLSO0MN3ojsbLVQGujrO0ayoqPJoE22WBq+nVG2FGOs1tAAlUzpRJukaAlL9GnNUHo0u0VGmk258n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644032; c=relaxed/simple;
	bh=ydSh3CWt3B7ejrznTDwsCjH/l6kU84/IezfDvplmyTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aagSE7ue2aaSX/YBn2U8KyyCv/rpjQD//1hif76yzB1MxnfINokfBMS6RdYeJXPowbCKLccXm16zio01jjLb4eWZSietSfR9IQmVxBQ+GgMNLBLjtEsBPNpGBzHcPL9EgcMNa6ucJ9+DlFz+si3f1/gaB2Z5e+q63wpQEz8nJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Cm4nJyVN; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Cm4nJyVN"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202508192253383763174b1c462903ac
        for <xenomai@lists.linux.dev>;
        Wed, 20 Aug 2025 00:53:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=bq+1eLJDTK3TLc12cnd5fphz2/aWVSw2RJiS+xgTBKE=;
 b=Cm4nJyVNKDqm96kA69ZEPbMKsE1x9T8DwJg+3RbGKBQSwBrCWQegVL88ZbEFIZwIIpWtW5
 eAddz9L40+FzhDk0BFgJGEgw5dyV4K1XihCqJbLD1NpZDhCHhaMHmAmqy7q53fPMr1V5OpkJ
 VdLDVLpOTL+HJyrZv4fZsQjkJ679bjTn9qZERLRUhkpew6yHwOMFEAcPFme6V1ZDnCHqrJdv
 5rimUlZArz1dPujFyrHifyjzMiXI5tQ5J2QMYxcHWhZdRDvz1idY07g8S6uDmgi1H86JGYTC
 Pt7akTNKHaTHp7I1579g/8Dec6SzIVJDKDF0xRcQFWyT4yDmpqK58uUg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.16 0/2] Dovetail 6.16: Fix some regressions
 introduced during last forward port
Date: Wed, 20 Aug 2025 00:53:34 +0200
Message-Id: <20250820-wip-flo-fixes-for-dovetail-6-15-v1-0-d44f50cb4b0b@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4ApWgC/y2MQQrCMBAAvxL27EoSaSye/YV4SNqNXQhJSbQtl
 P7dRTzOwMwOjSpTg5vaodLCjUsWMCcFw+Tzi5BHYbDadrq3GleeMaaCkTdqGEvFsSz09pzQoen
 QXFwfr9GRDgbkEnwjDNXnYZJP/qQkcq7068U84P7vlTsbB8/j+AJEbccHlQAAAA==
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
    I tired to trace that but failed to get the traces out of the
    machine.
  - I'm able to reproduce [1] on 6.16 now, no idea yet

CC: Philippe Gerum <rpm@xenomai.org>
CC: Jan Kiszka <jan.kiszka@siemens.com>

[1] https://lore.kernel.org/xenomai/6fcb3f9830056d99161ea8f50a016b99d98a7c71.camel@siemens.com/T/

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      x86/fpu: dovetail: Fix FPU corruption
      irq_pipeline: Fix pipelining code for level triggered IRQs

 arch/x86/kernel/fpu/core.c |  3 +++
 kernel/irq/chip.c          | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)
---
base-commit: eec111a874f5899e1078ef785ccf29dff986e5a0
change-id: 20250820-wip-flo-fixes-for-dovetail-6-15-1368f7f6e0b1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

