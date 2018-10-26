From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 5/9] boilerplate/compiler: drop __const and __pure shorthands
Date: Fri, 26 Oct 2018 16:08:21 +0200
Message-Id: <20181026140825.5251-5-rpm@xenomai.org>
In-Reply-To: <20181026140825.5251-1-rpm@xenomai.org>
References: <20181026140825.5251-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

We have no in-tree users for these anymore. Besides, __const may be
conflicting with different definitions from legacy libc headers.
---
 include/boilerplate/compiler.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
index f526eb269..ffeb6a4db 100644
--- a/include/boilerplate/compiler.h
+++ b/include/boilerplate/compiler.h
@@ -46,14 +46,6 @@
 #define __weak		__attribute__((__weak__))
 #endif
 
-#ifndef __const
-#define __const		__attribute__((__const__))
-#endif
-
-#ifndef __pure
-#define __pure		__attribute__((__pure__))
-#endif
-
 #ifndef __maybe_unused
 #define __maybe_unused	__attribute__((__unused__))
 #endif
-- 
2.17.2


