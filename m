From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] CONTRIBUTING: Fix a typo and clarify statement
Message-ID: <1a83d353-23d5-1a49-c2c6-739fe2caa3e9@siemens.com>
Date: Fri, 16 Nov 2018 15:04:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 CONTRIBUTING.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index e6bb851471..ad50c8b67a 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -19,7 +19,8 @@ Contribution Checklist
 
 - structure patches logically, in small steps [**required**]
     - one separable functionality/fix/refactoring = one patch
-    - do not mix those there in a single patch
+    - do not mix those three into a single patch (e.g. first refactor, then
+      add a new functionality that builds onto the refactoring)
     - after each patch, the tree still has to build and work, i.e. do not add
       even temporary breakages inside a patch series (helps when tracking down
       bugs)
-- 
2.16.4

