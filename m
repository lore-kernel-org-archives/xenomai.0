From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 0/5] Fix y2038 for clock_settime
Date: Tue,  3 Nov 2020 11:04:22 +0800
Message-Id: <1604372662-2762-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, henning.schild@siemens.com

This patch serial is aimed to remove 32bit timespec for clock_settime.

In the interface level, 32bit timespec is replaced by old_timespec32
followed the solution of vanilla kernel 5.4.

In addition, a new interface clock_settime64 is implemented specific
for 64bit timespec.

In the libcobalt, clock_settime dispatches syscall regarding the size
of time_t.

As a result, processes passing 32bit timespec goes to original clock_settime,
but the time will wrap around at 2038. processes passing 64bit timespec
goes to clock_settime64, 2038-safe.

chensong (5):
  [y2038]wrappers:introduce old_timespec32
  cobalt/kernel: introduce old_timespec32 to clock_settime
  kernel/cobalt: introduct clock_settime64
  kernel/cobalt/posix/syscall32:introduce old_timespec32 and
    __kernel_timespec to clock_settime of syscall32
  lib/cobalt/clock.c:dispatch clock_settime

 include/cobalt/kernel/clock.h                      |  6 ++---
 include/cobalt/kernel/compat.h                     |  6 +++++
 include/cobalt/uapi/syscall.h                      |  1 +
 .../cobalt/include/asm-generic/xenomai/wrappers.h  | 17 ++++++++++++
 kernel/cobalt/posix/clock.c                        | 30 ++++++++++++++++++----
 kernel/cobalt/posix/clock.h                        | 19 ++++++++++++--
 kernel/cobalt/posix/compat.c                       | 20 +++++++++++++++
 kernel/cobalt/posix/syscall32.c                    | 20 ++++++++++++---
 kernel/cobalt/posix/syscall32.h                    |  6 ++++-
 kernel/cobalt/trace/cobalt-posix.h                 | 24 +++++++++++++++--
 lib/cobalt/clock.c                                 |  6 ++++-
 11 files changed, 138 insertions(+), 17 deletions(-)

-- 
2.7.4




