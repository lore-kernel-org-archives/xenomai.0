From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 0/3] Fix Xenomai next build, update Isar,
 improve docs
Date: Fri, 23 Nov 2018 14:54:27 +0100
Message-Id: <cover.1542981269.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

See patches for details.

Jan Kiszka (3):
  xenomai: Remove patches
  Update to latest Isar next
  Improve README, add COPYING

 COPYING                                            | 17 +++++++++
 README.md                                          | 21 ++++++++++-
 conf/layer.conf                                    |  2 +
 ...m-Update-isar-apt-prior-to-installing-bui.patch | 38 -------------------
 kas.yml                                            |  6 +--
 recipes-kernel/linux/linux-xenomai.inc             |  2 +-
 ...dd-config-folder-to-xenomai-kernel-source.patch | 28 --------------
 ...2-debian-Add-arm64-as-target-architecture.patch | 44 ----------------------
 ...03-debian-Enable-SMP-in-userspace-package.patch | 30 ---------------
 recipes-xenomai/xenomai/xenomai_next.bb            |  8 ++--
 10 files changed, 43 insertions(+), 153 deletions(-)
 create mode 100644 COPYING
 delete mode 100644 isar-patches/0001-linux-custom-Update-isar-apt-prior-to-installing-bui.patch
 delete mode 100644 recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
 delete mode 100644 recipes-xenomai/xenomai/files/0002-debian-Add-arm64-as-target-architecture.patch
 delete mode 100644 recipes-xenomai/xenomai/files/0003-debian-Enable-SMP-in-userspace-package.patch

-- 
2.16.4


