From: Henning Schild <henning.schild@siemens.com>
Date: Thu,  5 Nov 2015 19:22:32 +0100
Message-Id: <1446747752-8396-1-git-send-email-henning.schild@siemens.com>
In-Reply-To: <20151105105550.GB16314@hermes.click-hack.org>
References: <20151105105550.GB16314@hermes.click-hack.org>
Subject: [Xenomai] [PATCH] scripts: increase number of Xs in mktemp template
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

In a5cfe9c9a8dbcc094b0c5043b21fa6cde7fc42e5 the use of mktemp was
introduces. Some versions of mktemp seem to require a template of at
least 6 Xs.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 scripts/prepare-kernel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 333d11c..b75acf9 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -238,7 +238,7 @@ fi
 # Create an empty output patch file, and initialize the temporary tree.
 if test "x$output_patch" != "x"; then
 
-    temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
+    temp_tree=`mktemp -d prepare-kernel-XXXXXX --tmpdir`
     if [ $? -ne 0 ]; then
 	echo Temporary directory could not be created.
 	exit 1
-- 
2.4.10


