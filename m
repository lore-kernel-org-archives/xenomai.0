From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Date: Wed,  8 Feb 2017 11:40:38 -1000
Message-Id: <1486590039-5193-1-git-send-email-dmitriy@mperpetuo.com>
Subject: [Xenomai] [PATCH v3 1/2] ipipe: add support for multiarch drivers
	to genpatches script
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Previous versions of genpatches.sh only allow one architecture
per driver. Since some drivers are shared between arm and arm64,
this adds new functionality to the script, allowing multiple
architectures to be specified per driver as a space-separated list.

Signed-off-by: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
---
 scripts/ipipe/genpatches.sh | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
index 9392a41..4c21c9c 100755
--- a/scripts/ipipe/genpatches.sh
+++ b/scripts/ipipe/genpatches.sh
@@ -123,6 +123,7 @@ match($0, /^diff --git a\/arch\/([^ \t\/]*)/) {
     split(substr($0, RSTART, RLENGTH), arch, /\//)
     a=arch[3]
 
+    is_multiarch=0
     set_current_arch(a)
     print $0 >> current_file
     next
@@ -137,14 +138,25 @@ match($0, /^diff --git a\/drivers\/([^ \t]*)/) {
 	 print "Error unknown architecture for driver "f
 	 unknown_file_error=1
     } else {
-	 a = driver_arch[f]
-	 set_current_arch(a)
-	 print $0 >> current_file
-	 next
+        a = driver_arch[f]
+        if(index(a, " ")) {
+            is_multiarch = 1
+            split(a, multiarch, " ")
+            for(a in multiarch) {
+                set_current_arch(multiarch[a])
+                print $0 >> current_file
+            }
+        } else {
+            is_multiarch = 0
+            set_current_arch(a)
+            print $0 >> current_file
+        }
+        next
     }
 }
 
 /^diff --git a\/scripts\/ipipe\/genpatches.sh/ {
+    is_multiarch=0
     if (splitmode == "no") {
 	current_file="/dev/null"
 	current_arch="nullarch"
@@ -154,6 +166,7 @@ match($0, /^diff --git a\/drivers\/([^ \t]*)/) {
 
 /^diff --git/ {
     set_current_arch("noarch")
+    is_multiarch=0
     print $0 >> current_file
     next
 }
@@ -164,7 +177,14 @@ match ($0, /#define [I]PIPE_CORE_RELEASE[ \t]*([^ \t]*)/) {
 }
 
 {
-    print $0 >> current_file
+    if(is_multiarch) {
+        for(a in multiarch) {
+            set_current_arch(multiarch[a])
+            print $0 >> current_file
+        }
+    } else {
+        print $0 >> current_file
+    }
 }
 
 END {
-- 
1.9.1


