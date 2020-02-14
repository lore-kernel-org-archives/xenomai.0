From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 1/2] recipes-kernel/linux-xenomai: Add support
 for DISTRO_ARCH i386
Date: Fri, 14 Feb 2020 09:38:18 +0100
Message-Id: <20200214083819.31451-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214083819.31451-1-Quirin.Gylstorff@siemens.com>
References: <20200214083819.31451-1-Quirin.Gylstorff@siemens.com>
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

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index ad3629b..3407b82 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -34,7 +34,7 @@ dpkg_runbuild_prepend() {
 	arm64)
 		ARCH=arm64
 		;;
-	amd64)
+	amd64|i386)
 		ARCH=x86
 		;;
 	*)
-- 
2.20.1


