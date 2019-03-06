From: roman.stratiienko@globallogic.com
Subject: [PATCH v2 04/10] kernel: cobalt: forward SRCARCH from the
 scripts/prepare-kernel.sh
Date: Wed,  6 Mar 2019 19:53:25 +0200
Message-Id: <20190306175331.25444-4-roman.stratiienko@globallogic.com>
In-Reply-To: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
References: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

$SRCARCH removed since v4.18-rc1, upstream commit 104daea149c4
("kconfig: reference environment variables directly and remove 'option env='")

This will fix build with v4.18

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 scripts/Kconfig.frag      | 2 +-
 scripts/prepare-kernel.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index cd39f7670..c9655d43a 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -16,7 +16,7 @@ menuconfig XENOMAI
 	  Please visit http://xenomai.org for more information.
 
 if XENOMAI
-source "arch/$SRCARCH/xenomai/Kconfig"
+source "arch/@SRCARCH@/xenomai/Kconfig"
 endif
 
 if MIGRATION
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 964e42e83..8707b1198 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -376,6 +376,7 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 	    -e "s,@VERSION_MINOR@,$version_minor,g" \
 	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
 	    -e "s,@VERSION_STRING@,$version_string,g" \
+	    -e "s,@SRCARCH@,$linux_arch,g" \
 	    $xenomai_root/scripts/Kconfig.frag |
             patch_append init/Kconfig
     fi
-- 
2.17.1


