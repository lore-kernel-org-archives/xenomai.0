From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 4/4] scripts/get-build-id.sh: replace
 counter
Date: Fri,  6 Nov 2020 15:56:32 +0100
Message-Id: <20201106145632.2951-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201106145632.2951-1-Quirin.Gylstorff@siemens.com>
References: <20201106145632.2951-1-Quirin.Gylstorff@siemens.com>
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

The loop to get the build index for artifact api was using
a counter to abort. This patch aborts the loop if the index
is above a valid value without guessing the amount of builds.

If no build was found the script returns an error as the
following lava test cannot access artifacts.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/get-build-id.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/get-build-id.sh b/scripts/get-build-id.sh
index ace70c6..8581edf 100755
--- a/scripts/get-build-id.sh
+++ b/scripts/get-build-id.sh
@@ -14,16 +14,21 @@ name=$1
 if [ -z "${name}" ]; then
     echo "no build name was given"
     exit -1
-    fi
+fi
 index=0
 JSON=$(curl -s --header "PRIVATE-TOKEN: ${API_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/pipelines/${CI_PIPELINE_ID}/jobs?scope[]=success"  )
-while  [ ${index} -le ${MAX_TEST:-16} ]
+while  build_name=$(echo "${JSON}"  | tr '\r\n' ' ' | jq -re ".[${index}].name")
 do
-    build_name=$(echo "${JSON}"  | tr '\r\n' ' ' | jq -r ".[${index}].name")
-    if [ "$build_name" = "${name}" ]; then
+    if [ "${build_name}" = "${name}" ]; then
         break
     fi
      index=$((index+1))
 done
 id=$(echo "${JSON}"  | tr '\r\n' ' ' | jq -r ".[${index}].id")
-echo $id
+if [ "$id" = "null" ]; then
+    >&2 echo "ERROR: did not find build with name: $name"
+    return 1
+else
+    echo $id
+    return 0
+fi
-- 
2.20.1


