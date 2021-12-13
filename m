Subject: Re: [PATCH v4 7/8] drivers/can: fix updating of tx_count statistics
References: <20211212115611.3036-1-dariobin@libero.it>
 <20211212115611.3036-6-dariobin@libero.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <67fcc697-1a8f-646b-6877-836dce689ece@siemens.com>
Date: Mon, 13 Dec 2021 13:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <20211212115611.3036-6-dariobin@libero.it>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dario Binacchi <dariobin@libero.it>, xenomai@xenomai.org
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Wolfgang Grandegger <wg@grandegger.com>, Philippe Gerum <rpm@xenomai.org>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Gianluca Falavigna <gianluca.falavigna@inwind.it>

On 12.12.21 12:56, Dario Binacchi wrote:
> As in the Linux kernel, the counter is updated only after the message
> has been really transmitted.
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> ---
> 
> (no changes since v1)
> 
>  kernel/drivers/can/mscan/rtcan_mscan.c     | 1 +
>  kernel/drivers/can/rtcan_flexcan.c         | 1 +
>  kernel/drivers/can/rtcan_raw.c             | 1 -
>  kernel/drivers/can/rtcan_virt.c            | 1 +
>  kernel/drivers/can/sja1000/rtcan_sja1000.c | 1 +
>  5 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/drivers/can/mscan/rtcan_mscan.c b/kernel/drivers/can/mscan/rtcan_mscan.c
> index 387e27cc0..da573aba6 100644
> --- a/kernel/drivers/can/mscan/rtcan_mscan.c
> +++ b/kernel/drivers/can/mscan/rtcan_mscan.c
> @@ -217,6 +217,7 @@ static int rtcan_mscan_interrupt(rtdm_irq_t *irq_handle)
>  		out_8(&regs->cantier, 0);
>  		/* Wake up a sender */
>  		rtdm_sem_up(&dev->tx_sem);
> +		dev->tx_count++;
>  
>  		if (rtcan_loopback_pending(dev)) {
>  
> diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
> index 7569d16f7..3348e8ce0 100644
> --- a/kernel/drivers/can/rtcan_flexcan.c
> +++ b/kernel/drivers/can/rtcan_flexcan.c
> @@ -897,6 +897,7 @@ static int flexcan_irq(rtdm_irq_t *irq_handle)
>  			      &priv->tx_mb->can_ctrl);
>  		flexcan_write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
>  		rtdm_sem_up(&dev->tx_sem);
> +		dev->tx_count++;
>  		if (rtcan_loopback_pending(dev))
>  			rtcan_loopback(dev);
>  		handled = RTDM_IRQ_HANDLED;
> diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
> index b17c1709d..dffc6e837 100644
> --- a/kernel/drivers/can/rtcan_raw.c
> +++ b/kernel/drivers/can/rtcan_raw.c
> @@ -844,7 +844,6 @@ static ssize_t __rtcan_raw_sendmsg(struct rtcan_device *dev, struct rtcan_socket
>  	goto send_out2;
>      }
>  
> -    dev->tx_count++;
>      ret = dev->hard_start_xmit(dev, frame);
>  
>      /* Return number of bytes sent upon successful completion */
> diff --git a/kernel/drivers/can/rtcan_virt.c b/kernel/drivers/can/rtcan_virt.c
> index c86c17fc3..28e06a9d6 100644
> --- a/kernel/drivers/can/rtcan_virt.c
> +++ b/kernel/drivers/can/rtcan_virt.c
> @@ -56,6 +56,7 @@ static int rtcan_virt_start_xmit(struct rtcan_device *tx_dev,
>  
>  	/* we can transmit immediately again */
>  	rtdm_sem_up(&tx_dev->tx_sem);
> +	tx_dev->tx_count++;
>  
>  	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE;
>  
> diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000.c b/kernel/drivers/can/sja1000/rtcan_sja1000.c
> index bd6c0ba5c..0f49551f9 100644
> --- a/kernel/drivers/can/sja1000/rtcan_sja1000.c
> +++ b/kernel/drivers/can/sja1000/rtcan_sja1000.c
> @@ -326,6 +326,7 @@ static int rtcan_sja_interrupt(rtdm_irq_t *irq_handle)
>  	if (irq_source & SJA_IR_TI) {
>  	    /* Wake up a sender */
>  	    rtdm_sem_up(&dev->tx_sem);
> +	    dev->tx_count++;
>  
>  	    if (rtcan_loopback_pending(dev)) {
>  
> 

I'll keep this fix in next and will later on propagate it to stable. So
you can drop it from v5.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

