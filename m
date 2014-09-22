Message-ID: <5420A0EC.9080501@xenomai.org>
Date: Tue, 23 Sep 2014 00:21:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe 3.8 pull request
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

The following changes since commit cceb73f645d139a3ad15c7ddcd371ef408b37cf5:

  Merge remote-tracking branch 'gilles/ipipe-3.8' into ipipe-3.8 (2014-04-01 10:23:21 +0200)

are available in the git repository at:


  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.8

for you to fetch changes up to b932bbfdc2bb7d3d9f3a46194e788f601b1a9e26:

  ipipe-core-3.8.13-arm-4 (2014-09-23 00:15:41 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (4):
      arm/ipipe: fix ipipe_syscall_root with mayday and EABI
      arm/ipipe: fix syscall restarting
      arm/fcse: avoid compilation error without FCSE
      ipipe-core-3.8.13-arm-4

 arch/arm/include/asm/fcse.h    |   12 ++++----
 arch/arm/include/asm/ipipe.h   |    8 ++---
 arch/arm/kernel/entry-common.S |    2 +-
 arch/arm/kernel/ipipe.c        |   69 ++++++++++++++++++++++++++++++-------------
 4 files changed, 59 insertions(+), 32 deletions(-)

-- 
                                                                Gilles.

