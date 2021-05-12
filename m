From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 0/9] ci improvements
Date: Wed, 12 May 2021 10:32:14 +0200
Message-Id: <cover.1620808343.git.jan.kiszka@siemens.com>
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

This brings a number of improvements for our CI/CT:
 - resource groups for board to avoid spinning actively on busy ones
 - filter variable to run only for a specific Xenomai branch
 - consolidation of the artifact/no-artifact cases
 - fix for artifact child pipeline

With this and an upcoming CI patch for Xenomai, we can now trigger the
lab test run for the specific Xenomai branch that received an update.

Jan

Jan Kiszka (9):
  ci: Create resource groups for all LAVA boards
  ci: Remove "board-" from job names
  ci: Fix USE_GITLAB_ARTIFACTS definition
  ci: Remove redundant job filtering on USE_GITLAB_ARTIFACTS
  ci: Pull common .add-lava-ssh-config into gitlab-ci-base.yml
  ci: Consolidate artifacts/no-artifacts case
  ci: Rename and reorder child pipeline
  ci: Factor out common bridge jobs
  ci: Add job filter variable

 .gitlab-ci-artifacts.yml            |  3 --
 ci/artifacts.yml                    | 22 +++----------
 ci/child_pipelines_artifacts.yml    | 26 ++++++++--------
 ci/child_pipelines_common.yml       | 21 +++++++++++++
 ci/child_pipelines_no_artifacts.yml | 26 ++++++++--------
 ci/gitlab-ci-base.yml               | 46 +++++++++++++++++++++------
 ci/kernel_4_19_xenomai_next.yml     | 48 ++++++++++++++---------------
 ci/kernel_5_4_xenomai_next.yml      | 48 ++++++++++++++---------------
 ci/no-artifacts.yml                 | 19 ++----------
 ci/xenomai_3_0_x.yml                | 20 ++++++------
 ci/xenomai_3_1_x.yml                | 48 ++++++++++++++---------------
 11 files changed, 170 insertions(+), 157 deletions(-)
 create mode 100644 ci/child_pipelines_common.yml

-- 
2.26.2


