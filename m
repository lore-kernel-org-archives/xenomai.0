Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972237CAC
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:00:51 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230927135040a657d0964f566162a4
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9Xi9bMG9rkJMNr5VSfwPReNb92OF+hWEZ/4sHZ5EIg8=;
 b=GQUEmR6LS7edW1XzMlQ0QMdmlKSOJ11PH8uRR6pXZiIjLe2kXw1PL33af8eEHiPGE/MVOL
 PRq28pHZuHEuIAL0QNiLKW1PSer2lzZK/DRXBdSYIi/wwGmy9qjnCPQnIen7+Ad4G8YJoaTk
 xENlaKMbQkn2oKtexGGRDS5Vixi4I=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/9] y2038: Finalize and enable y2038 support
Date: Wed, 27 Sep 2023 15:50:13 +0200
Message-Id: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABUzFGUC/3WNQQ6CMBAAv0J6dk3Z1Qie/IfhUMpWNoHWtEokp
 H+3cvc4k0xmU4mjcFLXalORF0kSfAE8VMqOxj8YZCisUCPpRrfgphDFeFhRUwMISKTJmMtZW6d
 K1ZvE0Efj7Vg6/56mIp+RnXz2zb0rPEp6hbju16X+2f+DpQYNQ20do6P2ZOiWhGf26WjDrLqc8
 xdNws3/xQAAAA==
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,
    
this is the final y2038 related patch series. With this series applied
y2038 support will be enabled by default for all affected
builds/architectures.

There is a kill switch (--disable-y2038) available in case unexpected
problems come up after merge but that is not expected. The y2038 queue
was regularly tested over the last two years now.
    
Short summary:
  - Implement y2038 safe ioctls around SO_RCVTIMEO and SO_SNDTIMEO
  - Enable additional function wrapping
  - Fix some smokey tests (reading of reference clocks)

Fingers crossed, seems the y2038 issue is solved now.

Best regards,
Florian

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Rebase on current next
- Take care of review comments from Jan 
- Reworked function wrapping, no additional __wrap_ implementations for
  time64 based services
- Added cleanup patches 
- Link to v1: https://lore.kernel.org/r/20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com

---
Florian Bezdeka (9):
      y2038: kernel/drivers: Implement SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
      y2038: lib/cobalt: Switch vdso to gettime64
      y2038: testsuite/clocktest: Fix reading of reference clock
      y2038: build: Introduce new build parameter --disable-y2038
      y2038: lib/cobalt: Split function name and interface in COBALT_DECL()
      y2038: lib/cobalt: Implement necessary wrappers for y2038 support
      y2038: testsuite/smokey: Add some function wrapping tests
      lib/cobalt: Cleanup includes
      lib/cobalt/wrappers.h: Remove duplicate definition of __stringify()

 configure.ac                                     | 63 ++++++++++++++++++-
 include/cobalt/fcntl.h                           | 10 +--
 include/cobalt/mqueue.h                          | 49 ++++++---------
 include/cobalt/pthread.h                         | 77 ++++++++++++------------
 include/cobalt/sched.h                           | 12 ++--
 include/cobalt/semaphore.h                       | 24 ++++----
 include/cobalt/signal.h                          | 16 ++---
 include/cobalt/stdio.h                           | 33 +++++-----
 include/cobalt/stdlib.h                          |  4 +-
 include/cobalt/sys/ioctl.h                       |  3 +-
 include/cobalt/sys/mman.h                        | 10 +--
 include/cobalt/sys/select.h                      |  8 +--
 include/cobalt/sys/socket.h                      | 70 +++++++++++----------
 include/cobalt/sys/time.h                        |  4 +-
 include/cobalt/sys/timerfd.h                     | 11 ++--
 include/cobalt/syslog.h                          | 12 ++--
 include/cobalt/time.h                            | 50 ++++++++-------
 include/cobalt/unistd.h                          | 10 +--
 include/cobalt/wrappers.h                        | 34 ++++++++---
 kernel/drivers/ipc/bufp.c                        | 34 +++++++++++
 kernel/drivers/ipc/iddp.c                        | 34 +++++++++++
 kernel/drivers/ipc/internal.h                    | 27 +++++++++
 kernel/drivers/ipc/rtipc.c                       | 29 +++++++++
 kernel/drivers/ipc/xddp.c                        | 18 ++++++
 kernel/drivers/net/stack/ipv4/tcp/tcp.c          | 31 ++++++++++
 lib/cobalt/Makefile.am                           |  2 +
 lib/cobalt/arch/arm/include/asm/xenomai/time.h   |  5 ++
 lib/cobalt/arch/arm64/include/asm/xenomai/time.h |  5 ++
 lib/cobalt/arch/x86/features.c                   |  1 -
 lib/cobalt/arch/x86/include/asm/xenomai/time.h   |  5 ++
 lib/cobalt/attr.c                                |  4 --
 lib/cobalt/clock.c                               | 33 +++++-----
 lib/cobalt/cobalt-glibc-time64.wrappers          | 23 +++++++
 lib/cobalt/cond.c                                |  7 ++-
 lib/cobalt/current.c                             |  3 +-
 lib/cobalt/init.c                                |  2 -
 lib/cobalt/internal.c                            |  4 +-
 lib/cobalt/malloc-nowrap.c                       |  1 +
 lib/cobalt/malloc.c                              |  1 +
 lib/cobalt/mq.c                                  | 17 +++---
 lib/cobalt/mutex.c                               |  6 +-
 lib/cobalt/parse_vdso.c                          |  2 -
 lib/cobalt/rtdm.c                                | 19 +++---
 lib/cobalt/sched.c                               |  5 --
 lib/cobalt/select.c                              | 60 ++++++++++++++++--
 lib/cobalt/semaphore.c                           |  4 +-
 lib/cobalt/signal.c                              |  9 ++-
 lib/cobalt/sigshadow.c                           |  1 +
 lib/cobalt/thread.c                              |  2 -
 lib/cobalt/ticks.c                               |  1 +
 lib/cobalt/timer.c                               | 12 ++--
 lib/cobalt/timerfd.c                             | 11 ++--
 lib/cobalt/umm.c                                 |  7 +--
 lib/cobalt/umm.h                                 |  2 -
 scripts/xeno-config-cobalt.in                    |  5 ++
 testsuite/clocktest/clocktest.c                  | 11 +++-
 testsuite/smokey/y2038/syscall-tests.c           | 47 +++++++++++++++
 57 files changed, 671 insertions(+), 319 deletions(-)
---
base-commit: 335e2aaf4e4f048ecd83cab75a7471ad8e93b97b
change-id: 20230809-florian-y2038-2-23303aa750cf

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

