From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 0/5] y2038: Adding support for mq_timed{send,recv}64
Date: Tue, 10 Aug 2021 12:24:46 +0200
Message-Id: <20210810102451.49642-1-florian.bezdeka@siemens.com>
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

this is kind of a re-send of the patch series originall published by
Song. There were some things that had to be addressed:

 - Code formattings
 - Copy paste errors in the test suite
 - Failing / incomplete tests, missing test cleanups
 - Incorrect compat syscall declerations

@Song: Especially the missing test cleanups and the incorrect compat
syscall declerations made me unhappy. Did you really test that once?
Please make sure to send properly tested patches. There are many
pitfalls in the game which makes the review process time consuming,
especially when I have to assume that it was not tested till now.

Changes in v3:
  - Patch 3: Fix timespec validation
  - Patch 5: Fix tests for mq_timedreceive64()
  - Patch 5: Fixed typos

Florian Bezdeka (1):
  y2038: testsuite/smokey/y2038: Adding tests for mq_timed{send,recv}64

Song Chen (4):
  y2038: cobalt/posix/mqueue: Adding mq_timedsend64
  y2038: lib/cobalt/mqueue: dispatch mq_timedsend
  y2038: cobalt/posix/muqueue: Adding mq_timedreceive64
  y2038: lib/cobalt/mqueue: dispatch mq_timedreceive

 include/cobalt/uapi/syscall.h          |   2 +
 kernel/cobalt/posix/mqueue.c           |  51 ++++++-
 kernel/cobalt/posix/mqueue.h           |  18 +++
 kernel/cobalt/posix/syscall32.c        |  16 +++
 kernel/cobalt/posix/syscall32.h        |  10 ++
 kernel/cobalt/trace/cobalt-posix.h     |   4 +-
 lib/cobalt/mq.c                        |  10 ++
 testsuite/smokey/y2038/syscall-tests.c | 190 ++++++++++++++++++++++++-
 8 files changed, 297 insertions(+), 4 deletions(-)

-- 
2.30.2


