From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Add new GPIO Cherryview driver
Message-ID: <fbf485e1-4ab1-c765-eee1-ba9deaa44579@siemens.com>
Date: Wed, 1 Sep 2021 09:12:07 +0200
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

Ensures build-testing.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 68785f657c..5932dec876 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -160,6 +160,7 @@ variables:
     - ./scripts/config -e XENO_DRIVERS_GPIO_ZYNQ7000
     - ./scripts/config -e XENO_DRIVERS_GPIO_XILINX
     - ./scripts/config -e XENO_DRIVERS_GPIO_OMAP
+    - ./scripts/config -e XENO_DRIVERS_GPIO_CHERRYVIEW
     - ./scripts/config -e XENO_DRIVERS_GPIO_DEBUG
     - ./scripts/config -e XENO_DRIVERS_GPIOPWM
     - ./scripts/config -e XENO_DRIVERS_SPI_BCM2835
-- 
2.31.1

