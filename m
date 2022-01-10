From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 0/3] Add kernel 5.15, update Isar
Date: Mon, 10 Jan 2022 18:32:16 +0100
Message-ID: <cover.1641835939.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Remaining patches to add 5.15 recipes and enable this kernel for
xenomai-next builds in CI. Also comes with an Isar update, bringing
ccache acceleration for local rebuilds.

Jan

Jan Kiszka (3):
  linux-xenomai: Add support for 5.15 kernel
  ci: Add kernel 5.15
  Update Isar revision, enabling ccache

 Kconfig                                      | 10 +++
 ci/kernel_5_15.yml                           | 82 ++++++++++++++++++++
 ci/xenomai_next.yml                          |  1 +
 conf/distro/include/xenomai-version.inc      | 14 +++-
 conf/machine/beagle-bone-black.conf          |  2 +-
 conf/machine/hikey.conf                      |  2 +-
 conf/machine/qemu-machine.inc                |  2 +-
 conf/machine/x86-64-efi.conf                 |  2 +-
 kas.yml                                      |  4 +-
 opt-ci.yml                                   |  4 +-
 opt-linux-5.15.yml                           | 17 ++++
 opt-linux-latest-5.15.yml                    | 18 +++++
 recipes-kernel/linux/files/armhf_defconfig   |  1 +
 recipes-kernel/linux/linux-xenomai_5.15.bb   | 18 +++++
 recipes-kernel/linux/linux-xenomai_latest.bb |  9 ++-
 15 files changed, 172 insertions(+), 14 deletions(-)
 create mode 100644 ci/kernel_5_15.yml
 create mode 100644 opt-linux-5.15.yml
 create mode 100644 opt-linux-latest-5.15.yml
 create mode 100644 recipes-kernel/linux/linux-xenomai_5.15.bb

-- 
2.31.1


