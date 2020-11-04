From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/4] ci: update for 5.4 testing
Date: Wed,  4 Nov 2020 17:11:50 +0100
Message-Id: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Split the xenomai build into multiple files to decrease duplicated
code. Defaults-builds now contains the base definition for each
build and test. 4.19_builds, 5.4_builds and xenomai_3_0_x.yml use
this base-builds for the targets.

You can find the a pipeline at:
https://gitlab.com/Quirin.Gy/xenomai-images-test/-/pipelines/211684466

Quirin Gylstorff (4):
  linux-xenomai: update ipipe versions
  delete linux-xenomai_4.14
  ci: Split build and add 5.4 builds
  tests: increase timeouts

 ci/4_19_builds.yml                           |  58 ++++++++++
 ci/5_4_builds.yml                            |  30 +++++
 ci/artifacts.yml                             |   4 +
 ci/default-builds.yml                        |  76 +++++++++++++
 ci/gitlab-ci-base.yml                        | 110 +------------------
 ci/no-artifacts.yml                          |   4 +
 ci/xenomai_3_0_x.yml                         |  36 ++++++
 opt-linux-4.19.yml                           |  17 +++
 opt-linux-latest.yml                         |   3 +
 recipes-kernel/linux/linux-xenomai_4.14.bb   |  24 ----
 recipes-kernel/linux/linux-xenomai_4.19.bb   |  12 +-
 recipes-kernel/linux/linux-xenomai_4.4.bb    |   8 +-
 recipes-kernel/linux/linux-xenomai_latest.bb |   6 +-
 scripts/get-build-id.sh                      |   2 +-
 tests/jobs/xenomai-beagle-bone-black.yml     |   8 +-
 tests/jobs/xenomai-hikey.yml                 |   6 +-
 tests/jobs/xenomai-ipc227e.yml               |   8 +-
 tests/jobs/xenomai-minnow.yml                |   8 +-
 tests/jobs/xenomai-qemu-amd64.yml            |   8 +-
 tests/jobs/xenomai-qemu-arm64.yml            |   8 +-
 tests/jobs/xenomai-qemu-armhf.yml            |   8 +-
 tests/jobs/xenomai-x86-64-efi.yml            |   8 +-
 22 files changed, 279 insertions(+), 173 deletions(-)
 create mode 100644 ci/4_19_builds.yml
 create mode 100644 ci/5_4_builds.yml
 create mode 100644 ci/default-builds.yml
 create mode 100644 ci/xenomai_3_0_x.yml
 create mode 100644 opt-linux-4.19.yml
 delete mode 100644 recipes-kernel/linux/linux-xenomai_4.14.bb

-- 
2.20.1


