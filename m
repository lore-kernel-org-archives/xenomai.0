From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 00/11] Add 4.4 testing and cleanup ci
Date: Fri, 14 Feb 2020 08:32:50 +0100
Message-Id: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
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

Add testing for Xenomai 3.0.x and 4.4. Also clean up the ci scripts
to avoid code duplications. Add new target ipc227e for 4.4 testing.

Quirin Gylstorff (11):
  ci: remove code duplications
  ci: Use gitlab extends instead of YAML Anchors
  scripts: Allow other layers to reuse scripts
  recipes-kernel/linux: Add 4.4
  ci: Add linux-4.4 build and tests
  ci: add option for 4.19
  ci: Remove proxy settings
  ci: add new build options
  recipes-xenomai/xenomai.inc: Add missing libxenomai-dev
  recipes-xenomai/xenomai.inc:  add exception handling
  ci: Add target ipc227e for testing 4.4

 .gitlab-ci.yml                             | 205 ++++++++++++---------
 opt-linux-4.19.yml                         |  17 ++
 opt-linux-4.4.yml                          |  17 ++
 recipes-kernel/linux/files/amd64_defconfig |   3 +-
 recipes-xenomai/xenomai/xenomai.inc        |  11 +-
 scripts/deploy_for_testing.sh              |  42 +++--
 scripts/run-lava-tests.sh                  |  58 +++---
 tests/jobs/xenomai-ipc227e.yml             |  74 ++++++++
 8 files changed, 295 insertions(+), 132 deletions(-)
 create mode 100644 opt-linux-4.19.yml
 create mode 100644 opt-linux-4.4.yml
 create mode 100644 tests/jobs/xenomai-ipc227e.yml

-- 
2.20.1


