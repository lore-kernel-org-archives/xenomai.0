Message-ID: <53B7C349.4020906@xenomai.org>
Date: Sat, 05 Jul 2014 11:20:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [GIT PULL] fixes for ipipe 3.10
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

The following changes since commit 4514baaee4bae1a2e2d1814532f2649b92fb60b1:

  ipipe: fix recursive trace locking (2014-06-25 12:05:48 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.10

for you to fetch changes up to ac15b301b34357b37f41455ae160c6054d6174e2:

  ipipe/genpatches.sh: move the 8250 serial debug to the noarch section (2014-07-05 11:18:01 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (3):
      arm/ipipe: fix compilation error when compiling only for imx6
      arm/ipipe: fix syscall restart
      ipipe/genpatches.sh: move the 8250 serial debug to the noarch section

 arch/arm/kernel/entry-common.S |    2 +-
 drivers/gpio/gpio-mxc.c        |    2 ++
 scripts/ipipe/genpatches.sh    |   20 ++++++++++----------
 3 files changed, 13 insertions(+), 11 deletions(-)

-- 
                                                                Gilles.

