From: gernot.hillier@siemens.com
Date: Fri,  8 Nov 2013 10:34:18 +0100
Message-Id: <1383903263-10441-3-git-send-email-gernot.hillier@siemens.com>
In-Reply-To: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
References: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
Subject: [Xenomai] [Xenomai-forge PATCH 2/7] debian: add missing directory
	creation (cherry picked from commit
	2de3997cf4a98fcd43b5d8a246aa6abe15135eca)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jeff Webb <jeff.webb@nta-inc.net>

---
 debian/rules | 1 +
 1 file changed, 1 insertion(+)

diff --git a/debian/rules b/debian/rules
index f6569f6..83e175c 100755
--- a/debian/rules
+++ b/debian/rules
@@ -96,6 +96,7 @@ install: build
 	$(MAKE) install DESTDIR=$(CURDIR)/debian/tmp/
 	dh_install --sourcedir=$(CURDIR)/debian/tmp
 	# Patch collection:
+	mkdir -p $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
 	cp adeos-ipipe-*.patch $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
 	# xeno-config should be only in libxenomai-dev
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
-- 
1.8.1.2


