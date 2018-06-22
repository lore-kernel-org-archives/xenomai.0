From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 22 Jun 2018 17:42:32 +0200
Message-Id: <cover.1529682156.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 0/4] Enhancements of signal_copyinfo extension
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Please see patches for details.

Jan

Jan Kiszka (4):
  cobalt/posix: Move signal_put_siginfo unmodified
  cobalt/posix: Convert put_siginfo callback into boolean
  cobalt/posix: Provide compat version signal_copyinfo extension
  cobalt/posix: Evaluate return code of signal_copyinfo extensions

 kernel/cobalt/posix/extension.h |   4 ++
 kernel/cobalt/posix/signal.c    | 112 +++++++++++++++++++++-------------------
 kernel/cobalt/posix/signal.h    |   8 +--
 kernel/cobalt/posix/syscall32.c |   4 +-
 4 files changed, 67 insertions(+), 61 deletions(-)

-- 
2.13.7


