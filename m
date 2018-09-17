From: Jan Kiszka <jan.kiszka@siemens.com>
References: <71fdaec3-cf6f-f054-95ac-b8a6b06050c9@siemens.com>
Message-ID: <220f2ab8-f6af-7c47-4054-770ec2e4618c@siemens.com>
Date: Mon, 17 Sep 2018 20:18:34 +0200
MIME-Version: 1.0
In-Reply-To: <71fdaec3-cf6f-f054-95ac-b8a6b06050c9@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] cobalt/posix/signal: Fix return code on
 siginfo copy errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 03.09.18 19:08, Jan Kiszka wrote:
> The put_siginfo functions return a non-zero value on error. We have to
> convert that into proper -EFAULT before returning.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   kernel/cobalt/posix/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
> index 1c62bd984d..7e0eb52e99 100644
> --- a/kernel/cobalt/posix/signal.c
> +++ b/kernel/cobalt/posix/signal.c
> @@ -376,7 +376,7 @@ out:
>   		/* no more ref. to sigp beyond this point. */
>   	}
>   
> -	return ret ?: sig;
> +	return ret ? -EFAULT : sig;
>   fail:
>   	xnlock_put_irqrestore(&nklock, s);
>   
> 

No complaints - merged to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

