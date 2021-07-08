From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/4] ci: Add option to upload artifacts to aws
 bucket
Date: Thu,  8 Jul 2021 17:02:58 +0200
Message-Id: <20210708150301.24083-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
References: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
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
To: jan.kiszka@siemens.com, xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The current build time is doubled by uploading the build artifacts
to the lava-server. By moving the storage of the build artifacts
to aws The build time should be reduces significantly.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml    |  3 ++-
 scripts/deploy_to_aws.sh | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100755 scripts/deploy_to_aws.sh

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index cf91379..352e023 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -44,7 +44,8 @@ default:
   script:
     - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
-    - if [ -z "${USE_GITLAB_ARTIFACTS}" ]; then scripts/deploy_for_testing.sh ${TARGET}; fi
+    - if [ -z "${USE_GITLAB_ARTIFACTS}" -a -z "${USE_S3_BUCKET}" ]; then scripts/deploy_for_testing.sh ${TARGET}; fi
+    - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
   extends: .add-lava-ssh-config
diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
new file mode 100755
index 0000000..814aec7
--- /dev/null
+++ b/scripts/deploy_to_aws.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019-2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+set -e
+target="$1"
+
+if [ -z "${target}" ]; then
+    exit 1
+fi
+images_dir=build/tmp/deploy/images
+
+if [ -z "${S3_BUCKET_URL}" ] || [ -z "${AWS_ACCESS_KEY_ID}" ]  || [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
+    echo "environment not available or incomplete - do not deploy"
+    exit 0
+fi
+
+destination="${S3_BUCKET_URL}"
+
+aws_args="--acl=public-read"
+
+isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
+deploy_dir="${destination}${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
+#KERNEL
+aws s3 cp "${aws_args}" "${images_dir}/${target}/${isar_base_name}-vmlinuz" "${deploy_dir}/${isar_base_name}-vmlinuz"
+# INITRD
+aws s3 cp "${aws_args}" "${images_dir}/${target}/${isar_base_name}-initrd.img" "${deploy_dir}/${isar_base_name}-initrd.img"
+# ROOTFS
+if ! ls "${images_dir}/${target}/${isar_base_name}".*.gz ; then
+    gzip "${images_dir}/${target}/${isar_base_name}.*"
+fi
+image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
+aws s3 cp "${aws_args}" "${image}" "${deploy_dir}/$(basename "${image}")"
+# DTB
+dtb="$(ls "${images_dir}/${target}/*.dtb" 2> /dev/null)"
+if [ -n "${dtb}" ] ; then
+    aws s3 cp "${aws_args}" "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
+fi
-- 
2.20.1


