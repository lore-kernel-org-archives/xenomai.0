Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6F36C9EE
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221991; cv=none; b=o3gpvbfq7cfXGKl2HPitXXJcpwT0AqSa94535qbgwsu+5FDvcY3GHUTeOPCnDKCaKxzInplo167VEKQPyj4j+SmGhH8lvbcvMXxmm3t0mnhdHOrhsQNscLYJ4Rsv11EQwuJso11a+BgsCMw6RQc7H2E8M62GXI0lNuX8ySXpwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221991; c=relaxed/simple;
	bh=7+ldLOrlyAE+2nA0XcT8Y9S/SuU/GwbZl6UESH6ZY6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OB1TTF+CfODsp5sUD919BZAGoyzfW/OsRg7AZPpJJbnYA28mE/fBCRMWoyPaNDFMtdNNNHi329iSrUxwHlgMcYyRU4mNBb46L720AdnqVmNRAturV65pySRY0r1jNi88t0Ut5saBqigdS3xsqEHxJN8Hge57Wk5mN81U7OdFVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=K9Xhv8cE; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="K9Xhv8cE"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260508062248ef4afdf92d0002076c
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/Hs51/Y5e+L5kIc0UN5qFt4eioRL0n6cixDr69zIaWE=;
 b=K9Xhv8cECNH2XgiGE2Vp7CxqeF8t48qx3Mb/Sl/bda+nM0odqNRx4WZRoRFxABylZlNrDk
 w+ZFE4rFdNNrXU2aATWlBCHkscM9veuHpLLIXgzIXo0D3Qep90+nc2xAlC4RrpLEmGAF7FH9
 tZ9J6PVEXQvdWq3+pfok9RnY5fqtPAY6rYxqOt9LVJuqC3oWfpjEuuPpURNJmuIsGwrn2sny
 +0DYONrQXO/jQdTnofrYpddkSDmu1Jjed70D5Zb4f4KyG0ijMvNUMC1OZ/VuVYHDgz8w8FU7
 PIg4XLbDm3VGKSRE2YHU9dWjbN6YL2WogvZSbJMKdKb02+dLZvykmcoQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/32] lib: Finish rearrangement of includes and license
 headers
Date: Fri, 08 May 2026 08:22:33 +0200
Message-Id: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqB/WkC/x2MWwqAIBAArxL73YJJSnWV6MNsrYXQ0F4Q3T3pc
 2BmHkgUmRJ0xQORTk4cfIaqLMAuxs+EPGUGKaQWtWzw4g3dGjCSM3YPEdnb9ZgoYatq5YSTRjc
 j5H7LCt//ux/e9wOCECb3awAAAA==
X-Change-ID: 20260428-wip-flo-refactor-includes-9545f0f2a68b
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

This is the missing cleanup of demo/, lib/, testuite/ and utils/ that
was partially handled already in the past as preparation commits for
bugfixes or build optimizations. I finally found some time to finish
that work for the missing folders.

There might be even more potential for cleanups inside the include/
directory - and as a result once again inside the already cleaned
directories. I skipped that for now, as I consider include/ as an API.
Changes might force users to adapt/recompile.

Tested against Dovetail 7.0 already.

Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (32):
      lib/alchemy: Rearrange includes and harmonize license headers
      lib/analogy: Rearrange includes and harmonize license headers
      lib/boilerplate: Rearrange includes and harmonize license headers
      lib/cobalt: Rearrange includes and harmonize license headers
      lib/psos: Rearrange includes and harmonize license headers
      lib/vxworks: Rearrange includes and harmonize license headers
      lib/copperplate: Rearrange includes and harmonize license headers
      lib/smokey: Rearrange includes and harmonize license headers
      lib/smokey: Move do_fork macro to its single user
      lib/trank: Rearrange includes and harmonize license headers
      testsuite/clocktest: Rearrange includes
      testsuite/gpiobench: Rearrange includes
      testsuite/gpiotest: Rearrange includes
      testsuite/latency: Rearrange includes
      testsuite/smokey/arith: Rearrange includes
      testsuite/smokey/alchemytests: Rearrange includes
      testsuite/smokey/dlopen: Rearrange includes
      testsuite/smokey/net_common: Rearrange includes
      testsuite/smokey/psostests: Rearrange includes
      testsuite/smokey/vxworkstests: Rearrange includes
      testsuite/smokey: Rearrange includes
      testsuite/spitest: Rearrange includes
      testsuite/switchtest: Rearrange includes
      testsuite/xeno-test: Rearrange includes
      demo/alchemy: Rearrange includes
      demo/posix/cobalt: Rearrange includes
      demo/posix/cyclictest: Rearrange includes
      utils/analogy: Rearrange includes
      utils/can: Rearrange includes
      utils/net: Rearrange includes
      utils: Rearrange includes
      clang-format: Enable sorting of includes

 .clang-format                                      |  2 +-
 demo/alchemy/altency.c                             | 15 ++----
 demo/alchemy/cobalt/cross-link.c                   |  3 --
 demo/posix/cobalt/bufp-label.c                     | 11 ++---
 demo/posix/cobalt/bufp-readwrite.c                 | 11 ++---
 demo/posix/cobalt/can-rtt.c                        | 13 ++----
 demo/posix/cobalt/eth_p_all.c                      | 19 ++++----
 demo/posix/cobalt/gpiopwm.c                        | 22 ++++-----
 demo/posix/cobalt/iddp-label.c                     | 11 ++---
 demo/posix/cobalt/iddp-sendrecv.c                  | 11 ++---
 demo/posix/cobalt/xddp-echo.c                      | 13 ++----
 demo/posix/cobalt/xddp-label.c                     | 15 ++----
 demo/posix/cobalt/xddp-stream.c                    | 14 ++----
 demo/posix/cyclictest/cyclictest.c                 | 32 +++++--------
 demo/posix/cyclictest/error.c                      |  4 ++
 demo/posix/cyclictest/error.h                      |  4 +-
 demo/posix/cyclictest/rt-utils.h                   |  2 +-
 demo/posix/cyclictest/rt_numa.h                    |  3 +-
 include/smokey/smokey.h                            |  6 ---
 lib/alchemy/Makefile.am                            |  3 +-
 lib/alchemy/alarm.c                                | 14 +++---
 lib/alchemy/alarm.h                                |  5 +-
 lib/alchemy/buffer.c                               | 15 +++---
 lib/alchemy/buffer.h                               |  6 +--
 lib/alchemy/cond.c                                 | 12 ++---
 lib/alchemy/cond.h                                 |  5 +-
 lib/alchemy/event.c                                | 17 ++++---
 lib/alchemy/event.h                                |  6 +--
 lib/alchemy/heap.c                                 | 14 +++---
 lib/alchemy/heap.h                                 |  7 ++-
 lib/alchemy/init.c                                 | 25 +++++-----
 lib/alchemy/internal.c                             |  8 ++--
 lib/alchemy/internal.h                             |  7 ++-
 lib/alchemy/mutex.c                                |  8 ++--
 lib/alchemy/mutex.h                                |  5 +-
 lib/alchemy/pipe.c                                 | 16 +++----
 lib/alchemy/pipe.h                                 |  3 +-
 lib/alchemy/queue.c                                | 14 +++---
 lib/alchemy/queue.h                                |  7 +--
 lib/alchemy/reference.h                            |  2 +-
 lib/alchemy/sem.c                                  | 15 +++---
 lib/alchemy/sem.h                                  |  7 ++-
 lib/alchemy/task.c                                 | 17 +++----
 lib/alchemy/task.h                                 | 14 +++---
 lib/alchemy/timer.c                                |  4 +-
 lib/alchemy/timer.h                                | 25 ----------
 lib/analogy/async.c                                |  6 +--
 lib/analogy/calibration.c                          | 18 ++++----
 lib/analogy/calibration.h                          |  4 +-
 lib/analogy/descriptor.c                           |  7 +--
 lib/analogy/info.c                                 |  6 +--
 lib/analogy/internal.h                             |  3 +-
 lib/analogy/math.c                                 | 10 ++--
 lib/analogy/range.c                                |  4 +-
 lib/analogy/root_leaf.h                            |  4 +-
 lib/analogy/sync.c                                 |  7 ++-
 lib/analogy/sys.c                                  |  5 +-
 lib/boilerplate/ancillaries.c                      | 30 +++++-------
 lib/boilerplate/debug.c                            | 12 ++---
 lib/boilerplate/hash.c                             |  5 +-
 lib/boilerplate/heapmem.c                          |  9 +---
 lib/boilerplate/iniparser/dictionary.c             |  2 -
 lib/boilerplate/iniparser/dictionary.h             |  2 -
 lib/boilerplate/iniparser/iniparser.c              |  5 +-
 lib/boilerplate/iniparser/iniparser.h              |  4 --
 lib/boilerplate/init/bootstrap.c                   |  7 ++-
 lib/boilerplate/obstack.c                          |  9 +---
 lib/boilerplate/setup.c                            | 19 ++------
 lib/boilerplate/time.c                             |  2 +-
 lib/boilerplate/tlsf/target.h                      |  3 +-
 lib/boilerplate/tlsf/tlsf.h                        |  2 -
 lib/boilerplate/version.c                          |  9 ++--
 lib/cobalt/arch/arm/features.c                     |  5 +-
 lib/cobalt/arch/arm/include/asm/xenomai/debug.h    |  3 +-
 lib/cobalt/arch/arm/include/asm/xenomai/features.h |  1 +
 lib/cobalt/arch/arm/include/asm/xenomai/syscall.h  |  5 +-
 lib/cobalt/arch/arm64/features.c                   |  5 +-
 .../arch/arm64/include/asm/xenomai/features.h      |  1 +
 .../arch/arm64/include/asm/xenomai/syscall.h       |  4 +-
 lib/cobalt/arch/x86/features.c                     | 13 +++---
 lib/cobalt/arch/x86/include/asm/xenomai/features.h |  1 -
 lib/cobalt/attr.c                                  |  4 +-
 lib/cobalt/clock.c                                 |  7 +--
 lib/cobalt/cond.c                                  |  7 +--
 lib/cobalt/cond.h                                  |  3 +-
 lib/cobalt/current.c                               | 10 ++--
 lib/cobalt/current.h                               |  4 +-
 lib/cobalt/init.c                                  | 24 ++++------
 lib/cobalt/internal.c                              | 16 ++-----
 lib/cobalt/internal.h                              |  8 ++--
 lib/cobalt/malloc-nowrap.c                         |  2 +-
 lib/cobalt/malloc.c                                |  4 +-
 lib/cobalt/mmap.c                                  |  7 ++-
 lib/cobalt/mq.c                                    |  8 +---
 lib/cobalt/mutex.c                                 |  5 +-
 lib/cobalt/mutex.h                                 |  5 +-
 lib/cobalt/parse_vdso.c                            | 12 ++---
 lib/cobalt/printf.c                                | 17 ++-----
 lib/cobalt/rtdm.c                                  |  8 +---
 lib/cobalt/sched.c                                 |  9 ++--
 lib/cobalt/semaphore.c                             | 10 ++--
 lib/cobalt/signal.c                                |  5 +-
 lib/cobalt/sigshadow.c                             |  7 ++-
 lib/cobalt/thread.c                                |  5 +-
 lib/cobalt/ticks.c                                 |  8 ++--
 lib/cobalt/timer.c                                 |  4 +-
 lib/cobalt/timerfd.c                               |  5 +-
 lib/cobalt/trace.c                                 |  9 ++--
 lib/cobalt/umm.c                                   | 18 +++-----
 lib/cobalt/umm.h                                   |  2 +-
 lib/cobalt/wrappers.c                              | 25 ++++------
 lib/cobalt/wrappers_time64.c                       |  8 ----
 lib/copperplate/clockobj.c                         | 15 ++----
 lib/copperplate/cluster.c                          |  5 +-
 lib/copperplate/eventobj.c                         |  6 +--
 lib/copperplate/heapobj-heapmem.c                  |  5 +-
 lib/copperplate/heapobj-malloc.c                   | 15 +++---
 lib/copperplate/heapobj-pshared.c                  | 38 ++++++++--------
 lib/copperplate/heapobj-tlsf.c                     | 15 +++---
 lib/copperplate/init.c                             | 24 +++++-----
 lib/copperplate/internal.c                         | 19 ++------
 lib/copperplate/internal.h                         | 12 +----
 lib/copperplate/reference.c                        | 10 ++--
 lib/copperplate/regd/fs-cobalt.c                   | 13 +++---
 lib/copperplate/regd/fs-common.c                   | 21 ++++-----
 lib/copperplate/regd/fs-mercury.c                  | 16 +++----
 lib/copperplate/regd/regd.c                        | 36 +++++++--------
 lib/copperplate/registry.c                         | 53 +++++++++++-----------
 lib/copperplate/semobj.c                           |  8 +---
 lib/copperplate/syncobj.c                          |  7 +--
 lib/copperplate/threadobj.c                        | 26 +++--------
 lib/copperplate/timerobj.c                         | 17 ++-----
 lib/copperplate/traceobj.c                         |  6 +--
 lib/psos/init.c                                    | 22 ++++-----
 lib/psos/internal.h                                |  3 +-
 lib/psos/pt.c                                      | 11 ++---
 lib/psos/pt.h                                      |  5 +-
 lib/psos/queue.c                                   | 14 ++----
 lib/psos/queue.h                                   |  5 +-
 lib/psos/reference.h                               |  2 +-
 lib/psos/rn.c                                      | 13 +++---
 lib/psos/rn.h                                      |  7 ++-
 lib/psos/sem.c                                     | 18 +++-----
 lib/psos/sem.h                                     |  5 +-
 lib/psos/task.c                                    | 20 +++-----
 lib/psos/task.h                                    |  7 ++-
 lib/psos/tm.c                                      |  9 ++--
 lib/psos/tm.h                                      |  3 --
 lib/smokey/helpers.c                               | 22 +++++----
 lib/smokey/init.c                                  | 19 +++-----
 lib/trank/init.c                                   |  5 +-
 lib/trank/internal.c                               | 12 ++---
 lib/trank/internal.h                               |  8 ++--
 lib/trank/native.c                                 | 12 +++--
 lib/trank/posix.c                                  | 16 +++----
 lib/vxworks/errnoLib.c                             |  8 ++--
 lib/vxworks/init.c                                 | 13 ++----
 lib/vxworks/intLib.c                               |  2 +-
 lib/vxworks/kernLib.c                              |  8 ++--
 lib/vxworks/lstLib.c                               |  2 +-
 lib/vxworks/memPartLib.c                           | 13 ++----
 lib/vxworks/memPartLib.h                           |  2 +-
 lib/vxworks/msgQLib.c                              | 16 ++-----
 lib/vxworks/msgQLib.h                              |  4 +-
 lib/vxworks/reference.h                            |  2 +-
 lib/vxworks/rngLib.c                               | 41 ++++++++---------
 lib/vxworks/rngLib.h                               |  4 +-
 lib/vxworks/semLib.c                               | 15 ++----
 lib/vxworks/semLib.h                               |  3 +-
 lib/vxworks/sysLib.c                               |  6 +--
 lib/vxworks/taskHookLib.c                          |  9 ++--
 lib/vxworks/taskHookLib.h                          |  3 +-
 lib/vxworks/taskInfo.c                             |  9 ++--
 lib/vxworks/taskLib.c                              | 19 +++-----
 lib/vxworks/taskLib.h                              |  6 +--
 lib/vxworks/tickLib.c                              |  7 ++-
 lib/vxworks/tickLib.h                              |  2 +-
 lib/vxworks/wdLib.c                                | 11 ++---
 lib/vxworks/wdLib.h                                |  3 +-
 testsuite/clocktest/clocktest.c                    | 17 +++----
 testsuite/gpiobench/gpiobench.c                    | 17 +++----
 testsuite/gpiotest/gpiotest.c                      |  8 +---
 testsuite/latency/latency.c                        | 22 ++++-----
 testsuite/smokey/alchemytests/alarm-1.c            |  6 +--
 testsuite/smokey/alchemytests/alchemytests.c       |  4 +-
 testsuite/smokey/alchemytests/buffer-1.c           |  7 +--
 testsuite/smokey/alchemytests/event-1.c            |  6 +--
 testsuite/smokey/alchemytests/heap-1.c             |  7 +--
 testsuite/smokey/alchemytests/heap-2.c             |  6 +--
 testsuite/smokey/alchemytests/mq-1.c               |  6 +--
 testsuite/smokey/alchemytests/mq-2.c               |  6 +--
 testsuite/smokey/alchemytests/mq-3.c               |  6 +--
 testsuite/smokey/alchemytests/mutex-1.c            |  5 +-
 testsuite/smokey/alchemytests/mutex-2.c            |  5 +-
 testsuite/smokey/alchemytests/pipe-1.c             | 11 ++---
 testsuite/smokey/alchemytests/sem-1.c              |  6 +--
 testsuite/smokey/alchemytests/sem-2.c              |  6 +--
 testsuite/smokey/alchemytests/task-1.c             |  4 +-
 testsuite/smokey/alchemytests/task-10.c            |  6 +--
 testsuite/smokey/alchemytests/task-11.c            |  2 -
 testsuite/smokey/alchemytests/task-2.c             |  6 +--
 testsuite/smokey/alchemytests/task-3.c             |  4 +-
 testsuite/smokey/alchemytests/task-4.c             |  6 +--
 testsuite/smokey/alchemytests/task-5.c             |  6 +--
 testsuite/smokey/alchemytests/task-6.c             |  4 +-
 testsuite/smokey/alchemytests/task-7.c             |  4 +-
 testsuite/smokey/alchemytests/task-8.c             |  6 +--
 testsuite/smokey/alchemytests/task-9.c             |  5 +-
 testsuite/smokey/arith/arith-noinline.c            |  3 +-
 testsuite/smokey/arith/arith.c                     |  6 +--
 testsuite/smokey/bufp/bufp.c                       |  9 +---
 testsuite/smokey/can/can.c                         |  8 +---
 testsuite/smokey/cpu-affinity/cpu-affinity.c       |  4 --
 testsuite/smokey/dlopen/dlopen.c                   |  1 -
 testsuite/smokey/dlopen/dlopentest.c               |  4 +-
 testsuite/smokey/dlopen/libalchemy-test.c          |  3 --
 testsuite/smokey/fpu-stress/fpu-stress.c           |  4 +-
 testsuite/smokey/gdb/gdb.c                         | 15 +++---
 testsuite/smokey/iddp/iddp.c                       |  9 +---
 testsuite/smokey/leaks/leaks.c                     | 21 +++------
 testsuite/smokey/main.c                            |  3 --
 testsuite/smokey/memcheck/memcheck.c               |  8 +---
 testsuite/smokey/memory-coreheap/coreheap.c        |  9 ++--
 testsuite/smokey/memory-heapmem/heapmem.c          |  3 +-
 testsuite/smokey/memory-pshared/pshared.c          |  5 +-
 testsuite/smokey/memory-tlsf/tlsf.c                |  6 +--
 testsuite/smokey/net_common/client.c               |  9 ----
 testsuite/smokey/net_common/server.c               | 17 +------
 testsuite/smokey/net_common/setup.c                | 23 +++-------
 testsuite/smokey/net_common/smokey_net_server.c    | 21 ++++-----
 testsuite/smokey/net_packet_dgram/packet_dgram.c   |  7 ---
 testsuite/smokey/net_packet_raw/packet_raw.c       |  9 +---
 testsuite/smokey/net_udp/udp.c                     |  4 --
 testsuite/smokey/posix-clock/posix-clock.c         |  6 +--
 testsuite/smokey/posix-cond/posix-cond.c           |  9 +---
 testsuite/smokey/posix-fork/posix-fork.c           |  1 -
 testsuite/smokey/posix-mutex/posix-mutex.c         | 10 +---
 testsuite/smokey/posix-select/posix-select.c       | 12 ++---
 testsuite/smokey/psostests/mq-1.c                  |  4 +-
 testsuite/smokey/psostests/mq-2.c                  |  4 +-
 testsuite/smokey/psostests/mq-3.c                  |  6 +--
 testsuite/smokey/psostests/psostests.c             |  1 -
 testsuite/smokey/psostests/pt-1.c                  |  5 +-
 testsuite/smokey/psostests/rn-1.c                  |  5 +-
 testsuite/smokey/psostests/sem-1.c                 |  4 +-
 testsuite/smokey/psostests/sem-2.c                 |  4 +-
 testsuite/smokey/psostests/task-1.c                |  4 +-
 testsuite/smokey/psostests/task-2.c                |  4 +-
 testsuite/smokey/psostests/task-3.c                |  4 +-
 testsuite/smokey/psostests/task-4.c                |  4 +-
 testsuite/smokey/psostests/task-5.c                |  4 +-
 testsuite/smokey/psostests/task-6.c                |  4 +-
 testsuite/smokey/psostests/task-7.c                |  4 +-
 testsuite/smokey/psostests/task-8.c                |  6 +--
 testsuite/smokey/psostests/task-9.c                |  4 +-
 testsuite/smokey/psostests/tm-1.c                  |  4 +-
 testsuite/smokey/psostests/tm-2.c                  |  4 +-
 testsuite/smokey/psostests/tm-3.c                  |  4 +-
 testsuite/smokey/psostests/tm-4.c                  |  4 +-
 testsuite/smokey/psostests/tm-5.c                  |  4 +-
 testsuite/smokey/psostests/tm-6.c                  |  4 +-
 testsuite/smokey/psostests/tm-7.c                  |  4 +-
 testsuite/smokey/rtdm/rtdm.c                       |  7 +--
 testsuite/smokey/sched-quota/sched-quota.c         | 15 ++----
 testsuite/smokey/sched-tp/sched-tp.c               | 12 ++---
 testsuite/smokey/setsched/setsched.c               |  9 ++--
 testsuite/smokey/sigdebug/sigdebug.c               | 15 ++----
 testsuite/smokey/timerfd/timerfd.c                 |  8 ++--
 testsuite/smokey/tsc/tsc.c                         |  7 +--
 testsuite/smokey/vxworkstests/lst-1.c              |  4 +-
 testsuite/smokey/vxworkstests/msgQ-1.c             |  4 +-
 testsuite/smokey/vxworkstests/msgQ-2.c             |  4 +-
 testsuite/smokey/vxworkstests/msgQ-3.c             |  4 +-
 testsuite/smokey/vxworkstests/rng-1.c              |  5 +-
 testsuite/smokey/vxworkstests/sem-1.c              |  6 +--
 testsuite/smokey/vxworkstests/sem-2.c              |  6 +--
 testsuite/smokey/vxworkstests/sem-3.c              |  4 +-
 testsuite/smokey/vxworkstests/sem-4.c              |  4 +-
 testsuite/smokey/vxworkstests/task-1.c             |  4 +-
 testsuite/smokey/vxworkstests/task-2.c             |  5 +-
 testsuite/smokey/vxworkstests/vxworkstests.c       |  1 -
 testsuite/smokey/vxworkstests/wd-1.c               |  6 +--
 testsuite/smokey/x86io/x86io.c                     |  5 +-
 testsuite/smokey/xddp/xddp.c                       | 10 +---
 testsuite/smokey/y2038/syscall-tests.c             |  4 +-
 testsuite/spitest/spitest.c                        | 14 ++----
 testsuite/switchtest/switchtest.c                  | 24 ++++------
 testsuite/xeno-test/xeno-test-run.c                | 12 ++---
 utils/analogy/analogy_calibrate.c                  |  7 ++-
 utils/analogy/analogy_calibrate.h                  |  8 ++--
 utils/analogy/analogy_config.c                     |  9 ++--
 utils/analogy/calibration_ni_m.c                   |  8 ++--
 utils/analogy/cmd_bits.c                           |  8 ++--
 utils/analogy/cmd_read.c                           | 13 +++---
 utils/analogy/cmd_write.c                          |  8 ++--
 utils/analogy/insn_bits.c                          |  6 +--
 utils/analogy/insn_read.c                          |  8 ++--
 utils/analogy/insn_write.c                         |  6 +--
 utils/analogy/wf_facilities.c                      |  6 +--
 utils/analogy/wf_facilities.h                      |  3 +-
 utils/analogy/wf_generate.c                        | 10 ++--
 utils/autotune/autotune.c                          | 17 +++----
 utils/can/rtcanconfig.c                            | 14 ++----
 utils/can/rtcanrecv.c                              |  9 +---
 utils/can/rtcansend.c                              | 13 ++----
 utils/chkkconf/checkconfig.c                       | 12 ++---
 utils/corectl/corectl.c                            | 11 ++---
 utils/hdb/hdb.c                                    | 16 +++----
 utils/net/nomaccfg.c                               |  8 ++--
 utils/net/rtcfg.c                                  | 17 +++----
 utils/net/rtifconfig.c                             | 17 +++----
 utils/net/rtiwconfig.c                             | 12 ++---
 utils/net/rtping.c                                 | 16 +++----
 utils/net/rtroute.c                                | 13 ++----
 utils/net/tdmacfg.c                                |  9 ++--
 utils/ps/rtps.c                                    |  7 +--
 utils/slackspot/slackspot.c                        | 19 ++++----
 317 files changed, 1081 insertions(+), 1783 deletions(-)
---
base-commit: ede726f005659977035c6520e9ed77312d472a09
change-id: 20260428-wip-flo-refactor-includes-9545f0f2a68b

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

