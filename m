Message-ID: <4360BEBD.3040602@domain.hid>
Date: Thu, 27 Oct 2005 13:49:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] serial driver fixes/improvements
References: <4360B46C.5030104@domain.hid>
In-Reply-To: <4360B46C.5030104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
> Hi,
> 
> this patch improves the behaviour of xeno_16550A on
> RTSER_RTIOC_EVENT_WAIT. In case it is invoked from non-RT, the driver
> tries to trigger an automatic switch-back to RT via returning ENOSYS.
> The patch also fixes another remaining issue about the right context
> when calling RTSER_RTIOC_SET_CONFIG (forgot the corner case of releasing
> the RX history buffer in RT).
> 
> Note that I intentionally did not apply the EPERM->ENOSYS scheme on
> RTSER_RTIOC_SET_CONFIG. Here a switch to non-RT might be required if the
> device was opened in non-RT and a reconfigure request regarding the RX
> history buffer is now issued in RT. I think it's better to let the user
> decide via a preceding explicit switch to non-RT if leaving RT is really
> correct.

Applied, thanks.

> 
> The patch furthermore contains a README describing the device setup. I
> hope I addressed potential questions and problems sufficiently, feedback
> is welcome.
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: drivers/16550A/Kconfig
> ===================================================================
> --- drivers/16550A/Kconfig	(revision 73)
> +++ drivers/16550A/Kconfig	(working copy)
> @@ -3,4 +3,5 @@
>  	bool "16550A UART driver"
>  	default n
>  	help
> -	Real-time UART driver for 16550A compatible controllers.
> +	Real-time UART driver for 16550A compatible controllers. See
> +	drivers/16550A/README for more details.
> Index: drivers/16550A/16550A.c
> ===================================================================
> --- drivers/16550A/16550A.c	(revision 73)
> +++ drivers/16550A/16550A.c	(working copy)
> @@ -556,18 +556,24 @@
>                  config = &config_buf;
>              }
>  
> -            if (testbits(config->config_mask, RTSER_SET_TIMESTAMP_HISTORY) &&
> -                testbits(config->timestamp_history,
> -                         RTSER_RX_TIMESTAMP_HISTORY)) {
> -                if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags)) {
> -                    if (rtdm_in_rt_context())
> -                        return -EPERM;
> +            if (testbits(config->config_mask, RTSER_SET_TIMESTAMP_HISTORY)) {
> +                if (test_bit(RTDM_CREATED_IN_NRT, &context->context_flags) &&
> +                    rtdm_in_rt_context()) {
> +                    /* already fail if we MAY allocate or release a non-RT
> +                     * buffer in RT context */
> +                    return -EPERM;
> +                }
>  
> -                    hist_buf = kmalloc(IN_BUFFER_SIZE * sizeof(__u64),
> -                                       GFP_KERNEL);
> -                } else
> -                    hist_buf =
> -                        rtdm_malloc(IN_BUFFER_SIZE * sizeof(__u64));
> +                if (testbits(config->timestamp_history,
> +                             RTSER_RX_TIMESTAMP_HISTORY)) {
> +                    if (test_bit(RTDM_CREATED_IN_NRT,
> +                                 &context->context_flags))
> +                        hist_buf = kmalloc(IN_BUFFER_SIZE * sizeof(__u64),
> +                                           GFP_KERNEL);
> +                    else
> +                        hist_buf =
> +                            rtdm_malloc(IN_BUFFER_SIZE * sizeof(__u64));
> +                }
>  
>                  if (!hist_buf)
>                      return -ENOMEM;
> @@ -643,7 +649,7 @@
>              rtdm_toseq_t        timeout_seq;
>  
>              if (!rtdm_in_rt_context())
> -                return -EPERM;
> +                return -ENOSYS;
>  
>              /* only one waiter allowed, stop any further attempts here */
>              if (test_and_set_bit(0, &ctx->ioc_event_lock))
> @@ -1005,7 +1011,7 @@
>      device_class:       RTDM_CLASS_SERIAL,
>      device_sub_class:   RTDM_SUBCLASS_16550A,
>      driver_name:        "rt_16550A",
> -    driver_version:     RTDM_DRIVER_VER(1, 1, 1),
> +    driver_version:     RTDM_DRIVER_VER(1, 1, 2),
>      peripheral_name:    "UART 16550A",
>      provider_name:      "Jan Kiszka",
>  };
> Index: drivers/16550A/README
> ===================================================================
> --- drivers/16550A/README	(revision 0)
> +++ drivers/16550A/README	(revision 0)
> @@ -0,0 +1,34 @@
> +Real-Time Serial Driver for 16550A-Compatible Devices
> +=====================================================
> +
> +Preparation
> +-----------
> + - decide which serial ports are to be managed by the real-time driver
> +
> + - identify their I/O addresses and IRQ numbers:
> +
> +   setserial /dev/ttyS<N>
> +
> + - disable the Linux driver for all these devices:
> +
> +   setserial /dev/ttyS<N> uart none
> +
> +
> +Invocation
> +----------
> +
> +modprobe xeno_16550A ioaddr=<io1>[,<io2>...] irq=<irq1>[,<irq2>...]
> +                     [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]
> +
> +Arguments:
> +    ioaddr<N>   - I/O address of device <N> (e.g. 0x3f8 for ttyS0)
> +    irq<N>      - interrupt number of device <N> (e.g. 4 for ttyS0)
> +    tx_fifo<N>  - Transmitter FIFO size in bytes of device <N>, default is 16
> +    start_index - First device instance number to be used, default is 0
> +
> +
> +Usage
> +-----
> +
> +The API is described in the API documentation under Modules -> Real-Time
> +Driver Model -> Device Profiles -> Serial Devices.
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

