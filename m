From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 13 Feb 2018 13:38:20 +0100
Message-Id: <9b9ea70134ab04dafd1dbb7130631639c6460225.1518525088.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518525088.git.henning.schild@siemens.com>
References: <cover.1518525088.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518525088.git.henning.schild@siemens.com>
References: <cover.1518525088.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 2/3] debian: add mssing build dependency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Fixes the following error:

> configure.ac:93: error: possibly undefined macro: LT_SYS_SYMBOL_USCORE
>       If this token and others are legitimate, please use m4_pattern_allow.
>       See the Autoconf documentation.
> autoreconf: /usr/bin/autoconf failed with exit status: 1

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 debian/control | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/debian/control b/debian/control
index 425f00741..3427987e1 100644
--- a/debian/control
+++ b/debian/control
@@ -2,8 +2,7 @@ Source: xenomai
 Section: devel
 Priority: extra
 Maintainer: Xenomai <xenomai@xenomai.org>
-Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool,
- pkg-config
+Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool, pkg-config, libltdl-dev
 Standards-Version: 3.9.3
 Homepage: http://www.xenomai.org/
 
-- 
2.13.6


