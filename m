Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 0/3] [florian/y2038] recvmmsg for timespec64
Date: Tue,  7 Sep 2021 15:06:12 +0800
Message-Id: <1630998372-19271-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

This patch serial is to introdule a new sycall recvmmsg64 to support
64-bit time_t.

All the test cases have been tested and passed and resource is cleaned
up before leaving.

At beginning, i tried to initialize socket like this way:
	socket(AF_UNIX, SOCK_STREAM, 0);

However, it returns immediately in __rtdm_fd_recvmmsg, couldn't
get valid value from rtdm_fd_get.

I'm not familiar with this part, i guess it's supported in GPOS
instead of xenomai, then i turned to IPCPROTO_XDDP, it works. Any
suggestion about this part is welcomed.


Song Chen (3):
  y2038: cobalt/posix/io: Adding recvmmsg64
  y2038: lib/cobalt/rtdm: dispatch recvmmg
  y2038: testsuite/smokey/y2038: testcase for recvmmsg64

 include/cobalt/uapi/syscall.h          |   1 +
 kernel/cobalt/posix/io.c               |  15 ++++
 kernel/cobalt/posix/io.h               |   5 ++
 kernel/cobalt/posix/syscall32.c        |  16 ++++
 kernel/cobalt/posix/syscall32.h        |   6 ++
 kernel/cobalt/rtdm/fd.c                |   2 +-
 lib/cobalt/rtdm.c                      |   5 ++
 testsuite/smokey/y2038/syscall-tests.c | 135 +++++++++++++++++++++++++++++++++
 8 files changed, 184 insertions(+), 1 deletion(-)

-- 
2.7.4


