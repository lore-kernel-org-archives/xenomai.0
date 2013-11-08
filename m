From: gernot.hillier@siemens.com
Date: Fri,  8 Nov 2013 10:34:16 +0100
Message-Id: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
Subject: [Xenomai] [Xenomai-forge PATCH 0/7] Merging debian/* into -forge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gernot Hillier <gernot.hillier@siemens.com>

Hi there!

As recently discussed ("merging debian/* from xenomai-2"), this series
cherry-picks all missing debian/* commits from Xenomai 2.6 into -forge. The
last patch provides a basically working build for Xenomai 2.99 packages.

Thanks in advance!

Gernot Hillier (2):
  debian: cleanup configure invocation
  debian: Prepare packaging for Xenomai-forge based on Xenomai-2.6
    Debian rules

Gilles Chanteperdrix (3):
  debian: adapt to latest I-pipe core patches     (cherry picked from
    commit 89ff2edf76dae49e4a3643f17e118954b68a692e)
  debian: remove now useless configure options     (cherry picked from
    commit c581878158605578792f88ced09f02ad34c092de)
  debian: rework

Jeff Webb (1):
  debian: add missing directory creation     (cherry picked from commit
    2de3997cf4a98fcd43b5d8a246aa6abe15135eca)

Roland Stigge (1):
  Updated debian/*     (cherry picked from commit
    2a229690dffa48bf6eea995280815ac828c0f126)

 debian/changelog                           | 18 +++++++++
 debian/compat                              |  2 +-
 debian/control                             | 32 +++++++--------
 debian/libxenomai-dev.install              |  1 -
 debian/linux-patch-xenomai.README.Debian   | 17 --------
 debian/linux-patch-xenomai.kpatches.in     |  3 --
 debian/rules                               | 65 ++++++++----------------------
 debian/xenomai-kernel-source.README.Debian | 20 +++++++++
 debian/xenomai-runtime.install             |  1 -
 scripts/bootstrap                          |  2 +-
 scripts/wrap-link.sh                       |  4 ++
 11 files changed, 76 insertions(+), 89 deletions(-)
 delete mode 100644 debian/linux-patch-xenomai.README.Debian
 delete mode 100644 debian/linux-patch-xenomai.kpatches.in
 create mode 100644 debian/xenomai-kernel-source.README.Debian

-- 
1.8.1.2


