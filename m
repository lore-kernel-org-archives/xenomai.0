From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 0/3] Cleanups & qemu-armhf target addition
Date: Mon, 26 Nov 2018 16:08:22 +0100
Message-Id: <cover.1543244905.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Mostly brings the qemu-armhf target. See patches for other details.

Jan

Jan Kiszka (3):
  customizations: Remove obsolete cleanup and chown
  linux-xenomai: Fix arm64 SRC_URI
  Add qemu-armhf target

 .../files/ethernet => board-qemu-armhf.yml         |   11 +-
 .../files/ethernet => conf/machine/qemu-armhf.conf |    9 +-
 .../multiconfig/qemu-armhf-xenomai-demo.conf       |    9 +-
 recipes-core/customizations/customizations.bb      |    4 -
 recipes-core/customizations/files/ethernet         |    2 +-
 recipes-kernel/linux/files/armhf_defconfig         | 7248 ++++++++++++++++++++
 recipes-kernel/linux/linux-xenomai_4.14.bb         |    6 +-
 start-qemu.sh                                      |   14 +
 8 files changed, 7276 insertions(+), 27 deletions(-)
 copy recipes-core/customizations/files/ethernet => board-qemu-armhf.yml (54%)
 copy recipes-core/customizations/files/ethernet => conf/machine/qemu-armhf.conf (54%)
 copy recipes-core/customizations/files/ethernet => conf/multiconfig/qemu-armhf-xenomai-demo.conf (54%)
 create mode 100644 recipes-kernel/linux/files/armhf_defconfig

-- 
2.16.4


