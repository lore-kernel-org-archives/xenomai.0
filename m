From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/3] y2038: sigtimedwait64
Date: Tue, 10 Aug 2021 17:27:08 +0200
Message-Id: <20210810152711.227714-1-florian.bezdeka@siemens.com>
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

Here comes the next y2038 related syscall implementation. Once again
based on v1 sent out by Song. I had to rework the patches a bit, mostly
to stay POSIX compatible (EAGAIN vs. ETIMEOUT) and necessary test
adjustments and improvements.

Best regards,
Florian

Florian Bezdeka (1):
  y2038: testsuite/smokey/y2038: Adding tests for sigtimedwait64

Song Chen (2):
  y2038: cobalt/posix/signal: Adding sigtimedwait64
  y2038: lib/cobalt/signal: dispatch sigtimedwait

 include/cobalt/uapi/syscall.h          |  1 +
 kernel/cobalt/posix/signal.c           | 21 ++++++-
 kernel/cobalt/posix/signal.h           |  5 ++
 kernel/cobalt/posix/syscall32.c        | 21 +++++++
 kernel/cobalt/posix/syscall32.h        |  5 ++
 kernel/cobalt/trace/cobalt-posix.h     |  4 +-
 lib/cobalt/signal.c                    |  4 ++
 testsuite/smokey/y2038/syscall-tests.c | 80 ++++++++++++++++++++++++++
 8 files changed, 137 insertions(+), 4 deletions(-)

-- 
2.30.2


