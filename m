From: Henning Schild <henning.schild@siemens.com>
Date: Fri,  6 Nov 2015 11:33:02 +0100
Message-Id: <1446805982-11899-1-git-send-email-henning.schild@siemens.com>
In-Reply-To: <20151105183035.GH16314@hermes.click-hack.org>
References: <20151105183035.GH16314@hermes.click-hack.org>
Subject: [Xenomai] [PATCHv2] scripts: increase number of Xs in mktemp
	template
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
introduces. There are version of mktemp that are ok with less than six
Xs, but POSIX requires exactly six.
http://pubs.opengroup.org/onlinepubs/9699919799/functions/mkstemp.html

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


