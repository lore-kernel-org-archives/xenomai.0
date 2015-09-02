MIME-Version: 1.0
Date: Wed, 2 Sep 2015 14:24:14 -0700
Message-ID: <CAJqUr7wt0=bOLsmOTZ9PP-VtywnWGgmAOX0fkexPsP=pZ03aVg@mail.gmail.com>
From: Don Mahurin <don@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [pull request] ipipe/ipipe-3.14.44-arm64, function tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Pull request for ipipe/ipipe-3.14.44-arm64, adding arm64 function tracing
(cherry-picked from 3.18), required for ipipe tracing functionality.


The following changes since commit 5711ae4e759acefd98f16f086029fbdbc8a3673e:

  ipipe/arm64: move local_async_enable out of ifdef IPIPE (2015-08-19
12:40:51 -0700)

are available in the git repository at:

  http://gitlab.mperpetuo.com/it/ipipe.git
ipipe-3.14.44-arm64-function-tracer

for you to fetch changes up to c35175ea8254e4e0306386aa143a9f4e896e0f47:

  arm64: Add ftrace support (2015-09-02 13:27:12 -0700)

----------------------------------------------------------------
AKASHI Takahiro (3):
      ftrace: Add arm64 support to recordmcount
      arm64: add __ASSEMBLY__ in asm/insn.h
      arm64: Add ftrace support

 arch/arm64/Kconfig               |   4 +
 arch/arm64/include/asm/ftrace.h  |  23 +++++
 arch/arm64/include/asm/insn.h    |   2 +
 arch/arm64/kernel/Makefile       |   4 +
 arch/arm64/kernel/arm64ksyms.c   |   4 +
 arch/arm64/kernel/entry-ftrace.S | 175
+++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c       |  64 ++++++++++++++
 scripts/recordmcount.c           |   7 ++
 scripts/recordmcount.pl          |   5 ++
 9 files changed, 288 insertions(+)
 create mode 100644 arch/arm64/include/asm/ftrace.h
 create mode 100644 arch/arm64/kernel/entry-ftrace.S
 create mode 100644 arch/arm64/kernel/ftrace.c
