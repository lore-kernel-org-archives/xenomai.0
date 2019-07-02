From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/2] ipipe-noarch: IRQ tracing and lockdep fixes/cleanups
Date: Tue,  2 Jul 2019 18:32:25 +0200
Message-Id: <cover.1562085146.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

See patches for details.

Jan

Jan Kiszka (2):
  ipipe: Restore trace_hardirqs_on_virt_caller
  ipipe: lockdep: Remove duplicate context checks

 kernel/locking/lockdep.c        |  6 ------
 kernel/trace/trace_preemptirq.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.16.4


