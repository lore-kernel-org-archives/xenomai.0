Message-ID: <4F2BF442.9080308@domain.hid>
Date: Fri, 03 Feb 2012 15:50:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Only export required CFLAGS via xeno-config
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

-Werror-implicit-function-declaration is not compatible with C++, and
also decisions about -Wall and -pipe should be left to the application.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 configure.in |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/configure.in b/configure.in
index b2563ee..2185925 100644
--- a/configure.in
+++ b/configure.in
@@ -448,13 +448,13 @@ else
 fi
 AC_MSG_RESULT([done])
 
-dnl Common CFLAGS and LDFLAGS
-XENO_USER_CFLAGS="-D_GNU_SOURCE -D_REENTRANT -Wall -Werror-implicit-function-declaration -pipe"
-XENO_USER_LDFLAGS=
+dnl Exported CFLAGS and LDFLAGS, shared with internal flags
+XENO_USER_APP_CFLAGS="-D_GNU_SOURCE -D_REENTRANT"
+XENO_USER_APP_LDFLAGS=
 
-dnl Exported CFLAGS and LDFLAGS, may be enhanced per-arch below
-XENO_USER_APP_CFLAGS=$XENO_USER_CFLAGS
-XENO_USER_APP_LDFLAGS=$XENO_USER_LDFLAGS
+dnl Internal CFLAGS and LDFLAGS, may be enhanced per-arch below
+XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -Werror-implicit-function-declaration -pipe"
+XENO_USER_LDFLAGS="$XENO_USER_APP_LDFLAGS"
 
 case $XENO_TARGET_ARCH in
  x86)
-- 
1.7.3.4

