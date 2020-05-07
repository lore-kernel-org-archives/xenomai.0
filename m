From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images ][ PATCH v2 4/4] scripts/run-lava-tests: Add
 LAVA_MASTER_URL
Date: Thu,  7 May 2020 14:03:33 +0200
Message-Id: <20200507120333.31550-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200507120333.31550-1-Quirin.Gylstorff@siemens.com>
References: <20200507120333.31550-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, Jan.Kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Allow to set the LAVA master URL.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 2 +-
 tests/README.md           | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 8566493..764f3a9 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -37,7 +37,7 @@ do
     sleep ${interval}
     timeout=$(expr ${timeout} - ${interval})
 done
-lava_master_uri=http://localhost:${lava_master_port}
+lava_master_uri=${LAVA_MASTER_URL:-http://localhost}:${lava_master_port}
 
 # connect to lava master
 lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${lava_master_uri} --username ${LAVA_MASTER_ACCOUNT} default
diff --git a/tests/README.md b/tests/README.md
index 8bf97a5..119f90f 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -117,6 +117,7 @@ The following variables are used and set by the ci system:
   - `LAVA_ARTIFACTS_URL` : optional variable where to get the artifacts for testing
   - `LAVA_DEPLOY_DIR`: Directory to deploy the Artifacts in a build. Default /var/lib/lava/artifacts
   - `LAVA_MASTER_PORT`: PORT to access the LAVA Master
+  - `LAVA_MASTER_URL`: URL to the LAVA Master
 
 - General build settings
   - `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
-- 
2.20.1


