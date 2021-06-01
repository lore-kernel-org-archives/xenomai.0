From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/6] y2038: clock_getres64 and clock_adjtime64
Date: Tue,  1 Jun 2021 15:31:18 +0200
Message-Id: <20210601133124.1466307-1-florian.bezdeka@siemens.com>
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

The next set of changes for fixing the y2038 problem for Xenomai:

  - clock_getres64
  - clock_adjtime64 (only relevant for external clocks, so with limited
    testing)

Once again: Patches provided by Song, fixes like style adjustments,
updated error handling, fixing failing tests done by me and squashed into
the patch that introdoced the problem.
 
Best regards,
Florian

Song Chen (3):
  y2038: cobalt/posix/clock: Adding clock_adjtime64
  y2038: lib/cobalt/clock: dispatch clock_adjtime
  y2038: testsuite/smokey/y2038: testcase for adjtime64

chensong (3):
  y2038: cobalt/posix/clock: Adding clock_getres64
  y2038: lib/cobalt/clock: dispatch clock_getres
  y2038: testsuite/smokey/y2038: testcase for getres64

 include/cobalt/uapi/syscall.h          |   2 +
 kernel/cobalt/posix/clock.c            |  48 ++++++++++-
 kernel/cobalt/posix/clock.h            |  12 +++
 kernel/cobalt/posix/syscall32.c        |  14 ++++
 kernel/cobalt/posix/syscall32.h        |   8 ++
 lib/cobalt/clock.c                     |  10 +++
 testsuite/smokey/y2038/syscall-tests.c | 105 +++++++++++++++++++++++++
 7 files changed, 198 insertions(+), 1 deletion(-)

-- 
2.31.1


