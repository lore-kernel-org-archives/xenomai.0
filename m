Message-ID: <434FC80F.6070907@domain.hid>
Date: Fri, 14 Oct 2005 17:00:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Fixes for serial driver
References: <434FC080.3000900@domain.hid>
In-Reply-To: <434FC080.3000900@domain.hid>
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
> attached are two minor fixes for the serial driver and header: one is
> cosmetic, the other addresses out-of-memory detection.
> 
> Credits go, as usual, to Sebastian. ;)
> 

Applied, thanks.

> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: skins/rtdm/rtserial.h
> ===================================================================
> --- skins/rtdm/rtserial.h	(revision 29)
> +++ skins/rtdm/rtserial.h	(working copy)
> @@ -113,7 +113,7 @@
>  
>  /*!
>   * @anchor RTSER_xxx_PARITY   @name RTSER_xxx_PARITY
> - * Number of parity bits @anchor RTSER_xxx_PARITY
> + * Number of parity bits
>   * @{ */
>  #define RTSER_NO_PARITY             0x00
>  #define RTSER_ODD_PARITY            0x01
> Index: drivers/16550A/16550A.c
> ===================================================================
> --- drivers/16550A/16550A.c	(revision 29)
> +++ drivers/16550A/16550A.c	(working copy)
> @@ -568,6 +568,9 @@
>                  } else
>                      hist_buf =
>                          rtdm_malloc(IN_BUFFER_SIZE * sizeof(__u64));
> +
> +                if (!hist_buf)
> +                    return -ENOMEM;
>              }
>  
>              rt_16550_set_config(ctx, config, &hist_buf);
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

