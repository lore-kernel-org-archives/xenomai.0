From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 7/7] debian: Enable lazy-setsched in userspace package
Date: Tue,  3 Dec 2019 12:32:17 +0100
Message-Id: <1070b04bc3c5d886efef0cad7d02ae6252eaf07b.1575372737.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575372737.git.jan.kiszka@siemens.com>
References: <cover.1575372737.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575372737.git.jan.kiszka@siemens.com>
References: <cover.1575372737.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This feature is useful for applications tuning scheduling parameters
from within RT contexts. Primarily a topic for legacy applications. But
as this doesn't come with noteworthy downsides, make it available in the
generic package configuration.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 debian/rules | 1 +
 1 file changed, 1 insertion(+)

diff --git a/debian/rules b/debian/rules
index 06e3523a6c..68e7a4e378 100755
--- a/debian/rules
+++ b/debian/rules
@@ -18,6 +18,7 @@ CONFIG_OPTS = --prefix=/usr \
             --mandir=/usr/share/man \
             --with-testdir=/usr/lib/xenomai/testsuite \
             --enable-smp \
+            --enable-lazy-setsched \
             --enable-debug=symbols
 
 ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
-- 
2.16.4


