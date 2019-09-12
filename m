From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH v2] debian/rules: Add debug symbols
Date: Thu, 12 Sep 2019 12:02:11 +0200
Message-Id: <20190912100211.10656-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <486f677a-f3d9-acb3-9113-bb607f87acb8@siemens.com>
References: <486f677a-f3d9-acb3-9113-bb607f87acb8@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Configure debian build with debugging symbols to allow debugging.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 debian/rules | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 08562c7ab..06e3523a6 100755
--- a/debian/rules
+++ b/debian/rules
@@ -17,7 +17,8 @@ CONFIG_OPTS = --prefix=/usr \
             --includedir=/usr/include/xenomai \
             --mandir=/usr/share/man \
             --with-testdir=/usr/lib/xenomai/testsuite \
-            --enable-smp
+            --enable-smp \
+            --enable-debug=symbols
 
 ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
-- 
2.20.1


