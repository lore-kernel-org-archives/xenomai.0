From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 0/2] Add support for x86(32bit) 
Date: Fri, 14 Feb 2020 09:38:17 +0100
Message-Id: <20200214083819.31451-1-Quirin.Gylstorff@siemens.com>
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

Add missing entry for x86 32 build. Allow overwrite of derived
isar layers. Patch is send upstream to isar.

Quirin Gylstorff (2):
  recipes-kernel/linux-xenomai: Add support for DISTRO_ARCH i386
  recipes-kernel/linux: Allow overwrite of KERNEL_DEFCONFIG

 kas.yml                                       |  4 +++
 ...inux-Weak-KERNEL_DEFCONFIG-to-allow-.patch | 29 +++++++++++++++++++
 recipes-kernel/linux/linux-xenomai.inc        |  4 +--
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 patches/0001-recipes-kernel-linux-Weak-KERNEL_DEFCONFIG-to-allow-.patch

-- 
2.20.1


