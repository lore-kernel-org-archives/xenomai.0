From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/6] Export posix mqueues and named semaphores to procfs 
Date: Mon, 23 Aug 2021 17:00:25 +0200
Message-Id: <20210823150031.78791-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

with this series I'm trying to care about all the feedback I got for
RFCs I sent out some days ago. Exporting mqueues and named semaphores to
the procfs helps to debug and identify resource leaks.

mqueues will be exported to 
	/proc/xenomai/registry/posix/mqueue/<name>

named semaphores will be exported to 
	/proc/xenomai/registry/posix/sem/<name>

While adding the tests I noticed that the exit code of the subprocess
started in the smokey leak test was not correctly reported to the parent
process. That is now fixed as well. (See last patch for details)

All patches compile time tested for all targets by the gitlab
hackerspace CI pipeline. In addition manually tested on ARM64. My
internal CI is currently out of order, so tests on real hardware were
skipped this time.

Best regards,
Florian

 
Florian Bezdeka (6):
  cobalt/registry: Share xnregistry_vfreg_ops with other compile units
  cobalt/registry: Initialize refcnt of exported virtual proc files
  cobalt/registry: Adding a new xnptree for exporting posix entries
  cobalt/posix/mqueue: Export created mqueues to procfs
  cobalt/posix/semaphore: Export named semaphores to procfs
  testsuite/smokey/leaks: Add export checks for mqueues and named
    semaphores

 include/cobalt/kernel/registry.h |  2 +
 kernel/cobalt/posix/mqueue.c     | 38 +++++++++++++++++-
 kernel/cobalt/posix/sem.c        | 37 ++++++++++++++++-
 kernel/cobalt/registry.c         |  3 ++
 testsuite/smokey/leaks/leaks.c   | 68 +++++++++++++++++++++-----------
 5 files changed, 123 insertions(+), 25 deletions(-)

-- 
2.30.2


