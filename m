Subject: Re: [PATCH v2 6/7] drivers/net: icmp: remove variable-length array
References: <20210327101912.2291474-1-rpm@xenomai.org>
 <20210327101912.2291474-7-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4d5a7a87-c3d1-2e41-4c8b-e2cff1efd30a@siemens.com>
Date: Wed, 7 Apr 2021 12:24:33 +0200
MIME-Version: 1.0
In-Reply-To: <20210327101912.2291474-7-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 27.03.21 11:19, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  kernel/drivers/net/stack/ipv4/icmp.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
> index 0671cbc93..c3563595e 100644
> --- a/kernel/drivers/net/stack/ipv4/icmp.c
> +++ b/kernel/drivers/net/stack/ipv4/icmp.c
> @@ -313,8 +313,17 @@ static int rt_icmp_send_request(u32 daddr, struct icmp_bxm *icmp_param)
>  int rt_icmp_send_echo(u32 daddr, u16 id, u16 sequence, size_t msg_size)
>  {
>  	struct icmp_bxm icmp_param;
> -	unsigned char pattern_buf[msg_size];
> +	unsigned char *pattern_buf;
>  	off_t pos;
> +	int ret;
> +
> +	/*
> +	 * This is ping, exec time is not that critical, so
> +	 * rtdm_malloc() is ok for the purpose of echoing.

Solution is fine but comment is misleading: This is the submission path,
not the reflection. We are setting up the ping message here, and this is
indeed not time-critical. I'll fix that up on merge.

> +	 */
> +	pattern_buf = rtdm_malloc(msg_size);
> +	if (pattern_buf == NULL)
> +		return -ENOMEM;
>  
>  	/* first purge any potentially pending ICMP fragments */
>  	rt_ip_frag_invalidate_socket(icmp_socket);
> @@ -343,7 +352,10 @@ int rt_icmp_send_echo(u32 daddr, u16 id, u16 sequence, size_t msg_size)
>  	}
>  	icmp_param.data.buf = pattern_buf;
>  
> -	return rt_icmp_send_request(daddr, &icmp_param);
> +	ret = rt_icmp_send_request(daddr, &icmp_param);
> +	rtdm_free(pattern_buf);
> +
> +	return ret;
>  }
>  
>  /***
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

