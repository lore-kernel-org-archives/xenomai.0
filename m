Subject: Re: [PATCH] lib/cobalt: Wrap __open_2() to support _FORTIFY_SOURCE on
 open()
References: <20200910134819.6847-1-leupold@rsi-elektrotechnik.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <505c1398-2a36-dda7-c3da-c9fac4e01e1e@siemens.com>
Date: Thu, 10 Sep 2020 16:19:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200910134819.6847-1-leupold@rsi-elektrotechnik.de>
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

On 10.09.20 15:48, Jan Leupold via Xenomai wrote:
> __open_2() from glibc adds a runtime precondition test for the 'oflag'
> parameter to the functionality of open(). It may be used when the macro
> _FORTIFY_SOURCE is defined when compiling the application code. Added this
> wrapper to cover that case.
> 
> Signed-off-by: Jan Leupold <leupold@rsi-elektrotechnik.de>
> ---
>  include/cobalt/fcntl.h     |  2 ++
>  lib/cobalt/cobalt.wrappers |  1 +
>  lib/cobalt/rtdm.c          | 18 ++++++++++++++++++
>  lib/cobalt/wrappers.c      |  6 ++++++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/include/cobalt/fcntl.h b/include/cobalt/fcntl.h
> index d54989389..30e9bf9c8 100644
> --- a/include/cobalt/fcntl.h
> +++ b/include/cobalt/fcntl.h
> @@ -31,6 +31,8 @@ COBALT_DECL(int, open(const char *path, int oflag, ...));
>  
>  COBALT_DECL(int, open64(const char *path, int oflag, ...));
>  
> +COBALT_DECL(int, __open_2(const char *path, int oflag));
> +
>  COBALT_DECL(int, fcntl(int fd, int cmd, ...));
>  
>  #ifdef __cplusplus
> diff --git a/lib/cobalt/cobalt.wrappers b/lib/cobalt/cobalt.wrappers
> index f63a170f8..b1a4170fb 100644
> --- a/lib/cobalt/cobalt.wrappers
> +++ b/lib/cobalt/cobalt.wrappers
> @@ -54,6 +54,7 @@
>  --wrap mq_notify
>  --wrap open
>  --wrap open64
> +--wrap __open_2
>  --wrap socket
>  --wrap close
>  --wrap ioctl
> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 9f3dcd25f..c2b7e11f3 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -23,6 +23,7 @@
>  #include <pthread.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> +#include <stdlib.h>
>  #include <sys/socket.h>
>  #include <sys/mman.h>
>  #include <rtdm/rtdm.h>
> @@ -94,6 +95,23 @@ COBALT_IMPL(int, open64, (const char *path, int oflag, ...))
>  	return do_open(path, oflag | O_LARGEFILE, mode);
>  }
>  
> +COBALT_IMPL(int, __open_2, (const char *path, int oflag))
> +{
> +    /* __open_2() from glibc adds a runtime precondition test for the 'oflag'
> +     * parameter to the functionality of open(). It may be used when the macro
> +     * _FORTIFY_SOURCE is defined when compiling the application code.
> +     */
> +    if (__OPEN_NEEDS_MODE(oflag)) {
> +        const char* msg =
> +            "invalid open call: O_CREAT or O_TMPFILE without mode\n";
> +        ssize_t n = write(STDERR_FILENO, msg, strlen(msg));
> +        (void) n;
> +        abort();
> +    }
> +
> +	return do_open(path, oflag, 0);
> +}
> +
>  COBALT_IMPL(int, socket, (int protocol_family, int socket_type, int protocol))
>  {
>  	int s;
> diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
> index ed8fbaf16..03ba724d2 100644
> --- a/lib/cobalt/wrappers.c
> +++ b/lib/cobalt/wrappers.c
> @@ -205,6 +205,12 @@ int __real_open64(const char *path, int oflag, ...)
>  }
>  #endif
>  
> +__weak
> +int __real___open_2(const char *path, int oflag)
> +{
> +    return __open_2(path, oflag);
> +}
> +
>  __weak
>  int __real_socket(int protocol_family, int socket_type, int protocol)
>  {
> 

Is that enough? My bits/fcntl2.h maps open() on __open_alias for the
other (valid) cases.

Also, we need the same for open64.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

