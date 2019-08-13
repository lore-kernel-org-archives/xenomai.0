From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH] debian/rules: dh_strip exclude smokey
Date: Tue, 13 Aug 2019 18:56:28 +0200
Message-Id: <20190813165628.31705-1-Quirin.Gylstorff@siemens.com>
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
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To execute the smokey testsuite it is necessary to hold debug dbg
symbols to test gdb. Debian normally strips all debug symbols from
all build results. Exclude all components containing smokey from
stripping.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 debian/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 883ae3ed8..3d5729c22 100755
--- a/debian/rules
+++ b/debian/rules
@@ -102,7 +102,7 @@ binary-arch: build install
 	dh_installdocs -s -A README
 	dh_link -s
 	dh_installchangelogs -s
-	dh_strip -s
+	dh_strip -s --exclude=smokey
 	dh_compress -s
 	dh_fixperms -s
 	dh_makeshlibs -s
-- 
2.20.1


