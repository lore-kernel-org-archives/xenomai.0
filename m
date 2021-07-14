From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 1/4] scripts/deploy_to_aws: Correct upload
 of dtb
Date: Wed, 14 Jul 2021 09:41:52 +0200
Message-Id: <20210714074155.2625-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210714074155.2625-1-Quirin.Gylstorff@siemens.com>
References: <20210714074155.2625-1-Quirin.Gylstorff@siemens.com>
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

If a dtb exists it was not uploaded correctly.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/deploy_to_aws.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 814aec7..5a5b29a 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -40,7 +40,7 @@ fi
 image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
 aws s3 cp "${aws_args}" "${image}" "${deploy_dir}/$(basename "${image}")"
 # DTB
-dtb="$(ls "${images_dir}/${target}/*.dtb" 2> /dev/null)"
+dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
 if [ -n "${dtb}" ] ; then
     aws s3 cp "${aws_args}" "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
 fi
-- 
2.20.1


