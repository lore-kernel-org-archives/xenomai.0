From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] ci: Make default s3 fetch URL zone-independent
Message-ID: <928769ee-1d38-3a15-839b-4e612004ab6d@siemens.com>
Date: Wed, 11 Aug 2021 15:31:41 +0200
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

No need to encode the European zone here into the default, let AWS sort
this out.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/run-lava-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index b1b51bb..dde542c 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -16,7 +16,7 @@ if [ -z "${TARGET}" ]; then
 fi
 
 # S3 artifacts
-artifact_url="${LAVA_ARTIFACTS_URL:-https://xenomai-images-artifacts.s3.eu-central-1.amazonaws.com/artifacts}"
+artifact_url="${LAVA_ARTIFACTS_URL:-https://xenomai-images-artifacts.s3.amazonaws.com/artifacts}"
 # public master
 lava_master_uri="${LAVA_MASTER_URL:-https://lava.xenomai.org}"
 
-- 
2.31.1

