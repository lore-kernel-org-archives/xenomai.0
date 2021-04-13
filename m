From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] debian: Fix packaging of xeno-config
Message-ID: <d4124d9d-86c7-8f47-76db-0586217ec10e@siemens.com>
Date: Tue, 13 Apr 2021 21:04:24 +0200
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

This is not a runtime tool, it's for development. And as libxenomai-dev
has no dependency on xenomai-runtime (as there should be none), it is
missed in build-only installations.

Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Fixes: 6e77fe2b8d3f ("debian: drop xeno-config from -dev package")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 debian/libxenomai-dev.install | 1 +
 debian/rules                  | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/debian/libxenomai-dev.install b/debian/libxenomai-dev.install
index 9f95c359c4..a8e6b4e339 100644
--- a/debian/libxenomai-dev.install
+++ b/debian/libxenomai-dev.install
@@ -1,3 +1,4 @@
+usr/bin/xeno-config
 usr/include
 usr/lib/*.la
 usr/lib/*.a
diff --git a/debian/rules b/debian/rules
index 22c90586d1..3fc65ef3a2 100755
--- a/debian/rules
+++ b/debian/rules
@@ -73,9 +73,8 @@ install: build
 	for f in $(CURDIR)/kernel/cobalt/udev/*.rules ; do \
 	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
 	done
-	# xeno-config should be only in xenomai-runtime
-	rm -f $(CURDIR)/debian/libxenomai-dev/usr/bin/xeno-config
-	rm -f $(CURDIR)/debian/libxenomai-dev/usr/share/man/man1/xeno-config.1
+	# xeno-config should be only in libxenomai-dev
+	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
 	install -m 644 debian/libxenomai1.modprobe $(CURDIR)/debian/libxenomai1/etc/modprobe.d/xenomai.conf
 	# remove empty directory
 	rm -rf $(CURDIR)/debian/xenomai-doc/usr/share/doc/xenomai-doc/ps
-- 
2.26.2


