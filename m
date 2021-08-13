From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v2] ci: Add default for S3_BUCKET_URL
Message-ID: <7895bdb4-c7fa-6d04-9d22-11f95c197a8d@siemens.com>
Date: Fri, 13 Aug 2021 12:10:54 +0200
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

This corresponds to the default for LAVA_ARTIFACTS_URL.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - reorder to fix failing consistency check before default was assigned

 scripts/deploy_to_aws.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 9864cc1..e7c22f0 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -18,13 +18,13 @@ if [ -z "${target}" ]; then
 fi
 images_dir=build/tmp/deploy/images
 
-if [ -z "${S3_BUCKET_URL}" ] || [ -z "${AWS_ACCESS_KEY_ID}" ]  || [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
+destination="${S3_BUCKET_URL:-s3://xenomai-images-artifacts/artifacts}"
+
+if [ -z "${destination}" ] || [ -z "${AWS_ACCESS_KEY_ID}" ]  || [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
     echo "environment not available or incomplete - do not deploy"
     exit 0
 fi
 
-destination="${S3_BUCKET_URL}"
-
 aws_args="--acl=public-read"
 
 isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
-- 
2.31.1

