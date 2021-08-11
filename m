From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] ci: Add default for S3_BUCKET_URL
Message-ID: <1a979e75-7c32-210b-9a58-bf0672d1e838@siemens.com>
Date: Wed, 11 Aug 2021 11:30:00 +0200
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
 scripts/deploy_to_aws.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 5a5b29a..98deebc 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -23,7 +23,7 @@ if [ -z "${S3_BUCKET_URL}" ] || [ -z "${AWS_ACCESS_KEY_ID}" ]  || [ -z "${AWS_SE
     exit 0
 fi
 
-destination="${S3_BUCKET_URL}"
+destination="${S3_BUCKET_URL:-s3://xenomai-images-artifacts/artifacts}"
 
 aws_args="--acl=public-read"
 
-- 
2.31.1

