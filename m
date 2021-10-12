From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/4] Alchemy fixes around timeouts
Date: Tue, 12 Oct 2021 20:19:16 +0200
Message-Id: <cover.1634062760.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

See patches for details

Jan

Jan Kiszka (4):
  lib/alchemy: Fix rt_pipe_read* with timeouts
  lib/alchemy/testsuite: Fix pipe-1 test case
  lib/alchemy/testsuite: Extend pipe-1 test by timeout checks
  lib/alchemy: Fix/clarify documentation of *_timed functions regarding
    abs_timeout

 include/alchemy/pipe.h         |  8 +----
 lib/alchemy/buffer.c           | 28 ++++++----------
 lib/alchemy/cond.c             | 14 +++-----
 lib/alchemy/event.c            | 16 ++++-----
 lib/alchemy/heap.c             | 16 ++++-----
 lib/alchemy/mutex.c            | 12 +++----
 lib/alchemy/pipe.c             | 61 +++++++++++++++++++++++++++-------
 lib/alchemy/queue.c            | 32 +++++++-----------
 lib/alchemy/sem.c              | 16 ++++-----
 lib/alchemy/task.c             | 27 ++++++---------
 lib/alchemy/testsuite/pipe-1.c | 35 ++++++++++++++++++-
 11 files changed, 143 insertions(+), 122 deletions(-)

-- 
2.31.1


