From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/3] y2038: Fixes for compat mode
Date: Mon, 21 Feb 2022 14:25:01 +0100
Message-Id: <20220221132504.55876-1-florian.bezdeka@siemens.com>
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
Cc: jan.kiszka@siemens.com, johannes.lauenstein@siemens.com, Florian Bezdeka <florian.bezdeka@siemens.com>

I started testing the compat mode on a Ubuntu based system with glibc
2.34 which supports switching to 64 bit based time_t. These are the fixes
for problems observed while testing the kernel / cobalt part.

More tests, especially for the libcobalt part will be necessary,
especially because the way how glibc implemented the switch to 64 bit
time_t affects the function wrapping we use.

Best regards,
Florian

Florian Bezdeka (3):
  y2038: posix/mqueue: Fix compat case for mq_timedreceive64
  y2038: cobalt: rtdm/fd: Take care of compat mode for recvmmsg64
  y2038: cobalt: posix/signal: Take care of compat mode for
    sigtimedwait64

 .../x86/include/asm/xenomai/syscall32-table.h |  3 +++
 kernel/cobalt/posix/mqueue.c                  | 26 +++++++++----------
 kernel/cobalt/posix/mqueue.h                  |  2 +-
 kernel/cobalt/posix/syscall32.c               | 17 ++++++++++--
 kernel/cobalt/posix/syscall32.h               |  3 ++-
 5 files changed, 34 insertions(+), 17 deletions(-)

-- 
2.35.1


