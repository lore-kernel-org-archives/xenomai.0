From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 0/9] EADV-related fixes, select refactorings,
 restartable compat syscalls
Date: Mon,  5 Jul 2021 09:36:32 +0200
Message-Id: <cover.1625470600.git.jan.kiszka@siemens.com>
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

This should resolved the EADV bug seen with select when called with
Linux fds. It also fixes wrong EADV reporting for other services. And it
adds the missing syscall restart support for clock_nanosleep and select
when taking the compat path.

Please review and test carefully, some details are rather tricky.

I'm considering the EADV fixes for stable as well, though they will
alter the return codes. But the current scheme was broken anyway.

Jan


CC: Philippe Gerum <rpm@xenomai.org>
CC: Steve Freyder <steve@freyder.net>

Jan Kiszka (9):
  cobalt/posix/io: Remove unneeded special case of select_bind_one
  cobalt/posix/io: Avoid err variable shadowing
  cobalt/rtdm/fd: Fix comment typo
  cobalt/rtdm/fd: Fix error code documentation of rtdm_fd_select
  cobalt/rtdm/fd: Fix default handler setups
  cobalt/select: Add proper handling of EADV
  cobalt/posix/syscall32: Mark compat clock_nanosleep restartable
  cobalt/posix/compat: Privatize sys32_get/put_fdset
  cobalt/posix/io: Unify native and compat versions of select

 include/cobalt/kernel/compat.h  |   8 +-
 kernel/cobalt/posix/compat.c    |  14 ++--
 kernel/cobalt/posix/io.c        | 131 +++++++++++++++++++++-----------
 kernel/cobalt/posix/io.h        |   3 +
 kernel/cobalt/posix/syscall32.c |  93 +----------------------
 kernel/cobalt/rtdm/fd.c         |  69 ++++++++++-------
 lib/cobalt/select.c             |   2 +-
 7 files changed, 146 insertions(+), 174 deletions(-)

-- 
2.26.2


