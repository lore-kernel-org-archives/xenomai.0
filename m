Subject: Re: [PATCH] cobalt: remove call to sigprocmask
References: <20190712111849.25670-1-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <debb723e-9470-8911-02ec-fce4aefa1546@siemens.com>
Date: Fri, 12 Jul 2019 15:07:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190712111849.25670-1-norbert.lange@andritz.com>
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
To: Norbert Lange <nolange79@gmail.com>, xenomai@xenomai.org

On 12.07.19 13:18, Norbert Lange via Xenomai wrote:
> sigprocmask should not be used in multithreaded applications,
> doing so is "unspecified".

Is this more than cosmetic on Linux? Then it should be documented here because
we shipped the change in 3.0.9, and if that may have caused regressions, users
should know.

> 
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>  lib/cobalt/printf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
> index 7426f2bda..80db9516a 100644
> --- a/lib/cobalt/printf.c
> +++ b/lib/cobalt/printf.c
> @@ -647,7 +647,7 @@ static void spawn_printer_thread(void)
>  	sigfillset(&sset);
>  	pthread_sigmask(SIG_BLOCK, &sset, &oset);
>  	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
> -	sigprocmask(SIG_SETMASK, &oset, NULL);
> +	pthread_sigmask(SIG_SETMASK, &oset, NULL);
>  	pthread_setname_np(printer_thread, "cobalt_printf");
>  }
>  
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

