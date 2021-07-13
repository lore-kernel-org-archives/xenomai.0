From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 4/4] scripts/run-lava-tests: parse test-report
 for errors
Date: Tue, 13 Jul 2021 16:51:42 +0200
Message-Id: <20210713145142.16025-5-Quirin.Gylstorff@siemens.com>
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

The total number of errors is easier collected by parsing
the LAVA API output as it already contains the information
requested. The lavacli output does not contain the sum of errors.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/run-lava-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index c787160..0c39340 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -84,7 +84,7 @@ url="${api}/${auth}"
 curl --silent "${url}" -o test-report.xml
 
 # change return code to generate a error in gitlab-ci if a test is failed
-number_of_fails="$(lavacli results "${test_id}" | grep -c fail )"
+number_of_fails="$(grep -o "errors=\"[0-9]*\"" test-report.xml | head -1  | cut -d\" -f2 )"
 
 if [ -n "${ssh_pid}" ];then
    kill "${ssh_pid}"
-- 
2.20.1


