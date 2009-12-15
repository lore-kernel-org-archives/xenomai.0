From: Paolo Bernini <nihil84@domain.hid>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: multipart/mixed; boundary=Apple-Mail-6--872321699
Date: Tue, 15 Dec 2009 19:45:19 +0100
In-Reply-To: <4B25014E.9050407@domain.hid>
References: <94A6EC74-5941-40D6-9F99-6DF96D1FD006@domain.hid>
	<4B25014E.9050407@domain.hid>
Message-Id: <A97B8526-73AD-4572-B8DC-35964374BD6F@gmail.com>
Subject: Re: [Xenomai-core] [i.MX27] imx serial driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--Apple-Mail-6--872321699
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

Il giorno 13/dic/2009, alle ore 15.59, Gilles Chanteperdrix ha scritto:

> Paolo Bernini wrote:
>> Hello all, first of all I introduce myself: I am Paolo Bernini and I
>> am a student of University of Pisa.
>>=20
>> While working on my thesis I wrote a real time driver for i.MX
>> special serial devices based on current implementation of 16550A. It
>> is very simple, it has several limitations and it is tested only for
>> i.MX27 processors, but it should support any i.MX processor if
>> supplied of their memory map of the devices.
>>=20
>> Actually it allocate only one device and the only way to choose
>> which, is by in code constraints definitions but it can be easily
>> enhanced, I think.
>>=20
>> If you are interested I can send it to you as is.
>>=20
>>=20
>> Thanks.
>=20
> Hi,
>=20
> I suspect this serial driver would interest many users of the imx
> architecture, so, could you send it as a patch against the head =
branch?

[cut]

Here it is.

Unfortunately I was unable to include the new source in the patch so I =
send them as separate files.
You should place them in the directory ksrc/drivers/serial/

Note that I experienced problems with data alignment disagreement =
between kernel and user code; problems that I solved with a =
-fpack-struct=3D4 in the CFLAGS of the kernel.
As far I know, with the new rtdm structures this issue should not be =
present anymore, but tests has to be done.

The driver is very experimental and note that some of the features =
defined for standard serial devices aren't supported by the imx physical =
device.


--Apple-Mail-6--872321699
Content-Disposition: attachment;
	filename=imx_uart.patch
Content-Type: application/octet-stream;
	name="imx_uart.patch"
Content-Transfer-Encoding: 7bit

diff --git a/ksrc/drivers/serial/Kconfig b/ksrc/drivers/serial/Kconfig
index afbaabf..e5472a4 100644
--- a/ksrc/drivers/serial/Kconfig
+++ b/ksrc/drivers/serial/Kconfig
@@ -39,4 +39,11 @@ config XENO_DRIVERS_16550A_ANY
 
 endchoice
 
+config XENO_DRIVERS_IMX
+	depends on XENO_SKIN_RTDM && MACH_MX27=y
+	tristate "IMX UART driver (EXPERIMENTAL)"
+	help
+	Real-time UART driver for Motorola IMX controllers, equipped in some
+	Freescale i.MX ARM microprocessors. 
+
 endmenu
diff --git a/ksrc/drivers/serial/Makefile b/ksrc/drivers/serial/Makefile
index 57d042e..c20b67c 100644
--- a/ksrc/drivers/serial/Makefile
+++ b/ksrc/drivers/serial/Makefile
@@ -5,8 +5,10 @@ ifeq ($(PATCHLEVEL),6)
 EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
 
 obj-$(CONFIG_XENO_DRIVERS_16550A) += xeno_16550A.o
+obj-$(CONFIG_XENO_DRIVERS_IMX) += xeno_imx.o
 
 xeno_16550A-y := 16550A.o
+xeno_imx-y := imx.o
 
 else
 

--Apple-Mail-6--872321699
Content-Disposition: attachment;
	filename=imx_io.h
Content-Type: application/octet-stream;
	name="imx_io.h"
Content-Transfer-Encoding: 7bit

/*
 *  linux/drivers/xenomai/serial/imx_io.h
 *
 *  RTDM Xenomai Driver for Motorola IMX serial ports
 *
 *  Based on drivers/xenomai/serial/16550A_io.h, by Jan Kiszka
 *
 *  Author: Paolo Bernini <paolo.bernini@domain.hid>
 *  Copyright (C) 2009 Paolo Bernini
 *
 * Xenomai is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Xenomai is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Xenomai; if not, write to the Free Software Foundation,
 * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

/* Manages the I/O access method of the driver. */

#include <linux/module.h>
#include <asm/io.h>
#include <linux/clk.h>

#include <rtdm/rtserial.h>
#include <rtdm/rtdm_driver.h>

#define MAX_DEVICES				8

/* WARNING: Buffer size MUST be power of 2 */
#define BUFFER_SIZE				4096

#ifdef CONFIG_ARCH_MX2 		/* TODO: extend memory map to other ARCHs */
	#define IMX_DEVICE_SIZE			180
	static unsigned long mem[MAX_DEVICES] = {
		0x1000A000,		/* i.MX27 UART1 base address */
		0x1000B000,		/* i.MX27 UART2 base address */
		0x1000C000,		/* i.MX27 UART3 base address */
		0x1000D000,		/* i.MX27 UART4 base address */
		0x1001B000,		/* i.MX27 UART5 base address */
		0x1001C000		/* i.MX27 UART6 base address */
	};
#else
	#error "Processor architecture not supported (yet)."
#endif


/* DEVICE REGISTER ADDRESSES **************************************************/
#define URXD0 0x00 /* Receiver Register */
#define URTX0 0x40 /* Transmitter Register */
#define UCR1  0x80 /* Control Register 1 */
#define UCR2  0x84 /* Control Register 2 */
#define UCR3  0x88 /* Control Register 3 */
#define UCR4  0x8c /* Control Register 4 */
#define UFCR  0x90 /* FIFO Control Register */
#define USR1  0x94 /* Status Register 1 */
#define USR2  0x98 /* Status Register 2 */
#define UESC  0x9c /* Escape Character Register */
#define UTIM  0xa0 /* Escape Timer Register */
#define UBIR  0xa4 /* BRM Incremental Register */
#define UBMR  0xa8 /* BRM Modulator Register */
#define UBRC  0xac /* Baud Rate Count Register */
#if defined CONFIG_ARCH_MX3 || defined CONFIG_ARCH_MX2
#define ONEMS 0xb0 /* One Millisecond register */
#define UTS   0xb4 /* UART Test Register */
#endif
#if defined(CONFIG_ARCH_IMX) || defined(CONFIG_ARCH_MX1)
#define BIPR1 0xb0 /* Incremental Preset Register 1 */
#define BIPR2 0xb4 /* Incremental Preset Register 2 */
#define BIPR3 0xb8 /* Incremental Preset Register 3 */
#define BIPR4 0xbc /* Incremental Preset Register 4 */
#define BMPR1 0xc0 /* BRM Modulator Register 1 */
#define BMPR2 0xc4 /* BRM Modulator Register 2 */
#define BMPR3 0xc8 /* BRM Modulator Register 3 */
#define BMPR4 0xcc /* BRM Modulator Register 4 */
#define UTS   0xd0 /* UART Test Register */
#endif

/* UART Control Register Bit Fields.*******************************************/
#define  URXD_CHARRDY    (1<<15)
#define  URXD_ERR        (1<<14)
#define  URXD_OVRRUN     (1<<13)
#define  URXD_FRMERR     (1<<12)
#define  URXD_BRK        (1<<11)
#define  URXD_PRERR      (1<<10)
#define  UCR1_ADEN       (1<<15) /* Auto dectect interrupt */
#define  UCR1_ADBR       (1<<14) /* Auto detect baud rate */
#define  UCR1_TRDYEN     (1<<13) /* Transmitter ready interrupt enable */
#define  UCR1_IDEN       (1<<12) /* Idle condition interrupt */
#define  UCR1_RRDYEN     (1<<9)	 /* Recv ready interrupt enable */
#define  UCR1_RDMAEN     (1<<8)	 /* Recv ready DMA enable */
#define  UCR1_IREN       (1<<7)	 /* Infrared interface enable */
#define  UCR1_TXMPTYEN   (1<<6)	 /* Transimitter empty interrupt enable */
#define  UCR1_RTSDEN     (1<<5)	 /* RTS delta interrupt enable */
#define  UCR1_SNDBRK     (1<<4)	 /* Send break */
#define  UCR1_TDMAEN     (1<<3)	 /* Transmitter ready DMA enable */
#if defined(CONFIG_ARCH_IMX) || defined(CONFIG_ARCH_MX1)
#define  UCR1_UARTCLKEN  (1<<2)	 /* UART clock enabled */
#endif
#if defined CONFIG_ARCH_MX3 || defined CONFIG_ARCH_MX2
#define  UCR1_UARTCLKEN  (0)	 /* not present on mx2/mx3 */
#endif
#define  UCR1_DOZE       (1<<1)	 /* Doze */
#define  UCR1_UARTEN     (1<<0)	 /* UART enabled */
#define  UCR2_ESCI     	 (1<<15) /* Escape seq interrupt enable */
#define  UCR2_IRTS  	 (1<<14) /* Ignore RTS pin */
#define  UCR2_CTSC  	 (1<<13) /* CTS pin control */
#define  UCR2_CTS        (1<<12) /* Clear to send */
#define  UCR2_ESCEN      (1<<11) /* Escape enable */
#define  UCR2_PREN       (1<<8)  /* Parity enable */
#define  UCR2_PROE       (1<<7)  /* Parity odd/even */
#define  UCR2_STPB       (1<<6)	 /* Stop */
#define  UCR2_WS         (1<<5)	 /* Word size */
#define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable */
#define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
#define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
#define  UCR2_SRST 	     (1<<0)	 /* SW reset */
#define  UCR3_DTREN 	 (1<<13) /* DTR interrupt enable */
#define  UCR3_PARERREN   (1<<12) /* Parity enable */
#define  UCR3_FRAERREN   (1<<11) /* Frame error interrupt enable */
#define  UCR3_DSR        (1<<10) /* Data set ready */
#define  UCR3_DCD        (1<<9)  /* Data carrier detect */
#define  UCR3_RI         (1<<8)  /* Ring indicator */
#define  UCR3_TIMEOUTEN  (1<<7)  /* Timeout interrupt enable */
#define  UCR3_RXDSEN	 (1<<6)  /* Receive status interrupt enable */
#define  UCR3_AIRINTEN   (1<<5)  /* Async IR wake interrupt enable */
#define  UCR3_AWAKEN	 (1<<4)  /* Async wake interrupt enable */
#ifdef CONFIG_ARCH_IMX
#define  UCR3_REF25 	 (1<<3)  /* Ref freq 25 MHz, only on mx1 */
#define  UCR3_REF30 	 (1<<2)  /* Ref Freq 30 MHz, only on mx1 */
#endif
#if defined CONFIG_ARCH_MX2 || defined CONFIG_ARCH_MX3
#define  UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select, on mx2/mx3 */
#endif
#define  UCR3_INVT  	 (1<<1)  /* Inverted Infrared transmission */
#define  UCR3_BPEN  	 (1<<0)  /* Preset registers enable */
#define  UCR4_CTSTL_32   (32<<10) /* CTS trigger level (32 chars) */
#define  UCR4_INVR  	 (1<<9)  /* Inverted infrared reception */
#define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enable */
#define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
#define  UCR4_REF16 	 (1<<6)  /* Ref freq 16 MHz */
#define  UCR4_IRSC  	 (1<<5)  /* IR special case */
#define  UCR4_TCEN  	 (1<<3)  /* Transmit complete interrupt enable */
#define  UCR4_BKEN  	 (1<<2)  /* Break condition interrupt enable */
#define  UCR4_OREN  	 (1<<1)  /* Receiver overrun interrupt enable */
#define  UCR4_DREN  	 (1<<0)  /* Recv data ready interrupt enable */
#define  UFCR_RXTL_SHF   0       /* Receiver trigger level shift */
#define  UFCR_RFDIV      (7<<7)  /* Reference freq divider mask */
#define  UFCR_TXTL_SHF   10      /* Transmitter trigger level shift */
#define  USR1_PARITYERR  (1<<15) /* Parity error interrupt flag */
#define  USR1_RTSS  	 (1<<14) /* RTS pin status */
#define  USR1_TRDY  	 (1<<13) /* Transmitter ready interrupt/dma flag */
#define  USR1_RTSD  	 (1<<12) /* RTS delta */
#define  USR1_ESCF  	 (1<<11) /* Escape seq interrupt flag */
#define  USR1_FRAMERR    (1<<10) /* Frame error interrupt flag */
#define  USR1_RRDY       (1<<9)	 /* Receiver ready interrupt/dma flag */
#define  USR1_TIMEOUT    (1<<7)	 /* Receive timeout interrupt status */
#define  USR1_RXDS  	 (1<<6)	 /* Receiver idle interrupt flag */
#define  USR1_AIRINT	 (1<<5)	 /* Async IR wake interrupt flag */
#define  USR1_AWAKE 	 (1<<4)	 /* Aysnc wake interrupt flag */
#define  USR2_ADET  	 (1<<15) /* Auto baud rate detect complete */
#define  USR2_TXFE  	 (1<<14) /* Transmit buffer FIFO empty */
#define  USR2_DTRF  	 (1<<13) /* DTR edge interrupt flag */
#define  USR2_IDLE  	 (1<<12) /* Idle condition */
#define  USR2_IRINT 	 (1<<8)	 /* Serial infrared interrupt flag */
#define  USR2_WAKE  	 (1<<7)	 /* Wake */
#define  USR2_RTSF  	 (1<<4)	 /* RTS edge interrupt flag */
#define  USR2_TXDC  	 (1<<3)	 /* Transmitter complete */
#define  USR2_BRCD  	 (1<<2)	 /* Break condition */
#define  USR2_ORE        (1<<1)	 /* Overrun error */
#define  USR2_RDR        (1<<0)	 /* Recv data ready */
#define  UTS_FRCPERR	 (1<<13) /* Force parity error */
#define  UTS_LOOP        (1<<12) /* Loop tx and rx */
#define  UTS_TXEMPTY	 (1<<6)	 /* TxFIFO empty */
#define  UTS_RXEMPTY	 (1<<5)	 /* RxFIFO empty */
#define  UTS_TXFULL 	 (1<<4)	 /* TxFIFO full */
#define  UTS_RXFULL 	 (1<<3)	 /* RxFIFO full */
#define  UTS_SOFTRST	 (1<<0)	 /* Software reset */


/* DEVICE DATA STRUCTURE TYPEs ************************************************/

struct ring_buffer {
	int head;						/* head pointer */
	int tail;						/* tail pointer */
	char buf[BUFFER_SIZE];			/* buffer */
};

typedef struct ring_buffer ring_buffer_t;

struct rt_imx_device {
	void* mapped_io;				/* pointer to device memory base addr */
	struct clk* perclk;				/* UART peripheral clock pointer */
};

struct rt_imx_port {
	struct rtser_config config;		/* current device configuration */
	
	unsigned long membase;			/* port memory base address */
	unsigned long uartclk;			/* UART peripheral clock */

	rtdm_irq_t irq_handle;			/* device IRQ handle */
	rtdm_lock_t lock;				/* lock to protect context struct */
	int reserved;					/* padding int */

	struct ring_buffer rxbuffer;	/* RX circular buffer */
	int in_nwait;					/* bytes the user waits for */
	rtdm_event_t in_event;			/* raised to unblock reader */
	volatile unsigned long in_lock;	/* single-reader lock */
	uint64_t *in_history;			/* RX timestamp buffer */

	struct ring_buffer txbuffer;	/* TX circular buffer */
	rtdm_event_t out_event;			/* raised to unblock writer */
	rtdm_mutex_t out_lock;			/* single-writer mutex */

	uint64_t last_timestamp;		/* timestamp of last event */
	int ioc_events;					/* recorded events */
	rtdm_event_t ioc_event;			/* raised to unblock event waiter */
	volatile unsigned long ioc_event_lock;	/* single-waiter lock */

	int status;						/* cache for URXD0 + soft-states */
	int saved_errors;				/* error cache for RTIOC_GET_STATUS */
};

/******************************************************************************/
/* Ring buffer manager ********************************************************/
/******************************************************************************/

static inline
int rbuf_pending(ring_buffer_t* buf) {
	return buf->head - buf->tail;
}

static inline
int rbuf_copy_in(ring_buffer_t* buf, char* src, int sz, rtdm_user_info_t* ui)
{
	int block = BUFFER_SIZE - (buf->head & (BUFFER_SIZE - 1));
	
	block = (sz < block) ? sz : block;
	
	if (ui) {
		if (rtdm_copy_from_user(ui, &buf->buf[buf->head], src, block) != 0)
			return -EFAULT;
	} else 
		memcpy(&buf->buf[buf->head], src, block);
	
	buf->head += block;
	
	return block;
}

static inline
int rbuf_copy_out(ring_buffer_t* buf, char* dst, int sz, rtdm_user_info_t* ui)
{
	int block = BUFFER_SIZE - (buf->tail & (BUFFER_SIZE - 1));
	
	block = (sz < block) ? sz : block;
	
	if (ui) {
		if (rtdm_copy_to_user(ui, dst, &buf->buf[buf->tail], block) != 0)
			return -EFAULT;
	} else
		memcpy(dst, &buf->buf[buf->tail], block);
	
	buf->tail += block;
	
	return block;
}


/******************************************************************************/
/* Event handling *************************************************************/
/******************************************************************************/

static inline
int rt_imx_read_wait(struct rt_imx_port* port, rtdm_toseq_t* to_seq)
{
	return 
	rtdm_event_timedwait(&port->in_event, port->config.rx_timeout, to_seq);
}

static inline
void rt_imx_read_wakeup(struct rt_imx_port* port) {
	rtdm_event_signal(&port->in_event);
}

static inline
int rt_imx_write_wait(struct rt_imx_port* port, rtdm_toseq_t* to_seq)
{
	return 
	rtdm_event_timedwait(&port->out_event, port->config.tx_timeout, to_seq);
}

static inline
void rt_imx_write_wakeup(struct rt_imx_port* port) {
	rtdm_event_signal(&port->out_event);
}


/******************************************************************************/
/* Device control functions ***************************************************/
/******************************************************************************/

static inline 
void rt_imx_transmit_buffer(struct rt_imx_port *port)
{	/* lock acquired on entry */
	struct ring_buffer* xmit = &port->txbuffer;
	
	while ( !(readl(port->membase + UTS) & UTS_TXFULL) ) {
		if (rbuf_pending(xmit) == 0)
			break;

		/* send xmit->buf[xmit->tail] out of the port here */
		writel(xmit->buf[xmit->tail], port->membase + URTX0);
		++(xmit->tail);
	}
}

void rt_imx_break_ctl(struct rt_imx_port* port, int break_state)
{	/* interrupts disabled on entry */
	unsigned long temp;
	
	temp = readl(port->membase + UCR1);
	temp = (break_state != 0) ? temp | UCR1_SNDBRK :temp & ~UCR1_SNDBRK ;
	
	writel(temp, port->membase + UCR1);
}


static inline void rt_imx_stop_tx(struct rt_imx_port* port) 
{	/* interrupts disabled on entry */
	unsigned long temp = readl(port->membase + UCR1);
	writel(temp & ~UCR1_TXMPTYEN, port->membase + UCR1);
}

static inline void rt_imx_start_tx(struct rt_imx_port* port)
{	/* interrupts disabled on entry */
	unsigned long temp = readl(port->membase + UCR1);
	writel(temp | UCR1_TXMPTYEN, port->membase + UCR1);
	
	if (readl(port->membase + UTS) & UTS_TXEMPTY)
		rt_imx_transmit_buffer(port);
}

static inline void rt_imx_stop_rx(struct rt_imx_port* port) 
{	/* interrupts disabled on entry */
	unsigned long temp = readl(port->membase + UCR2);
	writel(temp & ~UCR2_RXEN, port->membase + UCR2);
}

static inline void rt_imx_start_rx(struct rt_imx_port* port) 
{	/* interrupts disabled on entry */
	unsigned long temp = readl(port->membase + UCR2);
	writel(temp | UCR2_RXEN, port->membase + UCR2);
}


/******************************************************************************/
/* Map & Release IO ***********************************************************/
/******************************************************************************/

static struct rt_imx_device imx_devices[MAX_DEVICES];

static inline unsigned long rt_imx_base_addr(int rt_dev_id)
{
	return (unsigned long)imx_devices[rt_dev_id].mapped_io;
}

static int rt_imx_init_io(struct rtdm_device* dev, int imx_dev_id) 
{
	int rt_dev_id = dev->device_id;
	dev->device_data = &imx_devices[rt_dev_id];

	/* retrieving peripheral clock */
	imx_devices[rt_dev_id].perclk = clk_get(NULL, "uart_clk");
	if (IS_ERR(imx_devices[rt_dev_id].perclk))
		return PTR_ERR(imx_devices[rt_dev_id].perclk);
		
	clk_enable(imx_devices[rt_dev_id].perclk);

	imx_devices[rt_dev_id].mapped_io = ioremap(mem[imx_dev_id], PAGE_SIZE);
	if (!imx_devices[rt_dev_id].mapped_io)
		return EBUSY;
	
	return 0;
}

static void rt_imx_release_io(struct rtdm_device* dev) 
{
	int rt_dev_id = dev->device_id;

	clk_disable(imx_devices[rt_dev_id].perclk);
	clk_put(imx_devices[rt_dev_id].perclk);

	iounmap(imx_devices[rt_dev_id].mapped_io);
}



--Apple-Mail-6--872321699
Content-Disposition: attachment;
	filename=imx.c
Content-Type: application/octet-stream;
	name="imx.c"
Content-Transfer-Encoding: 7bit

/*
 *  linux/drivers/xenomai/serial/imx.c
 *
 *  RTDM Xenomai Driver for Motorola IMX serial ports
 *
 *  Based on drivers/serial/imx.c, by Linus Torvalds, Theodore Ts'o.
 *    and on drivers/xenomai/serial/16550A.c, by Jan Kiszka
 *
 *  Author: Paolo Bernini <paolo.bernini@domain.hid>
 *  Copyright (C) 2009 Paolo Bernini
 *
 * Xenomai is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Xenomai is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Xenomai; if not, write to the Free Software Foundation,
 * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * TODO list:
 * - enable support to more than one interface
 */

#include "imx_io.h"

#include <linux/version.h>
#include <linux/module.h> 

#define RT_IMX_DRIVER_NAME	"xeno_imx"

/* RTSER masks */
#define PARITY_MASK			0x03
#define DATA_BITS_MASK		0x03
#define STOP_BITS_MASK		0x01
#define FIFO_MASK			0xC0
#define EVENT_MASK			0x0F

#define IMX27_TTYSMX2_IDX	2
#define IMX27_TTYSMX2_IRQ	18

/* transmitter and receiver trigger level */
#define TXTL	2
#define RXTL	1


/* Module Params definitions **************************************************/
static unsigned int irq;			/* interrupt index */
static unsigned int dev_index;		/* system index of the managed port */

module_param(irq, uint, 0400);
MODULE_PARM_DESC(irq, "Interrupt index (IRQ) of the managed port");

module_param(dev_index, uint, 0400);
MODULE_PARM_DESC(dev_index, "System index of the managed port");


/* Default rt serial port configuration ***************************************/
static const struct rtser_config default_config = {
	0xFFFF, RTSER_DEF_BAUD, RTSER_DEF_PARITY, RTSER_DEF_BITS,
	RTSER_DEF_STOPB, RTSER_DEF_HAND, RTSER_DEF_FIFO_DEPTH,
	RTSER_DEF_TIMEOUT, RTSER_DEF_TIMEOUT, RTSER_DEF_TIMEOUT,
	RTSER_DEF_TIMESTAMP_HISTORY, RTSER_DEF_EVENT_MASK
};


/* Pointer to allocated device TODO: support more than one device *************/
static struct rtdm_device* device[MAX_DEVICES];


/******************************************************************************/
/* INTERRUPT ROUTINES *********************************************************/
/******************************************************************************/

static inline void rt_imx_txint(struct rt_imx_port* port)
{
	rt_imx_transmit_buffer(port);
	
	if (rbuf_pending(&port->txbuffer) == 0) {
		rt_imx_stop_tx(port);
		rt_imx_write_wakeup(port);
	}
}


static inline void rt_imx_rxint(struct rt_imx_port* port, uint64_t* timestamp)
{
	struct ring_buffer* recv = &port->rxbuffer;
	int rbytes = 0;
	unsigned long rx, temp;
	
	while(readl(port->membase + USR2) & USR2_RDR) {
		rx = readl(port->membase + URXD0);
		
		temp = readl(port->membase + USR2);
		if (temp & USR2_BRCD) {		/* sensed break */
			/* reset break flag */
			writel(temp | USR2_BRCD, port->membase + USR2);
			port->status |= RTSER_LSR_BREAK_IND;
		}
		
		if (rbuf_pending(recv) == BUFFER_SIZE) {
			/* NOTE: on overflow data stream is no more reliable */
			port->status |= RTSER_SOFT_OVERRUN_ERR;
		}
		
		recv->buf[recv->head & (BUFFER_SIZE - 1)] = (char) (rx & 0x000000FF);
		if (port->in_history)
			port->in_history[recv->head & (BUFFER_SIZE - 1)] = *timestamp;
			
		++(recv->head);
		++rbytes;
		
		if ( rx & (URXD_PRERR | URXD_OVRRUN | URXD_FRMERR) ) {
			if (rx & URXD_PRERR)
				port->status |= RTSER_LSR_PARITY_ERR;
			if (rx & URXD_FRMERR)
				port->status |= RTSER_LSR_FRAMING_ERR;
			if (rx & URXD_OVRRUN)
				port->status |= RTSER_LSR_OVERRUN_ERR;
		}
	}
	

	if (port->in_nwait > 0) {
		if ((port->in_nwait <= rbytes)) {
			port->in_nwait = 0;
			rt_imx_read_wakeup(port);
		} else
			port->in_nwait -= rbytes;
	}
}

static int rt_imx_int(rtdm_irq_t* irq_context)
{
	struct rt_imx_port* port;
	uint64_t timestamp = rtdm_clock_read();
	unsigned long sts;

	port = rtdm_irq_get_arg(irq_context, struct rt_imx_port);

	rtdm_lock_get(&port->lock);

	sts = readl(port->membase + USR1);
	
	if (sts & USR1_RRDY)
		rt_imx_rxint(port, &timestamp);

	if (sts & USR1_TRDY && readl(port->membase + UCR1) & UCR1_TXMPTYEN)
		rt_imx_txint(port);

	if (sts & USR1_RTSD)
		; // TODO: enable hw handshake and make rt_imx_rtsint()

	rtdm_lock_put(&port->lock);

	return RTDM_IRQ_HANDLED;
}


/******************************************************************************/
/* PRIVATE UTILITIES **********************************************************/
/******************************************************************************/

static int rt_imx_set_config(struct rt_imx_port *port,
			       const struct rtser_config *config, uint64_t **in_history_ptr) 
{
	unsigned long temp, old_ucr1;
	int err = 0;
		
	/* variable to save the context while holding a lock*/
	rtdm_lockctx_t lock_ctx;
	
	/* LINE CONFIGURATION *****************************************************/
	/* make line configuration atomic and IRQ-safe */
	rtdm_lock_get_irqsave(&port->lock, lock_ctx);

	if (testbits(config->config_mask, RTSER_SET_BAUD)) {
		unsigned int div, num, den;
	
		port->config.baud_rate = config->baud_rate;
		
		div = port->uartclk / (config->baud_rate << 4);
		div = (div > 7) ? 7 : (div == 0) ? 1 : div;
				
		num = port->uartclk;
		den = (config->baud_rate * div) << 4;

		/* shift num and denom right until they fit into 16 bits */
		while (num > 0x10000 || den > 0x10000) {
			num >>= 1;
			den >>= 1;
		}
		if (num > 0)
			num -= 1;
		if (den > 0)
			den -= 1;

		/* disable interrupts */
		old_ucr1 = readl(port->membase + UCR1);
		writel (old_ucr1 & ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN), 
				port->membase + UCR1);

		/* The UBIR register must be updated BEFORE the UBMR register */
		writel(den, port->membase + UBIR);
		writel(num, port->membase + UBMR);

#ifdef ONEMS
		writel(port->uartclk / div / 1000, port->membase + ONEMS);
#endif

		div = (div == 7) ? 6 : 6-div;	 /* 6 in RFDIV means divide by 7 */

		temp = readl(port->membase + UFCR);
		temp = (temp & (~UFCR_RFDIV)) | (div << 7);
		writel(temp, port->membase + UFCR);
		
		/* restore UCR1 */
		writel(old_ucr1, port->membase + UCR1);
	}

	/* read UART Control Register 2 */
	temp = readl(port->membase + UCR2);
		
	/* configure parity */
	if (testbits(config->config_mask, RTSER_SET_PARITY)) {
		port->config.parity = config->parity & PARITY_MASK;
		switch (port->config.parity) {
		case RTSER_NO_PARITY:
			temp &= ~(UCR2_PREN | UCR2_PROE); break;
		case RTSER_ODD_PARITY:
			temp |= UCR2_PREN | UCR2_PROE; break;
		case RTSER_EVEN_PARITY:
			temp &= ~(UCR2_PROE); temp |= UCR2_PREN; break;
		}
	}
	
	/* configure data bits nr. */
	if (testbits(config->config_mask, RTSER_SET_DATA_BITS)) {
		port->config.data_bits = config->data_bits & DATA_BITS_MASK;
		switch(port->config.data_bits) {
		case RTSER_8_BITS:
			temp |= UCR2_WS; break;
		case RTSER_7_BITS:
			temp &= ~(UCR2_WS); break;
		default:
			printk(RT_IMX_DRIVER_NAME ": Requested data bits not supported\n");
		}
	}
			
	/* configure stop bits */
	if (testbits(config->config_mask, RTSER_SET_STOP_BITS)) {
		port->config.stop_bits = config->stop_bits & STOP_BITS_MASK;
		switch (port->config.stop_bits) {
		case RTSER_1_STOPB:
			temp &= ~(UCR2_STPB); break;
		case RTSER_2_STOPB:
			temp |= UCR2_STPB; break;
		default:
			printk(RT_IMX_DRIVER_NAME ": Requested stop bits not supported\n");
		}
	}
		
	/* configure handshake */
	if (testbits(config->config_mask, RTSER_SET_HANDSHAKE)) {
		port->config.handshake = config->handshake;

		switch (port->config.handshake) {
		case RTSER_RTSCTS_HAND:
			// ...?

		default:	/* RTSER_NO_HAND */
			temp |= UCR2_IRTS | UCR2_CTSC | UCR2_CTS;
			break;
		}
	}
	
	/* write configuration to UCR2 */
	if (testbits(config->config_mask, 
			RTSER_SET_PARITY |
			RTSER_SET_DATA_BITS |
			RTSER_SET_STOP_BITS |
			RTSER_SET_BAUD)) {

		writel(temp, port->membase + UCR2);

		port->ioc_events &= ~RTSER_EVENT_ERRPEND;
	}

	/* TODO: configure FIFO */

	rtdm_lock_put_irqrestore(&port->lock, lock_ctx);
	/* END OF LINE CONFIGURATION **********************************************/

	/* Timeout manipulation is not atomic. The user is supposed to take
	   care not to use and change timeouts at the same time. */
	if (testbits(config->config_mask, RTSER_SET_TIMEOUT_RX))
		port->config.rx_timeout = config->rx_timeout;
	if (testbits(config->config_mask, RTSER_SET_TIMEOUT_TX))
		port->config.tx_timeout = config->tx_timeout;
	if (testbits(config->config_mask, RTSER_SET_TIMEOUT_EVENT))
		port->config.event_timeout = config->event_timeout;

	if (testbits(config->config_mask, RTSER_SET_TIMESTAMP_HISTORY)) {
		/* change timestamp history atomically */
		rtdm_lock_get_irqsave(&port->lock, lock_ctx);

		if (testbits
		    (config->timestamp_history, RTSER_RX_TIMESTAMP_HISTORY)) {
			if (!port->in_history) {
				port->in_history = *in_history_ptr;
				*in_history_ptr = NULL;
				if (!port->in_history)
					err = -ENOMEM;
			}
		} else {
			*in_history_ptr = port->in_history;
			port->in_history = NULL;
		}

		rtdm_lock_put_irqrestore(&port->lock, lock_ctx);
	}

	if (testbits(config->config_mask, RTSER_SET_EVENT_MASK)) {
		/* change event mask atomically */
		rtdm_lock_get_irqsave(&port->lock, lock_ctx);

		port->config.event_mask = config->event_mask & EVENT_MASK;
		port->ioc_events = 0;

		if (testbits(config->event_mask, RTSER_EVENT_RXPEND) && 
				(rbuf_pending(&port->rxbuffer) > 0))
			port->ioc_events |= RTSER_EVENT_RXPEND;

		if (testbits(config->event_mask, RTSER_EVENT_ERRPEND))
			port->ioc_events |= RTSER_EVENT_ERRPEND;

		if (testbits(config->event_mask,
			     RTSER_EVENT_MODEMHI | RTSER_EVENT_MODEMLO))
			printk(RT_IMX_DRIVER_NAME ": MODEM interrupt not supported\n");

		rtdm_lock_put_irqrestore(&port->lock, lock_ctx);
	}

	return err;
}

void rt_imx_cleanup_ctx(struct rt_imx_port* port) 
{
	rtdm_event_destroy(&port->in_event);
	rtdm_event_destroy(&port->out_event);
	rtdm_event_destroy(&port->ioc_event);
	rtdm_mutex_destroy(&port->out_lock);
}


/******************************************************************************/
/* INTERFACE FUNCTIONS ********************************************************/
/******************************************************************************/

/* rt_dev_open ****************************************************************/

int rt_imx_open(struct rtdm_dev_context* context,
		  rtdm_user_info_t* user_info, int oflags) 
{
	struct rt_imx_port* port = (struct rt_imx_port*) context->dev_private;
	struct rt_imx_device* device;
	int rt_dev_id = context->device->device_id;
	int err = 0;
	unsigned long temp;
	uint64_t* dummy_history = NULL;
	
	/* variable to save the context while holding a lock*/
	rtdm_lockctx_t lock_ctx;

	/* (re)set context */
	memset(port, 0, sizeof(struct rt_imx_port));

	/* IPC initialisation - cannot fail with used parameters */
	rtdm_lock_init(&port->lock);
	rtdm_event_init(&port->in_event, 0);
	rtdm_event_init(&port->out_event, 0);
	rtdm_event_init(&port->ioc_event, 0);
	rtdm_mutex_init(&port->out_lock);

	device = (struct rt_imx_device*) context->device->device_data;
	
	port->membase = rt_imx_base_addr(rt_dev_id);
	port->uartclk = clk_get_rate(device->perclk);

	rt_imx_set_config(port, &default_config, &dummy_history);
	
	rtdm_lock_get_irqsave(&port->lock, lock_ctx);

	/* set receiver / transmitter trigger level */
	temp = TXTL << 10 | RXTL;
	writel(temp, port->membase + UFCR);

	/* disable the DREN bit (Data REady int. ENable) before requesting IRQs */
	temp = readl(port->membase + UCR4);
	writel(temp & ~UCR4_DREN, port->membase + UCR4);

	/* register irq handler */
	err = rtdm_irq_request(&port->irq_handle, irq,
			       rt_imx_int,
			       RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE,
			       context->device->proc_name, port);
	if (err != 0) {
		/* reset RTS */
		writel(USR1_RTSD, port->membase + USR1);
		rt_imx_cleanup_ctx(port);	/* destroy locks and mutexes*/
		
		printk(KERN_ERR RT_IMX_DRIVER_NAME ": Can't obtain IRQ(%d)\n", irq);
		goto out;
	}
	
	/* Clear and enable interrupts */
	writel(USR1_RTSD, port->membase + USR1);

	/* UART ENable */
	temp = readl(port->membase + UCR1);
	temp |= UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN;
	writel(temp, port->membase + UCR1);
	
	/* Receiver and Transmitter enable */
	temp = readl(port->membase + UCR2);
	writel(temp | UCR2_TXEN | UCR2_RXEN, port->membase + UCR2);

#if defined CONFIG_ARCH_MX2 || defined CONFIG_ARCH_MX3
	/* This bit should always be set to 1 */
	temp = readl(port->membase + UCR3);
	writel(temp | UCR3_RXDMUXSEL, port->membase + UCR3);
#endif

out:
	rtdm_lock_put_irqrestore(&port->lock, lock_ctx);

	return err;
}

/* rt_dev_close ***************************************************************/

int rt_imx_close(struct rtdm_dev_context* context,
		   rtdm_user_info_t* user_info) 
{
	struct rt_imx_port *port = (struct rt_imx_port*)context->dev_private;
	unsigned long temp;
	uint64_t *in_history;
	
	/* variable to save the context while holding a lock*/
	rtdm_lockctx_t lock_ctx;

	rtdm_lock_get_irqsave(&port->lock, lock_ctx);

	/* free the interrupt */
	rtdm_irq_free(&port->irq_handle);
	
	/* Disable all interrupts, port and break condition */
	temp = readl(port->membase + UCR1);
	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
	writel(temp, port->membase + UCR1);

	in_history = port->in_history;
	port->in_history = NULL;

	rtdm_lock_put_irqrestore(&port->lock, lock_ctx);

	rt_imx_cleanup_ctx(port);

	if (in_history) {
		if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags))
			kfree(in_history);
		else
			rtdm_free(in_history);
	}

	return 0;
}

/* rt_dev_ioctl ***************************************************************/

int rt_imx_ioctl(struct rtdm_dev_context* context, rtdm_user_info_t* user_info,
		   unsigned int request, void* arg) 
{
	rtdm_lockctx_t lock_ctx;
	struct rt_imx_port *port = (struct rt_imx_port*) context->dev_private;
	int err;
	
	switch (request) {
	
	case RTSER_RTIOC_GET_CONFIG:
		if (user_info)
			err = rtdm_safe_copy_to_user(user_info, arg, &port->config,
					sizeof(struct rtser_config));
		else
			memcpy(arg, &port->config,
					sizeof(struct rtser_config));
		return 0;
		
	case RTSER_RTIOC_SET_CONFIG: {
		struct rtser_config *config;
		struct rtser_config config_buf;
		uint64_t *hist_buf = NULL;

		config = (struct rtser_config *)arg;

		if (user_info) {
			err = rtdm_safe_copy_from_user(user_info, &config_buf, arg,
					sizeof(struct rtser_config));
			if (err)
				return err;

			config = &config_buf;
		}

		if (testbits(config->config_mask, RTSER_SET_BAUD)
				&& (config->baud_rate > (port->uartclk >> 4)
				||  config->baud_rate < 9600))
			/* invalid baudrate for this port */
			return -EINVAL;

		if (testbits(config->config_mask, RTSER_SET_TIMESTAMP_HISTORY)) {
			if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags)
					&& rtdm_in_rt_context())
			{
				/* allocation or release of non-RT buffer in RT context. */
				return -EPERM;
			}

			if (testbits(config->timestamp_history, RTSER_RX_TIMESTAMP_HISTORY))
			{
				if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags))
					hist_buf = kmalloc(BUFFER_SIZE*sizeof(nanosecs_abs_t),
						    GFP_KERNEL);
				else
					hist_buf = rtdm_malloc(BUFFER_SIZE*sizeof(nanosecs_abs_t));
							
				if (!hist_buf)
					return -ENOMEM;
			}
		}

		rt_imx_set_config(port, config, &hist_buf);

		if (hist_buf) {
			if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags))
				kfree(hist_buf);
			else
				rtdm_free(hist_buf);
		}

		return 0;
	}
	
	case RTSER_RTIOC_GET_STATUS: {
		int status;

		rtdm_lock_get_irqsave(&port->lock, lock_ctx);

		status = port->saved_errors | port->status;
		port->status = 0;
		port->saved_errors = 0;
		port->ioc_events &= ~RTSER_EVENT_ERRPEND;

		rtdm_lock_put_irqrestore(&port->lock, lock_ctx);

		if (user_info) {
			struct rtser_status status_buf;

			err = rtdm_safe_copy_to_user(
					user_info,
					arg,
					&status_buf,
					sizeof(struct rtser_status));
		} else {
			((struct rtser_status *)arg)->line_status = status;
		}
		
		break;
	}

	case RTSER_RTIOC_BREAK_CTL:
		rtdm_lock_get_irqsave(&port->lock, lock_ctx);
		rt_imx_break_ctl(port, ((long)arg & RTSER_BREAK_SET));
		rtdm_lock_put_irqrestore(&port->lock, lock_ctx);
		return 0;

	case RTIOC_PURGE: {
		rtdm_lock_get_irqsave(&port->lock, lock_ctx);
		if ((long)arg & RTDM_PURGE_RX_BUFFER) {
			rt_imx_stop_rx(port);	/* disable rx to ensure FIFO flushing */
		
			port->rxbuffer.head = 0;
			port->rxbuffer.tail = 0;

			while (readl(port->membase + USR1) & USR1_RRDY)
				readl(port->membase + URXD0);	/* flush RX FIFO */
				
			rt_imx_start_rx(port);
		}
		if ((long)arg & RTDM_PURGE_TX_BUFFER) {
			rt_imx_stop_tx(port);
			
			port->txbuffer.head = 0;
			port->txbuffer.tail = 0;
		}
		rtdm_lock_put_irqrestore(&port->lock, lock_ctx);
		return 0;
	}

	default:
		return -ENOTTY;
	}

	return 0;
}

/* rt_dev_read ****************************************************************/

ssize_t rt_imx_read(struct rtdm_dev_context* context,
		      rtdm_user_info_t* user_info, void* buf, size_t nbyte) 
{     
	struct rt_imx_port* port = (struct rt_imx_port*) context->dev_private;
	struct ring_buffer* recv = &port->rxbuffer;
	rtdm_lockctx_t lock_ctx;
	size_t read = 0;
	int pending;
	int block, retv;
	char *out_pos = (char *)buf;
	rtdm_toseq_t timeout_seq;
	ssize_t ret = -EAGAIN;	/* for non-blocking read */
	int nonblocking;

	if (nbyte == 0)
		return 0;

	if (user_info && !rtdm_rw_user_ok(user_info, buf, nbyte))
		return -EFAULT;

	rtdm_toseq_init(&timeout_seq, port->config.rx_timeout);

	/* non-blocking is handled separately here */
	nonblocking = (port->config.rx_timeout < 0);

	/* only one reader allowed, stop any further attempts here */
	if (test_and_set_bit(0, &port->in_lock))
		return -EBUSY;

	rtdm_lock_get_irqsave(&port->lock, lock_ctx);

	for (;;) {
		if (port->status) {
			if (testbits(port->status, RTSER_LSR_BREAK_IND))
				ret = -EPIPE;
			else
				ret = -EIO;
			
			port->saved_errors = port->status &
			    (RTSER_LSR_OVERRUN_ERR | RTSER_LSR_PARITY_ERR |
			     RTSER_LSR_FRAMING_ERR | RTSER_SOFT_OVERRUN_ERR);
			port->status = 0;
			break;
		}

		rtdm_lock_put_irqrestore(&port->lock, lock_ctx);

		pending = rbuf_pending(recv);	/* ring buffer is thread safe */

		if (pending > 0) {
			block = (pending <= nbyte) ? pending : nbyte;

			do {
				retv = rbuf_copy_out(recv, out_pos, block, user_info);
				if (retv == -EFAULT)
					goto break_unlocked;
				
				out_pos += retv;	/* update user data pointer */
				block -= retv;		/* update remaining bytes to copy */
				nbyte -= retv;		/* update remaining bytes requested */
				read += retv;		/* update read counter */
			} while (block > 0);

			if (rbuf_pending(recv) == 0)
				port->ioc_events &= ~RTSER_EVENT_RXPEND;

			if (nbyte == 0)
				goto break_unlocked; /* All requested bytes read. */

			continue;
		}

		if (nonblocking)
			/* ret was set to EAGAIN in case of a real non-blocking call or
				contains the error returned by rtdm_event_wait[_until] */
				goto break_unlocked;

		port->in_nwait = nbyte;
	
		ret = rt_imx_read_wait(port, &timeout_seq);
		if (ret == -EIDRM)
			return -EBADF;	/* Device has been closed: return immediately */
			
		if (ret < 0) {
			rtdm_lock_get_irqsave(&port->lock, lock_ctx);

			nonblocking = 1;
			if (rbuf_pending(recv) > 0)
				continue;	/* Final turn: collect pending bytes before exit. */

			port->in_nwait = 0;
			break;
		}

		rtdm_lock_get_irqsave(&port->lock, lock_ctx);
	}

	rtdm_lock_put_irqrestore(&port->lock, lock_ctx);

break_unlocked:
	clear_bit(0, &port->in_lock);	/* Release the simple reader lock */

	if ((read > 0) && ((ret == 0) || (ret == -EAGAIN) ||
			   (ret == -ETIMEDOUT) || (ret == -EINTR)))
		ret = read;

	return ret;
}

/* rt_dev_write ***************************************************************/

ssize_t rt_imx_write(struct rtdm_dev_context* context,
		       rtdm_user_info_t* user_info, const void* buf, size_t nbyte) 
{
	struct rt_imx_port* port = (struct rt_imx_port*) context->dev_private;
	struct ring_buffer* xmit = &port->txbuffer;
	size_t written = 0;
	int free;
	int block, retv;
	char *in_pos = (char *)buf;
	ssize_t ret;

	rtdm_lockctx_t lock_ctx;
	
	/* to maintain a continuos timeout across multiple calls of blocking wait */
	rtdm_toseq_t timeout_seq;

	if (nbyte == 0)
		return 0;

	if (user_info && !rtdm_read_user_ok(user_info, buf, nbyte))
		return -EFAULT;

	rtdm_toseq_init(&timeout_seq, port->config.rx_timeout);

	/* Make write operation atomic. */
	ret = rtdm_mutex_timedlock(&port->out_lock, port->config.rx_timeout,
				   &timeout_seq);
	if (ret)
		return ret;

	while (nbyte > 0) {
		rtdm_lock_get_irqsave(&port->lock, lock_ctx);

		rtdm_lock_put_irqrestore(&port->lock, lock_ctx);

		free = BUFFER_SIZE - rbuf_pending(xmit);

		if (free > 0) {
			block = (nbyte <= free) ? nbyte : free;

			do {
				retv = rbuf_copy_in(xmit, in_pos, block, user_info);
				
				in_pos += retv;		/* update user data pointer */
				block -= retv;		/* update remaining bytes to copy */
				nbyte -= retv;		/* update remaining bytes requested */
				written += retv;	/* update written counter */
			} while (block > 0);

			/* start transmission */
			rtdm_lock_get_irqsave(&port->lock, lock_ctx);

			rt_imx_start_tx(port);

			rtdm_lock_put_irqrestore(&port->lock, lock_ctx);
			
			continue;
		}
		
		/* HERE only if bytes still pending and no space left on FIFO */
		
		ret = rt_imx_write_wait(port, &timeout_seq);
		if (ret < 0) {
			if (ret == -EIDRM)
				return -EBADF;	/* Device has been closed: return immediately */
			if (ret == -EWOULDBLOCK)
				ret = -EAGAIN;	/* Fix error code for non-blocking mode. */
			break;
		}
	}

	rtdm_mutex_unlock(&port->out_lock);

	if ((written > 0) && ((ret == 0) || (ret == -EAGAIN) ||
			      (ret == -ETIMEDOUT) || (ret == -EINTR)))
		ret = written;

	return ret;
}


/******************************************************************************/
/* INIT & EXIT MODULE *********************************************************/
/******************************************************************************/

/* RTDM device descriptor template */
static const struct rtdm_device __initdata device_tmpl = {
	.struct_version		= RTDM_DEVICE_STRUCT_VER,

	.device_flags		= RTDM_NAMED_DEVICE | RTDM_EXCLUSIVE,
	.context_size		= sizeof(struct rt_imx_port),
	.device_name		= "",

	.open_rt		= rt_imx_open,
	.open_nrt		= rt_imx_open,

	.ops = {
		.close_rt	= rt_imx_close,
		.close_nrt	= rt_imx_close,

		.ioctl_rt	= rt_imx_ioctl,
		.ioctl_nrt	= rt_imx_ioctl,

		.read_rt	= rt_imx_read,

		.write_rt	= rt_imx_write,
	},

	.device_class		= RTDM_CLASS_SERIAL,
	.device_sub_class	= RTDM_SUBCLASS_16550A,
	.profile_version	= RTSER_PROFILE_VER,
	.driver_name		= RT_IMX_DRIVER_NAME,
	.driver_version		= RTDM_DRIVER_VER(0, 0, 10),
	.peripheral_name	= "UART IMX",
	.provider_name		= "Paolo Bernini",
};

/**************************************************************** module_init */

static int __init rt_imx_serial_init(void) 
{
	int i, err;

	/* Param check */
	if (irq == 0) {
		printk(KERN_ERR "irq parameter needed to init module\n");
		return -EINVAL;
	}	

	for (i=0; i<1 /*MAX_DEVICES*/;++i) {
		device[i] = kmalloc(sizeof(struct rtdm_device), GFP_KERNEL);
		err = -ENOMEM;
		if (!device[i])
			goto cleanup_out;

		/* initializing device data structure */
		memcpy(device[i], &device_tmpl, sizeof(struct rtdm_device));
		snprintf(device[i]->device_name, RTDM_MAX_DEVNAME_LEN, "rtser%d", i);
		device[i]->device_id = i;
		device[i]->proc_name = device[i]->device_name;

		/* initializing io port */
		err = rt_imx_init_io(device[i], dev_index);
		if (err)
			goto kfree_out;
			
		/* Resetting the device sending a software reset */
		writel(0, rt_imx_base_addr(0) + UCR2);

		err = rtdm_dev_register(device[i]);
		if (err)
			goto release_io_out;

		printk(KERN_INFO "Serial: RT IMX driver as %s\n", device[i]->device_name);
	}
	
	return 0;

release_io_out:
	rt_imx_release_io(device[i]);

kfree_out:
	kfree(device[i]);

cleanup_out:
	printk(KERN_INFO "Serial: Unable to register RT IMX driver\n");
	return err;
}

/**************************************************************** module_exit */

static void __exit rt_imx_serial_exit(void) 
{
	rt_imx_release_io(device[0]);
	rtdm_dev_unregister(device[0], 1000);
	kfree(device[0]);
}

/******************************************************************************/
/* MODULE INFO ****************************************************************/
/******************************************************************************/

module_init(rt_imx_serial_init);

module_exit(rt_imx_serial_exit);


MODULE_AUTHOR("Paolo Bernini");
MODULE_DESCRIPTION("IMX Xenomai serial port driver");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:imx-uart");


--Apple-Mail-6--872321699
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



Here for comments, and help.
Greetings.

--- 
Paolo Bernini
B.Sc. in Information Technology Engineering

Scuola Superiore di Studi Universitari e Perfezionamento Sant'Anna
ARTS Lab - Advanced Robotics Technology and System Lab
Viale Rinaldo Piaggio, 34 - 56025 Pontedera (Pisa), Italy
Tel.     050 88-3410
e-mail    p.bernini@domain.hid













--Apple-Mail-6--872321699--

