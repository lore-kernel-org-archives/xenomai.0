From: Evan Gates <evan.gates@gmail.com>
Subject: [PATCH] meson: allow use of installed uapi headers
Date: Wed,  2 Mar 2022 16:34:43 -0700
Message-Id: <20220302233443.14696-1-egates@cardinalpeak.com>
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

Commit c70a9d9d536aefcf6574328aaac0fcc86f9ab0f7 added a test for
$UAPI/include/uapi/evl that was meant to ensure the given $UAPI path was
correct.  That test meant that $UAPI had to point to a linux-evl source
directory and could not point to installed headers in e.g. /usr/include.
The script had previously allowed the use of installed headers, using
the existence of $UAPI/Kbuild as an hueristic to decide whether $UAPI
pointed to linux-evl source or to installed headers.

Rewrite the script to check for the existence of all three required
directories (asm, asm-generic, evl) in two possible locations ($UAPI,
$UAPI/include/uapi).  This once again allows the use of installed headers,
and gets rid of the heuristic, instead testing for the actual directories.

Fixes: c70a9d9 (build: tighten consistency check for uapi)
---
 meson/setup-uapi.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
index 1b43c02..bb96e86 100644
--- a/meson/setup-uapi.sh
+++ b/meson/setup-uapi.sh
@@ -1,19 +1,17 @@
 #! /bin/sh
 
-if test \! -d $UAPI/include/uapi/evl; then
-    echo "meson: path given to -Duapi does not look right ($UAPI/include/uapi/evl is missing)"
-    exit 1
-fi
+set evl asm asm-generic
 
-mkdir -p $O_UAPI
-rm -f $O_UAPI/asm $O_UAPI/asm-generic $O_UAPI/evl
+for uapi in $UAPI/include/uapi $UAPI; do
+	for d do test -d $uapi/$d || continue 2; done
+	found=1
+	break
+done
 
-if test -r $UAPI/Kbuild; then
-    ln -s $UAPI/arch/$ARCH/include/uapi/asm $O_UAPI/asm
-    ln -s $UAPI/include/uapi/asm-generic $O_UAPI/asm-generic
-    ln -s $UAPI/include/uapi/evl $O_UAPI/evl
-elif test \! -L	$O_UAPI/asm; then
-    ln -s $UAPI/asm $O_UAPI/asm
-    ln -s $UAPI/asm-generic $O_UAPI/asm-generic
-    ln -s $UAPI/evl $O_UAPI/evl
+if [ ! "$found" ]; then
+	echo meson: path given to -Duapi does not look right
+	exit 1
 fi
+
+mkdir -p $O_UAPI
+for d do ln -sf $uapi/$d $O_UAPI/$d; done
-- 
2.33.0


