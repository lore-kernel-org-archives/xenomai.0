Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829F4D118
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Evg8VfHP"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231205124139206177a0530b91c37c
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=C4MkzJ1AOXSSo4vc7ZAhrPa5IwNFYV6X4JibSSYa204=;
 b=Evg8VfHP1upA7522UcBOiiWP9FerBP6g4EfyTAjvwu/m5vi6VzArv1vMyx8Bc5foeM+DKh
 u4G7zNBp3HGsnMhGZdQBzdZYye6vQso4YGJRA7KbyQO93SvK16UAautvjC7EVbPvf1lFDiA/
 6RkTZRGqny8udURu3fadkyTSdjCxA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 00/13] Migration to ARRAY_SIZE() and further include
 cleanups
Date: Tue, 05 Dec 2023 13:41:37 +0100
Message-Id: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEab2UC/x3MTQqAIBBA4avIrBtQI6iuEi0kxxoIjRGiH7x70
 vJbvPdCJmHKMKoXhE7OnGKFaRQsm4srIftqsNq2xmqDYU/oRNyNmR/C0Gofeu9tRwPU6BAKfP3
 DaS7lAwsH7DdgAAAA
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

Warning, this is high altitute work ;-). I had some time on my flight back
from New Zealand, so review carefully.

Everything is compile tested and passed our internal CI already - as
usual.

I'm trying to address some comments / further cleanups mentioned by Jan
during the last testsuite cleanup series.

Best regards,
Florian

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (13):
      testsuite: Migrate to ARRAY_SIZE()
      demo: Migrate to ARRAY_SIZE()
      lib: Migrate to ARRAY_SIZE()
      kernel/drivers: Mirate to ARRAY_SIZE()
      demo: Cleanup includes
      lib/alchemy: Cleanup includes
      lib/analogy: Cleanup includes
      lib/boilerplate: Cleanup includes
      lib/copperplate: Cleanup includes
      lib/psos: Cleanup includes
      lib/smokey: Cleanup includes
      lib/trank: Cleanup includes
      lib/vxworks: Cleanup includes

 demo/alchemy/altency.c                                   |  2 +-
 demo/alchemy/cobalt/cross-link.c                         |  3 +--
 demo/posix/cobalt/bufp-label.c                           |  5 ++++-
 demo/posix/cobalt/bufp-readwrite.c                       |  5 ++++-
 demo/posix/cobalt/can-rtt.c                              |  2 --
 demo/posix/cobalt/eth_p_all.c                            |  2 --
 demo/posix/cobalt/gpiopwm.c                              |  3 ---
 demo/posix/cobalt/iddp-label.c                           |  5 ++++-
 demo/posix/cobalt/iddp-sendrecv.c                        |  5 ++++-
 demo/posix/cobalt/xddp-echo.c                            |  5 ++++-
 demo/posix/cobalt/xddp-label.c                           |  5 ++++-
 demo/posix/cobalt/xddp-stream.c                          |  5 ++++-
 demo/posix/cyclictest/cyclictest.c                       |  6 +++---
 include/smokey/smokey.h                                  |  2 +-
 kernel/drivers/analogy/national_instruments/mio_common.c |  6 ++----
 kernel/drivers/analogy/national_instruments/ni_670x.c    |  2 +-
 kernel/drivers/analogy/national_instruments/ni_stc.h     |  4 ++--
 kernel/drivers/analogy/national_instruments/pcimio.c     |  2 +-
 .../net/drivers/experimental/e1000/e1000_80003es2lan.c   |  3 +--
 .../drivers/net/drivers/experimental/e1000/e1000_82541.c |  3 +--
 .../drivers/net/drivers/experimental/e1000/e1000_phy.c   |  6 ++----
 kernel/drivers/net/drivers/igb/e1000_phy.c               |  6 ++----
 lib/alchemy/alarm.c                                      |  2 +-
 lib/alchemy/buffer.c                                     |  2 +-
 lib/alchemy/cond.c                                       |  2 +-
 lib/alchemy/event.c                                      |  2 +-
 lib/alchemy/heap.c                                       |  1 -
 lib/alchemy/init.c                                       |  3 +--
 lib/alchemy/internal.c                                   |  2 --
 lib/alchemy/mutex.c                                      |  2 +-
 lib/alchemy/pipe.c                                       |  3 ++-
 lib/alchemy/queue.c                                      |  2 +-
 lib/alchemy/sem.c                                        |  1 -
 lib/alchemy/task.c                                       |  2 +-
 lib/analogy/calibration.c                                |  2 +-
 lib/analogy/descriptor.c                                 |  1 -
 lib/analogy/math.c                                       |  1 -
 lib/analogy/range.c                                      |  1 -
 lib/boilerplate/ancillaries.c                            |  8 +++-----
 lib/boilerplate/avl.c                                    |  1 +
 lib/boilerplate/debug.c                                  |  7 ++-----
 lib/boilerplate/hash.c                                   |  2 +-
 lib/boilerplate/heapmem.c                                |  5 ++---
 lib/boilerplate/iniparser/dictionary.c                   |  1 -
 lib/boilerplate/init/bootstrap.c                         |  1 +
 lib/boilerplate/setup.c                                  |  7 +++----
 lib/boilerplate/time.c                                   |  1 +
 lib/boilerplate/version.c                                |  1 +
 lib/cobalt/mutex.c                                       |  2 +-
 lib/cobalt/sigshadow.c                                   |  2 +-
 lib/copperplate/clockobj.c                               |  4 ----
 lib/copperplate/cluster.c                                |  3 ---
 lib/copperplate/eventobj.c                               |  2 --
 lib/copperplate/heapobj-heapmem.c                        |  7 +++++--
 lib/copperplate/init.c                                   |  4 +---
 lib/copperplate/internal.c                               |  4 ++--
 lib/copperplate/syncobj.c                                |  2 --
 lib/copperplate/threadobj.c                              |  1 +
 lib/copperplate/traceobj.c                               |  1 +
 lib/psos/init.c                                          |  8 ++------
 lib/psos/pt.c                                            |  5 +----
 lib/psos/queue.c                                         |  7 +------
 lib/psos/rn.c                                            |  5 +----
 lib/psos/sem.c                                           |  4 +---
 lib/psos/task.c                                          |  5 +----
 lib/psos/tm.c                                            |  3 ---
 lib/smokey/helpers.c                                     |  1 +
 lib/smokey/init.c                                        |  8 +++-----
 lib/trank/init.c                                         |  1 +
 lib/trank/internal.c                                     |  4 ++--
 lib/vxworks/errnoLib.c                                   |  1 +
 lib/vxworks/init.c                                       |  3 ++-
 lib/vxworks/kernLib.c                                    |  1 +
 lib/vxworks/memPartLib.c                                 |  1 +
 lib/vxworks/msgQLib.c                                    |  1 +
 lib/vxworks/rngLib.c                                     |  1 +
 lib/vxworks/semLib.c                                     |  1 +
 lib/vxworks/sysLib.c                                     |  4 ++--
 lib/vxworks/taskHookLib.c                                |  2 ++
 lib/vxworks/taskInfo.c                                   |  1 +
 lib/vxworks/taskLib.c                                    |  6 ------
 lib/vxworks/tickLib.c                                    |  6 +-----
 lib/vxworks/wdLib.c                                      |  1 +
 testsuite/smokey/alchemytests/mq-1.c                     |  3 ++-
 testsuite/smokey/alchemytests/mq-2.c                     |  3 ++-
 testsuite/smokey/net_common/server.c                     |  8 ++++----
 testsuite/smokey/net_common/setup.c                      |  2 +-
 testsuite/smokey/posix-select/posix-select.c             |  4 ++--
 testsuite/smokey/vxworkstests/msgQ-1.c                   |  3 ++-
 testsuite/smokey/vxworkstests/msgQ-2.c                   |  3 ++-
 testsuite/switchtest/switchtest.c                        | 16 ++++++++--------
 91 files changed, 136 insertions(+), 168 deletions(-)
---
base-commit: ed69c34214f9fcf57b459e701ed4f65f6753bb8c
change-id: 20231201-flo-array-size-f30df8dd25e9

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

