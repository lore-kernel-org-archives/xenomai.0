Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <8408c1f1192fcb031f0e.1481882197@devws148.be.alcatel-lucent.com>
Date: Fri, 16 Dec 2016 10:56:37 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH] psos: avoid including standard header files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

To keep the namespace as clean as possible for the applications
don't include standard header files.

diff --git a/include/psos/psos.h b/include/psos/psos.h
--- a/include/psos/psos.h
+++ b/include/psos/psos.h
@@ -24,7 +24,7 @@
 #ifndef _XENOMAI_PSOS_PSOS_H
 #define _XENOMAI_PSOS_PSOS_H
 
-#include <sys/types.h>
+typedef unsigned long u_long;
 
 #ifndef SUCCESS
 #define SUCCESS 0

