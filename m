Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2C34CFC1
	for <xenomai@lists.linux.dev>; Wed, 19 Nov 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562335; cv=none; b=DMtZZBIH+3raKvYMLf4rPZlHKngaO7BOQVrcL1ejDSp0RQRlvYRmAbvwc8fHFLP3ID7DL1Vkek/V2Nfo0CdiZ5efDYG2KhRCK8KCkIxz3wVA/WlOlC6B9oxsStoCqYxuCdrvkI+05pHN31Zv95JK3fJiwpHVp2O4hn1mGNnNfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562335; c=relaxed/simple;
	bh=cDBhVZPJsaGSKQ7wclIn/DEz36QEql/BtWvhRBotj3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n08spSA0Pf9yobifvH2eOlaFlFaV8CYPTdFODBTYrGrkPPcsmyjbEbRKJrvQs5MxMTNDbsTs7oXeZi/paNzE5nKvnQBV3/y8DYwdYG5+cSFoBUzHmffdBzl1srp96PscUfoLM9F+LOeAgA1qYQbaW6shddyH3LztE/PdQhvsNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Mmkv8Z2h; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Mmkv8Z2h"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025111914252113cf78aacf0002074b
        for <xenomai@lists.linux.dev>;
        Wed, 19 Nov 2025 15:25:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=k+CeJZzPAaCbSUiaWJzzMmdOUMhd3lsBz1MHMsPDk8g=;
 b=Mmkv8Z2hQXs/U9k/eiMND2ud3zaqofwf1aUJ2IWWZ+bwANAaJPUv0iGGWS3gwcOK8Snbtl
 D766K4GGXGoYsVtt6Wo6STyj83tOKYIHGL98gzE15MZJ+frp42wRGKQTfQ0QbjfZ0+yY7X/v
 GLn1AW4JFA9Qst0H+CpALe5sKsuzq5VFZz0P59Dvx5rwh0YGcZVmH6h9Uoun/WnETE+sQbU8
 T7m9UbjHfLwjLDvXI7rwR4+lPKp0XRhIxrNM5H+ahLdRieAMRHgWl/mgd21/O9NbwHnSJhs+
 cdANb+At7X6n0qyXgIERlN+C2TLAzaWccONs82kuUCzz4ig3kTxT/XGg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU / FPSIMD
 usage
Date: Wed, 19 Nov 2025 15:25:18 +0100
Message-Id: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE7THWkC/x2NQQ7CIBAAv0L27JpSK1qvGh/g1XgAuthNgDaAj
 UnTv0s8zhxmVsiUmDJcxAqJFs48xQpyJ8COOr4JeagMbdMepZQ9Oj+hQok6BdWhmzOHAQvlghS
 18RQoFlSntu/MYTi7xkJNGZ0JTdLRjjUWP95XOSdy/P2/n/C4X8VtWqho9kLtJby27Qf5kOXvn
 QAAAA==
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

these are the necessary backports for dovetail 6.1 that would allow us to
enable the in-kernel FPU usage of switchtest. This is currently not
possible as dovetail < 6.12 does not allow / implement the necessary fpsimd
context switching.

I have backported the necessary patches down to 5.10. That would allow
us to unconditionally enable the tests for the xenomai3-next branch. I
will send out the 5.15 and 5.10 series once we agreed that this version
(targeting 6.1) is correct.

Please note that there is a small problem with this series. Patch 1
removes the check/flag that was used by the dovetail enablement code to
detect in-band FPU usage. The new flag is implemented differently in
patch 2. Patch 2 also fixes the usage of that flag. I had no better
idea. Otherwise I would have to delete? the in-kernel fpu preemption
code (temporary).

Previous discussion can be found here:
https://lore.kernel.org/xenomai/cover.1758264904.git.jan.kiszka@siemens.com/T/#t

Best regards,
Florian

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      arm64: fpsimd: Drop unneeded 'busy' flag
      arm64: fpsimd: Preserve/restore kernel mode NEON at context switch
      arm64/fpsimd: Avoid erroneous elide of user state reload

 arch/arm64/include/asm/processor.h   |   2 +
 arch/arm64/include/asm/simd.h        |  11 +-
 arch/arm64/include/asm/thread_info.h |   3 +-
 arch/arm64/kernel/fpsimd.c           | 193 ++++++++++++++++++++---------------
 4 files changed, 114 insertions(+), 95 deletions(-)
---
base-commit: 501e3ddd3ff59f522d9c7a1f2ee993620d5389f9
change-id: 20251119-flo-6-1-arm64-fpsimd-test-enablement-67294b3d8f0c

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

