Message-ID: <4B19A7F5.80708@domain.hid>
Date: Sat, 05 Dec 2009 01:23:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] assorted backports for the 2.4 branch.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit 0b6b63885e91bd18c0aa31c935a0a1a5d44ef152:
  Philippe Gerum (1):
        blackfin: fix all syscall templates

are available in the git repository at:

  git+ssh://git.xenomai.org/xenomai-gch.git for-2.4

Gilles Chanteperdrix (5):
      posix: fix pthread_cond_wait syscall signals handling
      posix: fix __wrap_pthread_cond_wait for better handling of signals and error conditions
      posix: mark nanosleep as non restartable
      nucleus: defer selector block deletion to an APC.
      native: increase user-space native skin default stack size.

Peter Soetens (2):
      nucleus: move posix selector in nucleus for every skin to use.
      posix: Fix __wrap_select() when timeout happens.

 include/nucleus/select.h   |    5 +++
 include/nucleus/thread.h   |    4 +++
 ksrc/nucleus/module.c      |   19 +++++++++++--
 ksrc/nucleus/pod.c         |    8 +++++
 ksrc/nucleus/select.c      |   64 ++++++++++++++++++++++++++++++++++++-------
 ksrc/nucleus/shadow.c      |    2 +-
 ksrc/nucleus/thread.c      |    3 ++
 ksrc/skins/posix/syscall.c |   21 +++-----------
 ksrc/skins/posix/thread.c  |    7 -----
 ksrc/skins/posix/thread.h  |    4 ---
 src/skins/native/task.c    |    2 +
 src/skins/posix/cond.c     |   31 ++++++++++++++++-----
 src/skins/posix/select.c   |    2 +-
 13 files changed, 121 insertions(+), 51 deletions(-)

-- 
					    Gilles.

