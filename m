From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite: smokey: Fix CFLAGS for gdb test
Message-ID: <134b4aa5-ef4e-1835-8b9b-9691fcb19ca4@siemens.com>
Date: Fri, 12 Jul 2019 17:21:27 +0200
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

CXXFLAGS is for C++, but we are C here. That misplacement cause the
non-debug build of the testcase to fail due to missing symbols.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/gdb/Makefile.am | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/gdb/Makefile.am b/testsuite/smokey/gdb/Makefile.am
index 987d6ee2d5..9c0843d9bf 100644
--- a/testsuite/smokey/gdb/Makefile.am
+++ b/testsuite/smokey/gdb/Makefile.am
@@ -8,6 +8,5 @@ CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 libgdb_a_CPPFLAGS = 		\
 	@XENO_USER_CFLAGS@	\
 	-I$(top_srcdir)		\
-	-I$(top_srcdir)/include
-
-libgdb_a_CXXFLAGS = -g -O0
+	-I$(top_srcdir)/include	\
+	-g -O0
-- 
2.16.4

