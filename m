Subject: [xenomai-images][PATCH 4/3] README: Fix image path
References: <cover.1542981269.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1d30efcb-14a1-d723-8365-f36303f9b4bc@siemens.com>
Date: Fri, 23 Nov 2018 15:41:13 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1542981269.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org

Copy&paste mistake, plus outdated path structure by now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 44d056d..f7efbe4 100644
--- a/README.md
+++ b/README.md
@@ -33,7 +33,7 @@ installed.
 Physical targets will generate read-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run
 
-    dd if=build/tmp/deploy/images/ebsy-image-base-long-life-ebsy-simatic-ipc227e.wic.img \
+    dd if=build/tmp/deploy/images/hikey/demo-image-hikey-xenomai-demo-hikey.wic.img \
        of=/dev/<medium-device> bs=1M status=progress
 
 ## Community Resources
-- 
2.16.4

