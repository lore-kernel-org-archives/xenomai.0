From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 1/2] Update Isar revision
Date: Thu, 14 Apr 2022 17:49:27 +0200
Message-Id: <e2b9425567b239c86606b8fa743c2f9b582b75ad.1649951368.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649951368.git.jan.kiszka@siemens.com>
References: <cover.1649951368.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Various fixes and better control over sstate.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas.yml b/kas.yml
index 62ddbb4..6b3b32d 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: eeefa03185e3f259d08ff94295b0981a19eddf55
+    refspec: a960a4e52c50ef4a15e382768eeee5fa9cfffead
     layers:
       meta:
 
-- 
2.34.1


