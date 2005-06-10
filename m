Message-ID: <42A948EB.6000206@domain.hid>
Date: Fri, 10 Jun 2005 10:01:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] patch for 2.6.x adeos
References: <Pine.LNX.4.53.0506101042001.16390@domain.hid>
In-Reply-To: <Pine.LNX.4.53.0506101042001.16390@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: adeos-main@gna.org

Rus V. Brushkoff wrote:
> 	Hi.
> 
>  This needed to compile adeos with recent binutils.

Applied, thanks.

> 
> 
> 		Rus
> 
> 
> ------------------------------------------------------------------------
> 
> --- x86.c	2005-06-10 09:16:37.000000000 +0300
> +++ /usr/src/linux-2.6.11-adeos.curr/adeos/x86.c	2005-05-11 13:05:49.000000000 +0300
> @@ -120,7 +122,7 @@
>  	"addl $4,%esp\n\t" \
>  	"iret\n" \
>  "2:      movl ("SYMBOL_NAME_STR(__adeos_std_vector_table + 4 * trapnr)"),%eax\n\t" \
> -	"movl 8(%esp),%es\n\t" \
> +	"mov 8(%esp),%es\n\t" \
>  	"movl %eax,8(%esp)\n\t" \
>  	"popl %eax\n\t" \
>  	"popl %ds\n\t" \
> @@ -167,7 +169,7 @@
>  	"addl $4,%esp\n\t" \
>  	"iret\n" \
>  "2:      movl ("SYMBOL_NAME_STR(__adeos_std_vector_table + 4 * trapnr)"),%eax\n\t" \
> -	"movl %eax,12(%esp)\n\t" \
> +	"mov %eax,12(%esp)\n\t" \
>  	"popl %eax\n\t" \
>  	"popl %ds\n\t" \
>  	"popl %es\n\t" \


-- 

Philippe.

