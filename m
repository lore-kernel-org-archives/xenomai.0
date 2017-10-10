MIME-Version: 1.0
From: Nitin Kulkarni <nitin.kulkarni@mindmusiclabs.com>
Date: Tue, 10 Oct 2017 18:17:49 +0200
Message-ID: <CAPgPmP1-L1Se8FtVe2wiKLXp-OHpv7TLrjDW29AJJ_X1aMqs8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Porting upboard pinctrl driver to make it I-Pipe aware
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

I am trying to use the GPIO interrupt in real-time domain. Hence, I am
trying to
make the up_board_pinctrl driver usable with the rtdm framework.

I had ported the intel-pinctrl driver for Intel Joule previously, but the
up-board driver
is quite different. Although, I tried similar tactics to make it work but I
am not able to get it working with RTDM interrupts.
The up-board driver is platform speciifc and not in the mainline kernel.

You can find the code here:

https://github.com/emutex/ubilinux-kernel/blob/upboard-4.9/drivers/platform/x86/up_board_pinctrl.c

If someone can suggest me what I am missing that would be great.
Here are the changes I did.


--- a/drivers/platform/x86/up_board_pinctrl.c
+++ b/drivers/platform/x86/up_board_pinctrl.c
@@ -28,7 +28,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-
+#include <linux/ipipe.h>
 /*
  * The UP Board features an external 40-pin header for I/O functions
including
  * GPIO, I2C, UART, SPI, PWM and I2S, similar in layout to the Raspberry
Pi 2.
@@ -99,7 +99,8 @@ struct up_cpld_info {
  unsigned dir_reg_size;
  struct up_cpld_led_info *leds;
  unsigned num_leds;
- spinlock_t lock;
+ ipipe_spinlock_t lock;
 };

 struct up_board_info {
@@ -410,7 +411,7 @@ static int cpld_set_value(struct up_cpld_info *cpld,
unsigned int offset,
  u64 old_regval;
  int ret = 0;

- spin_lock(&cpld->lock);
+ raw_spin_lock(&cpld->lock);

  old_regval = cpld->dir_reg;

@@ -423,7 +424,7 @@ static int cpld_set_value(struct up_cpld_info *cpld,
unsigned int offset,
  if (cpld->dir_reg != old_regval)
  ret = cpld_configure(cpld);

- spin_unlock(&cpld->lock);
+ raw_spin_unlock(&cpld->lock);

  return ret;
 }
@@ -481,7 +482,7 @@ static int up_gpio_pincfg_cpld(struct platform_device
*pdev,
  };
  int i, ret;

- spin_lock_init(&cpld->lock);
+ raw_spin_lock_init(&cpld->lock);

  /* Initialise the CPLD config input GPIOs as outputs, initially low */
  for (i = 0; i < ARRAY_SIZE(cpld_gpios); i++) {
@@ -538,27 +539,49 @@ static int up_gpio_pincfg_init(struct platform_device
*pdev,
  return up_gpio_pincfg_cpld(pdev, board);
 }


 static irqreturn_t up_gpio_irq_handler(int irq, void *data)
 {

  struct up_pin_info *pin = (struct up_pin_info *)data;

- generic_handle_irq(pin->irq);
+ ipipe_handle_demuxed_irq(pin->irq);
  return IRQ_HANDLED;
 }

-static unsigned int up_gpio_irq_startup(struct irq_data *data)
+static void ipipe_irq_cascade(struct irq_desc *desc)
 {
+ struct up_pin_info *pin = irq_desc_get_handler_data(desc);
+ int irq = irq_desc_get_irq(desc);
+ desc->irq_data.chip->irq_ack(&desc->irq_data);
+
+ up_gpio_irq_handler(irq,pin);
+
+}
+
+static unsigned int up_gpio_irq_startup(struct irq_data *data)
+{
+
  struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
  struct up_pctrl *up_pctrl = gc_to_up_pctrl(gc);
  unsigned offset = irqd_to_hwirq(data);

  struct up_pin_info *pin = &up_pctrl->board->pins[offset];

- return request_irq(pin->soc_gpio.irq, up_gpio_irq_handler,
-    IRQF_ONESHOT, dev_name(gc->parent), pin);
+ ipipe_unlock_irq(data->irq);
+
+ irq_set_chained_handler_and_data(pin->soc_gpio.irq,
+ ipipe_irq_cascade,pin);
 }

 static void up_gpio_irq_shutdown(struct irq_data *data)
-{
+{
  struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
  struct up_pctrl *up_pctrl = gc_to_up_pctrl(gc);
  unsigned offset = irqd_to_hwirq(data);
@@ -898,7 +921,7 @@ static int up_pinctrl_probe(struct platform_device
*pdev)
  }

  ret = gpiochip_irqchip_add(&up_pctrl->chip, &up_gpio_irqchip, 0,
-    handle_simple_irq, IRQ_TYPE_NONE);
+    handle_level_irq, IRQ_TYPE_NONE);
  if (ret) {
  dev_err(&pdev->dev, "failed to add IRQ chip\n");
  goto fail_irqchip_add;





Regards,
Nitin
