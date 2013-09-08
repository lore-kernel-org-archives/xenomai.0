Message-ID: <522CA8C2.1050203@xenomai.org>
Date: Sun, 08 Sep 2013 18:41:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe 3.8 pull request
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

The following changes since commit 54e4874873e9bc6c65c30ee36ac0278020ad4854:

  ipipe: pass migration data along with SETAFFINITY event (2013-08-21 19:02:42 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch for-ipipe-3.8

for you to fetch changes up to 28338cbab9b051f79cfb92490d9dd25db885df30:

  arm/ipipe: fix compilation without Xenomai patch (2013-09-08 18:19:09 +0200)

----------------------------------------------------------------
Charles Steinkuehler (1):
      scripts/ipipe: make genpatches.sh more portable

Gilles Chanteperdrix (2):
      arm/ipipe: fix ARMv4/v5 mm switch without CONFIG_IPIPE
      arm/ipipe: fix compilation without Xenomai patch

 arch/arm/Kconfig                   |    5 +++++
 arch/arm/include/asm/mmu_context.h |    8 ++++++--
 scripts/ipipe/genpatches.sh        |   16 ++++++++++------
 3 files changed, 21 insertions(+), 8 deletions(-)

-- 
                                                                Gilles.

