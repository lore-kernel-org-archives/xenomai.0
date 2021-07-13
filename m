From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/4] scripts/deploy_to_aws: Correct upload of
 dtb
Date: Tue, 13 Jul 2021 16:51:39 +0200
Message-Id: <20210713145142.16025-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210713145142.16025-1-Quirin.Gylstorff@siemens.com>
References: <20210713145142.16025-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If a dtb exists it was not uploaded correctly.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/deploy_to_aws.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 814aec7..02f7aeb 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -40,7 +40,7 @@ fi
 image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
 aws s3 cp "${aws_args}" "${image}" "${deploy_dir}/$(basename "${image}")"
 # DTB
-dtb="$(ls "${images_dir}/${target}/*.dtb" 2> /dev/null)"
-if [ -n "${dtb}" ] ; then
+if ls "${images_dir}/${target}/"*.dtb ; then
+    dtb=$(ls "${images_dir}/${target}/"*.dtb )
     aws s3 cp "${aws_args}" "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
 fi
-- 
2.20.1


