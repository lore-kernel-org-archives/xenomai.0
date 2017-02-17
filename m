From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 17 Feb 2017 14:48:13 +0100
Message-Id: <20170217134813.23980-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH] debian/control: add pkg-config as build dep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Required for PKG_CHECK_MODULES that is used for fuse in configure

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 debian/control | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/debian/control b/debian/control
index 2225648..86e8e37 100644
--- a/debian/control
+++ b/debian/control
@@ -2,7 +2,8 @@ Source: xenomai
 Section: devel
 Priority: extra
 Maintainer: Xenomai <xenomai@xenomai.org>
-Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool
+Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool,
+ pkg-config
 Standards-Version: 3.9.3
 Homepage: http://www.xenomai.org/
 
-- 
2.10.2


