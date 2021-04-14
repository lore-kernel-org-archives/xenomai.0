From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH for libevl] benchmarks/latmus: latmon: apply new API interface
 and Macros
Date: Wed, 14 Apr 2021 02:14:39 -0400
Message-Id: <20210414061439.1882-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Some API functions and macros related to dt and gpio are modified
or removed so we change accordingly.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/benchmarks/zephyr/frdm_k64f-enable-EVL-latency-monitor.patch b/benchmarks/zephyr/frdm_k64f-enable-EVL-latency-monitor.patch
index 936d964..6ca0f7f 100644
--- a/benchmarks/zephyr/frdm_k64f-enable-EVL-latency-monitor.patch
+++ b/benchmarks/zephyr/frdm_k64f-enable-EVL-latency-monitor.patch
@@ -1,55 +1,70 @@
-From 09f3918f91f6dfd5bbf20bb04f9518187d79b445 Mon Sep 17 00:00:00 2001
-From: Philippe Gerum <rpm@xenomai.org>
-Date: Sat, 4 Jan 2020 13:22:59 +0100
+From 3d7db55c7a551c0d0c1ab1f49fd63a85907e2a63 Mon Sep 17 00:00:00 2001
+From: hongzha1 <hongzhan.chen@intel.com>
+Date: Mon, 15 Mar 2021 04:22:18 -0400
 Subject: [PATCH] frdm_k64f: enable EVL latency monitor
 
-Use GPIO24 for issuing the pulse signal to the device under test,
-GPIO25 for receiving the acknowledge.
----
- boards/arm/frdm_k64f/frdm_k64f.dts | 10 ++++++++++
- boards/arm/frdm_k64f/pinmux.c      |  3 +++
- 2 files changed, 13 insertions(+)
+Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
 
 diff --git a/boards/arm/frdm_k64f/frdm_k64f.dts b/boards/arm/frdm_k64f/frdm_k64f.dts
-index 432482db6c..8e67a25dc8 100644
+index f587059e0f..23bc58eb8a 100644
 --- a/boards/arm/frdm_k64f/frdm_k64f.dts
 +++ b/boards/arm/frdm_k64f/frdm_k64f.dts
-@@ -37,6 +37,8 @@
+@@ -14,6 +14,8 @@
+ 		led2 = &red_led;
+ 		sw0 = &user_button_3;
  		sw1 = &user_button_2;
- 		eth = &eth;
- 		can-0 = &can0;
-+		latmon-pulse = &pulse_gpio;
-+		latmon-ack = &ack_gpio;
++		latmonpulse = &pulse_gpio;
++		latmonack = &ack_gpio;
  	};
  
  	chosen {
-@@ -62,6 +64,10 @@
- 			gpios = <&gpiob 21 0>;
+@@ -40,6 +42,10 @@
+ 			gpios = <&gpiob 21 GPIO_ACTIVE_LOW>;
  			label = "User LD3";
  		};
 +		pulse_gpio: latmon_out {
-+			gpios = <&gpioe 24 0>;
++			gpios = <&gpioe 24 GPIO_ACTIVE_LOW>;
 +			label = "Latmon pulse";
 +		};
  	};
  
  	gpio_keys {
-@@ -74,6 +80,10 @@
+@@ -52,6 +58,10 @@
  			label = "User SW3";
- 			gpios = <&gpioa 4 (GPIO_INT_ACTIVE_LOW | GPIO_PUD_PULL_UP)>;
+ 			gpios = <&gpioa 4 GPIO_ACTIVE_LOW>;
  		};
 +		ack_gpio: latmon_in {
-+			gpios = <&gpioe 25 GPIO_INT_ACTIVE_HIGH>;
++			gpios = <&gpioe 25 GPIO_ACTIVE_LOW>;
 +			label = "Latmon ACK";
 +		};
  	};
  
  	arduino_header: connector {
+@@ -81,9 +91,7 @@
+ 			   <16 0 &gpiod 0 0>,	/* D10 */
+ 			   <17 0 &gpiod 2 0>,	/* D11 */
+ 			   <18 0 &gpiod 3 0>,	/* D12 */
+-			   <19 0 &gpiod 1 0>,	/* D13 */
+-			   <20 0 &gpioe 25 0>,	/* D14 */
+-			   <21 0 &gpioe 24 0>;	/* D15 */
++			   <19 0 &gpiod 1 0>;	/* D13 */
+ 	};
+ };
+ 
+@@ -119,7 +127,7 @@ arduino_serial: &uart3 {
+ };
+ 
+ arduino_i2c: &i2c0 {
+-	status = "okay";
++	status = "disabled";
+ 
+ 	fxos8700@1d {
+ 		compatible = "nxp,fxos8700";
 diff --git a/boards/arm/frdm_k64f/pinmux.c b/boards/arm/frdm_k64f/pinmux.c
-index 35f3c9e44c..f1c341fe9e 100644
+index 12576fa0eb..f9314d8cfd 100644
 --- a/boards/arm/frdm_k64f/pinmux.c
 +++ b/boards/arm/frdm_k64f/pinmux.c
-@@ -115,6 +115,9 @@ static int frdm_k64f_pinmux_init(struct device *dev)
+@@ -120,6 +120,9 @@ static int frdm_k64f_pinmux_init(const struct device *dev)
  					| PORT_PCR_ODE_MASK);
  	pinmux_pin_set(porte, 25, PORT_PCR_MUX(kPORT_MuxAlt5)
  					| PORT_PCR_ODE_MASK);
@@ -58,7 +73,7 @@ index 35f3c9e44c..f1c341fe9e 100644
 +	pinmux_pin_set(porte, 25, PORT_PCR_MUX(kPORT_MuxAsGpio));
  #endif
  
- #if CONFIG_ADC_1
+ #if DT_NODE_HAS_STATUS(DT_NODELABEL(adc1), okay) && CONFIG_ADC
 -- 
-2.24.1
+2.17.1
 
diff --git a/benchmarks/zephyr/latmon/src/main.c b/benchmarks/zephyr/latmon/src/main.c
index d273078..479f8a9 100644
--- a/benchmarks/zephyr/latmon/src/main.c
+++ b/benchmarks/zephyr/latmon/src/main.c
@@ -20,8 +20,9 @@ LOG_MODULE_REGISTER(latency_monitor, LOG_LEVEL_DBG);
 #include <net/net_context.h>
 #include <net/net_mgmt.h>
 #include <net/socket.h>
-#include <gpio.h>
+#include <drivers/gpio.h>
 #include <zephyr.h>
+#include <device.h>
 #include "latmon.h"
 
 static K_SEM_DEFINE(dhcp_done, 0, 1);
@@ -57,7 +58,7 @@ static uint32_t histogram_cells;
 #define HISTOGRAM_CELLS_MAX 1000
 static uint32_t histogram[HISTOGRAM_CELLS_MAX];
 
-static struct device *gpiodev_pulse, *gpiodev_ack;
+const struct device *gpiodev_pulse, *gpiodev_ack;
 
 static bool abort_monitor;
 
@@ -66,7 +67,7 @@ static K_SEM_DEFINE(ack_event, 0, 1);
 static K_MUTEX_DEFINE(stat_mutex);
 
 static void dhcp_handler(struct net_mgmt_event_callback *cb,
-			u32_t mgmt_event,
+			uint32_t mgmt_event,
 			struct net_if *iface)
 {
 	struct net_if_config *cf = &iface->config;
@@ -85,13 +86,35 @@ static void dhcp_handler(struct net_mgmt_event_callback *cb,
 	}
 }
 
-#define GPIO_PULSE_DEVICE	DT_ALIAS_LATMON_PULSE_GPIOS_CONTROLLER
-#define GPIO_PULSE_PIN		DT_ALIAS_LATMON_PULSE_GPIOS_PIN
-#define GPIO_ACK_DEVICE		DT_ALIAS_LATMON_ACK_GPIOS_CONTROLLER
-#define GPIO_ACK_PIN		DT_ALIAS_LATMON_ACK_GPIOS_PIN
-
-static void gpio_ack_handler(struct device *port,
-			struct gpio_callback *cb, u32_t pins);
+#define LATMUS_PULSE_NODE DT_ALIAS(latmonpulse)
+#define LATMUS_ACK_NODE DT_ALIAS(latmonack)
+
+#if DT_NODE_HAS_STATUS(LATMUS_PULSE_NODE, okay)
+#define GPIO_PULSE_DEVICE	DT_GPIO_LABEL(LATMUS_PULSE_NODE, gpios)
+#define GPIO_PULSE_PIN		DT_GPIO_PIN(LATMUS_PULSE_NODE, gpios)
+#define GPIO_PULSE_FLAGS	DT_GPIO_FLAGS(LATMUS_PULSE_NODE, gpios)
+#else
+/* A build error here means your board isn't set up latmus-pulse. */
+#error "Unsupported board: latmon-pulse devicetree alias is not defined"
+#define GPIO_PULSE_DEVICE	""
+#define GPIO_PULSE_PIN		0
+#define GPIO_PULSE_FLAGS	0
+#endif
+
+#if DT_NODE_HAS_STATUS(LATMUS_ACK_NODE, okay)
+#define GPIO_ACK_DEVICE		DT_GPIO_LABEL(LATMUS_ACK_NODE, gpios)
+#define GPIO_ACK_PIN		DT_GPIO_PIN(LATMUS_ACK_NODE, gpios)
+#define GPIO_ACK_FLAGS (GPIO_INPUT | DT_GPIO_FLAGS(LATMUS_ACK_NODE, gpios))
+#else
+/* A build error here means your board isn't set up latmus-ack. */
+#error "Unsupported board: latmon-ack devicetree alias is not defined"
+#define GPIO_ACK_DEVICE	""
+#define GPIO_ACK_PIN		0
+#define GPIO_ACK_FLAGS	0
+#endif
+
+void gpio_ack_handler(const struct device *port,
+			struct gpio_callback *cb, uint32_t pins);
 
 static bool setup_gpio_pins(void)
 {
@@ -106,14 +129,14 @@ static bool setup_gpio_pins(void)
 	}
 
 	ret = gpio_pin_configure(gpiodev_pulse,
-				GPIO_PULSE_PIN, GPIO_DIR_OUT);
+				GPIO_PULSE_PIN, GPIO_OUTPUT_ACTIVE | GPIO_PULSE_FLAGS);
 	if (ret) {
 		LOG_ERR("cannot configure output pin %s.%d\n",
 			GPIO_PULSE_DEVICE, GPIO_PULSE_PIN);
 		return false;
 	}
 
-	ret = gpio_pin_write(gpiodev_pulse, GPIO_PULSE_PIN, 1);
+	ret = gpio_pin_set(gpiodev_pulse, GPIO_PULSE_PIN, 1);
 	if (ret) {
 		LOG_ERR("gpio out error: set");
 		return false;
@@ -127,25 +150,28 @@ static bool setup_gpio_pins(void)
 	}
 
 	ret = gpio_pin_configure(gpiodev_ack, GPIO_ACK_PIN,
-				 (GPIO_DIR_IN | GPIO_INT |
-				  GPIO_INT_EDGE | GPIO_INT_ACTIVE_LOW));
+				 GPIO_ACK_FLAGS);
+
 	if (ret) {
 		LOG_ERR("cannot configure input pin %s.%d\n",
 			GPIO_ACK_DEVICE, GPIO_ACK_PIN);
 		return false;
 	}
 
-	gpio_init_callback(&gpio_cb, gpio_ack_handler, BIT(GPIO_ACK_PIN));
+	ret = gpio_pin_interrupt_configure(gpiodev_ack, GPIO_ACK_PIN,
+			GPIO_INT_EDGE_TO_INACTIVE);
 
-	ret = gpio_add_callback(gpiodev_ack, &gpio_cb);
 	if (ret) {
-		LOG_ERR("cannot add GPIO input callback");
+		LOG_ERR("cannot configure interrupt pin %s.%d\n",
+				GPIO_ACK_DEVICE, GPIO_ACK_PIN);
 		return false;
 	}
 
-	ret = gpio_pin_enable_callback(gpiodev_ack, GPIO_ACK_PIN);
+	gpio_init_callback(&gpio_cb, gpio_ack_handler, BIT(GPIO_ACK_PIN));
+
+	ret = gpio_add_callback(gpiodev_ack, &gpio_cb);
 	if (ret) {
-		LOG_ERR("cannot enable GPIO input callback");
+		LOG_ERR("cannot add GPIO input callback");
 		return false;
 	}
 
@@ -230,10 +256,10 @@ static bool send_trailing_data(void)
 static bool ack_wait;
 
 /* In raw ticks */
-static u32_t ack_date;
+static uint32_t ack_date;
 
-static void gpio_ack_handler(struct device *port,
-			struct gpio_callback *cb, u32_t pins)
+void gpio_ack_handler(const struct device *port,
+			struct gpio_callback *cb, uint32_t pins)
 {
 	if (ack_wait) {
 		ack_date = k_cycle_get_32();
@@ -244,7 +270,7 @@ static void gpio_ack_handler(struct device *port,
 
 static int monitor(void)
 {
-	u32_t pulse_date, delta, delta_ns, delta_usecs, warmup_count = 0;
+	uint32_t pulse_date, delta, delta_ns, delta_usecs, warmup_count = 0;
 	unsigned int key;
 	int cell;
 
@@ -261,14 +287,14 @@ static int monitor(void)
 
 		/* Trigger the pulse, prepare for ACK receipt. */
 		key = irq_lock();
-		gpio_pin_write(gpiodev_pulse, GPIO_PULSE_PIN, 0);
+		gpio_pin_set(gpiodev_pulse, GPIO_PULSE_PIN, 0);
 		pulse_date = k_cycle_get_32();
 		/* We would need a wmb here on SMP. */
 		ack_wait = true;
 		irq_unlock(key);
 		/* Wait a bit then deassert the signal. */
 		k_busy_wait(1);
-		gpio_pin_write(gpiodev_pulse, GPIO_PULSE_PIN, 1);
+		gpio_pin_set(gpiodev_pulse, GPIO_PULSE_PIN, 1);
 
 		/* Wait for the device under test to ACK. */
 		if (k_sem_take(&ack_event, K_SECONDS(1))) {
@@ -284,7 +310,7 @@ static int monitor(void)
 
 		delta = ack_date < pulse_date ? ~pulse_date + 1 + ack_date :
 			ack_date - pulse_date;
-		delta_ns = (u32_t)k_cyc_to_ns_floor64(delta);
+		delta_ns = (uint32_t)k_cyc_to_ns_floor64(delta);
 
 		sum_lat += delta_ns;
 		if (delta_ns < min_lat)
-- 
2.17.1


