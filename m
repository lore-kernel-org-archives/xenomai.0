Subject: Re: [PATCH] drivers/serial: 16550A: fix tx timeout bug in
 rt_16550_write
References: <Ck9Qvyw1mkelhwhpAZSIDipLnkcOa-Z1S9cL_oVq6p20rVpOSTJr97KCzuEoDqNucszDkzc32NYktwFWWQ9TJbVVH2wNoy6s4nd3NdzGBPc=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <89a70e21-d19c-d641-97d3-7154feb1914f@siemens.com>
Date: Fri, 26 Apr 2019 18:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <Ck9Qvyw1mkelhwhpAZSIDipLnkcOa-Z1S9cL_oVq6p20rVpOSTJr97KCzuEoDqNucszDkzc32NYktwFWWQ9TJbVVH2wNoy6s4nd3NdzGBPc=@codecraftsmen.org>
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
To: Jeff Webb <w1@codecraftsmen.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 26.04.19 02:44, Jeff Webb wrote:
> From: Jeff Webb <jeff.webb@codecraftsmen.org>
> 
> This was likely a copy-and-paste error that resulted in
> rx_timeout being used instead of tx_timeout in two places.
> 
> Signed-off-by: Jeff Webb <jeff.webb@codecraftsmen.org>
> ---
>   kernel/drivers/serial/16550A.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
> index 24415cf..923211b 100644
> --- a/kernel/drivers/serial/16550A.c
> +++ b/kernel/drivers/serial/16550A.c
> @@ -963,10 +963,10 @@ ssize_t rt_16550_write(struct rtdm_fd *fd, const void *buf, size_t nbyte)
> 
>   	ctx = rtdm_fd_to_private(fd);
> 
> -	rtdm_toseq_init(&timeout_seq, ctx->config.rx_timeout);
> +	rtdm_toseq_init(&timeout_seq, ctx->config.tx_timeout);
> 
>   	/* Make write operation atomic. */
> -	ret = rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.rx_timeout,
> +	ret = rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.tx_timeout,
>   				   &timeout_seq);
>   	if (ret)
>   		return ret;
> --
> 2.17.1
> 
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

