From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] debian: Add config folder to xenomai-kernel-source
Message-ID: <387c3deb-4c48-97c9-04e8-e5bf349048e4@siemens.com>
Date: Tue, 6 Nov 2018 14:20:36 +0100
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

Meanwhile required for prepare-kernel.sh.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 debian/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 8b871a4882..99ed8982ce 100755
--- a/debian/rules
+++ b/debian/rules
@@ -73,7 +73,7 @@ install: build
 	cp debian/libxenomai1.lintian $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
 	cp debian/libxenomai-dev.lintian $(CURDIR)/debian/libxenomai-dev/usr/share/lintian/overrides/libxenomai-dev
 	mkdir -p $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source $(CURDIR)/debian/xenomai-kernel-source/usr/share/doc/xenomai-kernel-source
-	cp -a kernel include scripts $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
+	cp -a config kernel include scripts $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
 
 # Build architecture-independent files here.
 binary-indep: build install
-- 
2.16.4

