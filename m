From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/3] Fix eventobj_wait for EVOBJ_ALL
Date: Fri, 31 Jan 2020 15:37:57 +0100
Message-Id: <cover.1580481480.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

See patches for details.

Jan

Jan Kiszka (3):
  lib/alchemy/testsuite: Add event test case for EV_ALL bug
  kernel/cobalt/posix: Fix cobalt_event_wait for COBALT_EVENT_ALL case
  lib/copperplate: Fix eventobj_wait for COBALT_EVENT_ALL case

 kernel/cobalt/posix/event.c     | 2 +-
 lib/alchemy/testsuite/event-1.c | 9 +++++++++
 lib/copperplate/eventobj.c      | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.16.4


