From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 2/3] linux-xenomai: Fix arm64 SRC_URI
Date: Mon, 26 Nov 2018 16:08:24 +0100
Message-Id: <7a5b92cbddb09476a49347be13f9be5c078fd58e.1543244905.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543244905.git.jan.kiszka@siemens.com>
References: <cover.1543244905.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543244905.git.jan.kiszka@siemens.com>
References: <cover.1543244905.git.jan.kiszka@siemens.com>
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

Use the stable branch, the split one no longer exists.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.14.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai_4.14.bb b/recipes-kernel/linux/linux-xenomai_4.14.bb
index 1bc139c..c668d75 100644
--- a/recipes-kernel/linux/linux-xenomai_4.14.bb
+++ b/recipes-kernel/linux/linux-xenomai_4.14.bb
@@ -15,7 +15,7 @@ SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=htt
 SRCREV_amd64 = "5dec184b4c190bd3ef4d448fc80c7f2251cfd744"
 PV_amd64 = "4.14.78+"
 
-SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=v4.14.71-split"
+SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=stable/4.14.71-arm64"
 SRCREV_arm64 = "d24e3f9e425af92f4a181306d22d4b799e71a370"
 PV_arm64 = "4.14.71+"
 
-- 
2.16.4


