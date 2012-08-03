Message-ID: <501BDC7D.3@antcom.de>
Date: Fri, 03 Aug 2012 16:13:17 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [GIT PULL] Updates from Debian
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

as promised, I'm providing updates of debian/* files (see pull request below).
It deviates a bit from what I just uploaded as Debian's xenomai 2.6.1-1 since
at xenomai.org, we maintain a "native" Debian package (2.6.1).

There is also an adjustment to scripts/prepare-patch.sh, fixing a Debian
specific issue (obsolete dh-kpatches).

The tree is based on git://git.xenomai.org/xenomai-head.git

Also, feel free to compare to the Debian patches provided as a tarball at

http://packages.qa.debian.org/x/xenomai.html

(See below right on this webpage, "patch tracker" - the "experimental"
patches for 2.6.1-1 should appear soon.)

Thanks,

Roland



The following changes since commit b6d3eb52335850e42bfcf9390194ac5a3e29f8b2:

  hal: pass to ipipe_timer_set a delay in hrclock ticks (2012-08-03 00:51:49 +0200)

are available in the git repository at:

  git://git.antcom.de/xenomai.git debian

for you to fetch changes up to 4725c6c8680c7b9337b791eb82f75ffd3c1bfbe5:

  Removal of dh-kpatches support (2012-08-03 15:40:21 +0200)

----------------------------------------------------------------
Roland Stigge (2):
      Updated debian/*
      Removal of dh-kpatches support

 debian/changelog                         |    6 ++++++
 debian/compat                            |    2 +-
 debian/control                           |    6 +++---
 debian/linux-patch-xenomai.README.Debian |    4 +++-
 debian/linux-patch-xenomai.kpatches.in   |    3 ---
 debian/rules                             |   33 +++++++++++++++++----------------
 debian/xenomai-runtime.install           |    1 -
 scripts/prepare-patch.sh                 |   19 -------------------
 8 files changed, 30 insertions(+), 44 deletions(-)
 delete mode 100644 debian/linux-patch-xenomai.kpatches.in


