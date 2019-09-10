From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] demo-image: Add dbus package
Message-ID: <f2feda16-2099-042b-3681-0f7182218fc3@siemens.com>
Date: Tue, 10 Sep 2019 12:28:52 +0200
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

WPA supplicant is looking for this. It worked nevertheless but gave an
ugly error during boot.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/demo-image.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 8afad67..c611a37 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -17,7 +17,7 @@ DESCRIPTION = "Xenomai demo and test image"
 IMAGE_PREINSTALL += " \
     bash-completion less vim nano man \
     ifupdown isc-dhcp-client net-tools iputils-ping ssh \
-    iw wireless-tools wpasupplicant \
+    iw wireless-tools wpasupplicant dbus \
     gdb"
 
 IMAGE_INSTALL += "xenomai-runtime"
-- 

2.16.4

