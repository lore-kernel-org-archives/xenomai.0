From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib: Drop unused copperplate/wrappers.h
Message-ID: <e6c263f5-80d1-7eac-7d9e-e511705242f6@siemens.com>
Date: Tue, 16 Feb 2021 11:10:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Internal header, broken for mercury and not used anymore.

Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/copperplate/Makefile.am |  3 +--
 include/copperplate/wrappers.h  | 30 ------------------------------
 2 files changed, 1 insertion(+), 32 deletions(-)
 delete mode 100644 include/copperplate/wrappers.h

diff --git a/include/copperplate/Makefile.am b/include/copperplate/Makefile.am
index 5b97c63d14..5baa09bdf9 100644
--- a/include/copperplate/Makefile.am
+++ b/include/copperplate/Makefile.am
@@ -13,8 +13,7 @@ includesub_HEADERS =		\
 	threadobj.h		\
 	timerobj.h		\
 	traceobj.h		\
-	tunables.h		\
-	wrappers.h
+	tunables.h
 
 noinst_HEADERS =		\
 	registry-obstack.h
diff --git a/include/copperplate/wrappers.h b/include/copperplate/wrappers.h
deleted file mode 100644
index a7c68f5cb8..0000000000
--- a/include/copperplate/wrappers.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2011 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
-
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-
-#ifndef _COPPERPLATE_WRAPPERS_H
-#define _COPPERPLATE_WRAPPERS_H
-
-#include <xeno_config.h>
-
-#ifdef CONFIG_XENO_COBALT
-#include <cobalt/wrappers.h>
-#else /* CONFIG_XENO_MERCURY */
-#include <mercury/wrappers.h>
-#endif /* CONFIG_XENO_MERCURY */
-
-#endif /* _COPPERPLATE_WRAPPERS_H */
-- 
2.26.2


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

