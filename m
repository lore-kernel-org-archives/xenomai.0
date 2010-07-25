Message-ID: <4C4C02BC.4010306@domain.hid>
Date: Sun, 25 Jul 2010 11:24:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
	<4C468040.3030509@domain.hid> <4C468485.5060408@domain.hid>
	<4C47597F.1010406@domain.hid>
	<4C478313.2030606@domain.hid>
	<4C48C1BB.8080606@domain.hid> <4C48C2CE.1030706@domain.hid>
	<4C4A292F.5040900@domain.hid>
	<4C4ADFC6.1010900@domain.hid> <4C4B35F1.60103@domain.hid>
	<4C4B379F.9040107@domain.hid> <4C4BC6D6.8070806@domain.hid>
In-Reply-To: <4C4BC6D6.8070806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patch prevents IRQ 384 (MMC Chip Detect)
 on omap-2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   Test 1 results:
> With the Adeos patch installed, but Adeos disabled, the system ran 
> normally. IRQ 384s were presented and serviced.  (The SD card removal 
> amd insertion was handled correctly.)

Ok. Could you try the following patch? It fixes the "always growing PIH 
interrupt count" number here, and now I have some twl4030_usb 
interrupts. However, I could not test the SD card insertion/removal, 
because I am working on the board remotely.

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8d608a1..0037e31 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -478,10 +478,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (msg->len == 0)
 		return -EINVAL;
 
-#ifdef CONFIG_IPIPE
-	disable_irq(dev->irq);
-#endif /* CONFIG_IPIPE */
-
 	omap_i2c_write_reg(dev, OMAP_I2C_SA_REG, msg->addr);
 
 	/* REVISIT: Could the STB bit of I2C_CON be used with probing? */
@@ -525,9 +521,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 			/* Let the user know if i2c is in a bad state */
 			if (time_after(jiffies, delay)) {
-#ifdef CONFIG_IPIPE
-				enable_irq(dev->irq);
-#endif /* CONFIG_IPIPE */
 				dev_err(dev->dev, "controller timed out "
 				"waiting for start condition to finish\n");
 				return -ETIMEDOUT;
@@ -539,9 +532,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		w &= ~OMAP_I2C_CON_STT;
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 	}
-#ifdef CONFIG_IPIPE
-	enable_irq(dev->irq);
-#endif /* CONFIG_IPIPE */
 
 	/*
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 9df9a5a..fb4b9f2 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -332,7 +332,7 @@ static int twl4030_irq_thread(void *data)
 					note_interrupt(module_irq, d,
 							IRQ_NONE);
 				else
-					d->handle_irq(module_irq, d);
+					ipipe_handle_irq_cond(module_irq);
 			}
 		}
 		local_irq_enable();

-- 
					    Gilles.

