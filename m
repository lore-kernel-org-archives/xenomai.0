Subject: Re: [PATCH] lib/cobalt: only compile __real___open[64]_2 wrappers if
 fortified
References: <20200911083227.5477-1-leupold@rsi-elektrotechnik.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ada9ad0f-8106-ef4d-8cec-fcc38873a430@siemens.com>
Date: Fri, 11 Sep 2020 10:55:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200911083227.5477-1-leupold@rsi-elektrotechnik.de>
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
To: Jan Leupold <leupold@rsi-elektrotechnik.de>, xenomai@xenomai.org

On 11.09.20 10:32, Jan Leupold via Xenomai wrote:
> If Xenomai itself is not compiled with FORTIFY_SOURCE then the function
> declarations for __open_2() and __open64_2() are not available.
> __STD(__open_2(...)) will not link in this case (would be a very special
> use case anyway?).
> 

That seems like a reasonable approach.

BUT: This must be part of v3 of your patch (version your patches,
please). And there are two more things in that patch which I missed
yesterday. Will comment in the original thread.

Jan

> Signed-off-by: Jan Leupold <leupold@rsi-elektrotechnik.de>
> ---
>  lib/cobalt/wrappers.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
> index 5d86607de..5ff6b63bc 100644
> --- a/lib/cobalt/wrappers.c
> +++ b/lib/cobalt/wrappers.c
> @@ -205,6 +205,7 @@ int __real_open64(const char *path, int oflag, ...)
>  }
>  #endif
>  
> +#if __USE_FORTIFY_LEVEL > 0
>  __weak
>  int __real___open_2(const char *path, int oflag)
>  {
> @@ -216,6 +217,7 @@ int __real___open64_2(const char *path, int oflag)
>  {
>      return __open64_2(path, oflag);
>  }
> +#endif // __USE_FORTIFY_LEVEL > 0
>  
>  __weak
>  int __real_socket(int protocol_family, int socket_type, int protocol)
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

