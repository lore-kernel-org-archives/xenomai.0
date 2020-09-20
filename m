From: Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH] libs: Add linking dependency for libmodechk
Date: Sun, 20 Sep 2020 22:21:18 +0300
Message-Id: <20200920192118.13099-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

When building Cobalt core ALT rpmbuild QA script detects that libmodechk
is linked improperly:

verify-elf: ERROR: ./usr/lib64/libmodechk.so.0.0.0: undefined symbol: cobalt_assert_nrt

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 lib/cobalt/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 5230a38ec..ae408b863 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -42,6 +42,8 @@ libcobalt_la_CPPFLAGS =			\
 	-I$(top_srcdir)/include/cobalt	\
 	-I$(top_srcdir)/include
 
+libmodechk_la_LIBADD = libcobalt.la
+
 libmodechk_la_SOURCES =	\
 	malloc.c	\
 	malloc-nowrap.c
-- 
2.21.0


