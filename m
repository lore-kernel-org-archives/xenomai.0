From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v3 1/2] scripts/run-lava-tests: Wait until ssh
 connection is open
Date: Mon, 30 Sep 2019 16:05:33 +0200
Message-Id: <20190930140534.25731-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <901ed017-ab67-f975-b471-8753adbb4e97@siemens.com>
References: <901ed017-ab67-f975-b471-8753adbb4e97@siemens.com>
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

To connect with lava master use a ssh connection with port forwarding.
It can take some time till the port is available. Therefore
wait until the port is available.

---
 scripts/run-lava-tests.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index b288edf..8f49917 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -13,12 +13,23 @@ set -e
 TARGET=$1
 
 LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"
-
+LAVA_MASTER_PORT=28080
 # open connection for ssh port forwarding
-ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:28080 localhost:80' ${LAVA_MASTER} &
-
+ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_MASTER} &
+# wait for connection
+INTERVAL=1
+TIMEOUT=60
+until ss -tulw | grep -q "${LAVA_MASTER_PORT}"
+do
+    if [ ${TIMEOUT} -le 0 ]; then
+        echo "could not open connection to LAVA Master"
+        exit 1
+    fi
+    sleep ${INTERVAL}
+    TIMEOUT=$(expr ${TIMEOUT} - ${INTERVAL})
+done
 # connect to lava master
-lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:28080 --username siemens default
+lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:${LAVA_MASTER_PORT} --username ${LAVA_ACCOUNT} default
 
 test_id=$(lavacli jobs submit tests/jobs/xenomai-${TARGET}.yml)
 lavacli jobs logs ${test_id}
-- 
2.20.1


