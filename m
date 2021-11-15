From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v3 6/8] ci: Fail test job when an error
 occurred during lava job submission
Date: Mon, 15 Nov 2021 11:13:44 +0100
Message-Id: <20211115101346.3566075-7-florian.bezdeka@siemens.com>
In-Reply-To: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
References: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

It can happen that the LAVA job submission fails. If so, the CI job
should be marked as failed. Previously we had something like the
following in the log, but the job was still marked as "OK".

Log:
connect to lava server: https://lava.xenomai.org
Deploy artifacts from 'https://xenomai-images-artifacts.s3.amazonaws.com/artifacts'
submit lava job
<ProtocolError for https://[snip]/RPC2: 500 HTTPSConnectionPool(host='lava.xenomai.org', port=443): Read timed out. (read timeout=20.0)>
<ProtocolError for https://[snip]/RPC2: 500 HTTPSConnectionPool(host='lava.xenomai.org', port=443): Read timed out. (read timeout=20.0)>
scripts/run-lava-tests.sh: 56: [: Illegal number:

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 scripts/run-lava-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index dde542c..de63b28 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -9,6 +9,7 @@
 #
 # SPDX-License-Identifier: MIT
 #
+set -e
 TARGET=$1
 if [ -z "${TARGET}" ]; then
     echo "no target was given"
-- 
2.30.2


