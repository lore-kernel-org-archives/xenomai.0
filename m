From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 02/11] ci: Use gitlab extends instead of YAML
 Anchors
Date: Fri, 14 Feb 2020 08:32:52 +0100
Message-Id: <20200214073259.1769-3-Quirin.Gylstorff@siemens.com>
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

Gitlab uses extends as an alternative to YAML Anchors since 11.3.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e5dd3c1..4b3f970 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -25,22 +25,23 @@ default:
 
 # add lavacli to the container and install the ssh keys
 # for the test infrastructure
-.add-lava-ssh-config: &lava-ssh-key
+.add-lava-ssh-config:
   before_script:
     - mkdir -p -m=700 ~/.ssh
     - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
     - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
     - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 
-.build: &build-job
-  <<: *lava-ssh-key
+.build:
+  extends: .add-lava-ssh-config
   stage: build
   script:
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh ${TARGET}
 
-.test: &test-job
-  <<: *lava-ssh-key
+.test:
+  extends: .add-lava-ssh-config
+  image: kasproject/kas-isar:latest
   stage: lava-test
   script:
     - scripts/install-lavacli.sh
@@ -51,51 +52,51 @@ default:
 
 
 build:qemu-amd64:
-  <<: *build-job
+  extends: .build
   variables:
     TARGET: qemu-amd64
 
 lava-test:qemu-amd64:
   needs: [ "build:qemu-amd64" ]
-  <<: *test-job
+  extends: .test
   variables:
     TARGET: qemu-amd64
 
 build:qemu-armhf:
-  <<: *build-job
+  extends: .build
   variables:
     TARGET: qemu-armhf
 
 lava-test:qemu-armhf:
   needs: [ "build:qemu-armhf" ]
-  <<: *test-job
+  extends: .test
   variables:
     TARGET: qemu-armhf
 
 build:qemu-arm64:
-  <<: *build-job
+  extends: .build
   variables:
     TARGET: qemu-arm64
 
 lava-test:qemu-arm64:
   needs: [ "build:qemu-arm64" ]
-  <<: *test-job
+  extends: .test
   variables:
     TARGET: qemu-arm64
 
 build:board-hikey:
-  <<: *build-job
+  extends: .build
   variables:
     TARGET: hikey
     BUILD_OPTIONS: ":opt-lava-test.yml"
 lava-test:board-hikey:
   needs: [ "build:board-hikey" ]
-  <<: *test-job
+  extends: .test
   variables:
     TARGET: hikey
 
 build:board-beaglebone:
-  <<: *build-job
+  extends: .build
   variables:
     TARGET: beagle-bone-black
     BUILD_OPTIONS: ":opt-lava-test.yml"
@@ -103,18 +104,18 @@ build:board-beaglebone:
 
 lava-test:board-beaglebone:
   needs: [ "build:board-beaglebone" ]
-  <<: *test-job
+  extends: .test
   variables:
     TARGET: beaglebone
 
 build:board-x86-64-efi:
-  <<: *build-job
+  extends: .build
   variables:
     TARGET: x86-64-efi
     BUILD_OPTIONS: ":opt-lava-test.yml"
 
 lava-test:board-x86-64-efi:
   needs: [ "build:board-x86-64-efi" ]
-  <<: *test-job
+  extends: .test
   variables:
     TARGET: x86-64
-- 
2.20.1


