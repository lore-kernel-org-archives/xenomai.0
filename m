From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Date: Mon,  6 Feb 2017 14:51:38 -0800
Message-Id: <1486421498-31209-1-git-send-email-dmitriy@mperpetuo.com>
Subject: [Xenomai] [PATCH] ipipe: fix script name in genpatches usage output
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The script name was being output as "$me" when run with --help.
---
 scripts/ipipe/genpatches.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/ipipe/genpatches.sh b/scripts/ipipe/genpatches.sh
index 9392a41..07b6cf3 100755
--- a/scripts/ipipe/genpatches.sh
+++ b/scripts/ipipe/genpatches.sh
@@ -1,7 +1,7 @@
 #! /bin/sh
 
-me=`basename $0`
-usage='usage: $me [--split] [--help] [reference]'
+me=$(basename -- "$0")
+usage='usage: '"$me"' [--split] [--help] [reference]'
 split=no
 
 while test $# -gt 0; do
-- 
1.9.1


