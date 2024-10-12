Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C89154426
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728816; cv=none; b=hh50w6p68QWOgsNfs8BGPqijZn0pg7uB9gQvSqdSlhn5j8ILRKjGM1GoYtLKlTyfO5AJkRqLoV95+pmt/28xjVg6XGdYoJ/PLe2IccqGtn/eESFpOnoUF4V6hNpZszrknqVlXSwlrKz74lCYZNQySDz4shpGD8ZqUrC/FRMrLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728816; c=relaxed/simple;
	bh=Vu422P87xzhavD8D2zyGs9WHFIpcK+ph7X68jpr5GoU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aBazURic/fjTUQeIyKa3ayLZblKfdNyQKVt5bijSawjUUATimUfxF4qNzLT1ICCQu2vxZgaYipxjXvaW5txfJQRf3F7cEddmFjPunEoksI/NfhJjfNIL1nGz76RDSGl93wRDcoWVOr0YDRD6RexTIxpR4JntGkSLxLEbaEDklK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UvR2rRcS; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UvR2rRcS"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202410121026425cedcaa679dffa446e
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 12:26:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SdnoXBYWWJ5cDbbXBpqpFgzTrW2KC8lMtEWllyYH3og=;
 b=UvR2rRcSaMysOO6PMdBL0wWHYzjRaAagIEU0XPdarZAvMdbxHw61EJ9wenV8f4vAyYlZI9
 SaN+QZWbixNsSqgpdq3/y/GQrQgjrPuQIb1/KeLPedFStBuG9j98V/9YsBkqBoKimRb91EDk
 uHqD/W908Gly/xl/f8lt+qn//jBubAuN9nSb1nyEJrm60yi1s0MCJCcU79t4Uae5M4saseOS
 fkxEXm5LJ6F42l6UrxE0wsn39c6ax9TvWP66DmC7oXbrh5vYsAxtxO2e532Lx0QNSZQG1310
 9JS5a3zOK5G9/usE6xPgwcxAj2pzoG3KTYXNT+zsyc5pppxpmDV5aCpA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/7] Dumping my refactoring cleanup queue before the
 upcoming release
Date: Sat, 12 Oct 2024 12:26:39 +0200
Message-Id: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9OCmcC/x2NywrCMBAAf6Xs2YVNELT+injIY2MDYVM2VAql/
 +7qceYwc8BgrTzgMR2g/KmjdjFwlwnSEuTNWLMxePJXR85jaR1T4yDbipFLV0Zl48EYZspzLnT
 PdAMLxJ+MGiQtlpCtNZOrcqn7//h8necXekCYJoEAAAA=
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

this is a summary of cleanups waiting in different feature branches. I
thought it might make sense to dump that to the list to see if there is
interest to get that into the upcoming release.

The header cleanups are just housekeeping. Helping to speed up the build
a bit. More or less drive-by fixes.

The second part of the series might need some more testing / discussion.
This is a cleanup that is now possible after the armv8 compat
implementation done by Clara. All architecutres are now following the
Linux syscall ABI, so that we can clean up a lot of our own SYSCALL_
stuff and switch to syscall() provided by libc.

The next step, definitely out of scope for this release, is moving on to
a prctl() based infrastructure. I have that ready already, but that is
future work.

As the cleanup got possible during 3.3 development I thought it might
make sense to include the cleanup as well. Might help to make
backporting of fixes easier.

Let's see, happy reviewing.

Best regards,
Florian

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (7):
      testsuite/smokey: Cleanup of unused includes
      testsuite: Cleanup of unused includes
      libcobalt: arm: Cleanup unused includes
      libcobalt: arm64: Cleanup unused includes
      cobalt: sycall API: Remove architecture specific implementations
      cobalt: sycall API: Reformat all XENOMAI_SYSCALLx call sites
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
 lib/cobalt/arch/arm/features.c                     |  17 +-
 .../arch/arm/include/asm/xenomai/Makefile.am       |   3 +-
 lib/cobalt/arch/arm/include/asm/xenomai/syscall.h  | 122 ------------
 lib/cobalt/arch/arm64/features.c                   |  17 +-
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
 testsuite/clocktest/clocktest.c                    |   2 +-
 testsuite/gpiobench/gpiobench.c                    |   8 +-
 testsuite/gpiotest/gpiotest.c                      |   2 +-
 testsuite/latency/latency.c                        |   1 +
 testsuite/smokey/alchemytests/sem-2.c              |   1 +
 testsuite/smokey/alchemytests/task-11.c            |   1 -
 testsuite/smokey/arith/arith-noinline.c            |   2 -
 testsuite/smokey/bufp/bufp.c                       |   2 +-
 testsuite/smokey/cpu-affinity/cpu-affinity.c       |   3 +-
 testsuite/smokey/dlopen/dlopen.c                   |   6 +-
 testsuite/smokey/dlopen/dlopentest.c               |   3 +-
 testsuite/smokey/dlopen/libalchemy-test.c          |   3 +-
 testsuite/smokey/dlopen/libposix-test.c            |   2 +-
 testsuite/smokey/gdb/gdb.c                         |   2 +-
 testsuite/smokey/iddp/iddp.c                       |   2 +-
 testsuite/smokey/leaks/leaks.c                     |   4 +-
 testsuite/smokey/main.c                            |   3 +-
 testsuite/smokey/memcheck/memcheck.c               |   2 +-
 testsuite/smokey/memory-coreheap/coreheap.c        |   1 +
 testsuite/smokey/memory-heapmem/heapmem.c          |   1 +
 testsuite/smokey/memory-pshared/pshared.c          |   1 +
 testsuite/smokey/memory-tlsf/tlsf.c                |   1 +
 testsuite/smokey/net_common/server.c               |   4 -
 testsuite/smokey/net_common/smokey_net_server.c    |   3 -
 testsuite/smokey/net_packet_dgram/packet_dgram.c   |   3 -
 testsuite/smokey/net_packet_raw/packet_raw.c       |   1 -
 testsuite/smokey/posix-clock/posix-clock.c         |   4 +-
 testsuite/smokey/posix-cond/posix-cond.c           |   4 +-
 testsuite/smokey/posix-fork/posix-fork.c           |   4 +-
 testsuite/smokey/posix-mutex/posix-mutex.c         |   3 +-
 testsuite/smokey/posix-select/posix-select.c       |   5 +-
 testsuite/smokey/psostests/pt-1.c                  |   1 -
 testsuite/smokey/psostests/rn-1.c                  |   1 -
 testsuite/smokey/rtdm/rtdm.c                       |   1 +
 testsuite/smokey/sched-quota/sched-quota.c         |   3 +-
 testsuite/smokey/sched-tp/sched-tp.c               |   6 +-
 testsuite/smokey/setsched/setsched.c               |   2 +-
 testsuite/smokey/sigdebug/Makefile.am              |   2 +-
 testsuite/smokey/timerfd/timerfd.c                 |   2 +-
 testsuite/smokey/tsc/tsc.c                         |   5 -
 testsuite/smokey/vxworkstests/lst-1.c              |   1 -
 testsuite/smokey/vxworkstests/msgQ-1.c             |   1 -
 testsuite/smokey/vxworkstests/msgQ-2.c             |   1 -
 testsuite/smokey/vxworkstests/msgQ-3.c             |   1 -
 testsuite/smokey/vxworkstests/rng-1.c              |   2 -
 testsuite/smokey/vxworkstests/sem-1.c              |   1 -
 testsuite/smokey/vxworkstests/sem-2.c              |   1 -
 testsuite/smokey/vxworkstests/sem-3.c              |   1 -
 testsuite/smokey/vxworkstests/task-1.c             |   1 -
 testsuite/smokey/vxworkstests/task-2.c             |   2 -
 testsuite/smokey/vxworkstests/wd-1.c               |   1 -
 testsuite/smokey/x86io/x86io.c                     |   2 +-
 testsuite/smokey/xddp/xddp.c                       |   2 +-
 testsuite/smokey/y2038/syscall-tests.c             |   7 +-
 testsuite/spitest/spitest.c                        |   3 +-
 testsuite/switchtest/switchtest.c                  |   3 +-
 98 files changed, 321 insertions(+), 944 deletions(-)
---
base-commit: db203dc68964235b1c6b549bfaa2c3b88f736814
change-id: 20241012-flo-cleanup-before-release-a90d9df08d07

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

