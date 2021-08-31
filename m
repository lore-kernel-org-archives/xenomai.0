From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 3/3] drivers/gpio: Flip default for GPIO_RTIOC_TS to
 real-time clock
Date: Tue, 31 Aug 2021 09:15:08 +0200
Message-Id: <91dc10af05ef13c1a78ba4d30fbaf96eaa3f2703.1630394108.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1630394108.git.jan.kiszka@siemens.com>
References: <cover.1630394108.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This is in line with other drivers and should avoid surprises like [1]
in the future.

[1] https://xenomai.org/pipermail/xenomai/2021-June/045661.html

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/rtdm/uapi/gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rtdm/uapi/gpio.h b/include/rtdm/uapi/gpio.h
index fb84274453..82612a53d3 100644
--- a/include/rtdm/uapi/gpio.h
+++ b/include/rtdm/uapi/gpio.h
@@ -30,8 +30,8 @@ struct rtdm_gpio_readout {
 #define GPIO_RTIOC_REQS		_IO(RTDM_CLASS_GPIO, 4)
 #define GPIO_RTIOC_RELS		_IO(RTDM_CLASS_GPIO, 5)
 #define GPIO_RTIOC_TS_MONO	_IOR(RTDM_CLASS_GPIO, 7, int)
-#define GPIO_RTIOC_TS		GPIO_RTIOC_TS_MONO
 #define GPIO_RTIOC_TS_REAL	_IOR(RTDM_CLASS_GPIO, 8, int)
+#define GPIO_RTIOC_TS		GPIO_RTIOC_TS_REAL
 
 #define GPIO_TRIGGER_NONE		0x0 /* unspecified */
 #define GPIO_TRIGGER_EDGE_RISING	0x1
-- 
2.31.1


