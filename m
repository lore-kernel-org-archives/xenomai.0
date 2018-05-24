From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 24 May 2018 19:44:51 +0200
Message-Id: <cover.1527183892.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 0/2] Named semaphore fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

This fixes the issue Tamas reported with pshared semaphores. Still, the
code is complex and requires a careful review.

Eventually, some test case for pshared setups would be good. I don't
think smokey can already provide the necessary infrastructure for that,
though.

Jan

Jan Kiszka (2):
  cobalt/posix/sem: Fix semaphore leak on failing xnmalloc
  cobalt/posix/sem: Fix sem_open for preexisting semaphores

 kernel/cobalt/posix/nsem.c | 15 ++++++++++-----
 kernel/cobalt/posix/sem.c  | 23 ++++++++++++++++++-----
 kernel/cobalt/posix/sem.h  |  3 +++
 3 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.13.6


