From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 0/4] ci: update for 5.4 testing
Date: Fri,  6 Nov 2020 15:56:28 +0100
Message-Id: <20201106145632.2951-1-Quirin.Gylstorff@siemens.com>
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
https://gitlab.com/Quirin.Gy/xenomai-images-test/-/pipelines/212790664

---

Changes V2:
- replace counter variable from get-build-id.sh
- add new kas option file for 5.4 - opt-linux-latest.yml now builds 4.19 by
default.
- fix Variable assignment in opt-linux-latest.yml
- add xenomai version to build name
- use ipipe-x86-4.19.y-cip as base instead of ipipe-x86-4.19.y for linux-latest

Quirin Gylstorff (4):
  ci: Split build and add 5.4 builds
  tests: increase timeouts
  ci: Add xenomai-version to build
  scripts/get-build-id.sh: replace counter

 ci/4_19_builds.yml                           |  88 ++++++++++++++
 ci/5_4_builds.yml                            |  40 +++++++
 ci/artifacts.yml                             |   1 +
 ci/default-builds.yml                        |  76 ++++++++++++
 ci/gitlab-ci-base.yml                        | 116 ++-----------------
 ci/xenomai_3_0_x.yml                         |  38 ++++++
 opt-linux-4.19.yml                           |  17 +++
 opt-linux-latest-5.4.yml                     |  18 +++
 opt-linux-latest.yml                         |   1 +
 recipes-kernel/linux/linux-xenomai_latest.bb |   6 +-
 scripts/get-build-id.sh                      |  15 ++-
 tests/jobs/xenomai-beagle-bone-black.yml     |   8 +-
 tests/jobs/xenomai-hikey.yml                 |   6 +-
 tests/jobs/xenomai-ipc227e.yml               |   8 +-
 tests/jobs/xenomai-minnow.yml                |   8 +-
 tests/jobs/xenomai-qemu-amd64.yml            |   8 +-
 tests/jobs/xenomai-qemu-arm64.yml            |   8 +-
 tests/jobs/xenomai-qemu-armhf.yml            |   8 +-
 tests/jobs/xenomai-x86-64-efi.yml            |   8 +-
 19 files changed, 333 insertions(+), 145 deletions(-)
 create mode 100644 ci/4_19_builds.yml
 create mode 100644 ci/5_4_builds.yml
 create mode 100644 ci/default-builds.yml
 create mode 100644 ci/xenomai_3_0_x.yml
 create mode 100644 opt-linux-4.19.yml
 create mode 100644 opt-linux-latest-5.4.yml

-- 
2.20.1


