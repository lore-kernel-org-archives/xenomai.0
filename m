From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v4 5/8] ci: Update README.md regarding CI
 variables
Date: Fri, 7 Jan 2022 16:03:00 +0100
Message-ID: <42919d0f2714acc3c24e23ef90a1a0a8f03a01a2.1641567783.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641567783.git.jan.kiszka@siemens.com>
References: <cover.1641567783.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Some were undocumented, DEPLOY_DIR_EXTENSION is now history and was
actually never an external interface.

Reindent the LAVA settings section at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/README.md | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index 5779e9b..0767192 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -96,21 +96,26 @@ the [Custom CI configuration path](https://code.siemens.com/help/ci/pipelines/se
 ## CI Variables
 
 The following variables are used and set by the ci system:
-- proxy settings:
+- Proxy settings:
   - `HTTP_PROXY`    : http proxy
   - `HTTPS_PROXY`   : https proxy
   - `FTP_PROXY`     : ftp proxy
   - `NO_PROXY`      : no proxy
 
 - LAVA settings:
-  - `LAVA_MASTER_ACCOUNT`  : lava master account name to register lavacli for test execution
-  - `LAVA_MASTER_TOKEN`    : token to connect with the lava master
-  - `LAVA_ARTIFACTS_URL` : optional variable where to get the artifacts for testing
+  - `LAVA_MASTER_ACCOUNT`: lava master account name to register lavacli for test execution
+  - `LAVA_MASTER_TOKEN`: token to connect with the lava master
+  - `LAVA_ARTIFACTS_URL`: optional variable where to get the artifacts for testing
   - `LAVA_MASTER_URL`: URL to the LAVA Master
 
-- General build settings
+- Image deployment settings:
+  - `USE_S3_BUCKET`: Set to `1` in order to upload build artifacts to AWS S3
+  - `AWS_ACCESS_KEY_ID`: Key ID to use for uploading
+  - `AWS_SECRET_ACCESS_KEY`: Secret access key for uploading
+  - `S3_BUCKET_URL`: S3 URL where to place the artifacts (synchronize with `LAVA_ARTIFACTS_URL`)
+
+- Build settings:
   - `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
-  - `DEPLOY_DIR_EXTENSION`: Extension path to store artifacts for the same target
 
 ## LAVA Template variable
 
-- 
2.31.1


