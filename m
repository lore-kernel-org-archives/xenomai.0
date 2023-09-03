Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A32F52
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:07 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230903150458e713864a0cbbc1a97e
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:04:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=YMbC9peSjk+HNRAGUDo3SGzyfYo3UwzLfSIogZ5zTuc=;
 b=GZs2Z7asDJK9lHyIhjaMTJWWt5xF+0PgXVil8Doi1rlVFmTPOccZSPOlbOoYSrXn3nQE56
 jmKFYoGCEbLDvdKw+wfkauM1jMvb1QXRwQR1RM46SOLUiFtNNelkw2lKjzDTQKLh9JeULwdn
 ztV2rNfL9NYVbj21sAMbICjo+VHvs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 00/20] I-pipe house cleaning
Date: Sun,  3 Sep 2023 17:04:37 +0200
Message-Id: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Initially, I just ran into the "Revisit: I-pipe requirement" comment on
the lostage_signal self field. But then I did a systematic search for
i[-]pipe and found way more. This is the result which should only make
things (minimally) faster and otherwise simply remove now dead code.

Jan

Jan Kiszka (20):
  cobalt: Drop self element from lostage_signal
  drivers/udd: Drop self element from irqswitch_work
  cobalt: Drop not longer supported CONFIG_XENO_OPT_STATS_IRQS
  testsuite/smokey/y2038: Activate minimal clock_settime64
  testsuite/clocktest: Drop obsolete CLOCK_HOST_REALTIME and wallclock
    offset bits
  testsuite/smokey: Remove VDSO test
  lib/cobalt: Drop legacy_tsc code for I-pipe
  lib/cobalt: Drop tsc.h
  cobalt/uapi: Drop tsc.h
  lib/cobalt: Drop VDSO support
  kernel/cobalt: Remove archcall syscall stub
  kernel/cobalt: Retire clock_freq field in cobalt_featinfo
  kernel/cobalt: Remove VDSO support
  testsuite/smokey/rtdm: Remove dead code
  lib/cobalt: Refactor cobalt_read_tsc API to cobalt_read_ns
  lib/copperplate: Refactor clockobj_get_tsc API to clockobj_get_ns
  scripts/Kconfig.frag: Switch to I-pipe only
  include/cobalt: Fix inclusion guard names
  ci: Update comment
  cobalt/posix: Update comment

 .gitlab-ci.yml                                |   2 +-
 configure.ac                                  |   1 -
 include/cobalt/kernel/Makefile.am             |   1 -
 .../kernel/dovetail/pipeline/pipeline.h       |   5 -
 .../cobalt/kernel/dovetail/pipeline/tick.h    |   6 +-
 include/cobalt/kernel/intr.h                  |  30 -----
 include/cobalt/kernel/thread.h                |   1 -
 include/cobalt/kernel/vdso.h                  |  49 -------
 include/cobalt/sys/cobalt.h                   |   3 +-
 include/cobalt/ticks.h                        |  49 -------
 include/cobalt/uapi/asm-generic/features.h    |   8 +-
 include/cobalt/uapi/kernel/Makefile.am        |   4 +-
 include/cobalt/uapi/kernel/urw.h              | 113 ----------------
 include/cobalt/uapi/kernel/vdso.h             |  66 ----------
 include/cobalt/uapi/syscall.h                 |   2 +-
 include/copperplate/clockobj.h                |  35 +----
 kernel/cobalt/Kconfig                         |  12 --
 .../arch/arm/include/asm/xenomai/syscall.h    |   9 --
 .../arm/include/asm/xenomai/uapi/features.h   |   1 -
 .../arch/arm/include/asm/xenomai/uapi/tsc.h   |  25 ----
 .../arch/arm64/include/asm/xenomai/syscall.h  |   9 --
 .../arm64/include/asm/xenomai/uapi/features.h |   2 -
 .../arch/arm64/include/asm/xenomai/uapi/tsc.h |  25 ----
 .../arch/x86/include/asm/xenomai/syscall.h    |   8 --
 .../x86/include/asm/xenomai/uapi/features.h   |   1 -
 kernel/cobalt/clock.c                         |   2 -
 kernel/cobalt/dovetail/kevents.c              |   1 -
 kernel/cobalt/init.c                          |   1 -
 kernel/cobalt/posix/memory.c                  |  21 ---
 kernel/cobalt/posix/process.c                 |   5 +-
 kernel/cobalt/posix/syscall.c                 |  12 --
 kernel/cobalt/sched.c                         |  51 +------
 kernel/cobalt/thread.c                        |   6 -
 kernel/cobalt/trace/cobalt-posix.h            |   1 -
 kernel/drivers/udd/udd.c                      |   4 +-
 lib/cobalt/arch/arm/features.c                |  46 -------
 .../arch/arm/include/asm/xenomai/Makefile.am  |   3 +-
 lib/cobalt/arch/arm/include/asm/xenomai/tsc.h |  48 -------
 lib/cobalt/arch/arm64/features.c              |  42 ------
 .../arm64/include/asm/xenomai/Makefile.am     |   3 +-
 .../arch/arm64/include/asm/xenomai/tsc.h      |  54 --------
 .../arch/x86/include/asm/xenomai/Makefile.am  |   3 +-
 lib/cobalt/arch/x86/include/asm/xenomai/tsc.h |  38 ------
 lib/cobalt/clock.c                            | 124 +++---------------
 lib/cobalt/init.c                             |   4 +-
 lib/cobalt/internal.c                         |   6 +-
 lib/cobalt/internal.h                         |   2 +-
 lib/cobalt/ticks.c                            |  70 +---------
 lib/cobalt/umm.c                              |  14 +-
 lib/cobalt/umm.h                              |   6 +-
 lib/copperplate/clockobj.c                    |   8 +-
 lib/copperplate/threadobj.c                   |   4 +-
 lib/psos/tm.c                                 |   2 +-
 scripts/Kconfig.frag                          |   6 +-
 testsuite/clocktest/clocktest.c               |  64 +--------
 testsuite/smokey/Makefile.am                  |   2 -
 testsuite/smokey/arith/arith.c                |   6 +-
 testsuite/smokey/posix-cond/posix-cond.c      |  46 +++----
 testsuite/smokey/rtdm/rtdm.c                  |  12 --
 testsuite/smokey/tsc/tsc.c                    |  37 +-----
 testsuite/smokey/vdso-access/Makefile.am      |   9 --
 testsuite/smokey/vdso-access/vdso-access.c    |  31 -----
 testsuite/smokey/y2038/syscall-tests.c        |  30 -----
 63 files changed, 99 insertions(+), 1192 deletions(-)
 delete mode 100644 include/cobalt/kernel/vdso.h
 delete mode 100644 include/cobalt/uapi/kernel/urw.h
 delete mode 100644 include/cobalt/uapi/kernel/vdso.h
 delete mode 100644 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/tsc.h
 delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/tsc.h
 delete mode 100644 lib/cobalt/arch/arm/include/asm/xenomai/tsc.h
 delete mode 100644 lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h
 delete mode 100644 lib/cobalt/arch/x86/include/asm/xenomai/tsc.h
 delete mode 100644 testsuite/smokey/vdso-access/Makefile.am
 delete mode 100644 testsuite/smokey/vdso-access/vdso-access.c

-- 
2.35.3

