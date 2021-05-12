From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 3/9] ci: Fix USE_GITLAB_ARTIFACTS definition
Date: Wed, 12 May 2021 10:32:17 +0200
Message-Id: <5faf3357524c826de670c924db9acc9d03f064b6.1620808343.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620808343.git.jan.kiszka@siemens.com>
References: <cover.1620808343.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Variables do not propagate automatically to child pipelines. So define
this one in the artifact version of the child pipeline file.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci-artifacts.yml | 3 ---
 ci/artifacts.yml         | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci-artifacts.yml b/.gitlab-ci-artifacts.yml
index 6d2f1ee..85345b8 100644
--- a/.gitlab-ci-artifacts.yml
+++ b/.gitlab-ci-artifacts.yml
@@ -9,8 +9,5 @@
 # SPDX-License-Identifier: MIT
 #
 
-variables:
-  USE_GITLAB_ARTIFACTS: "true"
-
 include:
   - local: '/ci/child_pipelines_artifacts.yml'
diff --git a/ci/artifacts.yml b/ci/artifacts.yml
index 2a0d639..fb1549f 100644
--- a/ci/artifacts.yml
+++ b/ci/artifacts.yml
@@ -8,6 +8,10 @@
 #
 # SPDX-License-Identifier: MIT
 #
+
+variables:
+  USE_GITLAB_ARTIFACTS: "true"
+
 # add lavacli to the container and install the ssh keys
 # for the test infrastructure
 .add-lava-ssh-config:
-- 
2.26.2


