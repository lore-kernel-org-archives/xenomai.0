Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA092DE6FE
	for <xenomai@lists.linux.dev>; Thu, 16 Oct 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596356; cv=none; b=YWy4oQ35gMojmQKHkVPZyhRQXwvQqqL4Y73jJ82YTBnhOs3lKK8rEINo89YMdPF+x8rmWa8kVH958ZxoUuml+giKk6xTxxhjg+RQUvqj4bP3as+AVxJQFVcsgYA5ozY7wFBpIGQBECh6uSV2myJCVGq3C+X2vKt4JInXBU+nQzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596356; c=relaxed/simple;
	bh=8FojTqut9gCSLmVzSUHYFTDfOncUnR7XDRDb5uuniOQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hs/hQqxLbcG3xsHsxIxwHAHU8560kyiNq1VLglvNcl8PfQ0+gM9wNbYRLsrVut8C5nA2nykRVFjuIxJad5HTmjUWzgt/mzcIPjZXKr5Uv27fhAzCY99LcmGkmxJltr5pwa1ezGPL26HJS9mwmsGA+HffypgLUdYaaXWSZRP6fO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ZS0xqYkb; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZS0xqYkb"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202510160632256b71c90ca00002074a
        for <xenomai@lists.linux.dev>;
        Thu, 16 Oct 2025 08:32:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=R++tAgHvcI/0iT0xOP8tMUJb2Gw2qx9z3T/iC+aXhR0=;
 b=ZS0xqYkbWIvTTw+jX4qwfjU1Aw5+lYLENY6njODEqh/A2QgSOIWphJsm9m1OxpKumb/OK6
 nRAB49LopiQG3r9M2nS5bEgJ0wad777/pFNUER8SoSxiQHonre20w+vRjmgf0R8cF7D1/fcQ
 gp4ej7yaiFrw35FjcboKfnKu8E8tYtS8ciuYRV7HcyCpyi51/LX0GgAgjgBUK9izQMm5UmUE
 Os9xJLypMTNgEZ3KCXDk8p3nlZfBXKWcvM6Wu3umrkQfMqmWeYB9L/6/DvQk2/lnfr0/LZUB
 pmuz+PMkMnYM7x27JcrKw8uTS+Dwaz+IQKqPqwIorPkLtQ0BxX3ljVTQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH v2 0/7] Fixes related to toolchain / libc update
Date: Thu, 16 Oct 2025 08:32:17 +0200
Message-ID: <cover.1760596344.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Changes in v2:
 - added patch to make sched-quota test more reliable
 - addressed review comments on v1 (commit message fixes, __always_inline)

Fixes that where found via the trixie update in xenomai-images and some
cleanups. Most affect ARM 32-bit, the last-but-one also 32-bit x86.

While the patches do not change the ABI and would therefore be backport
candidates, I will likely only pick patches 3, 5 and 7 for stable.

Which means that current stable versions of Xenomai should remain
careful before updating their toolchains or libc versions for ARM and
32-bit x86.

Jan

Jan Kiszka (7):
  testsuite/switchtest: Avoid including arch-specific syscall header
  lib/cobalt: arm: Avoid thumb mode in syscall-issuing modules
  arm: fptest: Ensure that fp_regs_set/check functions are truly inline
  kernel/cobalt: Optimize xndebug_trace_relax implementation
  lib/cobalt: arm: Skip SIGSHADOW_ACTION_BACKTRACE over asynchronous
    signals
  lib/cobalt: x86: Fix and simplify 32-bit syscall argument setup
  testsuite/smokey/sched-quota: Make workload more predictable

 configure.ac                                  |  1 +
 .../arm/include/asm/xenomai/uapi/fptest.h     |  9 ++-
 kernel/cobalt/debug.c                         | 11 ++-
 kernel/cobalt/debug.h                         |  5 +-
 kernel/cobalt/thread.c                        |  2 +-
 .../arch/arm/include/asm/xenomai/Makefile.am  |  1 +
 .../arch/arm/include/asm/xenomai/debug.h      | 27 +++++++
 .../arch/arm/include/asm/xenomai/syscall.h    | 17 +++--
 .../arm64/include/asm/xenomai/Makefile.am     |  1 +
 .../arch/arm64/include/asm/xenomai/debug.h    | 18 +++++
 .../arch/x86/include/asm/xenomai/Makefile.am  |  1 +
 .../arch/x86/include/asm/xenomai/debug.h      | 18 +++++
 .../arch/x86/include/asm/xenomai/syscall.h    | 71 ++-----------------
 lib/cobalt/sigshadow.c                        | 12 ++--
 testsuite/smokey/sched-quota/sched-quota.c    |  2 +
 testsuite/switchtest/switchtest.c             |  2 +-
 16 files changed, 113 insertions(+), 85 deletions(-)
 create mode 100644 lib/cobalt/arch/arm/include/asm/xenomai/debug.h
 create mode 100644 lib/cobalt/arch/arm64/include/asm/xenomai/debug.h
 create mode 100644 lib/cobalt/arch/x86/include/asm/xenomai/debug.h

-- 
2.51.0

