Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9BC1DD525
	for <xenomai@lists.linux.dev>; Wed, 15 Jan 2025 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982653; cv=none; b=UeQlbk+JschTGPscaREYKHpsnvocw9I66N7/TonTap8TbFqODZfz3cgS410TR2kgNT/LbFlpluMib3+JPApQ9N3LUT0/1N4LbxQ0aeYcomRHMwyAt1CIF6WhIBP1Sf6tLile4uO/aHJZrYtU364KptLfH9Lhd3EEOjlMsgce5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982653; c=relaxed/simple;
	bh=KLIfS+aQzncGGSOotfzeGUrBdmE8lUcr3Dy6SKmJZrw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tz+tVJAupdZp5+UnJ+/bmck2HsWXgN4wzNioiZTPKXM/adgdZFn07oyEk339EMT5j5Gi37QYPyVCbUuoxZ7UBloiY/uLqY9FRyDK4FqVMEcqXcP+PY1ND7vDgkGweOFpmBr5RHQRlzl/KK3N3auircdSPF0YZVr96YrLqfVHats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fZvmjt8R; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fZvmjt8R"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202501152310412909f4f9ae5c5e342a
        for <xenomai@lists.linux.dev>;
        Thu, 16 Jan 2025 00:10:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Cfda8oaoMsxkAxJkLhNkwge3juZYPlQdXYZQbVBoyME=;
 b=fZvmjt8RGWlzZb+zA3urjN2J3pqoCgUsRqg3+pWyYrnqUa8P3CD6HpzGRbDgg/mHDesAl6
 +/+7Jx1w47+65LuyS3hWonLzRmDR5e6v7x9pLopvrciHxXClp0KfX2miYm4twRKeb5TKT/on
 6An7yA/i3mUxIc9SyUC65Bo3BVPGCT06M34N2GM2e0Mda01cR/ruNhFlDNWeicCNCioChNLV
 Bm8A2M9+r2/866cybS1B1WHhmHkbKlz2JLw96Rz+jRhUQX2f2hAbkwYDCxeS3ejGt7ZfSG6e
 NDFiZn1sEqN6FUQYENAlWhxWOV6WGWUDgdSYrI4lJFLvCIGOZ7BiJvoA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/3] libcobalt: Cleanup / Remove architecture specific
 syscall API
Date: Thu, 16 Jan 2025 00:10:39 +0100
Message-Id: <20241012-flo-cleanup-before-release-v2-0-3e9a16780880@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG9AiGcC/42OTQ6CMBBGr0K6dsy00QiuvIdh0Z+pNCktaYVoC
 Hd34AQu31t871tFpRKoinuzikJLqCEnBnVqhB10ehEExywUqotEqcDHDDaSTvMEhnwuBIWYK4H
 u0HXOY+vwJnjA7NIUnezAE2mOkeVUyIfPUXz2zEOo71y+x4FF7vav1iIBgVtX4zVq2+KjBhop1
 bPNo+i3bfsBzqlTh9sAAAA=
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

This is a cleanup that is now possible after the armv8 compat
implementation done by Clara. All architecutres are now following the
Linux syscall ABI, so that we can clean up a lot of our own SYSCALL_
stuff and switch to syscall() provided by libc.

All functional tests are looking fine, so I'm reaching out for early
feedback now.

Comparing the old implementation - assembly wise - with this series
shows some (minor) differences in register restore operations. That's 
mainly because syscall() is a function call that can not be inlined 
into the caller. Looking at the mass of code that we can delete now,
I think that is worth it. Other opinions and performance comparisions
welcome.
 
In addition this series is a good first step in the direction of moving
to prctl() based syscalls - like evl does. There is some more work to do
of course. One problem that was already identified is the number of
arguments passed to the kernel. Especially select() would not fit into a
prctl() call.

Best regards,
Florian

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Rebased on top of current next
- Rewording of patch/series subjects
- Link to v1: https://lore.kernel.org/r/20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com

---
Florian Bezdeka (3):
      libcobalt: sycall API: Remove architecture specific implementations
      libcobalt: sycall API: Reformat all XENOMAI_SYSCALLx call sites
      cobalt: syscall API: Remove architecture specific parts

 include/cobalt/Makefile.am                         |   3 +-
 .../kernel/dovetail/pipeline/vdso_fallback.h       |  19 +-
 include/cobalt/kernel/rtdm/fd.h                    |   1 -
 include/cobalt/syscall.h                           |  56 ++++++
 include/cobalt/uapi/asm-generic/syscall.h          |   1 -
 .../cobalt/arch/arm/include/asm/xenomai/syscall.h  |  51 +----
 .../arch/arm/include/asm/xenomai/uapi/syscall.h    |  28 ---
 .../arch/arm64/include/asm/xenomai/syscall.h       |  47 +----
 .../arch/arm64/include/asm/xenomai/uapi/syscall.h  |  28 ---
 .../cobalt/arch/x86/include/asm/xenomai/syscall.h  |  53 +----
 .../arch/x86/include/asm/xenomai/uapi/syscall.h    |  23 ---
 kernel/cobalt/dovetail/syscall.c                   |  34 +++-
 .../cobalt/include/asm-generic/xenomai/syscall.h   |  26 +++
 .../cobalt/include/asm-generic/xenomai/syscall32.h |  20 +-
 kernel/cobalt/posix/syscall.c                      |  70 ++++---
 kernel/cobalt/posix/syscall.h                      |   7 +-
 kernel/cobalt/rtdm/fd.c                            |   7 +-
 .../arch/arm/include/asm/xenomai/Makefile.am       |   3 +-
 lib/cobalt/arch/arm/include/asm/xenomai/syscall.h  | 122 ------------
 .../arch/arm64/include/asm/xenomai/Makefile.am     |   3 +-
 .../arch/arm64/include/asm/xenomai/syscall.h       | 104 ----------
 .../arch/x86/include/asm/xenomai/Makefile.am       |   3 +-
 lib/cobalt/arch/x86/include/asm/xenomai/syscall.h  | 216 ---------------------
 lib/cobalt/clock.c                                 |  11 +-
 lib/cobalt/cond.c                                  |  11 +-
 lib/cobalt/current.c                               |   3 +-
 lib/cobalt/init.c                                  |   5 +-
 lib/cobalt/internal.c                              |  23 +--
 lib/cobalt/mq.c                                    |   2 +-
 lib/cobalt/mutex.c                                 |   3 +-
 lib/cobalt/rtdm.c                                  |  20 +-
 lib/cobalt/sched.c                                 |  24 +--
 lib/cobalt/select.c                                |   6 +-
 lib/cobalt/semaphore.c                             |  14 +-
 lib/cobalt/signal.c                                |   2 +-
 lib/cobalt/sigshadow.c                             |   3 +-
 lib/cobalt/thread.c                                |  24 +--
 lib/cobalt/timer.c                                 |   5 +-
 lib/cobalt/timerfd.c                               |   3 +-
 lib/cobalt/trace.c                                 |  10 +-
 testsuite/smokey/y2038/syscall-tests.c             |   6 +-
 testsuite/switchtest/switchtest.c                  |   2 +-
 42 files changed, 276 insertions(+), 826 deletions(-)
---
base-commit: 7a6453b25b3c1341fd1a5abd553bfca99d0ef77b
change-id: 20241012-flo-cleanup-before-release-a90d9df08d07

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

