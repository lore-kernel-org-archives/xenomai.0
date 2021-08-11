From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/3] y2038: Adding event_wait64()
Date: Wed, 11 Aug 2021 15:36:45 +0200
Message-Id: <20210811133651.42582-1-florian.bezdeka@siemens.com>
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

Hi!

Just another y2038 related syscall, once again based on v1 sent out by
Song and rebased to current next with some code- and test-cleanups applied.

@Song:
This one was the last one in my inbox. Please make sure that all
following patches are based on next. IIRC there are 3 or 4 syscalls
remaining. We should take care of [1] as well. We need something in the CI 
that tests the full implementation, i.e. including the glibc wrappers (proper
syscall delegation). Recent glibc should allow us to use 64bit time_t.

[1]: https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21

Best regards,
Florian

Florian Bezdeka (1):
  y2038: testsuite/smokey/y2038: Adding tests for event_wait64

Song Chen (2):
  y2038: cobalt/posix/event: Adding event_wait64
  y2038: lib/cobalt/internal: dispatch event_wait

 include/cobalt/uapi/syscall.h          |  1 +
 kernel/cobalt/posix/event.c            | 34 ++++++++++-
 kernel/cobalt/posix/event.h            | 12 ++++
 kernel/cobalt/posix/syscall32.c        |  9 +++
 kernel/cobalt/posix/syscall32.h        |  7 +++
 kernel/cobalt/trace/cobalt-posix.h     |  3 +-
 lib/cobalt/internal.c                  |  5 ++
 testsuite/smokey/y2038/syscall-tests.c | 78 +++++++++++++++++++++++---
 8 files changed, 136 insertions(+), 13 deletions(-)

-- 
2.30.2


