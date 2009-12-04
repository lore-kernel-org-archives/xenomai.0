Message-ID: <4B1990E9.2040608@domain.hid>
Date: Fri, 04 Dec 2009 23:44:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] signals handling and posix fixes.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit 4f42de74f9b9a1d29093ba695e5ae0ff4a66a132:
  Philippe Gerum (1):
        x86: upgrade I-pipe support to 2.6.31.1-x86-2.4-07

are available in the git repository at:

  git+ssh://git.xenomai.org/xenomai-gch.git for-head

Gilles Chanteperdrix (2):
      signals: reduce signals handling memory footprint
      posix: cosmetic cleanup of pthread_cond_*wait

Peter Soetens (1):
      posix: Fix __wrap_select() when timeout happens.

 include/asm-arm/syscall.h      |    9 +---
 include/asm-blackfin/syscall.h |    8 +---
 include/asm-generic/syscall.h  |   18 ++++----
 include/asm-nios2/syscall.h    |    8 +---
 include/asm-powerpc/syscall.h  |    9 +---
 include/asm-x86/syscall.h      |   93 ++++++++++++++++++---------------------
 src/skins/common/bind.c        |   38 ++++++++++++++++
 src/skins/posix/cond.c         |   26 +++++------
 src/skins/posix/select.c       |    2 +-
 9 files changed, 110 insertions(+), 101 deletions(-)


-- 
					    Gilles.

