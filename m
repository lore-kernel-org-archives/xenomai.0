From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] build: Disable -Wformat-truncation
Message-ID: <ba35be04-cea2-bc1b-07b6-938af921b35a@siemens.com>
Date: Fri, 6 Aug 2021 19:18:53 +0200
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

This is default-on in Debian 11 and triggers in heapobj_pkg_init_shared
or heapobj_bind_session without adding value - we truncate for good
reasons.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index bd5fd5ba9a..b6742c4b92 100644
--- a/configure.ac
+++ b/configure.ac
@@ -692,7 +692,8 @@ fi
 dnl Internal CFLAGS and LDFLAGS, may be enhanced per-arch below
 XENO_USER_CFLAGS="$XENO_USER_APP_CFLAGS -pipe -fstrict-aliasing \
 -Wall -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long \
--Wno-unused-parameter -Werror -Wformat-security -D__XENO__ -D__IN_XENO__"
+-Wno-unused-parameter -Wno-format-truncation -Werror -Wformat-security \
+-D__XENO__ -D__IN_XENO__"
 if test x$want_fortify = xyes -a x$debug_mode != xfull; then
    XENO_USER_CFLAGS="$XENO_USER_CFLAGS -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2"
 fi
-- 
2.31.1

