Message-ID: <4F187256.50208@domain.hid>
Date: Thu, 19 Jan 2012 20:43:18 +0100
From: Manfred <manfred@domain.hid>
MIME-Version: 1.0
References: <4F1080E8.6020408@domain.hid>
	<4F1082E5.8000501@domain.hid>
	<4F132A7E.4000000@domain.hid>
In-Reply-To: <4F132A7E.4000000@domain.hid>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Omap3630, rtserial, xeno_16550A: crash on insmod
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

I finally managed to get the module compiling,
running and inserting.

The main problems (so far) were basically:
- Need a regshift for the offset
- Need a regshift when calling ioremap
AND (and this a bit tricky, because it is omap3630-specific):
- Make sure that we never read an empty rx_fifo:
if (testbits(rt_16550_reg_in(mode, base, LSR,MYREGSHIFT),RHR_EMPTY))
In front of any read with a RHR (Receive Holding Buffer)
rt_16550_reg_in(mode, base, RHR,MYREGSHIFT)

So far so good. However, if I make a crosslink example
(I connect the pins on my expansion board like this: uart1_tx<->uart2_rx,
uart1_rx<->uart2_tx), I always get a time-out:
---------------------------
main : write-file opened
main : write-config written
main : read-file opened
main : read-config written
main : write-task created
main : read-task created
main : starting write-task
main : starting read-task
  Nr |   write->irq    |    irq->read    |   write->read   |
-----------------------------------------------------------
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
---------------------------

I tried to track where the message comes from:
"rt_16550_read(..)" seems to bail-out with a return value of
ETIMEDOUT
but this seems to be defined in the rtdm-files ...
so I did not want to dig further, before asking here.

Do I need to also wire the cts, and rts cables to make it work?
(That would be really bad, because I don't have access to them
(not enough pin-outs))

When I have the standard driver (serial8250) loaded, I can
communicate with socat between the two interfaces.

Any Ideas?
I am not sure if this might be related to the IRQ problems
that Fabrice has mentioned in a recent post.

Thanks for the help.

For completeness: here the diffs:
(MYREGSHIFT is a macro at the moment, I have not decided yet how to 
store them)


diff -u ./serial/16550A.c ./serial/16550A.c
--- ./serial//16550A.c	2012-01-19 20:27:30.688571574 +0100
+++ ./serial//16550A.c	2012-01-19 20:25:21.229675524 +0100
@@ -16,6 +16,7 @@
   * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
   */

+
  #include <linux/version.h>
  #include <linux/module.h>
  #include <linux/ioport.h>
@@ -24,6 +25,17 @@
  #include <rtdm/rtserial.h>
  #include <rtdm/rtdm_driver.h>

+#define WHERESTR  "[file %s, line %d]: %s "
+#define WHEREARG  __FILE__, __LINE__
+
+//On OMAP3630: we need to check if Receiver FIFO is empty
+//A read on empty FIFO register is undefined (crashes)
+#define RHR_EMPTY		0x01
+
+
+#define MYREGSHIFT 2
+
+
  #define RT_16550_DRIVER_NAME	"xeno_16550A"

  #define MAX_DEVICES		8
@@ -107,7 +119,9 @@
  	int mcr_status;			/* MCR cache */
  	int status;			/* cache for LSR + soft-states */
  	int saved_errors;		/* error cache for RTIOC_GET_STATUS */
-};
+	int regshift;			/* Register shift for pointers
+					(e.g. regshift=2 on omap3630) */
+};
+//__attribute__ ((aligned (32)));

  static const struct rtser_config default_config = {
  	0xFFFF, RTSER_DEF_BAUD, RTSER_DEF_PARITY, RTSER_DEF_BITS,
@@ -124,16 +138,21 @@
  };
  static unsigned int baud_base[MAX_DEVICES];
  static int tx_fifo[MAX_DEVICES];
+static int regshift[MAX_DEVICES];
+
  static unsigned int start_index;

  compat_module_param_array(irq, uint, MAX_DEVICES, 0400);
  compat_module_param_array(baud_base, uint, MAX_DEVICES, 0400);
  compat_module_param_array(tx_fifo, int, MAX_DEVICES, 0400);
+compat_module_param_array(regshift, int, MAX_DEVICES, 0400);

  MODULE_PARM_DESC(irq, "IRQ numbers of the serial devices");
  MODULE_PARM_DESC(baud_base, "Maximum baud rate of the serial device "
  		 "(internal clock rate / 16)");
  MODULE_PARM_DESC(tx_fifo, "Transmitter FIFO size");
+MODULE_PARM_DESC(regshift, "Register Shift (e.g. for omap3630:2)");
+

  module_param(start_index, uint, 0400);
  MODULE_PARM_DESC(start_index, "First device instance number to be used");
@@ -154,27 +173,38 @@
  	int lsr = 0;
  	int c;

-	do {
-		c = rt_16550_reg_in(mode, base, RHR);	/* read input char */
-
-		ctx->in_buf[ctx->in_tail] = c;
-		if (ctx->in_history)
-			ctx->in_history[ctx->in_tail] = *timestamp;
-		ctx->in_tail = (ctx->in_tail + 1) & (IN_BUFFER_SIZE - 1);
-
-		if (++ctx->in_npend > IN_BUFFER_SIZE) {
-			lsr |= RTSER_SOFT_OVERRUN_ERR;
-			ctx->in_npend--;
-		}
-
-		rbytes++;
-		lsr &= ~RTSER_LSR_DATA;
-		lsr |= (rt_16550_reg_in(mode, base, LSR) &
-			(RTSER_LSR_DATA | RTSER_LSR_OVERRUN_ERR |
-			 RTSER_LSR_PARITY_ERR | RTSER_LSR_FRAMING_ERR |
-			 RTSER_LSR_BREAK_IND));
-	} while (testbits(lsr, RTSER_LSR_DATA));
-
+//if (testbits(rt_16550_reg_in(mode, base, LSR,MYREGSHIFT),RHR_EMPTY))
+      /* only read when RX FIFO not empty. */
+//	{
+	do {
+			
+	if (testbits(rt_16550_reg_in(mode, base, LSR,MYREGSHIFT),RHR_EMPTY))
+	{
+     	  c = rt_16550_reg_in(mode, base, RHR,MYREGSHIFT);/* read input 
char */
+	}
+	else
+	{
+	  c=0; //What should we return on empty fifo read?
+	}
+			
+			ctx->in_buf[ctx->in_tail] = c;
+			if (ctx->in_history)
+			ctx->in_history[ctx->in_tail] = *timestamp;
+		ctx->in_tail = (ctx->in_tail + 1) & (IN_BUFFER_SIZE - 1);
+			
+			if (++ctx->in_npend > IN_BUFFER_SIZE) {
+				lsr |= RTSER_SOFT_OVERRUN_ERR;
+				ctx->in_npend--;
+			}
+			
+	rbytes++;
+	lsr &= ~RTSER_LSR_DATA;
+	lsr |= (rt_16550_reg_in(mode, base, LSR,MYREGSHIFT) &
+			(RTSER_LSR_DATA | RTSER_LSR_OVERRUN_ERR |
+			 RTSER_LSR_PARITY_ERR | RTSER_LSR_FRAMING_ERR |
+					 RTSER_LSR_BREAK_IND));
+		} while (testbits(lsr, RTSER_LSR_DATA));
+//	}
+	
  	/* save new errors */
  	ctx->status |= lsr;

@@ -185,7 +215,7 @@
  	    (uart->config.handshake & RT_UART_RTSCTS) != 0 &&
  	    (uart->modem & MCR_RTS) != 0) {
  		uart->modem &= ~MCR_RTS;
-		rt_16550_reg_out(mode, base, MCR, uart->modem);
+		rt_16550_reg_out(mode, base, MCR, uart->modem,MYREGSHIFT);
  	}*/

  	return rbytes;
@@ -204,7 +234,7 @@
  		     (count > 0) && (ctx->out_npend > 0);
  		     count--, ctx->out_npend--) {
  			c = ctx->out_buf[ctx->out_head++];
-			rt_16550_reg_out(mode, base, THR, c);
+			rt_16550_reg_out(mode, base, THR, c,MYREGSHIFT);
  			ctx->out_head &= (OUT_BUFFER_SIZE - 1);
  		}
  	}
@@ -215,7 +245,7 @@
  	unsigned long base = ctx->base_addr;
  	int mode = rt_16550_io_mode_from_ctx(ctx);

-	ctx->status |= (rt_16550_reg_in(mode, base, LSR) &
+	ctx->status |= (rt_16550_reg_in(mode, base, LSR,MYREGSHIFT) &
  			(RTSER_LSR_OVERRUN_ERR | RTSER_LSR_PARITY_ERR |
  			 RTSER_LSR_FRAMING_ERR | RTSER_LSR_BREAK_IND));
  }
@@ -239,7 +269,7 @@
  	rtdm_lock_get(&ctx->lock);

  	while (1) {
-		iir = rt_16550_reg_in(mode, base, IIR) & IIR_MASK;
+		iir = rt_16550_reg_in(mode, base, IIR,MYREGSHIFT) & IIR_MASK;
  		if (testbits(iir, IIR_PIRQ))
  			break;

@@ -251,7 +281,7 @@
  		else if (iir == IIR_TX)
  			rt_16550_tx_interrupt(ctx);
  		else if (iir == IIR_MODEM) {
-			modem = rt_16550_reg_in(mode, base, MSR);
+			modem = rt_16550_reg_in(mode, base, MSR,MYREGSHIFT);
  			if (modem & (modem << 4))
  				events |= RTSER_EVENT_MODEMHI;
  			if ((modem ^ 0xF0) & (modem << 4))
@@ -292,7 +322,7 @@
  	}

  	/* update interrupt mask */
-	rt_16550_reg_out(mode, base, IER, ctx->ier_status);
+	rt_16550_reg_out(mode, base, IER, ctx->ier_status,MYREGSHIFT);

  	rtdm_lock_put(&ctx->lock);

@@ -320,9 +350,9 @@
  		ctx->config.baud_rate = config->baud_rate;
  		baud_div = (baud_base[dev_id] + (ctx->config.baud_rate>>1)) /
  			ctx->config.baud_rate;
-		rt_16550_reg_out(mode, base, LCR, LCR_DLAB);
-		rt_16550_reg_out(mode, base, DLL, baud_div & 0xff);
-		rt_16550_reg_out(mode, base, DLM, baud_div >> 8);
+		rt_16550_reg_out(mode, base, LCR, LCR_DLAB,MYREGSHIFT);
+		rt_16550_reg_out(mode, base, DLL, baud_div & 0xff,MYREGSHIFT);
+		rt_16550_reg_out(mode, base, DLM, baud_div >> 8,MYREGSHIFT);
  	}

  	if (testbits(config->config_mask, RTSER_SET_PARITY))
@@ -339,7 +369,7 @@
  		rt_16550_reg_out(mode, base, LCR,
  				 (ctx->config.parity << 3) |
  				 (ctx->config.stop_bits << 2) |
-				 ctx->config.data_bits);
+				 ctx->config.data_bits,MYREGSHIFT);
  		ctx->status = 0;
  		ctx->ioc_events &= ~RTSER_EVENT_ERRPEND;
  	}
@@ -347,9 +377,11 @@
  	if (testbits(config->config_mask, RTSER_SET_FIFO_DEPTH)) {
  		ctx->config.fifo_depth = config->fifo_depth & FIFO_MASK;
  		rt_16550_reg_out(mode, base, FCR,
-				 FCR_FIFO | FCR_RESET_RX | FCR_RESET_TX);
+				 FCR_FIFO | FCR_RESET_RX | FCR_RESET_TX,
+						 MYREGSHIFT);
  		rt_16550_reg_out(mode, base, FCR,
-				 FCR_FIFO | ctx->config.fifo_depth);
+				 FCR_FIFO | ctx->config.fifo_depth,
+						 MYREGSHIFT);
  	}

  	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
@@ -405,7 +437,7 @@
  		else
  			/* disable modem status interrupt */
  			ctx->ier_status &= ~IER_MODEM;
-		rt_16550_reg_out(mode, base, IER, ctx->ier_status);
+		rt_16550_reg_out(mode, base, IER, ctx->ier_status,MYREGSHIFT);

  		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
  	}
@@ -425,7 +457,7 @@
  			    RTSER_MCR_DTR | RTSER_MCR_RTS | RTSER_MCR_OUT2;
  			break;
  		}
-		rt_16550_reg_out(mode, base, MCR, ctx->mcr_status);
+		rt_16550_reg_out(mode, base, MCR, ctx->mcr_status,MYREGSHIFT);

  		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
  	}
@@ -487,7 +519,7 @@
  	if (err) {
  		/* reset DTR and RTS */
  		rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr,
-				 MCR, 0);
+				 MCR, 0,MYREGSHIFT);

  		rt_16550_cleanup_ctx(ctx);

@@ -499,7 +531,7 @@
  	/* enable interrupts */
  	ctx->ier_status = IER_RX;
  	rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx), ctx->base_addr, IER,
-			 IER_RX);
+			 IER_RX,MYREGSHIFT);

  	rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);

@@ -522,14 +554,16 @@
  	rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);

  	/* reset DTR and RTS */
-	rt_16550_reg_out(mode, base, MCR, 0);
+	rt_16550_reg_out(mode, base, MCR, 0,MYREGSHIFT);

  	/* mask all UART interrupts and clear pending ones. */
-	rt_16550_reg_out(mode, base, IER, 0);
-	rt_16550_reg_in(mode, base, IIR);
-	rt_16550_reg_in(mode, base, LSR);
-	rt_16550_reg_in(mode, base, RHR);
-	rt_16550_reg_in(mode, base, MSR);
+	rt_16550_reg_out(mode, base, IER, 0,MYREGSHIFT);
+	rt_16550_reg_in(mode, base, IIR,MYREGSHIFT);
+	rt_16550_reg_in(mode, base, LSR,MYREGSHIFT);
+       /* only read when RX FIFO not empty. */
+	if (testbits(rt_16550_reg_in(mode, base, LSR,MYREGSHIFT),RHR_EMPTY))
+		rt_16550_reg_in(mode, base, RHR,MYREGSHIFT);
+	
+	rt_16550_reg_in(mode, base, MSR,MYREGSHIFT);

  	in_history = ctx->in_history;
  	ctx->in_history = NULL;
@@ -638,9 +672,9 @@
  			struct rtser_status status_buf;

  			status_buf.line_status =
-			  rt_16550_reg_in(mode, base, LSR) | status;
+			  rt_16550_reg_in(mode, base, LSR,MYREGSHIFT) | status;
  			status_buf.modem_status =
-			    rt_16550_reg_in(mode, base, MSR);
+			    rt_16550_reg_in(mode, base, MSR,MYREGSHIFT);

  			err =
  			    rtdm_safe_copy_to_user(user_info, arg,
@@ -649,9 +683,9 @@
  							  rtser_status));
  		} else {
  			((struct rtser_status *)arg)->line_status =
-			  rt_16550_reg_in(mode, base, LSR) | status;
+			  rt_16550_reg_in(mode, base, LSR,MYREGSHIFT) | status;
  			((struct rtser_status *)arg)->modem_status =
-			    rt_16550_reg_in(mode, base, MSR);
+			    rt_16550_reg_in(mode, base, MSR,MYREGSHIFT);
  		}
  		break;
  	}
@@ -672,7 +706,7 @@

  		rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
  		ctx->mcr_status = new_mcr;
-		rt_16550_reg_out(mode, base, MCR, new_mcr);
+		rt_16550_reg_out(mode, base, MCR, new_mcr,MYREGSHIFT);
  		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
  		break;
  	}
@@ -699,7 +733,7 @@
  				     RTSER_EVENT_ERRPEND)) {
  				ctx->ier_status |= IER_STAT;
  				rt_16550_reg_out(mode, base, IER,
-						 ctx->ier_status);
+						 ctx->ier_status,MYREGSHIFT);
  			}

  			rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
@@ -752,7 +786,7 @@
  		    (ctx->config.parity << 3) | (ctx->config.stop_bits << 2) |
  		    ctx->config.data_bits;

-		rt_16550_reg_out(mode, base, LCR, lcr);
+		rt_16550_reg_out(mode, base, LCR, lcr,MYREGSHIFT);

  		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
  		break;
@@ -768,7 +802,8 @@
  	ctx->in_npend = 0;
  	ctx->status = 0;
  	fcr |= FCR_FIFO | FCR_RESET_RX;
-	rt_16550_reg_in(mode, base, RHR);
+       /* only read when RX FIFO not empty. */
+	if (testbits(rt_16550_reg_in(mode, base, LSR,MYREGSHIFT),RHR_EMPTY))
+		rt_16550_reg_in(mode, base, RHR,MYREGSHIFT);
  	
  		if ((long)arg & RTDM_PURGE_TX_BUFFER) {
  			ctx->out_head = 0;
@@ -777,9 +812,10 @@
  			fcr |= FCR_FIFO | FCR_RESET_TX;
  		}
  		if (fcr) {
-			rt_16550_reg_out(mode, base, FCR, fcr);
+			rt_16550_reg_out(mode, base, FCR, fcr,MYREGSHIFT);
  			rt_16550_reg_out(mode, base, FCR,
-					 FCR_FIFO | ctx->config.fifo_depth);
+					 FCR_FIFO | ctx->config.fifo_depth,
+							 MYREGSHIFT);
  		}
  		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
  		break;
@@ -832,7 +868,7 @@
  			ctx->ier_status |= IER_STAT;
  			rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
  					 ctx->base_addr, IER,
-					 ctx->ier_status);
+					 ctx->ier_status,MYREGSHIFT);
  		}

  		if (ctx->status) {
@@ -1047,7 +1083,7 @@
  			ctx->ier_status |= IER_TX;
  			rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
  					 ctx->base_addr, IER,
-					 ctx->ier_status);
+					 ctx->ier_status,MYREGSHIFT);

  			rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
  			continue;
@@ -1120,9 +1156,15 @@
  	int mode;
  	int err;
  	int i;
+	void*  tmpAddr;
+	u8 rdtmp;
+
+

+	
  	rt_16550_pnp_init();
  	rt_16550_pci_init();
+	

  	for (i = 0; i < MAX_DEVICES; i++) {
  		if (!rt_16550_addr_param(i))
@@ -1143,25 +1185,33 @@
  		dev->device_id = i;

  		dev->proc_name = dev->device_name;
-
  		err = rt_16550_init_io(i, dev->device_name);
  		if (err)
+		{
  			goto kfree_out;
+		}

  		if (baud_base[i] == 0)
  			baud_base[i] = DEFAULT_BAUD_BASE;

  		if (tx_fifo[i] == 0)
  			tx_fifo[i] = DEFAULT_TX_FIFO;
+		
+		
+		   i,(void*)io[i],(void*)rt_16550_base_addr(i),(void*)mem[i]);

  		/* Mask all UART interrupts and clear pending ones. */
  		base = rt_16550_base_addr(i);
  		mode = rt_16550_io_mode(i);
-		rt_16550_reg_out(mode, base, IER, 0);
-		rt_16550_reg_in(mode, base, IIR);
-		rt_16550_reg_in(mode, base, LSR);
-		rt_16550_reg_in(mode, base, RHR);
-		rt_16550_reg_in(mode, base, MSR);
+		tmpAddr=(void *)base+(IER << 2);
+		rt_16550_reg_out(mode, base, IER, 0,MYREGSHIFT);
+		rt_16550_reg_in(mode, base, IIR,MYREGSHIFT);
+		rdtmp=rt_16550_reg_in(mode, base, LSR,MYREGSHIFT);
+		//reading empty is BAD on omap3630!
+		if(testbits(rdtmp,RHR_EMPTY))
+			rt_16550_reg_in(mode, base, RHR,MYREGSHIFT);
+		
+		rt_16550_reg_in(mode, base, MSR,MYREGSHIFT);

  		err = rtdm_dev_register(dev);

@@ -1169,6 +1219,8 @@
  			goto release_io_out;

  		device[i] = dev;
+		
+		
  	}

  	return 0;
Only in xenomai-2.6.0/ksrc/drivers/serial/: 16550A.c.debug
Only in xenomai-2.6.0/ksrc/drivers/serial/: 16550A.c.orig
diff -u //16550A_io.h xenomai-2.6.0/ksrc/drivers/serial//16550A_io.h
--- //16550A_io.h	2012-01-19 20:27:30.688571574 +0100
+++ xenomai-2.6.0/ksrc/drivers/serial//16550A_io.h
2012-01-19 20:23:55.347754673 +0100
@@ -20,6 +20,7 @@

  typedef enum { MODE_PIO, MODE_MMIO } io_mode_t;

+
  #if defined(CONFIG_XENO_DRIVERS_16550A_PIO) || \
      defined(CONFIG_XENO_DRIVERS_16550A_ANY)
  static unsigned long io[MAX_DEVICES];
@@ -158,25 +159,31 @@
  #endif

  static RT_16550_IO_INLINE u8
-rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off)
+rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off,int rshift)
  {
+	void __iomem * addr=(void*)base;
  	switch (io_mode) {
  	case MODE_PIO:
-		return inb(base + off);
+		return inb(base + (off<<rshift));
  	default: /* MODE_MMIO */
-		return readb((void *)base + off);
+		addr+=(off<<rshift);
+        //printk(KERN_INFO "reading: at %p \n",(void*)addr);
+		return ioread8(addr);
  	}
  }

  static RT_16550_IO_INLINE void
-rt_16550_reg_out(io_mode_t io_mode, unsigned long base, int off, u8 val)
+rt_16550_reg_out(io_mode_t io_mode, unsigned long base, int off, u8 val,
+ int rshift)
  {
+	void __iomem * addr=(void*)base;
  	switch (io_mode) {
  	case MODE_PIO:
-		outb(val, base + off);
+		outb(val, base + (off<<rshift));
  		break;
  	case MODE_MMIO:
-		writeb(val, (void *)base + off);
+		addr+=(off<<rshift);
+	//printk(KERN_INFO "writing: at %p, val %i \n",(void*)addr,val);
+		iowrite8(val,(void*)addr);
  		break;
  	}
  }
@@ -185,11 +192,12 @@
  {
  	switch (rt_16550_io_mode(dev_id)) {
  	case MODE_PIO:
-		if (!request_region(rt_16550_addr_param(dev_id), 8, name))
+	/*MANFRED QUESTION: Does PIO request_region also need reshift?*/
+	if (!request_region(rt_16550_addr_param(dev_id), 8<<regshift[dev_id],
+         name))
  			return -EBUSY;
  		break;
  	case MODE_MMIO:
-		mapped_io[dev_id] = ioremap(rt_16550_addr_param(dev_id), 8);
+		mapped_io[dev_id] = ioremap(rt_16550_addr_param(dev_id),
+                                           8<<regshift[dev_id]);
  		if (!mapped_io[dev_id])
  			return -EBUSY;
  		break;
@@ -201,7 +209,8 @@
  {
  	switch (rt_16550_io_mode(dev_id)) {
  	case MODE_PIO:
-		release_region(io[dev_id], 8);
+	/*MANFRED QUESTION: Does PIO request_region also need regshift?*/
+		release_region(io[dev_id], 8<<regshift[dev_id]);
  		break;
  	case MODE_MMIO:
  		iounmap(mapped_io[dev_id]);



On 1/15/12 8:35 PM, Wolfgang Grandegger wrote:
> On 01/13/2012 08:15 PM, Manfred wrote:
>> (In reply to Wolfgangs Respond)
>>
>> Thank you for the explanations.
>> So I managed to recompile the kernel module with a lot of "printk"
>>
>> commands. And I could track the problem to the following:
>> it fails in:[1]
>> int __init rt_16550_init(void)
>>
>> When calling these lines:
>> rt_16550_reg_out(mode, base, IER, 0);
>> DEBUGPRINT("after reg_out IER \n");
>> rt_16550_reg_in(mode, base, IIR);
>> DEBUGPRINT("after reg_in IIR \n");
>>
>> So it seems to fail the first time when it tries to call:
>> rt_16550_reg_in(mode, base, IIR);
>> where
>> mode=1
>> rt_16550_reg_in is defined in:
>> 16550A_io.h:161:
>> static RT_16550_IO_INLINE u8
>> rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off)
>> {
>>      switch (io_mode) {
>>      case MODE_PIO:
>>          return inb(base + off);
>>      default: /* MODE_MMIO */
>>          return readb((void *)base + off);
>>      }
>> }
>>
>> -->  where is MODE_PIO defined?: is it 1 or 0?
>> (could not find it in any .c or .h file)
>
> Well, it's in :
>
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/serial/
> 16550A_io.h
>
> and depends on some Kconfig options. Also another prinkt can give you
> the required information.
>
>> So anyway, it either fails in inb(base+off)
>> or (more probably:) in read(void*)base+off
>
> Yes, most likely it's an unaligned access.
>
>> -->
>> Is this consistent with your assumption that we need a regshift?
>
> Yes. I was suggesting to put some printks in the Linux serial device
> setup code first to see how the registers are accessed.
>
>> If yes, which function calls need to be fixed?
>> -->
>> I tried to look in 8250.c [2]:
>> regshift seems to be mostly used when using map_8250_in_reg and
>> map_8250_out_reg:
>> offset = map_8250_in_reg(p, offset)<<  p->regshift;
>> offset = map_8250_in_reg(p, offset)<<  p->regshift;
>> but also elsewhere:
>> 2498 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
>> 2499 {
>> 2500         if (pt->port.iotype == UPIO_AU)
>> 2501                 return 0x1000;
>> 2502 #ifdef CONFIG_ARCH_OMAP
>> 2503         if (is_omap_port(pt))
>> 2504                 return 0x16<<  pt->port.regshift;
>> 2505 #endif
>> 2506         return 8<<  pt->port.regshift;
>> 2507 }
>> or:
>> 2600 static void serial8250_release_rsa_resource(struct
uart_8250_port *up)
>> 2601 {
>> 2602         unsigned long offset = UART_RSA_BASE<<  up->port.regshift;
>> 2603         unsigned int size = 8<<  up->port.regshift;
>> 2604
>> 2605         switch (up->port.iotype) {
>> 2606         case UPIO_HUB6:
>> 2607         case UPIO_PORT:
>> 2608                 release_region(up->port.iobase + offset, size);
>> 2609                 break;
>> 2610         }
>> 2611 }
>
> This is the driver. The devices are setup and configured in
>
> http://lxr.linux.no/#linux+v3.2.1/arch/arm/mach-omap2/serial.c
>
> IIRC. Check what regshift is used for your hardware (by putting further
> printk's).
>
>> -->
>> So can I just change the function in 16550A.c like this?:
>> rt_16550_reg_in(io_mode_t io_mode, unsigned long base, int off, int
>> regshift)
>> {
>>       switch (io_mode) {
>>      case MODE_PIO:
>>          return inb(base + off);
>>      default: /* MODE_MMIO */
>>           /* ADD REGSHIFT for MMIO Mode: */
>>           unsigned long paddr=((void*)base+off)<<  regshift;
>>           return readb((void *)base + off);
>
> You need to shift just the *offset* at the beginning of the function:
>
> 	off<<= regshift;
>
> You also need to adjust the region for request_region() or ioremap().
>
>> }
>>
>> Thanks for the help.
>> Please note, this is really my first try on kernel modules and drivers,
>> So sorry, in case I got it all wrong.
>
> No problem, you are welcome.
>
> Wolfgang.



