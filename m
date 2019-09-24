From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH] scripts/run-lava-tests: Wait until ssh
 connection is open
Date: Tue, 24 Sep 2019 13:54:16 +0200
Message-Id: <20190924115416.26379-1-Quirin.Gylstorff@siemens.com>
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

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index b288edf..bd185f8 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -14,11 +14,18 @@ TARGET=$1
 
 LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"
 
+LAVA_MASTER_PORT=28080
 # open connection for ssh port forwarding
-ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:28080 localhost:80' ${LAVA_MASTER} &
+ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_MASTER} &
+
+# wait for connection
+while [ -n $(ss -tulw | grep -q "${LAVA_MASTER_PORT}") ]
+do
+    sleep 1
+done
 
 # connect to lava master
-lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:28080 --username siemens default
+lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:${LAVA_MASTER_PORT} --username siemens default
 
 test_id=$(lavacli jobs submit tests/jobs/xenomai-${TARGET}.yml)
 lavacli jobs logs ${test_id}
-- 
2.20.1


