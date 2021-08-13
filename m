From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] ci: Do not rely on S3_BUCKET_URL being
 terminated by a slash
Message-ID: <4f10e4cf-b2a3-709b-394b-6272a587bcd0@siemens.com>
Date: Fri, 13 Aug 2021 12:11:02 +0200
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

Duplicate slashes cause no harm, but a missing can lead to confusing
errors.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Inserted before "ci: Add default for S3_BUCKET_URL" which didn't add a 
slash, thus triggered this issue.

 scripts/deploy_to_aws.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 5a5b29a..9864cc1 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -28,7 +28,7 @@ destination="${S3_BUCKET_URL}"
 aws_args="--acl=public-read"
 
 isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
-deploy_dir="${destination}${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
+deploy_dir="${destination}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
 #KERNEL
 aws s3 cp "${aws_args}" "${images_dir}/${target}/${isar_base_name}-vmlinuz" "${deploy_dir}/${isar_base_name}-vmlinuz"
 # INITRD
-- 
2.31.1

