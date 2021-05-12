From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 5/9] ci: Pull common .add-lava-ssh-config into
 gitlab-ci-base.yml
Date: Wed, 12 May 2021 10:32:19 +0200
Message-Id: <817c8de17359d20eccdc1642832c3ccb605d6f59.1620808343.git.jan.kiszka@siemens.com>
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

Also refactor a bit for better readability.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/artifacts.yml      |  8 --------
 ci/gitlab-ci-base.yml | 12 ++++++++++++
 ci/no-artifacts.yml   |  9 +--------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/ci/artifacts.yml b/ci/artifacts.yml
index 9d6b0e1..d75559a 100644
--- a/ci/artifacts.yml
+++ b/ci/artifacts.yml
@@ -12,14 +12,6 @@
 variables:
   USE_GITLAB_ARTIFACTS: "true"
 
-# add lavacli to the container and install the ssh keys
-# for the test infrastructure
-.add-lava-ssh-config:
-  before_script:
-    - mkdir -p -m=700 ~/.ssh
-    - if [ -n "$https_proxy" ]; then echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config; fi;
-    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
-    - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 .build:
   extends: .add-lava-ssh-config
   stage: build
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 37811af..839f6ea 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -26,6 +26,18 @@ variables:
 default:
   image: ghcr.io/siemens/kas/kas-isar:2.4
 
+# add lavacli to the container and install the ssh keys
+# for the test infrastructure
+.add-lava-ssh-config:
+  before_script:
+    - mkdir -p -m=700 ~/.ssh
+    - if [ -n "$https_proxy" ]; then
+          echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config;
+          chmod 600 ~/.ssh/config;
+      fi
+    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
+    - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
+
 .test:
   extends: .add-lava-ssh-config
   stage: test
diff --git a/ci/no-artifacts.yml b/ci/no-artifacts.yml
index f7e0aed..e652a03 100644
--- a/ci/no-artifacts.yml
+++ b/ci/no-artifacts.yml
@@ -8,14 +8,7 @@
 #
 # SPDX-License-Identifier: MIT
 #
-# add lavacli to the container and install the ssh keys
-# for the test infrastructure
-.add-lava-ssh-config:
-  before_script:
-    - mkdir -p -m=700 ~/.ssh
-    - if [ -n "$https_proxy" ]; then echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config; fi;
-    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
-    - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
+
 .build:
   extends: .add-lava-ssh-config
   stage: build
-- 
2.26.2


