Message-ID: <437074F8.6020003@domain.hid>
Date: Tue, 08 Nov 2005 10:50:48 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [16550A-PATCH] integer baud rate, type renaming
References: <436F8F47.8020307@domain.hid>
	<436F9F3F.3010405@domain.hid>
In-Reply-To: <436F9F3F.3010405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Hi all,
>>
>>and another patch: This one changes the rtserial API so that the baud
>>rate can now be provided as an integer instead of the previous low-level
>>encoded value. The baud base of a device is provided as module parameter
>>to the driver on insmod. Turned out that I specified a not very useful
>>interface in this regard. Moreover, this patch also moves to
>>int64_t/uint64_t types.
>>
>>No regressions known, except that existing applications need a tiny
>>patch for setting the baud rate according to the new format. Please apply.
>>
> 
> 
> There was a regression in user space due to the int64_t/uint64_t types.
> The attached patch addresses this in rtdm/rtdm.h by including inttypes.h
> - no need for the device profile header to care about this anymore.
> 
> Please apply THIS one instead.

Applied, thanks.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: skins/rtdm/rtdm.h
> ===================================================================
> --- skins/rtdm/rtdm.h	(revision 112)
> +++ skins/rtdm/rtdm.h	(working copy)
> @@ -48,6 +48,7 @@
>  #else  /* !__KERNEL__ */
>  
>  #include <fcntl.h>
> +#include <inttypes.h>
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>  
> Index: skins/rtdm/rtserial.h
> ===================================================================
> --- skins/rtdm/rtserial.h	(revision 112)
> +++ skins/rtdm/rtserial.h	(working copy)
> @@ -77,38 +77,13 @@
>  #ifndef _RTSERIAL_H
>  #define _RTSERIAL_H
>  
> -#include <asm/types.h>
>  #include <rtdm/rtdm.h>
>  
>  /*!
> - * @anchor RTSER_xxx_BAUD   @name RTSER_xxx_BAUD
> - * Baud rates
> + * @anchor RTSER_DEF_BAUD   @name RTSER_DEF_BAUD
> + * Default baud rate
>   * @{ */
> -#define RTSER_50_BAUD               2304
> -#define RTSER_75_BAUD               1536
> -#define RTSER_110_BAUD              1047
> -#define RTSER_134_5_BAUD            857
> -#define RTSER_150_BAUD              768
> -#define RTSER_300_BAUD              384
> -#define RTSER_600_BAUD              192
> -#define RTSER_1200_BAUD             96
> -#define RTSER_2400_BAUD             48
> -#define RTSER_3600_BAUD             32
> -#define RTSER_4800_BAUD             24
> -#define RTSER_7200_BAUD             16
> -#define RTSER_9600_BAUD             12
> -#define RTSER_19200_BAUD            6
> -#define RTSER_38400_BAUD            3
> -#define RTSER_57600_BAUD            2
> -#define RTSER_115200_BAUD           1
> -#define RTSER_DEF_BAUD              RTSER_9600_BAUD
> -
> -/** Generate customised baud rate code
> - * @param base UART clock base
> - * @param rate baud rate
> - */
> -#define RTSER_CUSTOM_BAUD(base, rate) \
> -    ((base + (rate >> 1)) / rate)
> +#define RTSER_DEF_BAUD              9600
>  /** @} */
>  
>  /*!
> @@ -259,7 +234,7 @@
>  typedef struct rtser_config {
>      int     config_mask;        /**< mask specifying valid fields,
>                                   *   see @ref RTSER_SET_xxx */
> -    int     baud_rate;          /**< baud rate, see @ref RTSER_xxx_BAUD */
> +    int     baud_rate;          /**< baud rate, default @ref RTSER_DEF_BAUD */
>      int     parity;             /**< number of parity bits, see
>                                   *   @ref RTSER_xxx_PARITY */
>      int     data_bits;          /**< number of data bits, see
> @@ -270,13 +245,13 @@
>                                   *   @ref RTSER_xxx_HAND */
>      int     fifo_depth;         /**< reception FIFO interrupt threshold, see
>                                   *   @ref RTSER_FIFO_xxx */
> -    __s64   rx_timeout;         /**< reception timeout in ns, see
> +    int64_t rx_timeout;         /**< reception timeout in ns, see
>                                   *   @ref RTSER_TIMEOUT_xxx for special
>                                   *   values */
> -    __s64   tx_timeout;         /**< transmission timeout in ns, see
> +    int64_t tx_timeout;         /**< transmission timeout in ns, see
>                                   *   @ref RTSER_TIMEOUT_xxx for special
>                                   *   values */
> -    __s64   event_timeout;      /**< event timeout in ns, see
> +    int64_t event_timeout;      /**< event timeout in ns, see
>                                   *   @ref RTSER_TIMEOUT_xxx for special
>                                   *   values */
>      int     timestamp_history;  /**< enable timestamp history, see
> @@ -303,9 +278,9 @@
>      int     events;             /**< signalled events, see
>                                   *   @ref RTSER_EVENT_xxx */
>      int     rx_pending;         /**< number of pending input characters */
> -    __u64   last_timestamp;     /**< last interrupt timestamp (absolute time
> +    uint64_t last_timestamp;    /**< last interrupt timestamp (absolute time
>                                   *   in ns) */
> -    __u64   rxpend_timestamp;   /**< reception timestamp (absolute time in ns)
> +    uint64_t rxpend_timestamp;  /**< reception timestamp (absolute time in ns)
>                                   *   of oldest character in input queue */
>  } rtser_event_t;
>  
> Index: drivers/16550A/16550A.c
> ===================================================================
> --- drivers/16550A/16550A.c	(revision 112)
> +++ drivers/16550A/16550A.c	(working copy)
> @@ -29,9 +29,9 @@
>  #define IN_BUFFER_SIZE      4096
>  #define OUT_BUFFER_SIZE     4096
>  
> +#define DEFAULT_BAUD_BASE   115200
>  #define DEFAULT_TX_FIFO     16
>  
> -#define BAUD_MASK           0xFFFF
>  #define PARITY_MASK         0x03
>  #define DATA_BITS_MASK      0x03
>  #define STOP_BITS_MASK      0x01
> @@ -84,7 +84,7 @@
>      rtdm_event_t            in_event;
>      char                    in_buf[IN_BUFFER_SIZE];
>      volatile unsigned long  in_lock;
> -    u64                     *in_history;
> +    uint64_t                *in_history;
>  
>      int                     out_head;
>      int                     out_tail;
> @@ -93,7 +93,7 @@
>      char                    out_buf[OUT_BUFFER_SIZE];
>      rtdm_mutex_t            out_lock;
>  
> -    u64                     last_timestamp;
> +    uint64_t                last_timestamp;
>      volatile int            ioc_events;
>      rtdm_event_t            ioc_event;
>      volatile unsigned long  ioc_event_lock;
> @@ -117,6 +117,8 @@
>  static int                  ioaddr_c;
>  static unsigned int         irq[MAX_DEVICES];
>  static int                  irq_c;
> +static unsigned int         baud_base[MAX_DEVICES];
> +static int                  baud_base_c;
>  static int                  tx_fifo[MAX_DEVICES];
>  static int                  tx_fifo_c;
>  static unsigned int         start_index;
> @@ -125,6 +127,9 @@
>  MODULE_PARM_DESC(ioaddr, "I/O addresses of the serial devices");
>  module_param_array(irq, uint, &irq_c, 0400);
>  MODULE_PARM_DESC(irq, "IRQ numbers of the serial devices");
> +module_param_array(baud_base, uint, &baud_base_c, 0400);
> +MODULE_PARM_DESC(baud_base,
> +    "Maximum baud rate of the serial device (internal clock rate / 16)");
>  module_param_array(tx_fifo, int, &tx_fifo_c, 0400);
>  MODULE_PARM_DESC(tx_fifo, "Transmitter FIFO size");
>  module_param(start_index, uint, 0400);
> @@ -135,7 +140,7 @@
>  
>  
>  static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
> -                                        u64 *timestamp)
> +                                        uint64_t *timestamp)
>  {
>      int dev_id = ctx->dev_id;
>      int rbytes = 0;
> @@ -219,7 +224,7 @@
>      struct rt_16550_context *ctx;
>      int                     dev_id;
>      int                     iir;
> -    u64                     timestamp = rtdm_clock_read();
> +    uint64_t                timestamp = rtdm_clock_read();
>      int                     rbytes = 0;
>      int                     events = 0;
>      int                     modem;
> @@ -297,11 +302,12 @@
>  
>  static int rt_16550_set_config(struct rt_16550_context *ctx,
>                                 const struct rtser_config *config,
> -                               u64 **in_history_ptr)
> +                               uint64_t **in_history_ptr)
>  {
>      rtdm_lockctx_t  lock_ctx;
>      int             dev_id;
>      int             ret = 0;
> +    int             baud_div = 0;
>  
>  
>      dev_id = ctx->dev_id;
> @@ -310,11 +316,12 @@
>      rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
>  
>      if (testbits(config->config_mask, RTSER_SET_BAUD)) {
> -        ctx->config.baud_rate = config->baud_rate & BAUD_MASK;
> -
> -        outb(LCR_DLAB,                           LCR(dev_id));
> -        outb(ctx->config.baud_rate & 0xff, DLL(dev_id));
> -        outb(ctx->config.baud_rate >> 8,   DLM(dev_id));
> +        ctx->config.baud_rate = config->baud_rate;
> +        baud_div = (baud_base[dev_id] + (ctx->config.baud_rate >> 1)) /
> +                   ctx->config.baud_rate;
> +        outb(LCR_DLAB,        LCR(dev_id));
> +        outb(baud_div & 0xff, DLL(dev_id));
> +        outb(baud_div >> 8,   DLM(dev_id));
>      }
>  
>      if (testbits(config->config_mask, RTSER_SET_PARITY))
> @@ -423,7 +430,7 @@
>      struct rt_16550_context *ctx;
>      int                     dev_id = context->device->device_id;
>      int                     ret;
> -    __u64                   *dummy;
> +    uint64_t                *dummy;
>  
>  
>      ctx = (struct rt_16550_context *)context->dev_private;
> @@ -473,7 +480,7 @@
>  {
>      struct rt_16550_context *ctx;
>      int                     dev_id;
> -    u64                     *in_history;
> +    uint64_t                *in_history;
>      rtdm_lockctx_t          lock_ctx;
>  
>  
> @@ -521,6 +528,7 @@
>  {
>      struct rt_16550_context *ctx;
>      int                     ret = 0;
> +    int                     dev_id = context->device->device_id;
>  
>  
>      ctx = (struct rt_16550_context *)context->dev_private;
> @@ -541,7 +549,7 @@
>          case RTSER_RTIOC_SET_CONFIG: {
>              struct rtser_config *config;
>              struct rtser_config config_buf;
> -            __u64               *hist_buf = NULL;
> +            uint64_t            *hist_buf = NULL;
>  
>              config = (struct rtser_config *)arg;
>  
> @@ -556,6 +564,12 @@
>                  config = &config_buf;
>              }
>  
> +            if (testbits(config->config_mask, RTSER_SET_BAUD) &&
> +                (config->baud_rate > baud_base[dev_id])) {
> +                /* the baudrate is to high for this port */
> +                return -EINVAL;
> +            }
> +
>              if (testbits(config->config_mask, RTSER_SET_TIMESTAMP_HISTORY)) {
>                  if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags) &&
>                      rtdm_in_rt_context()) {
> @@ -568,11 +582,11 @@
>                               RTSER_RX_TIMESTAMP_HISTORY)) {
>                      if (test_bit(RTDM_CREATED_IN_NRT,
>                                   &context->context_flags))
> -                        hist_buf = kmalloc(IN_BUFFER_SIZE * sizeof(__u64),
> +                        hist_buf = kmalloc(IN_BUFFER_SIZE * sizeof(uint64_t),
>                                             GFP_KERNEL);
>                      else
>                          hist_buf =
> -                            rtdm_malloc(IN_BUFFER_SIZE * sizeof(__u64));
> +                            rtdm_malloc(IN_BUFFER_SIZE * sizeof(uint64_t));
>                  }
>  
>                  if (!hist_buf)
> @@ -1011,7 +1025,7 @@
>      device_class:       RTDM_CLASS_SERIAL,
>      device_sub_class:   RTDM_SUBCLASS_16550A,
>      driver_name:        "rt_16550A",
> -    driver_version:     RTDM_DRIVER_VER(1, 1, 2),
> +    driver_version:     RTDM_DRIVER_VER(1, 2, 0),
>      peripheral_name:    "UART 16550A",
>      provider_name:      "Jan Kiszka",
>  };
> @@ -1043,6 +1057,9 @@
>          if (!request_region(ioaddr[i], 8, dev->device_name))
>              goto kfree_out;
>  
> +        if (baud_base[i] == 0)
> +            baud_base[i] = DEFAULT_BAUD_BASE;
> +
>          if (tx_fifo[i] == 0)
>              tx_fifo[i] = DEFAULT_TX_FIFO;
>  
> Index: drivers/16550A/README
> ===================================================================
> --- drivers/16550A/README	(revision 112)
> +++ drivers/16550A/README	(working copy)
> @@ -1,6 +1,9 @@
>  Real-Time Serial Driver for 16550A-Compatible Devices
>  =====================================================
>  
> +Driver revision: 1.2.0
> +
> +
>  Preparation
>  -----------
>   - decide which serial ports are to be managed by the real-time driver
> @@ -18,6 +21,7 @@
>  ----------
>  
>  modprobe xeno_16550A ioaddr=<io1>[,<io2>...] irq=<irq1>[,<irq2>...]
> +                     [baud_base=<base1>[,<base2>...]]
>                       [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]
>  
>  Arguments:
> @@ -25,6 +29,8 @@
>                    (e.g. "0x3f8,0x2f8")
>      irq         - interrupt numbers of the devices, comma separated
>                    (e.g. "4,3")
> +    baud_base   - Maximum baud rates of the devices, comma separated, default
> +                  is 115200
>      tx_fifo     - Transmitter FIFO sizes of the devices in bytes, comma
>                    separated, default is 16
>      start_index - First device instance number to be used, default is 0
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

