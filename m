References: <1520482772-3311-1-git-send-email-ivid.suvarna@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c83ffe8c-4677-2185-1ae9-c6229be78267@xenomai.org>
Date: Thu, 8 Mar 2018 11:16:06 +0100
MIME-Version: 1.0
In-Reply-To: <1520482772-3311-1-git-send-email-ivid.suvarna@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH] lib/boilerplate: Fix build for mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ivid Suvarna <ivid.suvarna@gmail.com>, xenomai@xenomai.org

On 03/08/2018 05:19 AM, Ivid Suvarna wrote:
> "commit 9da7bde" introduces rt_print_flush_buffers in ancillaries
> 
> Fixes the following error "--with-core=mercury" :
> 
>    >> ancillaries.c: In function ‘___panic’:
>    >> ancillaries.c:129:2: error: implicit declaration of function ‘rt_print_flush_buffers’
>    >>   rt_print_flush_buffers();
>    >>   ^
> 
> Signed-off-by: Ivid Suvarna <ivid.suvarna@gmail.com>
> ---
>  lib/boilerplate/ancillaries.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/boilerplate/ancillaries.c b/lib/boilerplate/ancillaries.c
> index 7e98141..a0754cb 100644
> --- a/lib/boilerplate/ancillaries.c
> +++ b/lib/boilerplate/ancillaries.c
> @@ -126,7 +126,9 @@ void ___panic(const char *fn, const char *name,
>  	if (asprintf(&p, "BUG in %s(): ", fn) < 0)
>  		p = "BUG: ";
>  	__printout(name, p, fmt, ap);
> +#ifdef CONFIG_XENO_COBALT
>  	rt_print_flush_buffers();
> +#endif /* CONFIG_XENO_COBALT */
>  	exit(1);
>  }
>  
> 

Merged, thanks.

-- 
Philippe.

