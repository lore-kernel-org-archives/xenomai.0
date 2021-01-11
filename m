From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 0/1] Add parent child pipelines to ci build
Date: Mon, 11 Jan 2021 10:36:13 +0100
Message-Id: <20210111093614.20006-1-Quirin.Gylstorff@siemens.com>
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

Add parent_child pipelines[1] to have a better overview of the builds.

[1]: https://docs.gitlab.com/ee/ci/parent_child_pipelines.html

You can see an example build at:
https://gitlab.com/Quirin.Gy/xenomai-images-test/-/pipelines/238991689

Changes V2:
 - make ci script compatible with gitlab.denx.de. gitlab.com supports
   job with the same name if the have only/except rules defined. V2 fixes
   this by splitting the child_piplines.yml in a artifacts/no_artifacs build.

Quirin Gylstorff (1):
  ci: Introduce parent-child pipelines

 .gitlab-ci-artifacts.yml                      |  8 +-
 .gitlab-ci.yml                                |  5 +-
 ci/artifacts.yml                              | 15 +++-
 ci/child_pipelines_artifacts.yml              | 37 +++++++++
 ci/child_pipelines_no_artifacts.yml           | 37 +++++++++
 ci/default-builds.yml                         | 76 ------------------
 ci/gitlab-ci-base.yml                         | 80 +++++++++++++++----
 ...uilds.yml => kernel_4_19_xenomai_next.yml} | 42 +++++-----
 ...builds.yml => kernel_5_4_xenomai_next.yml} | 16 ++--
 ci/no-artifacts.yml                           | 13 ++-
 ci/xenomai_3_0_x.yml                          | 16 ++--
 ci/xenomai_3_1_x.yml                          | 45 +++++------
 ci/xenomai_next.yml                           | 14 ++++
 13 files changed, 237 insertions(+), 167 deletions(-)
 create mode 100644 ci/child_pipelines_artifacts.yml
 create mode 100644 ci/child_pipelines_no_artifacts.yml
 delete mode 100644 ci/default-builds.yml
 rename ci/{4_19_builds.yml => kernel_4_19_xenomai_next.yml} (55%)
 rename ci/{5_4_builds.yml => kernel_5_4_xenomai_next.yml} (64%)
 create mode 100644 ci/xenomai_next.yml

-- 
2.20.1


