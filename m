From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/3] ci: cleanup
Date: Mon, 19 Jul 2021 16:29:44 +0200
Message-Id: <20210719142947.3034-1-Quirin.Gylstorff@siemens.com>
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
To: jan.kiszka@siemens.com, xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Remove artifact deployment to lava-master via ssh and to gitlab artifacts.

The current CI builds use AWS S3 for object storage. The objects used by the
test can be found for 5 days at [1].

[1]: https://xenomai-images-artifacts.s3.eu-central-1.amazonaws.com/artifacts/<GITLAB PIPELINE ID>/<kernel version>/<target>.

Quirin Gylstorff (3):
  ci: Remove artifact deployment
  ci: Remove deploy with ssh
  ci/gitlab-ci-base: use rules

 .gitlab-ci-artifacts.yml            | 13 --------
 .gitlab-ci.yml                      | 20 ++++++++++-
 ci/artifacts.yml                    | 20 -----------
 ci/child_pipelines_artifacts.yml    | 34 -------------------
 ci/child_pipelines_no_artifacts.yml | 34 -------------------
 ci/gitlab-ci-base.yml               |  9 ++---
 ci/no-artifacts.yml                 | 13 --------
 scripts/deploy_for_testing.sh       | 51 -----------------------------
 scripts/get-build-id.sh             | 34 -------------------
 scripts/run-lava-tests.sh           | 45 ++++---------------------
 10 files changed, 28 insertions(+), 245 deletions(-)
 delete mode 100644 .gitlab-ci-artifacts.yml
 delete mode 100644 ci/artifacts.yml
 delete mode 100644 ci/child_pipelines_artifacts.yml
 delete mode 100644 ci/child_pipelines_no_artifacts.yml
 delete mode 100644 ci/no-artifacts.yml
 delete mode 100755 scripts/deploy_for_testing.sh
 delete mode 100755 scripts/get-build-id.sh

-- 
2.20.1


