Date: Fri, 29 Apr 2016 21:40:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160429194018.GO1881@hermes.click-hack.org>
References: <1461854390-27536-1-git-send-email-tbultel@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461854390-27536-1-git-send-email-tbultel@free.fr>
Subject: Re: [Xenomai] [PATCH 1/1] posix skin: fix address passed to
 pse51_mutex_check_init in syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <tbultel@free.fr>
Cc: xenomai@xenomai.org

On Thu, Apr 28, 2016 at 04:39:50PM +0200, Thierry Bultel wrote:
> The address passed to pse51_mutex_check_init was the one of userland,
> not the kernel one.
> 
> Signed-off-by: Thierry Bultel <tbultel@free.fr>
> ---
>  ksrc/skins/posix/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
> index 87b95fa..31e2705 100644
> --- a/ksrc/skins/posix/syscall.c
> +++ b/ksrc/skins/posix/syscall.c
> @@ -1202,7 +1202,7 @@ static int __pthread_mutex_check_init(struct pt_regs *regs)
>  	} else
>  		attr = NULL;
>  
> -	return pse51_mutex_check_init(&umx->shadow_mutex, attr);
> +	return pse51_mutex_check_init(&mx.shadow_mutex, attr);
>  }

Ah, what a coincidence, Jan reported this issue a long time ago:
https://xenomai.org/pipermail/xenomai/2015-December/035656.html
and I have merged a patch for it just a few days ago in my local
branch (soon to be Xenomai 2.6.5).

-- 
					    Gilles.
https://click-hack.org

