From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 07/11] ci: Remove proxy settings
Date: Fri, 14 Feb 2020 08:32:57 +0100
Message-Id: <20200214073259.1769-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
References: <20200214073259.1769-1-Quirin.Gylstorff@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b8dbbc5..54542b1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -14,10 +14,6 @@ stages:
 
 variables:
   GIT_STRATEGY: clone
-  http_proxy: "$HTTP_PROXY"
-  https_proxy: "$HTTPS_PROXY"
-  ftp_proxy: "$FTP_PROXY"
-  no_proxy: "$NO_PROXY"
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
   LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
   ISAR_IMAGE: demo-image
@@ -31,13 +27,13 @@ default:
 .add-lava-ssh-config:
   before_script:
     - mkdir -p -m=700 ~/.ssh
-    - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
     - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
     - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 
 .build:
   extends: .add-lava-ssh-config
   stage: build
+  image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh ${TARGET}
@@ -92,6 +88,7 @@ build:board-hikey:
   variables:
     TARGET: hikey
     BUILD_OPTIONS: ":opt-lava-test.yml"
+
 lava-test:board-hikey:
   needs: [ "build:board-hikey" ]
   extends: .test
@@ -104,7 +101,6 @@ build:board-beaglebone:
     TARGET: beagle-bone-black
     BUILD_OPTIONS: ":opt-lava-test.yml"
 
-
 lava-test:board-beaglebone:
   needs: [ "build:board-beaglebone" ]
   extends: .test
-- 
2.20.1


