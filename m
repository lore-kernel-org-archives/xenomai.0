From: gernot.hillier@siemens.com
Date: Fri,  8 Nov 2013 10:34:21 +0100
Message-Id: <1383903263-10441-6-git-send-email-gernot.hillier@siemens.com>
In-Reply-To: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
References: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
Subject: [Xenomai] [Xenomai-forge PATCH 5/7] debian: cleanup configure
	invocation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gernot Hillier <gernot.hillier@siemens.com>

Remove duplicated testdir setting. This re-adds a useful part of
c6264554 reverted in 9445b03a. We shall not override/extend CONFIG_OPTS
as it's also used for the package description of libxenomai1 (see
binary-arch target).

Signed-off-by: Gernot Hillier <gernot.hillier@siemens.com>
(cherry picked from commit 4c88b115402a6e1d5020115c28f776f216f6e596)
---
 debian/rules | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/debian/rules b/debian/rules
index 643173c..7e5223a 100755
--- a/debian/rules
+++ b/debian/rules
@@ -14,7 +14,7 @@ DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
 CONFIG_OPTS = --prefix=/usr \
             --includedir=/usr/include/xenomai \
             --mandir=/usr/share/man \
-	    --with-testdir=/usr/lib/xenomai
+	    --with-testdir=/usr/lib/xenomai/testsuite
 
 ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
@@ -46,7 +46,7 @@ config.status: configure-stamp
 configure-stamp:
 	dh_testdir
 	autoreconf -fi
-	./configure $(CONFIG_OPTS) --with-testdir=/usr/lib/xenomai/testsuite
+	./configure $(CONFIG_OPTS)
 	touch configure-stamp
 
 clean:
-- 
1.8.1.2


