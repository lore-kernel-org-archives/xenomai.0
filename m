From: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Date: Thu, 18 Jan 2018 01:33:18 +0000
Message-Id: <1516239201-24251-1-git-send-email-dmitriy@oss-tech.org>
Subject: [Xenomai] [PATCH 0/3] Update Xenomai for Linux 4.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch set updates Xenomai for compatibility with the 4.14 kernel.

Dmitriy Cherkasov (3):
  cobalt/kernel: make signal code handling compatible with 4.14
  cobalt/kernel: remove usage of GFP_TEMPORARY
  cobalt/kernel: add missing header for 4.14 compatibility

 kernel/cobalt/debug.c                               | 2 +-
 kernel/cobalt/include/asm-generic/xenomai/syscall.h | 1 +
 kernel/cobalt/posix/process.c                       | 2 +-
 kernel/cobalt/posix/signal.c                        | 4 +++-
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.14.3


