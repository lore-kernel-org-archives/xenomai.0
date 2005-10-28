Message-ID: <4362A764.6070004@domain.hid>
Date: Sat, 29 Oct 2005 00:34:12 +0200
From: Hannes Mayer <h.mayer@domain.hid>
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

Hi Jan et al.!

Jan Kiszka wrote:
[...]
> +modprobe xeno_16550A ioaddr=<io1>[,<io2>...] irq=<irq1>[,<irq2>...]
> +                     [tx_fifo=<len1>[,<len2>...]] [start_index=<index>]
> +
> +Arguments:
> +    ioaddr<N>   - I/O address of device <N> (e.g. 0x3f8 for ttyS0)
> +    irq<N>      - interrupt number of device <N> (e.g. 4 for ttyS0)
> +    tx_fifo<N>  - Transmitter FIFO size in bytes of device <N>, default is 16
> +    start_index - First device instance number to be used, default is 0

If I may throw in my 2 eurocents:
I think the Arguments-section is a bit misleading.
One doesn't specify ioaddr1, ioaddr2 etc. on the command line, as suggested
by ioaddr<N>, but ioaddr=[1.dev],[2.dev]...
Same for irq and tx_fifo.

What about this:

Arguments:
     ioaddr      - I/O addresses of devices (e.g. 0x3f8 for ttyS0), separated by comma
     irq         - interrupt numbers of devices (e.g. 4 for ttyS0), separated by comma
     tx_fifo     - Transmitter FIFO sizes in bytes of devices, default is 16, separated by comma
     start_index - First device instance number to be used, default is 0 => rtser0

Just trying to make it as clear as possible :-)

Best regards,
Hannes.

