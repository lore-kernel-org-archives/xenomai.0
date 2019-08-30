Subject: Re: [PATCH 2/2] cobalt/pipe: unblock read()/write() on disconnect
References: <20190830160418.29507-1-rpm@xenomai.org>
 <20190830160418.29507-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77eaca38-d0bb-556d-3993-9697133616fd@siemens.com>
Date: Fri, 30 Aug 2019 19:01:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190830160418.29507-2-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 30.08.19 18:04, Philippe Gerum wrote:
> Threads waiting on read()/write() must be unblocked when the kernel
> endpoint is disconnected. read() should return 0, write() receives
> -EPIPE.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/cobalt/pipe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
> index 16e85125c..0c83095ba 100644
> --- a/kernel/cobalt/pipe.c
> +++ b/kernel/cobalt/pipe.c
> @@ -132,7 +132,7 @@ static inline void xnpipe_dequeue_all(struct xnpipe_state *state, int mask)
>   		if (__sigpending)					\
>   			break;						\
>   		prepare_to_wait_exclusive(__waitq, &__wait, TASK_INTERRUPTIBLE); \
> -		if (__cond)						\
> +		if (__cond || (__state)->status & XNPIPE_KERN_LCLOSE)	\
>   			break;						\
>   		schedule();						\
>   	}								\
> 

Thanks, applied to next, queued for stable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

