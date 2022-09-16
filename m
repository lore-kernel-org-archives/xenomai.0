Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A00D5C81
	for <xenomai@lists.linux.dev>; Fri, 16 Sep 2022 15:01:44 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202209161321160ac15d948ff2ceb4dd
        for <xenomai@lists.linux.dev>;
        Fri, 16 Sep 2022 15:21:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=lTBm6xasIV4HCEP7sxK7yyBRnUSOXGvMjubMpQfY67I=;
 b=NXVwft4ZNCM6CMsncn83d53ls2qEpZenxOZ1n6hVAj06iFNjoh9L0RaStkkxBBjLTBXTGr
 Fztv62FciDFWo2T2ZXIjA0buXz6d+lpH3MoT5GxeSV2ePwbUcEnu0EnWJUd6IARSPyon/DZ3
 i4oJzY6DnvCYrfq2WEIVs2eT9FxDc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: xenomai@lists.linux.dev,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com
Subject: [xenomai-images][PATCH] ci: Update AWS Deployment settings to use Cloudfront URL
Date: Fri, 16 Sep 2022 15:21:15 +0200
Message-Id: <20220916132115.32643-1-Quirin.Gylstorff@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Remove the acl settings as the are no longer valid.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/deploy_to_aws.sh  | 10 ++++------
 scripts/run-lava-tests.sh |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index f5aed6f..c555a2c 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -25,8 +25,6 @@ if [ -z "${destination}" ] || [ -z "${AWS_ACCESS_KEY_ID}" ]  || [ -z "${AWS_SECR
     exit 0
 fi
 
-aws_args="--acl=public-read"
-
 isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
 deploy_dir="${destination}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
 
@@ -39,17 +37,17 @@ if [ ! -f "${kernel}" ]; then
 fi
 
 #KERNEL
-aws s3 cp "${aws_args}" "${kernel}" "${deploy_dir}/${isar_base_name}-${kernel_suffix}"
+aws s3 cp "${kernel}" "${deploy_dir}/${isar_base_name}-${kernel_suffix}"
 # INITRD
-aws s3 cp "${aws_args}" "${images_dir}/${target}/${isar_base_name}-initrd.img" "${deploy_dir}/${isar_base_name}-initrd.img"
+aws s3 cp "${images_dir}/${target}/${isar_base_name}-initrd.img" "${deploy_dir}/${isar_base_name}-initrd.img"
 # ROOTFS
 if ! ls "${images_dir}/${target}/${isar_base_name}".*.gz ; then
     gzip "${images_dir}/${target}/${isar_base_name}.*"
 fi
 image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
-aws s3 cp "${aws_args}" "${image}" "${deploy_dir}/$(basename "${image}")"
+aws s3 cp "${image}" "${deploy_dir}/$(basename "${image}")"
 # DTB
 dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
 if [ -n "${dtb}" ] ; then
-    aws s3 cp "${aws_args}" "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
+    aws s3 cp  "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
 fi
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 30a853f..70deb36 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -17,7 +17,7 @@ if [ -z "${TARGET}" ]; then
 fi
 
 # S3 artifacts
-artifact_url="${LAVA_ARTIFACTS_URL:-https://xenomai-images-artifacts.s3.amazonaws.com/artifacts}"
+artifact_url="${LAVA_ARTIFACTS_URL:-https://d1a54g2tyy2hl.cloudfront.net/artifacts}"
 # public master
 lava_master_uri="${LAVA_MASTER_URL:-https://lava.xenomai.org}"
 
-- 
2.35.1

