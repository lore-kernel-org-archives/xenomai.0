From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 2/2] ci: Apply DNS hack also on test instances
Date: Thu, 14 Apr 2022 17:49:28 +0200
Message-Id: <46a6aef83e7f7a639662ade3fb2682cae711a15b.1649951368.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649951368.git.jan.kiszka@siemens.com>
References: <cover.1649951368.git.jan.kiszka@siemens.com>
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

We've seen DNS issues with the AWS defaults also on the test jobs.
Therefore, expand the scope of the hack to all jobs by generalizing
.add-proxy-config to .common-config.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 057b9dd..7c65ca0 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -26,8 +26,9 @@ variables:
 default:
   image: ghcr.io/siemens/kas/kas-isar:2.6.3
 
-.add-proxy-config:
+.common-config:
   before_script:
+    - sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
     - mkdir -p -m=700 ~/.ssh
     - if [ -n "$https_proxy" ]; then
           echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config;
@@ -35,16 +36,15 @@ default:
       fi
 
 .build:
-  extends: .add-proxy-config
+  extends: .common-config
   stage: build
   script:
-    - sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
     - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
-  extends: .add-proxy-config
+  extends: .common-config
   stage: test
   script:
     - scripts/install-lavacli.sh
-- 
2.34.1


