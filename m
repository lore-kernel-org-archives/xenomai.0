From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 16 Jul 2018 18:37:48 +0200
Message-Id: <cover.1531759073.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 0/6] Fix issues around setsched on remote threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This addresses http://xenomai.org/pipermail/xenomai/2018-July/039267.html.

The last patch of the series may not be a stable candidate as it changes
some return code of the kernel. The rest should go, though.

Jan

Jan Kiszka (6):
  cobalt/posix: Harden cobalt_thread_shadow against invalid requests
  cobalt/posix: Avoid mapping remote threads in
    cobalt_sched_setscheduler_ex
  cobalt/posix: Remove task parameter from cobalt_thread_shadow
  lib/cobalt: Avoid requesting shadowing for remote threads
  lib/cobalt: Pass setsched requests for unknown threads to glibc
  cobalt: Fix error code of cobalt_thread_setschedparam_ex

 kernel/cobalt/posix/sched.c  |  4 ++--
 kernel/cobalt/posix/thread.c | 14 ++++++++------
 kernel/cobalt/posix/thread.h |  3 +--
 lib/cobalt/sched.c           | 10 ++++++++++
 lib/cobalt/thread.c          | 18 ++++++++++++++++--
 5 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.16.4


