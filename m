Message-ID: <50ED750B.4010606@siemens.com>
Date: Wed, 09 Jan 2013 14:47:55 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] prepare-kernel: Only purge links from target
	directories
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Only remove files from the target directory of patch_link if they are
missing in Xenomai AND are actually symbolic links. This is required
when merging Xenomai directories into non-empty kernel dirs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is not required for the current patch workload but helps us in 2.6
with integrating ftrace (we patch into include/trace/events there).
Would reduce our queue length by one if this could be merged
nevertheless.

 scripts/prepare-kernel.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 36f9a4a..5f4043a 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -103,7 +103,7 @@ patch_link() {
 	    find . $recursive_opt \( $directorytype_opt \
                 $link_makefiles_opt -name $config_file -o -name '*.[chS]' \) |
             while read f; do
-                if test ! -e $xenomai_root/$target_dir/$f; then rm -Rf $f; fi
+                if test -L $f -a ! -e $xenomai_root/$target_dir/$f; then rm -Rf $f; fi
             done
         fi
 
-- 
1.7.3.4

