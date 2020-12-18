From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/2] add xenomai 3.1.x to pipeline
Date: Fri, 18 Dec 2020 10:49:43 +0100
Message-Id: <20201218094945.6941-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, Jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add xenomai 3.1 to the build and test pipeline of xenomai-images.

Add parent_child pipelines[1] to have a better overview of the builds.

[1]: https://docs.gitlab.com/ee/ci/parent_child_pipelines.html

You can see an example build at:
https://gitlab.com/Quirin.Gy/xenomai-images-test/-/pipelines/231763266

Quirin Gylstorff (2):
  ci: add xenomai 3.1 stable
  ci: Introduce parent-child pipelines

 .gitlab-ci-artifacts.yml                      |  6 +-
 .gitlab-ci.yml                                |  3 +-
 ci/artifacts.yml                              | 22 -----
 ci/child_pipelines.yml                        | 34 +++++++
 ci/default-builds.yml                         | 76 ---------------
 ci/gitlab-ci-base.yml                         | 93 ++++++++++++++++++-
 ...uilds.yml => kernel_4_19_xenomai_next.yml} | 42 ++++-----
 ...builds.yml => kernel_5_4_xenomai_next.yml} | 16 ++--
 ci/no-artifacts.yml                           | 21 -----
 ci/xenomai_3_0_x.yml                          | 16 ++--
 ci/xenomai_3_1_x.yml                          | 91 ++++++++++++++++++
 ci/xenomai_next.yml                           | 14 +++
 opt-xenomai-3.1.x.yml                         | 17 ++++
 .../xenomai/xenomai_stable-3.1.x.bb           | 21 +++++
 14 files changed, 304 insertions(+), 168 deletions(-)
 delete mode 100644 ci/artifacts.yml
 create mode 100644 ci/child_pipelines.yml
 delete mode 100644 ci/default-builds.yml
 rename ci/{4_19_builds.yml => kernel_4_19_xenomai_next.yml} (55%)
 rename ci/{5_4_builds.yml => kernel_5_4_xenomai_next.yml} (64%)
 delete mode 100644 ci/no-artifacts.yml
 create mode 100644 ci/xenomai_3_1_x.yml
 create mode 100644 ci/xenomai_next.yml
 create mode 100644 opt-xenomai-3.1.x.yml
 create mode 100644 recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb

-- 
2.20.1


