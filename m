From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v4 0/8] Update CI and kconfig for next and
 stable/3.2.x
Date: Fri, 7 Jan 2022 16:02:55 +0100
Message-ID: <cover.1641567783.git.jan.kiszka@siemens.com>
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

Changes in v4:
 - clean up CI variable interface and documentation

This accounts for change in Xenomai next as well as the fork-off of
stable/3.2.x. And it simplifies our gitlab-ci configuration as bit.

This is "v3" because of patch 3 which was still broken and required the
other 2 in order to actually achieve the goal.

There is also 5.15 enabling in next already, but that will likely need
an update once the pending mm-issue is understood and resolved.

Jan

Jan Kiszka (8):
  xenomai: Unify stable recipes, add link for 3.2.x
  ci: Refactor inclusions
  ci: Drop JOB_TEMPLATE_PATH variable
  ci: Drop no longer user TARGET_EXTENSION variable
  ci: Update README.md regarding CI variables
  ci: Add 3.2.x stable, confine next
  Kconfig: Add entry for 3.2.x head
  linux-xenomai: Refactor latest recipe

 .gitlab-ci.yml                                |  6 ++
 Kconfig                                       |  8 +-
 ci/gitlab-ci-base.yml                         |  4 +-
 ..._4_19_xenomai_next.yml => kernel_4_19.yml} | 32 +++----
 ..._5_10_xenomai_next.yml => kernel_5_10.yml} | 32 +++----
 ...el_5_4_xenomai_next.yml => kernel_5_4.yml} | 32 +++----
 ci/xenomai_3_0_x.yml                          | 23 ++---
 ci/xenomai_3_1_x.yml                          | 91 ++-----------------
 ci/xenomai_3_2_x.yml                          | 20 ++++
 ci/xenomai_next.yml                           | 11 ++-
 recipes-kernel/linux/linux-xenomai_latest.bb  | 37 ++++++--
 .../xenomai/xenomai_stable-3.0.x.bb           |  7 +-
 .../xenomai/xenomai_stable-3.1.x.bb           | 22 +----
 .../xenomai/xenomai_stable-3.2.x.bb           |  1 +
 scripts/deploy_to_aws.sh                      |  2 +-
 scripts/run-lava-tests.sh                     |  5 +-
 tests/README.md                               | 19 ++--
 17 files changed, 142 insertions(+), 210 deletions(-)
 rename ci/{kernel_4_19_xenomai_next.yml => kernel_4_19.yml} (71%)
 rename ci/{kernel_5_10_xenomai_next.yml => kernel_5_10.yml} (71%)
 rename ci/{kernel_5_4_xenomai_next.yml => kernel_5_4.yml} (71%)
 create mode 100644 ci/xenomai_3_2_x.yml
 mode change 100644 => 120000 recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
 create mode 120000 recipes-xenomai/xenomai/xenomai_stable-3.2.x.bb

-- 
2.31.1


