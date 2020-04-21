From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [Xenomai-images PATCH 3/4] test/README: Update
Date: Tue, 21 Apr 2020 10:31:29 +0200
Message-Id: <20200421083130.13437-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200421083130.13437-1-Quirin.Gylstorff@siemens.com>
References: <20200421083130.13437-1-Quirin.Gylstorff@siemens.com>
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

Add missing targets and update CI variable description.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 tests/README.md | 59 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index 01b956e..8bf97a5 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -8,9 +8,11 @@ sends them to the lava testlab.
 ## Test targets
 
 following images are test:
+- qemu-armhf
 - qemu-arm64
 - qemu-amd64
 - x86-64-efi
+- hikey
 - beagle-bone-black
 
 ## Deploy test
@@ -85,20 +87,47 @@ Setup a lava environment by following the
 [installation guide](https://docs.lavasoftware.org/lava/first-installation.html)
 or use [lava-docker](https://github.com/kernelci/lava-docker).
 
-# CI Variables
+# CI Files
+
+To support different ci setups all ci files are stored in `.ci`. `.gitlab-ci.yml` in
+the repository root use the settings to build on gitlab.com. To use another setup adapt
+the [Custom CI configuration path](https://code.siemens.com/help/ci/pipelines/settings#custom-ci-configuration-path)
+
+
+## CI Variables
 
 The following variables are used and set by the ci system:
-- `HTTP_PROXY`    : proxy settings
-- `HTTPS_PROXY`   : proxy settings
-- `FTP_PROXY`     : proxy settings
-- `NO_PROXY`      : proxy settings
-- `LAVA_SSH_USER` : ssh user to connect to the LAVA master
-- `LAVA_SSH_HOST` : ssh host name to connect to the LAVA master
-- `LAVA_SSH_PORT` : ssh port used for the ssh tunnel
-- `LAVA_SSH_UPLOAD_KEY`  :  private ssh key to connect to the LAVA master
-- `LAVA_SSH_KNOWN_HOSTS` : Known hosts to connect via ssh to the host given by `LAVA_SSH_HOST`
-- `LAVA_MASTER_ACCOUNT`  : lava master account name to register lavacli for test execution
-- `LAVA_MASTER_TOKEN`    : token to connect with the lava master
-- `LAVA_DEPLOY_DIR`    : optional variable to define directory to store the build artifacts
-- `LAVA_ARTIFACTS_URL` : optional variable where to get the artifacts for testing
-- `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
+- proxy settings:
+  - `HTTP_PROXY`    : http proxy
+  - `HTTPS_PROXY`   : https proxy
+  - `FTP_PROXY`     : ftp proxy
+  - `NO_PROXY`      : no proxy
+
+- SSH settings:
+  - `LAVA_SSH_USER` : ssh user to connect to the LAVA master
+  - `LAVA_SSH_HOST` : ssh host name to connect to the LAVA master
+  - `LAVA_SSH_PORT` : ssh port used for the ssh tunnel
+  - `LAVA_SSH_UPLOAD_KEY`  :  private ssh key to connect to the LAVA master
+  - `LAVA_SSH_KNOWN_HOSTS` : Known hosts to connect via ssh to the host given by `LAVA_SSH_HOST`
+
+- LAVA settings:
+  - `LAVA_MASTER_ACCOUNT`  : lava master account name to register lavacli for test execution
+  - `LAVA_MASTER_TOKEN`    : token to connect with the lava master
+  - `LAVA_DEPLOY_DIR`    : optional variable to define directory to store the build artifacts
+  - `LAVA_ARTIFACTS_URL` : optional variable where to get the artifacts for testing
+  - `LAVA_DEPLOY_DIR`: Directory to deploy the Artifacts in a build. Default /var/lib/lava/artifacts
+  - `LAVA_MASTER_PORT`: PORT to access the LAVA Master
+
+- General build settings
+  - `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
+  - `DEPLOY_DIR_EXTENSION`: Extension path to store artifacts for the same target
+  - `USE_GITLAB_ARTIFACTS`: If set this changes the deploy url to a gitlab api URL
+  - `JOB_TEMPLATE_PATH`: Path to the test templates - Default tests/jobs/xenomai
+  - `TARGET_EXTENSION`: Extension of the build job name
+## LAVA Template variable
+
+- `TARGET`: Name of the target in the LAVA Lab
+- `BUILD_ARCH`: Architecture of the Target
+- `DEPLOY_DIR`: Path to the test components will be generate by the script `scripts/run-lava-tests.sh`
+- `ISAR_IMAGE`: Name of the ISAR image (e.g. demo-image)
+- `ISAR_DISTRIBUTION`: Name of the ISAR DISTRIBUTION (e.g. xenomai-demo)
-- 
2.20.1


