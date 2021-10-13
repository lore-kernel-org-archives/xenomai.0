From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 0/8] Update to Debian 11
Date: Wed, 13 Oct 2021 14:17:24 +0200
Message-Id: <20211013121732.140595-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

with this series the Xenomai demo image will be based on Debian 11.

All Debian 11 related topics that had to be adressed are now merged to
the Xenomai next branch. The stable branches have not yet been updated
so CI will report some failures for such branches.

Patch 4 made it to the list but has not been applied to next yet. That's
why I resend it, integrated into this series at the right place.

The Xenomai LAVA instance has been down while working on this topic. The
job submission to LAVA failed, but the test jobs where still marked as
successful. That is now fixed as well.

Best regards,
Florian

Changes since v1:
 - Renamed opt-lava-test.yml to opt-ci-board.yml
 - Moved removal of expand-on-first-boot from opt-ci.yml to opt-ci-board.yml

Florian Bezdeka (7):
  kas: Rename opt-lava-test.yml to opt-ci-board.yml
  ci: Disable partition expanding for all real test boards
  kas: Introduce kas option file for CI builds
  kas: Integrate opt-debug.yml into opt-ci.yml
  demo-image: Fix sshd-regen-keys problems on arm / qemu
  xenomai-demo: Switch to Debian bullseye
  ci: Fail test job when an error occurred during lava job submission

Jan Kiszka (1):
  linux-xenomai: arm: Enable CONFIG_ARM_MODULE_PLTS

 ci/gitlab-ci-base.yml                         | 10 ++---
 conf/distro/xenomai-demo.conf                 |  4 +-
 ...Start-key-generation-after-entropy-s.patch | 40 +++++++++++++++++++
 ...Fix-some-systemd-obsolete-warnings-a.patch | 34 ++++++++++++++++
 isar-patches/series                           |  2 +
 kas.yml                                       |  4 ++
 opt-lava-test.yml => opt-ci-board.yml         |  2 +
 opt-ci.yml                                    | 20 ++++++++++
 recipes-kernel/linux/files/armhf_defconfig    |  1 -
 scripts/run-lava-tests.sh                     |  1 +
 10 files changed, 110 insertions(+), 8 deletions(-)
 create mode 100644 isar-patches/0001-sshd-regen-keys-Start-key-generation-after-entropy-s.patch
 create mode 100644 isar-patches/0002-sshd-regen-keys-Fix-some-systemd-obsolete-warnings-a.patch
 create mode 100644 isar-patches/series
 rename opt-lava-test.yml => opt-ci-board.yml (83%)
 create mode 100644 opt-ci.yml

-- 
2.31.1


