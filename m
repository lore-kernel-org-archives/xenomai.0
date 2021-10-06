Subject: Re: [PATCH v5 1/3] y2038: cobalt/posix/io: Adding recvmmsg64
References: <20211006135415.223689-1-florian.bezdeka@siemens.com>
 <20211006135415.223689-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <21a30bf8-284c-c2ba-c331-8d4405f1c0dc@siemens.com>
Date: Wed, 6 Oct 2021 17:27:07 +0200
MIME-Version: 1.0
In-Reply-To: <20211006135415.223689-2-florian.bezdeka@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 06.10.21 15:54, Florian Bezdeka wrote:
> From: Song Chen <chensong_2000@189.cn>
> 
> Add a syscall specific for recvmmsg64 with 64bit time_t.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> [Florian: Fixed some style issues]
> [Florian: Added Song's Signed-off back (malformed patch received)]
> [Florian: Fixed tracing infrastructure]
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/rtdm/fd.h    |  5 +++++
>  include/cobalt/uapi/syscall.h      |  1 +
>  kernel/cobalt/posix/io.c           |  9 +++++++++
>  kernel/cobalt/posix/io.h           |  5 +++++
>  kernel/cobalt/posix/syscall32.c    |  9 +++++++++
>  kernel/cobalt/posix/syscall32.h    |  6 ++++++
>  kernel/cobalt/rtdm/fd.c            | 21 ++++++++++++++++++++-
>  kernel/cobalt/trace/cobalt-posix.h |  3 ++-
>  8 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
> index 37a09c43e..058a9c638 100644
> --- a/include/cobalt/kernel/rtdm/fd.h
> +++ b/include/cobalt/kernel/rtdm/fd.h
> @@ -382,6 +382,11 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
>  		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg),
>  		       int (*get_timespec)(struct timespec64 *ts, const void __user *u_ts));
>  
> +int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgvec, unsigned int vlen,
> +			 unsigned int flags, void __user *u_timeout,
> +			 int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
> +			 int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg));
> +
>  ssize_t rtdm_fd_sendmsg(int ufd, const struct user_msghdr *msg,
>  			int flags);
>  
> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
> index 16edce15d..1523ddd2d 100644
> --- a/include/cobalt/uapi/syscall.h
> +++ b/include/cobalt/uapi/syscall.h
> @@ -134,6 +134,7 @@
>  #define sc_cobalt_sigtimedwait64		111
>  #define sc_cobalt_monitor_wait64		112
>  #define sc_cobalt_event_wait64			113
> +#define sc_cobalt_recvmmsg64			114
>  
>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>  
> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> index 0c17f55bf..0f9c963ad 100644
> --- a/kernel/cobalt/posix/io.c
> +++ b/kernel/cobalt/posix/io.c
> @@ -26,6 +26,7 @@
>  #include "internal.h"
>  #include "clock.h"
>  #include "io.h"
> +#include <cobalt/kernel/time.h>

Would be nicer to move this up to the other "<cobat/...>" includes.

I will likely fix this up myself.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

