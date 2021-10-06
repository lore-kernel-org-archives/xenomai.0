From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v5 0/3] y2038: Adding recvmmsg64
Date: Wed,  6 Oct 2021 15:54:12 +0200
Message-Id: <20211006135415.223689-1-florian.bezdeka@siemens.com>
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

Hi,

Just another y2038 related syscall, once again based on v4 sent out by
Song with the following changes (squashed into the affected patches):

- rebased to current next (especially patch 3)
- minor code cleanups / reformattings
- Added the syscall name to the tracing infrastructure
- Switched the test from CLOCK_REALTIME to CLOCK_MONOTONIC

Best regards,
Florian
 

Song Chen (3):
  y2038: cobalt/posix/io: Adding recvmmsg64
  y2038: lib/cobalt/rtdm: dispatch recvmmg
  y2038: testsuite/smokey/y2038: testcase for recvmmsg64

 include/cobalt/kernel/rtdm/fd.h        |   5 +
 include/cobalt/uapi/syscall.h          |   1 +
 kernel/cobalt/posix/io.c               |   9 ++
 kernel/cobalt/posix/io.h               |   5 +
 kernel/cobalt/posix/syscall32.c        |   9 ++
 kernel/cobalt/posix/syscall32.h        |   6 ++
 kernel/cobalt/rtdm/fd.c                |  21 +++-
 kernel/cobalt/trace/cobalt-posix.h     |   3 +-
 lib/cobalt/rtdm.c                      |   5 +
 testsuite/smokey/y2038/syscall-tests.c | 127 +++++++++++++++++++++++++
 10 files changed, 189 insertions(+), 2 deletions(-)

-- 
2.31.1


