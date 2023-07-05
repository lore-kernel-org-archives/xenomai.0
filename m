Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B571137F
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 07:18:41 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230705063823a3f1434b00ce83b5b4
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=VNaRiUoX/wkb3m8676e/Y7H+elmCrm6SP7IfWkqHra4=;
 b=MYZWx9epOZeIc4IAZ2EYYiQsr9d41KFpzW2YuPN6CqYDLKfaaysM9WdS2Hu/YUo+YTDSfZ
 +jOU6Bfy7ZodxcguzVWpDahZZ5PHewuYV/rI4s50+W9fXrlE1cGejnBDBlrlIbvJVlaSsf3u
 /cAi6MpKB+eWhhw/MQY6rik7O/Lfk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/12] y2038: Add time64_t support to scheduler and thread
 APIs
Date: Wed, 05 Jul 2023 08:38:22 +0200
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4PpWQC/x2NQQrCMBAAv1JydmGToIhfEQ/buGkXYhI2jSilf
 zd4nDnM7KaxCjdzm3aj/JYmJQ+wp8mElfLCIM/BxqHzePEIMRUVyvB16K9QSTeIpSv02jZlekl
 eAINFOnMIMVgzSjM1hlkph3W0ck9pyKoc5fNf3x/H8QMvCopxigAAAA==
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

this is hopefully the last preparation series necessary to turn on
time64_t support (a.k.a. y2038 support). 

With this series applied the Xenomai specific APIs around scheduler and
thread APIs will support time64_t when requested. The final "turn on by
default" switch will be part of the final y2038 series (which is hopefully
the next one).

The remaining stuff can be found in my y2038 queue at [1].
The Xenomai hackerspace wiki is up to date and represents the current
state of the y2038 work. See [2].

Best regards,
Florian

[1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/commits/florian%2Fy2038
[2] https://gitlab.com/Xenomai/xenomai-hacker-space/-/wikis/y2038/Y2038_Roadmap

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (12):
      y2038: cobalt: Introduce sched_param_ex64 and use it internally
      y2038: cobalt: Introduce sched_config64 and use it internally
      y2038: cobalt/posix/{sched,thread}: Add time64_t based syscalls
      y2038: lib/cobalt/{sched,thread}: Dispatch time64_t related services
      y2038: cobalt/uapi: Introduce xntimespec for struct sched_param_ex API
      y2038: cobalt/uapi: Align memory layout for time64 related types
      y2038: cobalt/uapi: Remove __user_old_{timespec,itimerspec,timeval,timex}
      y2038: testsuite/smokey/y2038: Fix reporting of thread return status
      y2038: testsuite/smokey/y2038: Add tests for sched_param_ex related syscalls
      y2038: testsuite/smokey/y2038: Fix a race in the pselect interruption test
      y2038: testsuite/smokey/y2038: Fix normalization of struct xn_timespec64
      testsuite/smokey: Fix unconditional unloads of the xeno_rtdmtest module

 include/cobalt/kernel/compat.h                     |   9 +-
 include/cobalt/uapi/kernel/types.h                 |  53 ----
 include/cobalt/uapi/sched.h                        |  20 +-
 include/cobalt/uapi/syscall.h                      |   7 +
 .../arch/arm/include/asm/xenomai/uapi/features.h   |   2 +-
 .../arch/arm64/include/asm/xenomai/uapi/features.h |   2 +-
 .../arch/x86/include/asm/xenomai/uapi/features.h   |   2 +-
 .../cobalt/include/asm-generic/xenomai/syscall.h   |  20 +-
 kernel/cobalt/posix/clock.c                        |  13 +-
 kernel/cobalt/posix/clock.h                        |  29 +-
 kernel/cobalt/posix/compat.c                       |   5 +-
 kernel/cobalt/posix/cond.c                         |   2 +-
 kernel/cobalt/posix/cond.h                         |   2 +-
 kernel/cobalt/posix/event.c                        |   2 +-
 kernel/cobalt/posix/event.h                        |   2 +-
 kernel/cobalt/posix/io.c                           |   2 +-
 kernel/cobalt/posix/io.h                           |   2 +-
 kernel/cobalt/posix/monitor.c                      |   2 +-
 kernel/cobalt/posix/monitor.h                      |   2 +-
 kernel/cobalt/posix/mqueue.c                       |   4 +-
 kernel/cobalt/posix/mqueue.h                       |   4 +-
 kernel/cobalt/posix/mutex.c                        |   2 +-
 kernel/cobalt/posix/mutex.h                        |   2 +-
 kernel/cobalt/posix/sched.c                        | 293 +++++++++++++----
 kernel/cobalt/posix/sched.h                        |  55 +++-
 kernel/cobalt/posix/sem.c                          |   2 +-
 kernel/cobalt/posix/sem.h                          |   2 +-
 kernel/cobalt/posix/signal.c                       |   2 +-
 kernel/cobalt/posix/signal.h                       |   2 +-
 kernel/cobalt/posix/syscall32.c                    |  24 +-
 kernel/cobalt/posix/thread.c                       | 172 ++++++++--
 kernel/cobalt/posix/thread.h                       |  55 +++-
 kernel/cobalt/posix/timer.c                        |  14 +-
 kernel/cobalt/posix/timer.h                        |   6 +-
 kernel/cobalt/posix/timerfd.c                      |  14 +-
 kernel/cobalt/posix/timerfd.h                      |   6 +-
 kernel/cobalt/trace/cobalt-posix.h                 |  29 +-
 lib/cobalt/clock.c                                 |   2 +-
 lib/cobalt/internal.h                              |   5 +
 lib/cobalt/sched.c                                 |  38 ++-
 lib/cobalt/thread.c                                |  29 +-
 lib/cobalt/timer.c                                 |   4 +-
 lib/cobalt/timerfd.c                               |   4 +-
 testsuite/smokey/cpu-affinity/cpu-affinity.c       |  13 +-
 testsuite/smokey/rtdm/rtdm.c                       |   7 +-
 testsuite/smokey/y2038/syscall-tests.c             | 346 ++++++++++++++++++++-
 46 files changed, 1038 insertions(+), 276 deletions(-)
---
base-commit: ba202eb8e976bbd03c524250dd4fa6810d167851
change-id: 20230630-florian-y2038-part-four-upstreaming-0c10a5eccfc1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

