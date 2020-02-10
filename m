Subject: Re: [PATCH 1/1] Restore proper operation of ioctl(SET_CONFIG)
References: <1581360882-8724-1-git-send-email-steve@freyder.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <75ff8160-5a37-3708-37e4-2a634dae3fb3@siemens.com>
Date: Mon, 10 Feb 2020 19:56:53 +0100
MIME-Version: 1.0
In-Reply-To: <1581360882-8724-1-git-send-email-steve@freyder.net>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Stephen Freyder <steve@freyder.net>, xenomai@xenomai.org

On 10.02.20 19:54, Stephen Freyder via Xenomai wrote:
> Disable software reset by setting SRST_B=1 when writing to UCR2 in
> rt_imx_uart_set_config.
> 
> Signed-off-by: Stephen Freyder <steve@freyder.net>
> ---
>   kernel/drivers/serial/rt_imx_uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
> index 2b27b7d..6894c1c 100644
> --- a/kernel/drivers/serial/rt_imx_uart.c
> +++ b/kernel/drivers/serial/rt_imx_uart.c
> @@ -703,9 +703,9 @@ static int rt_imx_uart_set_config(struct rt_imx_uart_ctx *ctx,
>   		uint64_t tdiv64;
>   
>   		if (ctx->config.data_bits == RTSER_8_BITS)
> -			ucr2 = UCR2_WS | UCR2_IRTS;
> +			ucr2 = UCR2_WS | UCR2_SRST | UCR2_IRTS;
>   		else
> -			ucr2 = UCR2_IRTS;
> +			ucr2 = UCR2_SRST | UCR2_IRTS;
>   
>   		if (ctx->config.handshake == RTSER_RTSCTS_HAND) {
>   			if (port->have_rtscts) {
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

