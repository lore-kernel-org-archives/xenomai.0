From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] ipipe: genpatches.sh: allow overriding the default version
 label
Message-ID: <ef887b61-98bc-3ea7-adec-70a68121eaa6@xenomai.org>
Date: Sun, 21 Apr 2019 17:21:12 +0200
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
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>


From: Philippe Gerum <rpm@xenomai.org>

In order to support localversion* variants like -cip, the automated
patch generator needs to override the default version label used by
genpatches.sh with 4.4 and 4.9 legacy kernels.
    
Use --label to override the default kernel version label in the output
file name. Otherwise, use the kernel release stamp.
    
Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 scripts/ipipe/genpatches.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
index cb83b6aed8fb..b37e8e23c188 100755
--- a/scripts/ipipe/genpatches.sh
+++ b/scripts/ipipe/genpatches.sh
@@ -1,7 +1,7 @@
 #! /bin/sh
 
 me=`basename $0`
-usage='usage: $me [--split] [--help] [reference]'
+usage='usage: $me [--split] [--label <label>] [--help] [reference]'
 split=no
 
 while test $# -gt 0; do
@@ -9,6 +9,10 @@ while test $# -gt 0; do
     --split)
 	split=yes
 	;;
+    --label)
+	shift
+	label=$1
+	;;
     --help)
 	echo "$usage"
 	exit 0
@@ -42,9 +46,13 @@ if [ -z "$reference" ]; then
     reference="v$kvers"
 fi
 
+if [ -z "$label" ]; then
+    label="$kvers"
+fi
+
 echo reference: $reference, kernel version: $kvers
 
-git diff "$reference" | awk -v kvers="$kvers" -v splitmode="$split" \
+git diff "$reference" | awk -v kvers="$kvers" -v label="$label" -v splitmode="$split" \
 'function set_current_arch(a)
 {
     if (!outfiles[a]) {
@@ -213,14 +221,14 @@ END {
 	    if (a != "noarch")
 		system("rm "outfiles[a])
 	} else if (a != "noarch") {
-	    dest="ipipe-core-"kvers"-"a"-"version[a]".patch"
+	    dest="ipipe-core-"label"-"a"-"version[a]".patch"
 	    close(outfiles[a])
 	    system("mv "outfiles[a]" "dest)
 	    if (splitmode == "no")
 		system("cat "outfiles["noarch"]" >> "dest)
 	    print dest
 	} else if (splitmode == "yes") {
-	    dest="ipipe-core-"kvers"-"a".patch"
+	    dest="ipipe-core-"label"-"a".patch"
 	    system("cat "outfiles["noarch"]" > "dest)
 	    print dest
 	}

-- 
Philippe.

