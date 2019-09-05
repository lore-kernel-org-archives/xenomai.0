From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/9] LAVA Setup
Date: Thu,  5 Sep 2019 17:44:16 +0200
Message-Id: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
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

This patchset adapts xenomai-images for the execution of tests
on  Linaro Automated Validation Architecture. 

Quirin Gylstorff (9):
  ci: Add LAVA jobs for targets
  machine: Allow override of the image type
  linux-xenomai: NFS support in KERNEL configuration
  beagle-bone-black: Add Devicetree and fake-hwclock
  kas: Use next as target
  ci: Add inline xenomai testsuite
  README: correct build line
  kernel: Update
  tests/README: Add deployment and Setup

 .gitlab-ci.yml                             | 58 +++++++++++--
 README.md                                  |  2 +-
 conf/machine/beagle-bone-black.conf        |  3 +-
 conf/machine/hikey.conf                    |  4 +-
 conf/machine/qemu-arm64.conf               |  1 -
 conf/machine/x86-64-efi.conf               |  2 +-
 kas.yml                                    |  2 +-
 recipes-core/images/demo-image.bb          |  2 +-
 recipes-kernel/linux/files/amd64_defconfig | 29 +++++--
 recipes-kernel/linux/linux-xenomai_4.19.bb | 12 ++-
 scripts/deploy_for_testing.sh              | 34 ++++++++
 scripts/run-lava-tests.sh                  | 30 +++++++
 tests/README.md                            | 42 ++++++++++
 tests/jobs/xenomai-beaglebone.yml          | 76 +++++++++++++++++
 tests/jobs/xenomai-minnow.yml              | 73 ++++++++++++++++
 tests/jobs/xenomai-qemu-amd64.yml          | 87 ++++++++++++++++++++
 tests/jobs/xenomai-qemu-arm64.yml          | 96 ++++++++++++++++++++++
 tests/jobs/xenomai-qemu-armhf.yml          | 87 ++++++++++++++++++++
 tests/jobs/xenomai-x86-64.yml              | 74 +++++++++++++++++
 xenomai-lava-test.yml                      | 20 +++++
 20 files changed, 704 insertions(+), 30 deletions(-)
 create mode 100755 scripts/deploy_for_testing.sh
 create mode 100755 scripts/run-lava-tests.sh
 create mode 100644 tests/README.md
 create mode 100644 tests/jobs/xenomai-beaglebone.yml
 create mode 100644 tests/jobs/xenomai-minnow.yml
 create mode 100644 tests/jobs/xenomai-qemu-amd64.yml
 create mode 100644 tests/jobs/xenomai-qemu-arm64.yml
 create mode 100644 tests/jobs/xenomai-qemu-armhf.yml
 create mode 100644 tests/jobs/xenomai-x86-64.yml
 create mode 100644 xenomai-lava-test.yml

-- 
2.20.1


