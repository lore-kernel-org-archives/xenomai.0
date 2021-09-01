From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] ci: Add new GPIO Cherryview driver
Message-ID: <0d04b387-1049-e744-6e75-b9430825e536@siemens.com>
Date: Wed, 1 Sep 2021 14:42:32 +0200
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

Ensures build-testing. We need to enable a couple of dependencies of the
driver for that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - enable dependencies

 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 88c4c37ba8..602a7682ac 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,6 +161,9 @@ variables:
     - ./scripts/config -e XENO_DRIVERS_GPIO_ZYNQ7000
     - ./scripts/config -e XENO_DRIVERS_GPIO_XILINX
     - ./scripts/config -e XENO_DRIVERS_GPIO_OMAP
+    - ./scripts/config -e PINCTRL
+    - ./scripts/config -e PINCTRL_CHERRYVIEW
+    - ./scripts/config -e XENO_DRIVERS_GPIO_CHERRYVIEW
     - ./scripts/config -e XENO_DRIVERS_GPIO_DEBUG
     - ./scripts/config -e XENO_DRIVERS_GPIOPWM
     - ./scripts/config -e XENO_DRIVERS_SPI_BCM2835
-- 
2.31.1

