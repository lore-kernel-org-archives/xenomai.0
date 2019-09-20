From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/3] Latest Kernel
Date: Fri, 20 Sep 2019 16:57:28 +0200
Message-Id: <20190920145731.25281-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This set updates isar and adds the feature to build the latest
available linux kernel with a selected xenomai version.

There some whitespace errors due to patch in patch.

Quirin Gylstorff (3):
  linux-4.19: Use SRCREV instead of branches or tags in SRC_URI
  kas: update isar
  ci: Add the option to build the latest kernel

 .gitlab-ci.yml                                |  13 +-
 kas.yml                                       |   6 +-
 opt-linux-latest.yml                          |  20 ++
 opt-latest.yml => opt-xenomai-next.yml        |   0
 ...inux-build-kernel-Allow-kernel-build.patch | 173 ++++++++++++++++++
 recipes-core/images/demo-image.bb             |   2 +-
 recipes-kernel/linux/linux-xenomai_4.19.bb    |  16 +-
 recipes-kernel/linux/linux-xenomai_latest.bb  |  24 +++
 8 files changed, 239 insertions(+), 15 deletions(-)
 create mode 100644 opt-linux-latest.yml
 rename opt-latest.yml => opt-xenomai-next.yml (100%)
 create mode 100644 patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
 create mode 100644 recipes-kernel/linux/linux-xenomai_latest.bb

-- 
2.20.1


