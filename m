From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] debian: Enable SMP in userspace package
Message-ID: <642220e6-22b9-a4fa-691b-1829db4f8ada@siemens.com>
Date: Tue, 6 Nov 2018 19:41:53 +0100
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

Hard to find a UP target these days, and we definitely want to be
generic with Debian packages.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 debian/rules | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 99ed8982ce..883ae3ed8c 100755
--- a/debian/rules
+++ b/debian/rules
@@ -16,7 +16,8 @@ DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
 CONFIG_OPTS = --prefix=/usr \
             --includedir=/usr/include/xenomai \
             --mandir=/usr/share/man \
-	    --with-testdir=/usr/lib/xenomai/testsuite
+            --with-testdir=/usr/lib/xenomai/testsuite \
+            --enable-smp
 
 ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
-- 
2.16.4

