From: Evan Gates <evan.gates@gmail.com>
Subject: [PATCH v2] meson: allow use of installed uapi headers
Date: Fri,  4 Mar 2022 12:02:05 -0700
Message-Id: <20220304190205.24489-1-egates@cardinalpeak.com>
In-Reply-To: <20220302233443.14696-1-egates@cardinalpeak.com>
References: <20220302233443.14696-1-egates@cardinalpeak.com>
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
the existence of $UAPI/Kbuild as an heuristic to decide whether $UAPI
pointed to linux-evl source or to installed headers.

Rewrite the script to check for the existence of all three required
directories in either location.  This allows the use of installed
headers again.

Fixes: c70a9d9 (build: tighten consistency check for uapi)
---

Changes in v2:

- Switch back to Kbuild heuristic in order to check/set the correct path
for the asm directory

- Add the missing directory back to the error message

- Actually test with both setups, not sure how I messed that up last time


 meson/setup-uapi.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
index 1b43c02..f27a07e 100644
--- a/meson/setup-uapi.sh
+++ b/meson/setup-uapi.sh
@@ -1,19 +1,19 @@
 #! /bin/sh
 
-if test \! -d $UAPI/include/uapi/evl; then
-    echo "meson: path given to -Duapi does not look right ($UAPI/include/uapi/evl is missing)"
-    exit 1
+if test -r $UAPI/Kbuild; then
+	set \
+		$UAPI/arch/$ARCH/include/uapi/asm \
+		$UAPI/include/uapi/asm-generic \
+		$UAPI/include/uapi/evl
+else
+	set $UAPI/asm $UAPI/asm-generic $UAPI/evl
 fi
 
-mkdir -p $O_UAPI
-rm -f $O_UAPI/asm $O_UAPI/asm-generic $O_UAPI/evl
+for d do
+	test -d $d && continue
+	echo "meson: path given to -Duapi does not look right ($d is missing)"
+	exit 1
+done
 
-if test -r $UAPI/Kbuild; then
-    ln -s $UAPI/arch/$ARCH/include/uapi/asm $O_UAPI/asm
-    ln -s $UAPI/include/uapi/asm-generic $O_UAPI/asm-generic
-    ln -s $UAPI/include/uapi/evl $O_UAPI/evl
-elif test \! -L	$O_UAPI/asm; then
-    ln -s $UAPI/asm $O_UAPI/asm
-    ln -s $UAPI/asm-generic $O_UAPI/asm-generic
-    ln -s $UAPI/evl $O_UAPI/evl
-fi
+mkdir -p $O_UAPI
+for d do ln -sf $d $O_UAPI/; done
-- 
2.33.0


