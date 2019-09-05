From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 5/9] kas: Use next as target
Date: Thu,  5 Sep 2019 17:44:21 +0200
Message-Id: <20190905154425.10007-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
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

For CI testing of the next branch.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas.yml b/kas.yml
index 260eb36..ee7b589 100644
--- a/kas.yml
+++ b/kas.yml
@@ -36,4 +36,4 @@ local_conf_header:
   cross: |
     ISAR_CROSS_COMPILE = "1"
   xenomai-version: |
-    PREFERRED_VERSION_xenomai ?= "stable"
+    PREFERRED_VERSION_xenomai ?= "next"
-- 
2.20.1


