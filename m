From: Henning Schild <henning.schild@siemens.com>
Date: Mon, 27 Aug 2018 15:28:04 +0200
Message-Id: <cover.1535375976.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 0/3] Eager FPU support for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

These patches incementally add eager fpu support for the 4.9/4.4 and
finally the 4.14 kernel. For a final round they can probably be
squashed. If they are not, some changes from the 4.14 one should go into
the first one.

I will post the corresponding 4.9.y patch against the kernel as well.

Both 4.9 and 4.4 are tested, 4.14 not yet.

Henning Schild (3):
  cobalt/x86: add support for eager fpu handling
  cobalt/x86: add ipipe-4.4 eager fpu support
  cobalt/x86: add ipipe-4.14 eager fpu support

 .../cobalt/arch/x86/include/asm/xenomai/thread.h   |  8 +-
 .../cobalt/arch/x86/include/asm/xenomai/wrappers.h | 16 ++++
 kernel/cobalt/arch/x86/thread.c                    | 85 ++++++++++++++++++++--
 .../cobalt/include/asm-generic/xenomai/syscall.h   |  4 +
 4 files changed, 107 insertions(+), 6 deletions(-)

-- 
2.16.4


