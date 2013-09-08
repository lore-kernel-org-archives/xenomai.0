Message-ID: <522CA861.70404@xenomai.org>
Date: Sun, 08 Sep 2013 18:40:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe-3.5.7 pull request
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


The following changes since commit 6627539a5ab006054d83fa89bcf026470fe36750:

  ipipe: pass migration data along with SETAFFINITY event (2013-08-21 19:26:57 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch for-ipipe-3.5.7

for you to fetch changes up to 881c6bdc04d3d48f0818db3cec4da9a1c7f1ba75:

  arm/ipipe: fix compilation without Xenomai patch (2013-09-08 18:33:36 +0200)

----------------------------------------------------------------
Charles Steinkuehler (1):
      scripts/ipipe: make genpatches.sh more portable

Gilles Chanteperdrix (3):
      scripts/ipipe: update patch generation script
      arm/ipipe: fix ARMv4/v5 mm switch without CONFIG_IPIPE
      arm/ipipe: fix compilation without Xenomai patch

 arch/arm/Kconfig                   |    5 +++
 arch/arm/include/asm/mmu_context.h |    8 +++-
 scripts/ipipe/genpatches.sh        |   86 +++++++++++++++++++++++----------------
 3 files changed, 62 insertions(+), 37 deletions(-)


-- 
                                                                Gilles.

