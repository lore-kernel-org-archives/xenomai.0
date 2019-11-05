From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 2/2] ci: add hikey test
Date: Tue,  5 Nov 2019 17:22:39 +0100
Message-Id: <20191105162239.18949-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191105162239.18949-1-Quirin.Gylstorff@siemens.com>
References: <20191105162239.18949-1-Quirin.Gylstorff@siemens.com>
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

add the hikey lava-test configuration to gitlab-ci.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0974548..0abc256 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -90,7 +90,18 @@ build:board-hikey:
   script:
     - kas build kas.yml:board-hikey.yml:opt-lava-test.yml${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh hikey
-# hikey is currently not part of the testlab
+
+lava-test:board-hikey:
+  <<: *lava-ssh-key
+  stage: lava-test
+  script:
+    - scripts/install-lavacli.sh
+    - scripts/run-lava-tests.sh hikey
+  needs: [ "build:board-hikey" ]
+  only:
+    variables:
+      - $LAVA_SSH_USER
+
 
 build:board-beaglebone:
   <<: *lava-ssh-key
-- 
2.20.1


