Message-ID: <52380AAA.1000303@siemens.com>
Date: Tue, 17 Sep 2013 09:54:18 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] x86/ipipe: Fix x86-64 issue when debugging
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

The following changes since commit 08c8af2d33a9d61c565b472cb770ff34a3d974d8:

  powerpc/ipipe: 3.10 merge fixup (2013-09-10 10:14:24 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/master

for you to fetch changes up to 146b3f5b23407689b58b8bbe5d194600334f35e5:

  x86/ipipe: Remove changes from paranoidzeroentry_ist (2013-09-16 18:36:34 +0200)

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

