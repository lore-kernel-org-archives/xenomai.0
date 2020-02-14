From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH v2 0/9] Add testing for xenomai-3.0.x 
Date: Fri, 14 Feb 2020 13:26:54 +0100
Message-Id: <20200214122703.7947-1-Quirin.Gylstorff@siemens.com>
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

- Add testing for Xenomai 3.0.x.
- Clean up the ci scripts to avoid code duplications.
- Add new target ipc227e for xenomai 3.0.x testing.
- Add missing export of libxenomai-dev
- Add missing exception handling for xenomai revision extraction.
  Linux xenomai already contains this changes

Changes in V2:
 - remove extra build and test of linux 4.4.
   Linux 4.4 is only supported by xenomai-3.0.x and therefore
   already part of the xenomai-3.0.x build and test.
 - remove 4.19 option
 - readd proxy settings. The proxycommand is only added if
   https_proxy is set.
 - change patch order


Quirin Gylstorff (9):
  ci: remove code duplications
  ci: Use gitlab extends instead of YAML Anchors
  scripts: Allow other layers to reuse scripts
  Add kas option for 4.4
  ci: Add testing of xenomai 3.0.x
  ci: Add target ipc227e for testing xenomai-3.0.x
  ci: Make proxycommand conditional
  recipes-xenomai/xenomai.inc: Add missing libxenomai-dev
  recipes-xenomai/xenomai.inc:  add exception handling

 .gitlab-ci.yml                             | 174 +++++++++++----------
 opt-linux-4.4.yml                          |  17 ++
 recipes-kernel/linux/files/amd64_defconfig |   3 +-
 recipes-xenomai/xenomai/xenomai.inc        |  11 +-
 scripts/deploy_for_testing.sh              |  42 ++---
 scripts/run-lava-tests.sh                  |  58 ++++---
 tests/jobs/xenomai-ipc227e.yml             |  74 +++++++++
 7 files changed, 250 insertions(+), 129 deletions(-)
 create mode 100644 opt-linux-4.4.yml
 create mode 100644 tests/jobs/xenomai-ipc227e.yml

-- 
2.20.1


