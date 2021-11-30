From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] Update consistently to kas 2.6.3
Message-ID: <fce457c2-93ba-df58-a1e9-514dd14ac3f6@siemens.com>
Date: Tue, 30 Nov 2021 09:29:58 +0100
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

CI was forgotten by 7c87984cc408, and the new stable version provides a
few minor fixes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md             | 2 +-
 ci/gitlab-ci-base.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 77296dc..b38e131 100644
--- a/README.md
+++ b/README.md
@@ -13,7 +13,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container -P ~/bin/
+    wget https://raw.githubusercontent.com/siemens/kas/2.6.3/kas-container -P ~/bin/
     chmod a+x ~/bin/kas-container
 
 Furthermore, install docker and make sure you have required permissions to
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 82d5dac..367085d 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -24,7 +24,7 @@ variables:
   LAVA_TESTS_ENABLED: "true"
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:2.4
+  image: ghcr.io/siemens/kas/kas-isar:2.6.3
 
 .add-proxy-config:
   before_script:
-- 
2.31.1

