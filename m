From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/2] ci: add xenomai 3.1 stable
Date: Fri, 18 Dec 2020 10:49:44 +0100
Message-Id: <20201218094945.6941-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201218094945.6941-1-Quirin.Gylstorff@siemens.com>
References: <20201218094945.6941-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, Jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml                         |  1 +
 ci/xenomai_3_1_x.yml                          | 94 +++++++++++++++++++
 opt-xenomai-3.1.x.yml                         | 17 ++++
 .../xenomai/xenomai_stable-3.1.x.bb           | 21 +++++
 4 files changed, 133 insertions(+)
 create mode 100644 ci/xenomai_3_1_x.yml
 create mode 100644 opt-xenomai-3.1.x.yml
 create mode 100644 recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index f7a9f77..a93a7a0 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -53,3 +53,4 @@ include:
   - local: '/ci/4_19_builds.yml'
   - local: '/ci/5_4_builds.yml'
   - local: '/ci/xenomai_3_0_x.yml'
+  - local: '/ci/xenomai_3_1_x.yml'
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
new file mode 100644
index 0000000..d083461
--- /dev/null
+++ b/ci/xenomai_3_1_x.yml
@@ -0,0 +1,94 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-4.19:board-qemu-amd64:xenomai-3.1.x:
+  extends: .build:board-qemu-amd64
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+
+lava-test-4.19:qemu-amd64:xenomai-3.1.x:
+  needs: [ "build-4.19:board-qemu-amd64:xenomai-3.1.x" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-3.1.x"
+
+build-4.19:board-qemu-armhf:xenomai-3.1.x:
+  extends: .build:board-qemu-armhf
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+
+lava-test-4.19:qemu-armhf:xenomai-3.1.x:
+  needs: [ "build-4.19:board-qemu-armhf:xenomai-3.1.x" ]
+  extends: .lava-test:qemu-armhf
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-3.1.x"
+
+build-4.19:board-qemu-arm64:xenomai-3.1.x:
+  extends: .build:board-qemu-arm64
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+
+lava-test-4.19:qemu-arm64:xenomai-3.1.x:
+  needs: [ "build-4.19:board-qemu-arm64:xenomai-3.1.x" ]
+  extends: .lava-test:qemu-arm64
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-3.1.x"
+
+build-4.19:board-hikey:xenomai-3.1.x:
+  extends: .build:board-hikey
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+
+lava-test-4.19:board-hikey:xenomai-3.1.x:
+  needs: [ "build-4.19:board-hikey:xenomai-3.1.x" ]
+  extends: .lava-test:board-hikey
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-3.1.x"
+
+build-4.19:board-beagle-bone-black:xenomai-3.1.x:
+  extends: .build:board-beagle-bone-black
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+
+lava-test-4.19:board-beagle-bone-black:xenomai-3.1.x:
+  needs: [ "build-4.19:board-beagle-bone-black:xenomai-3.1.x" ]
+  extends: .lava-test:board-beagle-bone-black
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-3.1.x"
+
+build-4.19:board-x86-64-efi:xenomai-3.1.x:
+  extends: .build:board-x86-64-efi
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
+
+lava-test-4.19:board-x86-64-efi:xenomai-3.1.x:
+  needs: [ "build-4.19:board-x86-64-efi:xenomai-3.1.x" ]
+  extends: .lava-test:board-x86-64-efi
+  variables:
+    DEPLOY_DIR_EXTENSION: "xenomai-3.1.x"
+    BUILD_IDENTIFIER: "4.19"
+    TARGET_EXTENSION: ":xenomai-3.1.x"
diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x.yml
new file mode 100644
index 0000000..7440a36
--- /dev/null
+++ b/opt-xenomai-3.1.x.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  xenomai-3-1-x: |
+    PREFERRED_VERSION_xenomai = "stable-3.1.x"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
new file mode 100644
index 0000000..d2c7a33
--- /dev/null
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.1.x.bb
@@ -0,0 +1,21 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require xenomai.inc
+
+CHANGELOG_V = "3.1.x-head"
+
+SRC_URI = " \
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.1.x"
+SRCREV = "${AUTOREV}"
+
+S = "${WORKDIR}/git"
-- 
2.20.1


