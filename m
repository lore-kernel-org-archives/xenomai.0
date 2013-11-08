From: gernot.hillier@siemens.com
Date: Fri,  8 Nov 2013 10:34:19 +0100
Message-Id: <1383903263-10441-4-git-send-email-gernot.hillier@siemens.com>
In-Reply-To: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
References: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
Subject: [Xenomai] [Xenomai-forge PATCH 3/7] debian: adapt to latest I-pipe
	core patches (cherry picked from commit
	89ff2edf76dae49e4a3643f17e118954b68a692e)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

---
 debian/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 83e175c..650c419 100755
--- a/debian/rules
+++ b/debian/rules
@@ -97,7 +97,7 @@ install: build
 	dh_install --sourcedir=$(CURDIR)/debian/tmp
 	# Patch collection:
 	mkdir -p $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
-	cp adeos-ipipe-*.patch $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
+	cp *ipipe-*.patch $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai
 	# xeno-config should be only in libxenomai-dev
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-config.1
-- 
1.8.1.2


