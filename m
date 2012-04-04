Message-ID: <4F7C44FD.2040406@domain.hid>
Date: Wed, 04 Apr 2012 14:56:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL] rt-puts fix, mprotect testsuite
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 0ef2410a2c9cf7102dead861241bd2d9957e4433:

  Mask signals in rt_print:printer_loop() (2012-04-02 00:16:41 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (3):
      Append missing newline to rt_[f]puts output
      testsuite: Add rt-print buffer flushes to native error paths
      Add regression test for mprotect on pinned memory

 src/skins/common/rt_print.c                |    7 ++-
 src/testsuite/regression/native/check.h    |    2 +
 src/testsuite/regression/native/leaks.c    |    1 +
 src/testsuite/regression/posix/Makefile.am |    2 +-
 src/testsuite/regression/posix/Makefile.in |   15 ++++-
 src/testsuite/regression/posix/check.h     |   10 +++
 src/testsuite/regression/posix/mprotect.c  |   97 ++++++++++++++++++++++++++++
 7 files changed, 129 insertions(+), 5 deletions(-)
 create mode 100644 src/testsuite/regression/posix/mprotect.c

