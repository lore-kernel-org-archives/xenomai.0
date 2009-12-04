Message-ID: <4B19963E.9080902@domain.hid>
Date: Sat, 05 Dec 2009 00:07:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1990E9.2040608@domain.hid>
In-Reply-To: <4B1990E9.2040608@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] signals handling and posix fixes.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Sorry, found a new issue. Here is the pull request with this latest fix. 

The following changes since commit 4f42de74f9b9a1d29093ba695e5ae0ff4a66a132:
  Philippe Gerum (1):
        x86: upgrade I-pipe support to 2.6.31.1-x86-2.4-07

are available in the git repository at:

  git+ssh://git.xenomai.org/xenomai-gch.git for-head

Gilles Chanteperdrix (3):
      signals: reduce signals handling memory footprint
      posix: cosmetic cleanup of pthread_cond_*wait
      posix: revert commit 58c1b922a96fedaef110c925a0dddb0e86dbcaf4

Peter Soetens (1):
      posix: Fix __wrap_select() when timeout happens.

 include/asm-arm/syscall.h      |    9 +---
 include/asm-blackfin/syscall.h |    8 +---
 include/asm-generic/syscall.h  |   18 ++++----
 include/asm-nios2/syscall.h    |    8 +---
 include/asm-powerpc/syscall.h  |    9 +---
 include/asm-x86/syscall.h      |   93 ++++++++++++++++++---------------------
 src/skins/common/bind.c        |   38 ++++++++++++++++
 src/skins/posix/select.c       |    2 +-
 8 files changed, 99 insertions(+), 86 deletions(-)


-- 
					    Gilles.

