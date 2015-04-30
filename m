From: Henning Schild <henning.schild@siemens.com>
Date: Thu, 30 Apr 2015 13:59:54 +0200
Message-Id: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH] debian: remove xeno-config from libxenomai-dev
	package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Since 8871363fa57266af4c8d8a06965f2898b940fb48 the binary and its man-page
are in the base package (xenomai-runtime). Remove the files from the -dev
package to resolve the current package conflict.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 debian/libxenomai-dev.install | 2 --
 1 file changed, 2 deletions(-)

diff --git a/debian/libxenomai-dev.install b/debian/libxenomai-dev.install
index 40ae57d..7b107cb 100644
--- a/debian/libxenomai-dev.install
+++ b/debian/libxenomai-dev.install
@@ -1,8 +1,6 @@
-usr/bin/xeno-config
 usr/include
 usr/lib/*.la
 usr/lib/*.a
 usr/lib/*.so
 usr/lib/cobalt.wrappers
 usr/lib/dynlist.ld
-usr/share/man/man1/xeno-config.1
-- 
1.9.1


