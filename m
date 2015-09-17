From: Henning Schild <henning.schild@siemens.com>
Date: Thu, 17 Sep 2015 14:46:33 +0200
Message-Id: <1442493995-25337-2-git-send-email-henning.schild@siemens.com>
In-Reply-To: <1442493995-25337-1-git-send-email-henning.schild@siemens.com>
References: <20150917143955.01a71eb6@md1em3qc>
 <1442493995-25337-1-git-send-email-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH xenomai2 2/2] scripts: make kernel 4.x ready
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 scripts/prepare-kernel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 021c650..ac438c6 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -456,7 +456,7 @@ case $linux_VERSION.$linux_PATCHLEVEL in
     #  Linux v2.6 and 3.x section
     #
 
-    2.6|3.*)
+    2.6|3.*|4.*)
 
     config_file=Kconfig
 
-- 
2.4.6


