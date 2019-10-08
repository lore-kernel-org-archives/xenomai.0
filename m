From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 3/3] ci: fix url replacement in jobs.
Date: Tue,  8 Oct 2019 15:14:42 +0200
Message-Id: <20191008131442.21295-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191008131442.21295-1-Quirin.Gylstorff@siemens.com>
References: <20191008131442.21295-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Shell substitution will use the complete default string. Remove
the quotation marks to fix call of lavacli.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 870f1f9..f714b78 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -37,7 +37,7 @@ if [ -z "${TARGET}" ]; then
     echo "no target was given"
     exit -1
 fi
-artifact_url="${LAVA_ARTIFACTS_URL:-'http://localhost/artifacts'}"
+artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
 
 # connect to lava master
 lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${LAVA_MASTER_URI} --username ${LAVA_MASTER_ACCOUNT} default
-- 
2.20.1


