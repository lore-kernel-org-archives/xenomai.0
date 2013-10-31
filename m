Message-ID: <527299C3.40408@siemens.com>
Date: Thu, 31 Oct 2013 18:56:19 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] forge: Bug fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 0e70b34a2d95bce15257ee7bf201cf8ab52d2fa8:

  lib/alchemy: use common name generator (2013-10-23 15:44:12 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-forge

for you to fetch changes up to 6bc323f2596d72b0a64fdd439bfb57966c519431:

  kernel/cobalt/intr: Fix deadlock of xnintr_attach (2013-10-31 18:13:12 +0100)

----------------------------------------------------------------
Jan Kiszka (2):
      kernel/x86: Remove bogus test for x86-32 around xsave assembly
      kernel/cobalt/intr: Fix deadlock of xnintr_attach

 kernel/cobalt/arch/x86/thread.c | 4 ++--
 kernel/cobalt/intr.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

