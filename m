Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747211103
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:01 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230505072058742b170498b73b3f2b
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:20:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2yBwlDH24FAczvDkJ51t6agpGVjrADa2iAEIhoUXbAg=;
 b=demwr+F/xwA0N4uvEhOPPpPzuyYdvmnHaT57NPOn98NuWqYSiITQ/8ltU/tZCJCTxbXF5g
 HVEgdKeU4ylWYD0Dj2RW4s77IAQ49nbzR8WMgi+tH5t/EoxyC7nKPzQRqi+Q2i1OHNG2rUfI
 dkCEimGFZt4EW0rzNfAwwH1UnlJ2Y=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/17] y2038: Part one - Cleanup existing implementation +
 general preparation
Date: Fri, 05 May 2023 09:20:55 +0200
Message-Id: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFeuVGQC/w3LQQqEMAwAwK9IzgZqI1j8TdS4Bkq6pO6CiH+3x
 znMDVVcpcLc3eDy16rFGoa+g/Vg+wjq1gwxRApjTLjn4sqGVwyU8Mt+YjHBaSDZxp0mCglaXrg
 KLs62Hq3bL+fneQE4+zKYbQAAAA==
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

I'm trying to bring the remaining patches from my y2038 queue into Xenomai 
next/master branches. The full queue [1] holds ~40 patches. I'm trying to 
split that up to keep reviewing efforts low.

Part one of this series:
Basically removing some unnecessary compat syscalls. While initally evolving 
a pattern that we followed for all the necessary syscalls we overlooked an 
existing compat mechanism, so we accidentially implemented to much.

Part two of this series:
Minor refactorings, fixes and preparations for 64 bit time_t.

Best regards,
Florian

[1] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (17):
      y2038: cobalt: posix/sem: Remove compat syscall for sem_timedwait64
      y2038: cobalt: posix/clock: Remove compat syscall for clock_gettime64
      y2038: cobalt: posix/clock: Remove compat syscall for clock_settime64
      y2038: cobalt: posix/clock: Remove compat syscall for clock_nanosleep64
      y2038: cobalt: posix/clock: Remove compat syscall for clock_getres64
      y2038: cobalt: posix/clock: Remove compat syscall for clock_adjtime64
      y2038: cobalt: posix/mutex: Remove compat syscall for mutex_timedlock64
      y2038: cobalt: posix/mqueue: Remove compat syscall for mq_timedsend64
      y2038: cobalt: posix/monitor: Remove compat syscall for monitor_wait64
      y2038: cobalt: posix/event: Remove compat syscall for event_wait64
      y2038: cobalt: posix/cond: Remove compat syscall for cond_wait_prologue64
      y2038: cobalt: Cleanup code style of time.{c,h}
      y2038: posix/mq: Fix mq_timedsend syscall routing
      y2038: posix/mq: Harmonize mq_receive and mq_timedreceive
      y2038: testsuite/smokey/y2038: Fix a very unlikely resource leak
      y2038: cobalt/posix/clock: Use timespec64_valid() for validation
      y2038: Prepare code base for 64bit time_t

 demo/alchemy/altency.c                 | 26 +++++-----
 include/cobalt/kernel/time.h           |  2 +-
 kernel/cobalt/posix/clock.c            | 59 +++++------------------
 kernel/cobalt/posix/clock.h            | 16 -------
 kernel/cobalt/posix/cond.c             | 12 +----
 kernel/cobalt/posix/cond.h             |  5 --
 kernel/cobalt/posix/event.c            | 26 ++++------
 kernel/cobalt/posix/event.h            |  5 --
 kernel/cobalt/posix/monitor.c          | 26 ++++------
 kernel/cobalt/posix/monitor.h          |  5 --
 kernel/cobalt/posix/mqueue.c           | 10 +---
 kernel/cobalt/posix/mqueue.h           |  3 --
 kernel/cobalt/posix/mutex.c            | 10 +---
 kernel/cobalt/posix/mutex.h            |  3 --
 kernel/cobalt/posix/sem.c              | 22 ++++-----
 kernel/cobalt/posix/sem.h              |  3 --
 kernel/cobalt/posix/syscall32.c        | 86 ----------------------------------
 kernel/cobalt/posix/syscall32.h        | 55 ----------------------
 kernel/cobalt/time.c                   |  4 +-
 lib/cobalt/mq.c                        | 47 ++++++++++++-------
 testsuite/latency/latency.c            | 34 +++++++-------
 testsuite/smokey/y2038/syscall-tests.c |  7 +--
 testsuite/spitest/spitest.c            |  6 ++-
 23 files changed, 116 insertions(+), 356 deletions(-)
---
base-commit: 967cff01b071f2799db1de4d088c396a40a074b6
change-id: 20230428-florian-y2038-part-one-713ed4f37308

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

