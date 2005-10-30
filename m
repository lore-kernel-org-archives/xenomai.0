Message-ID: <4364A267.5050209@domain.hid>
Date: Sun, 30 Oct 2005 11:37:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] clearify 16550A readme
References: <4363318A.1000604@domain.hid>
In-Reply-To: <4363318A.1000604@domain.hid>
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
> Hope this improves the understandability.
> 

Applied, thanks.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: drivers/16550A/README
> ===================================================================
> --- drivers/16550A/README	(Revision 86)
> +++ drivers/16550A/README	(Arbeitskopie)
> @@ -21,10 +21,14 @@
>                       [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]
>  
>  Arguments:
> -    ioaddr<N>   - I/O address of device <N> (e.g. 0x3f8 for ttyS0)
> -    irq<N>      - interrupt number of device <N> (e.g. 4 for ttyS0)
> -    tx_fifo<N>  - Transmitter FIFO size in bytes of device <N>, default is 16
> +    ioaddr      - I/O addresses of the devices, comma separated
> +                  (e.g. "0x3f8,0x2f8")
> +    irq         - interrupt numbers of the devices, comma separated
> +                  (e.g. "4,3")
> +    tx_fifo     - Transmitter FIFO sizes of the devices in bytes, comma
> +                  separated, default is 16
>      start_index - First device instance number to be used, default is 0
> +                  (=> "rtser0")
>  
>  
>  Usage
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

