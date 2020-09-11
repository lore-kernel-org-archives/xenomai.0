From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Subject: [PATCH] lib/cobalt: only compile __real___open[64]_2 wrappers if
 fortified
Date: Fri, 11 Sep 2020 08:32:27 +0000
Message-Id: <20200911083227.5477-1-leupold@rsi-elektrotechnik.de>
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
To: xenomai@xenomai.org

If Xenomai itself is not compiled with FORTIFY_SOURCE then the function
declarations for __open_2() and __open64_2() are not available.
__STD(__open_2(...)) will not link in this case (would be a very special
use case anyway?).

Signed-off-by: Jan Leupold <leupold@rsi-elektrotechnik.de>
---
 lib/cobalt/wrappers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 5d86607de..5ff6b63bc 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -205,6 +205,7 @@ int __real_open64(const char *path, int oflag, ...)
 }
 #endif
 
+#if __USE_FORTIFY_LEVEL > 0
 __weak
 int __real___open_2(const char *path, int oflag)
 {
@@ -216,6 +217,7 @@ int __real___open64_2(const char *path, int oflag)
 {
     return __open64_2(path, oflag);
 }
+#endif // __USE_FORTIFY_LEVEL > 0
 
 __weak
 int __real_socket(int protocol_family, int socket_type, int protocol)
-- 
2.20.1


-- 
_____________________________________________________________
R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
Fon: +49 8444 9204-0
Fax: +49 8444 9204-50
www.rsi-elektrotechnik.de

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Gesch���ftsf���hrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


