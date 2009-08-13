Message-ID: <4A8488F5.8050208@domain.hid>
Date: Thu, 13 Aug 2009 23:43:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pull requests.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 16d8b1f9a8158b73cee30084592aacf19d94fbe6:
  Philippe Gerum (1):
        nucleus: postpone sanity check to allow for signal receipt

are available in the git repository at:

  git+ssh://git@domain.hid for-2.4

Gilles Chanteperdrix (1):
      arm: fix syscalls with gcc 4.3.2

 include/asm-arm/syscall.h |   30 +++++++++++++++++++++---------
 src/skins/posix/thread.c  |    4 +++-
 2 files changed, 24 insertions(+), 10 deletions(-)


------------------------------------------------------------------------------


The following changes since commit 8256c8a538ce3aee42ccdded4bbe50a83dbeca2c:
  Philippe Gerum (1):
        sim: provide irqs_disabled_hw()

are available in the git repository at:

  git+ssh://git@domain.hid for-head

Gilles Chanteperdrix (4):
      native: increase user-space native skin default stack size.
      build: Do not compile with __thread by default on ARM
      arm: fix syscalls with gcc 4.3.2
      testsuite: fix division routines unit test feature macro test (for nodiv_llimd).

 configure.in                        |    5 +++--
 include/asm-arm/syscall.h           |   30 +++++++++++++++++++++---------
 src/skins/native/task.c             |    2 ++
 src/skins/posix/thread.c            |    4 +++-
 src/testsuite/unit/arith-noinline.c |    2 +-
 src/testsuite/unit/arith.c          |   14 +++++++-------
 6 files changed, 37 insertions(+), 20 deletions(-)


-- 
					    Gilles.

