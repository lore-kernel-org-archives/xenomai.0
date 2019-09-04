From: Henning Schild <henning.schild@siemens.com>
Subject: [xenomai-images][PATCH 1/1] kas.yml: switch isar url to a working
 clone url
Date: Wed,  4 Sep 2019 10:26:56 +0200
Message-Id: <20190904082656.12601-2-henning.schild@siemens.com>
In-Reply-To: <20190904082656.12601-1-henning.schild@siemens.com>
References: <20190904082656.12601-1-henning.schild@siemens.com>
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

From: Henning Schild <henning.schild@siemens.com>

The url was actually missing the .git extension which seems to break
cloning it. Maybe a github change or who knows, but that new one works.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 kas.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas.yml b/kas.yml
index 260eb36..a4d12c2 100644
--- a/kas.yml
+++ b/kas.yml
@@ -19,7 +19,7 @@ repos:
   xenomai:
 
   isar:
-    url: https://github.com/ilbers/isar
+    url: https://github.com/ilbers/isar.git
     refspec: 59c7dd2b8b3172d53de1c7a39fbd49751193559a
     layers:
       meta:
-- 
2.21.0


