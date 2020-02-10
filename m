From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 00/10] Updates,
 improved support for building latest revisions
Date: Mon, 10 Feb 2020 19:17:39 +0100
Message-Id: <cover.1581358669.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This is part I which should make us ready for 3.1. What is missing are
a number of CI test enhancements and cleanups that Quirin is working on.
Will come on top.

Jan


CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Jan Kiszka (9):
  Update Isar revision
  xenomai: Update to 3.0.10
  Switch to Xenomai 3.1
  Switch Xenomai 3.0 to kernel 4.4
  Provide Xenomai 3.0.x target
  xenomai: Consolidate master and next recipes
  linux-xenomai: Enable latest 4.4 build with Xenomai 3.0
  linux-xenomai: Update to ipipe-core-4.19.94-cip18-x86-10
  Switch to github as source explicitly

Quirin Gylstorff (1):
  recipes-kernel/linux: add exception handling

 conf/distro/include/xenomai-version.inc            |  12 +-
 conf/distro/xenomai-demo.conf                      |   2 +
 conf/machine/hikey.conf                            |   1 -
 conf/machine/qemu-arm64.conf                       |   1 -
 kas.yml                                            |  13 +-
 opt-linux-latest.yml                               |   5 +-
 opt-xenomai-3.0.x.yml                              |  17 ++
 opt-xenomai-next.yml                               |   3 -
 ...nel-linux-build-kernel-Allow-kernel-build.patch | 173 ---------------------
 recipes-kernel/linux/linux-xenomai.inc             |   9 +-
 recipes-kernel/linux/linux-xenomai_4.14.bb         |   6 +-
 recipes-kernel/linux/linux-xenomai_4.19.bb         |  11 +-
 recipes-kernel/linux/linux-xenomai_4.4.bb          |  20 +++
 recipes-kernel/linux/linux-xenomai_latest.bb       |  25 ++-
 .../{xenomai_3.0.9.bb => xenomai_3.0.10.bb}        |   2 +-
 .../xenomai/{xenomai_next.bb => xenomai_3.1.bb}    |   8 +-
 recipes-xenomai/xenomai/xenomai_master.bb          |   8 +-
 recipes-xenomai/xenomai/xenomai_next.bb            |  22 +--
 .../{xenomai_stable.bb => xenomai_stable-3.0.x.bb} |   7 +-
 19 files changed, 93 insertions(+), 252 deletions(-)
 create mode 100644 opt-xenomai-3.0.x.yml
 delete mode 100644 patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
 create mode 100644 recipes-kernel/linux/linux-xenomai_4.4.bb
 rename recipes-xenomai/xenomai/{xenomai_3.0.9.bb => xenomai_3.0.10.bb} (79%)
 copy recipes-xenomai/xenomai/{xenomai_next.bb => xenomai_3.1.bb} (55%)
 mode change 100644 => 120000 recipes-xenomai/xenomai/xenomai_next.bb
 rename recipes-xenomai/xenomai/{xenomai_stable.bb => xenomai_stable-3.0.x.bb} (56%)

-- 
2.16.4


