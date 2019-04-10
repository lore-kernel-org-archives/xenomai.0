Subject: Re: [PATCH v2 1/1] cobalt: mode argument from open forwarded for
 O_TMPFILE
References: <20190410142518.12791-1-norbert.lange@andritz.com>
 <20190410142518.12791-2-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <75a518ce-d64a-14ee-1da4-63aa033abffd@siemens.com>
Date: Wed, 10 Apr 2019 16:32:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190410142518.12791-2-norbert.lange@andritz.com>
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
To: Norbert Lange <nolange79@gmail.com>, xenomai@xenomai.org

On 10.04.19 16:25, Norbert Lange via Xenomai wrote:
> The optional mode argument (open is a vararg function),
> was only be read and forwarded if the O_CREAT flag is set.
> 
> That is not complete, as O_TMPFILE will require this
> argument aswell. Fixed in this commit, and a fallback definition
> of O_TMPFILE is added, incase libcobalt is built against an
> library lacking this macro.
> 
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>   lib/cobalt/rtdm.c     | 10 ++++++++--
>   lib/cobalt/wrappers.c |  9 +++++++--
>   2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 6b8898e70..176210ddc 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -30,6 +30,12 @@
>   #include <asm/xenomai/syscall.h>
>   #include "internal.h"
>   
> +/* support for very old c libraries not supporting O_TMPFILE */
> +#ifndef O_TMPFILE
> +#define O_TMPFILE (020000000 | 0200000)
> +#endif
> +
> +
>   static inline int set_errno(int ret)
>   {
>   	if (ret >= 0)
> @@ -65,7 +71,7 @@ COBALT_IMPL(int, open, (const char *path, int oflag, ...))
>   	mode_t mode = 0;
>   	va_list ap;
>   
> -	if (oflag & O_CREAT) {
> +	if ((oflag & O_CREAT)  || (oflag & O_TMPFILE) == O_TMPFILE) {
>   		va_start(ap, oflag);
>   		mode = va_arg(ap, int);
>   		va_end(ap);
> @@ -79,7 +85,7 @@ COBALT_IMPL(int, open64, (const char *path, int oflag, ...))
>   	mode_t mode = 0;
>   	va_list ap;
>   
> -	if (oflag & O_CREAT) {
> +	if ((oflag & O_CREAT)  || (oflag & O_TMPFILE) == O_TMPFILE) {
>   		va_start(ap, oflag);
>   		mode = va_arg(ap, int);
>   		va_end(ap);
> diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
> index 20ad63a61..323f60b92 100644
> --- a/lib/cobalt/wrappers.c
> +++ b/lib/cobalt/wrappers.c
> @@ -44,6 +44,11 @@
>   #include <malloc.h>
>   #include <boilerplate/compiler.h>
>   
> +/* support for very old c libraries not supporting O_TMPFILE */
> +#ifndef O_TMPFILE
> +#define O_TMPFILE (020000000 | 0200000)
> +#endif
> +
>   /* sched */
>   __weak
>   int __real_pthread_setschedparam(pthread_t thread,
> @@ -174,7 +179,7 @@ int __real_open(const char *path, int oflag, ...)
>   	mode_t mode = 0;
>   	va_list ap;
>   
> -	if (oflag & O_CREAT) {
> +	if ((oflag & O_CREAT) || (oflag & O_TMPFILE) == O_TMPFILE) {
>   		va_start(ap, oflag);
>   		mode = va_arg(ap, mode_t);
>   		va_end(ap);
> @@ -190,7 +195,7 @@ int __real_open64(const char *path, int oflag, ...)
>   	mode_t mode = 0;
>   	va_list ap;
>   
> -	if (oflag & O_CREAT) {
> +	if ((oflag & O_CREAT) || (oflag & O_TMPFILE) == O_TMPFILE) {
>   		va_start(ap, oflag);
>   		mode = va_arg(ap, mode_t);
>   		va_end(ap);
> 

OK, taken this one now, instead of v1.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

