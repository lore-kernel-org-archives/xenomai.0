From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Enable gpiolib
Message-ID: <39c6020f-5738-5e75-962b-4bd21e5e8ce7@siemens.com>
Date: Wed, 1 Sep 2021 14:41:08 +0200
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

This ensures that Xenomai GPIO drivers are built. It's a dependency of
XENO_DRIVERS_GPIO that is not automatically enabled.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 68785f657c..88c4c37ba8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -153,6 +153,7 @@ variables:
     - ./scripts/config -e XENO_DRIVERS_ANALOGY_S526
     - ./scripts/config -e XENO_DRIVERS_RTIPC
     - ./scripts/config -e XENO_DRIVERS_UDD
+    - ./scripts/config -e GPIOLIB
     - ./scripts/config -e XENO_DRIVERS_GPIO
     - ./scripts/config -e XENO_DRIVERS_GPIO_BCM2835
     - ./scripts/config -e XENO_DRIVERS_GPIO_MXC
-- 
2.31.1

