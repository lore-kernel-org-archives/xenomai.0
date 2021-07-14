From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 4/4] scripts/run-lava-tests: parse
 test-report for errors
Date: Wed, 14 Jul 2021 09:41:55 +0200
Message-Id: <20210714074155.2625-5-Quirin.Gylstorff@siemens.com>
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

The total number of errors is easier collected by parsing
the LAVA API output as it already contains the information
requested. The lavacli output does not contain the sum of errors.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 44e02fc..7972279 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -81,7 +81,7 @@ url="${api}/${auth}"
 curl --silent "${url}" -o report.xml
 
 # change return code to generate a error in gitlab-ci if a test is failed
-number_of_fails="$(lavacli results "${test_id}" | grep -c fail )"
+number_of_fails="$(grep -o "errors=\"[0-9]*\"" report.xml | head -1  | cut -d\" -f2 )"
 
 if [ -n "${ssh_pid}" ];then
    kill "${ssh_pid}"
-- 
2.20.1


