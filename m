From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] Update to kas 2.4
Message-ID: <d30fa4a9-ae89-17d6-c05a-3ac2b303bbc3@siemens.com>
Date: Fri, 5 Mar 2021 20:32:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md             | 2 +-
 ci/gitlab-ci-base.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 19d39dd..69b3e13 100644
--- a/README.md
+++ b/README.md
@@ -13,7 +13,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.3.3/kas-container -P ~/bin/
+    wget https://raw.githubusercontent.com/siemens/kas/2.4/kas-container -P ~/bin/
     chmod a+x ~/bin/kas-container
 
 Furthermore, install docker and make sure you have required permissions to
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 9fc1ee6..53ae66b 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -24,7 +24,7 @@ variables:
   ISAR_DISTRIBUTION: xenomai-demo
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:2.3.3
+  image: ghcr.io/siemens/kas/kas-isar:2.4
 
 .test:
   extends: .add-lava-ssh-config
-- 
2.26.2

