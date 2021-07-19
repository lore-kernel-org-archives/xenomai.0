From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 0/3] ci: cleanup
Date: Mon, 19 Jul 2021 18:29:46 +0200
Message-Id: <20210719162949.4342-1-Quirin.Gylstorff@siemens.com>
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

Remove artifact deployment to lava-master via ssh and to gitlab artifacts.

The current CI builds use AWS S3 for object storage. The objects used by the
test can be found for 5 days at [1].

[1]: https://xenomai-images-artifacts.s3.eu-central-1.amazonaws.com/artifacts/<GITLAB PIPELINE ID>/<kernel version>/<target>.

Changes V2:
 - cleanup of README
 - removed child_pipelines_common
 - removed ssh variables from gitlab-ci-base

Quirin Gylstorff (3):
  ci: Remove artifact deployment
  ci: Remove deploy with ssh
  ci/gitlab-ci-base: use rules

 .gitlab-ci-artifacts.yml            | 13 --------
 .gitlab-ci.yml                      | 30 +++++++++++++++--
 ci/artifacts.yml                    | 20 -----------
 ci/child_pipelines_artifacts.yml    | 34 -------------------
 ci/child_pipelines_common.yml       |  9 -----
 ci/child_pipelines_no_artifacts.yml | 34 -------------------
 ci/gitlab-ci-base.yml               | 19 ++++-------
 ci/no-artifacts.yml                 | 13 --------
 scripts/deploy_for_testing.sh       | 51 -----------------------------
 scripts/get-build-id.sh             | 34 -------------------
 scripts/run-lava-tests.sh           | 45 ++++---------------------
 tests/README.md                     | 17 ++--------
 12 files changed, 43 insertions(+), 276 deletions(-)
 delete mode 100644 .gitlab-ci-artifacts.yml
 delete mode 100644 ci/artifacts.yml
 delete mode 100644 ci/child_pipelines_artifacts.yml
 delete mode 100644 ci/child_pipelines_no_artifacts.yml
 delete mode 100644 ci/no-artifacts.yml
 delete mode 100755 scripts/deploy_for_testing.sh
 delete mode 100755 scripts/get-build-id.sh

-- 
2.20.1


