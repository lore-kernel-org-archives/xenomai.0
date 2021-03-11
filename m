From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 0/4] [y2038] clock_settime for timespec64
Date: Thu, 11 Mar 2021 10:45:38 +0800
Message-Id: <1615430738-23692-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

This patch serial is aimed to introduce a new syscall clock_settime64,
which is specific for 64-bit time_t.

There is no impact to current implemetation of clock_settime, nothing
broken.

chensong (4):
  include: wrappers: introduce old_timespec32 and __kernel_timespec
  [y2038]cobalt: posix: clock: Adding clock_settime64
  [y2038]cobalt: posix: syscall32: Adding compat clock_settime64
  [y2038] lib: cobalt: clock: dispatch clock_settime

 include/cobalt/uapi/syscall.h                        |  1 +
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 17 +++++++++++++++++
 kernel/cobalt/posix/clock.c                          | 12 ++++++++++++
 kernel/cobalt/posix/clock.h                          |  4 ++++
 kernel/cobalt/posix/syscall32.c                      | 13 +++++++++++++
 kernel/cobalt/posix/syscall32.h                      |  4 ++++
 lib/cobalt/clock.c                                   |  6 ++++++
 7 files changed, 57 insertions(+)

-- 
2.7.4




