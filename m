Subject: Re: [PATCH] drivers/serial: imx: fix transmit interrupt handling
References: <20190326131619.24709-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <4700e83d-4202-84c8-f073-c47f6beb7003@web.de>
Date: Mon, 1 Apr 2019 20:14:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190326131619.24709-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 26.03.19 14:16, Philippe Gerum via Xenomai wrote:
> We may receive TRDY when the TX-FIFO is not entirely empty, which
> breaks the logic in rt_imx_uart_tx_chars(), as we may break early from
> the transmit loop when the TXFULL condition is detected, skipping
> decrement of ctx->out_npend although a byte was sent.
>
> Because of this, we may end up with ghost bytes in the output buffer
> which were actually sent to the UART, but still erroneously counted in
> ctx->out_npend. As a result, incorrect output can be observed later on
> as bytes from the software FIFO are unduly sent, or such FIFO may
> overflow indefinitely due to accumulated errors.
>
> Fix this by testing TXFULL before sending the next byte to the UART.
> At this chance, drop the count limit on the FIFO depth: testing TXFULL
> is sufficient and robust.
>
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/drivers/serial/rt_imx_uart.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial=
/rt_imx_uart.c
> index 6118e29b7..f91d8fb8b 100644
> --- a/kernel/drivers/serial/rt_imx_uart.c
> +++ b/kernel/drivers/serial/rt_imx_uart.c
> @@ -422,18 +422,15 @@ static int rt_imx_uart_rx_chars(struct rt_imx_uart=
_ctx *ctx,
>
>   static void rt_imx_uart_tx_chars(struct rt_imx_uart_ctx *ctx)
>   {
> -	int ch, count;
> +	int ch;
>   	unsigned int uts_reg =3D ctx->port->devdata->uts_reg;
>
> -	for (count =3D ctx->port->tx_fifo;
> -	     (count > 0) && (ctx->out_npend > 0);
> -	     count--, ctx->out_npend--) {
> +	while (ctx->out_npend > 0 &&
> +	       !(readl(ctx->port->membase + uts_reg) & UTS_TXFULL)) {
>   		ch =3D ctx->out_buf[ctx->out_head++];
>   		writel(ch, ctx->port->membase + URTX0);
>   		ctx->out_head &=3D (OUT_BUFFER_SIZE - 1);
> -
> -		if (readl(ctx->port->membase + uts_reg) & UTS_TXFULL)
> -			break;
> +		ctx->out_npend--;
>   	}
>   }
>
>

Thanks, applied.

Jan

