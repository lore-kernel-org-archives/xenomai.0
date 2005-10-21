Message-ID: <435928CC.1050205@domain.hid>
Date: Fri, 21 Oct 2005 19:43:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [patch] problems with nucleus/types.h
References: <4358A63B.6030907@domain.hid>
In-Reply-To: <4358A63B.6030907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> after the latest changes in include/nucleus/types.h, I get some warnings
> during userspace lib compilation on my box:
> 
> In file included from /usr/src/xenomai/include/nucleus/queue.h:24,
>                  from /usr/src/xenomai/include/nucleus/timer.h:24,
>                  from /usr/src/xenomai/include/nucleus/thread.h:24,
>                  from
> /usr/src/xenomai/skins/native/lib/../../native/task.h:27,
>                  from /usr/src/xenomai/skins/native/lib/timer.c:21:
> /usr/src/xenomai/include/nucleus/types.h: In function
> 'xnobject_create_name':
> /usr/src/xenomai/include/nucleus/types.h:99: warning: implicit
> declaration of function 'snprintf'
> /usr/src/xenomai/include/nucleus/types.h:99: warning: incompatible
> implicit declaration of built-in function 'snprintf'
> 
> This is due to the static inline definition of xnobject_create_name in
> the mentioned header and missing a snprintf prototype in userspace.
> 
> What about the attached patch? It also avoids duplicating code by using
> strncpy (or am I overseeing a specific reason for doing it the other way?).
> 

Applied, since types.h must be usable with as little deps as possible in order 
to grab types and definitions. Thanks.

> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: include/nucleus/types.h
> ===================================================================
> --- include/nucleus/types.h	(revision 54)
> +++ include/nucleus/types.h	(working copy)
> @@ -76,26 +76,16 @@
>  
>  #define XNOBJECT_NAME_LEN 32
>  
> -static inline void xnobject_copy_name (char *dst,
> -				       const char *src)
> -{
> -    if (src)
> -	{
> -	const char *rp = src;
> -	char *wp = dst;
> -	do
> -	    *wp++ = *rp;
> -	while (*rp && rp++ - src < XNOBJECT_NAME_LEN);
> -	}
> -    else
> -	*dst = '\0';
> -}
> +#define xnobject_copy_name(dst, src) \
> +do { \
> +    if (src) \
> +        strncpy(dst, src, XNOBJECT_NAME_LEN); \
> +    else \
> +        *dst = '\0'; \
> +} while (0)
>  
> -static inline int xnobject_create_name(
> -		    char *dst, size_t n, void *obj)
> -{
> -    return snprintf(dst, n, "%p", obj);
> -}
> +#define xnobject_create_name(dst, n, obj) \
> +    snprintf(dst, n, "%p", obj)
>  
>  #define minval(a,b) ((a) < (b) ? (a) : (b))
>  #define maxval(a,b) ((a) > (b) ? (a) : (b))
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

