From: Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] debian: Enable dlopen-libs in userspace package
Date: Tue, 21 Jan 2020 19:34:01 +0100
Message-Id: <20200121183401.24327-1-henning.schild@siemens.com>
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

From: Henning Schild <henning.schild@siemens.com>

This feature might not be widely used but those debian packages are
supposed to be generic. Having it default on brings more benefits than
drawbacks for generic packages.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 debian/rules | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/debian/rules b/debian/rules
index 68e7a4e37..22c90586d 100755
--- a/debian/rules
+++ b/debian/rules
@@ -19,7 +19,8 @@ CONFIG_OPTS = --prefix=/usr \
             --with-testdir=/usr/lib/xenomai/testsuite \
             --enable-smp \
             --enable-lazy-setsched \
-            --enable-debug=symbols
+            --enable-debug=symbols \
+            --enable-dlopen-libs
 
 ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
-- 
2.24.1


