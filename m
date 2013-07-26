Message-ID: <51F2B7CD.7080507@siemens.com>
Date: Fri, 26 Jul 2013 19:54:21 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51B8120C.9080906@siemens.com>
In-Reply-To: <51B8120C.9080906@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] posix: Skip auto-shadowing if current thread
 is already shadowed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-06-12 08:15, Jan Kiszka wrote:
> While the user can also avoid double shadowing by providing the
> XENO_NOSHADOW environment variable, there is still no reason to attempt
> auto-shadowing in their absence if the current thread is already a
> Xenomai thread. This helps, e.g., in complex dlopen scenarios where
> the POSIX lib is pulled in belatedly, potentially after some other lib
> already shadowed the dlopen caller.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  src/skins/posix/init.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/src/skins/posix/init.c b/src/skins/posix/init.c
> index 80725c5..ca1d9e1 100644
> --- a/src/skins/posix/init.c
> +++ b/src/skins/posix/init.c
> @@ -31,6 +31,7 @@
>  #include <rtdk.h>
>  
>  #include <asm-generic/xenomai/bind.h>
> +#include <asm-generic/xenomai/current.h>
>  
>  int __pse51_muxid = -1;
>  int __pse51_rtdm_muxid = -1;
> @@ -67,7 +68,7 @@ static __constructor__ void __init_posix_interface(void)
>  	}
>  
>  	noshadow = getenv("XENO_NOSHADOW");
> -	if (!noshadow || !*noshadow) {
> +	if ((!noshadow || !*noshadow) && xeno_get_current() == XN_NO_HANDLE) {
>  		err = __real_pthread_getschedparam(pthread_self(), &policy,
>  						   &parm);
>  		if (err) {
> 

Ping for this patch. Any concerns remaining?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

