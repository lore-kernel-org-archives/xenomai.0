From: Henning Schild <henning.schild@siemens.com>
Date: Wed, 28 Oct 2015 12:15:16 +0100
Message-Id: <1446030916-6963-1-git-send-email-henning.schild@siemens.com>
In-Reply-To: <20151028105140.GA26607@hermes.click-hack.org>
References: <20151028105140.GA26607@hermes.click-hack.org>
Subject: [Xenomai] [PATCH v4] scripts: use mktemp instead of relying on
	TMPDIR beeing in env
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

The environment variable TMPDIR is optional and not always set. We could
test for it and fall back to /tmp/ or just use the tool mktemp.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 scripts/prepare-kernel.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 8e960e8..333d11c 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -238,9 +238,9 @@ fi
 # Create an empty output patch file, and initialize the temporary tree.
 if test "x$output_patch" != "x"; then
 
-    temp_tree=$TMPDIR/prepare-kernel-$$
-    if ! mkdir $temp_tree; then
-	echo Temporary directory $temp_tree already exists, aborting.
+    temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
+    if [ $? -ne 0 ]; then
+	echo Temporary directory could not be created.
 	exit 1
     fi
 
-- 
2.4.10


