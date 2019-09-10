From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 0/9] LAVA Setup
Date: Tue, 10 Sep 2019 16:44:50 +0200
Message-Id: <20190910144459.13239-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
References: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
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

Next steps are:
- adding a arm64 hardware target
- documentation how to setup a own lab with lava-docker
- discussion for a public LAVA master
- Add a own repository for the test description instead using inline-testcase 

Changes:
  V2:
    - If Variable LAVA_USER is not set, the stage lava-test is not executed.
    - incorporate review
      - rename files
      - reoder commits
    - fix check if lava test are sucessful
    - reoder patches
      - remove x86-64 nfs patch, already on next
      - remove beagle-bone Devicetree patch, already on next

Quirin Gylstorff (9):
  ci: Add LAVA jobs for targets
  ci: Add needs key word
  machine: Allow override of the image type
  kas: Use next as target
  ci: Add inline xenomai testsuite
  README: correct build line
  kernel: Update
  tests/README: Add deployment and Setup
  tests/README: Add Architecture

 .gitlab-ci.yml                             | 106 +++++++++++++++++++--
 README.md                                  |   2 +-
 conf/machine/hikey.conf                    |   6 +-
 conf/machine/qemu-arm64.conf               |   1 -
 conf/machine/x86-64-efi.conf               |   2 +-
 opt-latest.yml                             |  20 ++++
 opt-lava-test.yml                          |  20 ++++
 recipes-core/images/demo-image.bb          |   2 +-
 recipes-kernel/linux/files/amd64_defconfig |   2 +-
 recipes-kernel/linux/linux-xenomai_4.19.bb |  12 ++-
 scripts/deploy_for_testing.sh              |  40 ++++++++
 scripts/run-lava-tests.sh                  |  30 ++++++
 tests/README.md                            |  87 +++++++++++++++++
 tests/jobs/xenomai-beaglebone.yml          |  76 +++++++++++++++
 tests/jobs/xenomai-minnow.yml              |  73 ++++++++++++++
 tests/jobs/xenomai-qemu-amd64.yml          |  87 +++++++++++++++++
 tests/jobs/xenomai-qemu-arm64.yml          |  96 +++++++++++++++++++
 tests/jobs/xenomai-qemu-armhf.yml          |  87 +++++++++++++++++
 tests/jobs/xenomai-x86-64.yml              |  74 ++++++++++++++
 19 files changed, 800 insertions(+), 23 deletions(-)
 create mode 100644 opt-latest.yml
 create mode 100644 opt-lava-test.yml
 create mode 100755 scripts/deploy_for_testing.sh
 create mode 100755 scripts/run-lava-tests.sh
 create mode 100644 tests/README.md
 create mode 100644 tests/jobs/xenomai-beaglebone.yml
 create mode 100644 tests/jobs/xenomai-minnow.yml
 create mode 100644 tests/jobs/xenomai-qemu-amd64.yml
 create mode 100644 tests/jobs/xenomai-qemu-arm64.yml
 create mode 100644 tests/jobs/xenomai-qemu-armhf.yml
 create mode 100644 tests/jobs/xenomai-x86-64.yml

-- 
2.20.1


