Message-ID: <52384CC3.80904@siemens.com>
Date: Tue, 17 Sep 2013 14:36:19 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL 3.8] x86/ipipe: Fix x86-64 issue when debugging
	applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 6c40e8586e309608579f4baa0b7b5252d061686a:

  arm/fcse: avoid compilation warning in guaranteed mode (2013-09-08 22:45:39 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/3.8

for you to fetch changes up to c0bd1a464ad22c588bc09591f26d6b2b122f82b0:

  x86/ipipe: Remove changes from paranoidzeroentry_ist (2013-09-17 13:19:57 +0200)

----------------------------------------------------------------
Jan Kiszka (3):
      x86/ipipe: Switch off debug stack under I-pipe
      x86/ipipe: Call __ipipe_notify_trap directly from ipipe code
      x86/ipipe: Remove changes from paranoidzeroentry_ist

 arch/x86/include/asm/debugreg.h |  2 +-
 arch/x86/kernel/cpu/common.c    |  2 ++
 arch/x86/kernel/entry_64.S      | 22 ++++++----------------
 arch/x86/kernel/ipipe.c         |  4 ++--
 arch/x86/kernel/traps.c         |  5 +++++
 5 files changed, 16 insertions(+), 19 deletions(-)

