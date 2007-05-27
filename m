From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4656E8E9.5060403@domain.hid>
References: <4656E8E9.5060403@domain.hid>
Content-Type: text/plain
Date: Sun, 27 May 2007 10:55:08 +0200
Message-Id: <1180256109.5015.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 1/2] Fix logic in __ipipe_get_task_info
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Fri, 2007-05-25 at 15:47 +0200, Jan Kiszka wrote:
> That was obviously wrong, causing double acquisitions.
> 

Merged, thanks.

> Jan
> plain text document attachment (fix-__ipipe_get_task_info.patch)
> ---
>  kernel/ipipe/tracer.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.20/kernel/ipipe/tracer.c
> ===================================================================
> --- linux-2.6.20.orig/kernel/ipipe/tracer.c
> +++ linux-2.6.20/kernel/ipipe/tracer.c
> @@ -572,9 +572,10 @@ __ipipe_get_task_info(char *task_info, s
>  	int i;
>  	int locked = 1;
>  
> -	if (trylock && !read_trylock(&tasklist_lock))
> -		locked = 0;
> -	else
> +	if (trylock) {
> +		if (!read_trylock(&tasklist_lock))
> +			locked = 0;
> +	} else
>  		read_lock(&tasklist_lock);
>  
>  	if (locked)
-- 
Philippe.



