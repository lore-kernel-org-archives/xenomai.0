Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BF1FB51
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 09:39:53 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202308010929429906c74857087d1c5f
        for <xenomai@lists.linux.dev>;
        Tue, 01 Aug 2023 11:29:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=S7nVcNpiDDHbNcMOOHRdAxCuLcSORMLfER1fl7X8/M8=;
 b=izP+PGfjfxEnL6df8zeR0eAJyt+rPQNKl9sxGIvuKRQZ0gVsjVN/gD4bMh3gdCHqscq3mR
 lEke6YzIidAXnNd8foLa4ph96NwB6+BXQRAjEuYXgkDWBmtht5g1PCmI5vuYRtfSkbc4rPD0
 udOeQSfVeO5w10D9QSLKt+RrFPUGg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 0/7] y2038: Add time64_t support to scheduler and thread
 APIs
Date: Tue, 01 Aug 2023 11:29:34 +0200
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH7QyGQC/52OMY7CMBBFr4Jc76CJE5DZinsgiskwISMldjROo
 kUod19Dt+VSvl+8958ui6lk9717OpNVs6ZYoP7aOe4p3gX0Vth59DUea4RuSKYU4eGxDjCRzdC
 lxWCZ8mxCo8Y7IFdIB2HuuHLF1FIWaI0i98UVl2Eo42TS6c87fbkW7jXPyR7vJ2v1Wv8XXStAO
 GJDGE6HxrM/Z5VRYt5zGt2rsPoPrL5Y20ZCCMLkb6e/1m3bfgGV3ikRQwEAAA==
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Richard Weinberger <richard@nod.at>
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
Changes in v3:
- Added fixes for compat issue around struct rtser_config (rtdm)
- Move to types with fixed size, Patch 5
- Align struct xn_ts64 with struct __kernel_timespec (__u64 vs __s64)
- Link to v2: https://lore.kernel.org/r/20230630-florian-y2038-part-four-upstreaming-v2-0-b4e888eca2d9@siemens.com

Changes in v2:
- Removed patches that were already merged into next 
- Instead of introducing new time64_t syscalls the entire uapi around
  thread and sched has been moved to "time64_t always"
- Link to v1: https://lore.kernel.org/r/20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com

---
Florian Bezdeka (7):
      cobalt/posix/syscall32: Remove unused mq_fetch_timeout
      y2038: cobalt/uapi: Migrate struct sched_param_ex to time64_t
      y2038: cobalt/uapi: Remove __user_old_{timespec,itimerspec,timeval,timex}
      y2038: cobalt/{thread,sched}: Remove obsolete compat handling
      cobalt/uapi: Move to data types with fixed sizes
      include/rtdm/serial.h: Move to data types with fixed sizes
      include/rtdm/serial.h: Fix compat support of struct rtser_config

 include/cobalt/kernel/compat.h                     |  49 -----
 include/cobalt/uapi/event.h                        |   6 +-
 include/cobalt/uapi/kernel/types.h                 |  54 +----
 include/cobalt/uapi/sched.h                        |  52 ++---
 include/cobalt/uapi/sem.h                          |   6 +-
 include/cobalt/uapi/thread.h                       |   4 +-
 include/rtdm/uapi/serial.h                         |  35 +--
 .../arch/arm/include/asm/xenomai/uapi/features.h   |   2 +-
 .../arch/arm64/include/asm/xenomai/uapi/features.h |   2 +-
 .../arch/x86/include/asm/xenomai/syscall32-table.h |   8 -
 .../arch/x86/include/asm/xenomai/uapi/features.h   |   2 +-
 .../cobalt/include/asm-generic/xenomai/syscall.h   |  29 +--
 kernel/cobalt/posix/clock.c                        |  23 +-
 kernel/cobalt/posix/clock.h                        |  28 +--
 kernel/cobalt/posix/compat.c                       |  72 -------
 kernel/cobalt/posix/cond.c                         |   4 +-
 kernel/cobalt/posix/cond.h                         |   2 +-
 kernel/cobalt/posix/event.c                        |   4 +-
 kernel/cobalt/posix/event.h                        |   2 +-
 kernel/cobalt/posix/io.c                           |   4 +-
 kernel/cobalt/posix/io.h                           |   2 +-
 kernel/cobalt/posix/monitor.c                      |   4 +-
 kernel/cobalt/posix/monitor.h                      |   2 +-
 kernel/cobalt/posix/mqueue.c                       |   6 +-
 kernel/cobalt/posix/mqueue.h                       |   4 +-
 kernel/cobalt/posix/mutex.c                        |   4 +-
 kernel/cobalt/posix/mutex.h                        |   2 +-
 kernel/cobalt/posix/sched.c                        |  16 +-
 kernel/cobalt/posix/sem.c                          |   4 +-
 kernel/cobalt/posix/sem.h                          |   2 +-
 kernel/cobalt/posix/signal.c                       |   2 +-
 kernel/cobalt/posix/signal.h                       |   2 +-
 kernel/cobalt/posix/syscall32.c                    | 239 ---------------------
 kernel/cobalt/posix/syscall32.h                    |  45 ----
 kernel/cobalt/posix/thread.c                       |   8 +-
 kernel/cobalt/posix/timer.c                        |  14 +-
 kernel/cobalt/posix/timer.h                        |   6 +-
 kernel/cobalt/posix/timerfd.c                      |  14 +-
 kernel/cobalt/posix/timerfd.h                      |   6 +-
 lib/cobalt/clock.c                                 |   2 +-
 lib/cobalt/internal.h                              |   5 +
 lib/cobalt/timer.c                                 |   4 +-
 lib/cobalt/timerfd.c                               |   4 +-
 43 files changed, 174 insertions(+), 611 deletions(-)
---
base-commit: e1567904ecbac671aa9bf6cc0fa150bf43bfb4e9
change-id: 20230630-florian-y2038-part-four-upstreaming-0c10a5eccfc1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

