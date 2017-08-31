References: <E1dcPNl-0001Jt-0M@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <78857f31-96f4-c139-3058-71537cb3081e@siemens.com>
Date: Thu, 31 Aug 2017 16:47:08 +0200
MIME-Version: 1.0
In-Reply-To: <E1dcPNl-0001Jt-0M@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Jan Kiszka : cobalt: Introduce xnftrace_printf
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2017-08-01 07:06, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 6c41c016bb8613cf5344239b0ea33f9f0e6ab050
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=6c41c016bb8613cf5344239b0ea33f9f0e6ab050
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Mon Jul 31 15:37:57 2017 +0200
> 
> cobalt: Introduce xnftrace_printf
> 
> This allows to inject a user-defined string into the system's ftrace
> without leaving RT mode (because of using a standard write on
> /sys/kernel/debug/tracing/trace_marker).
> 
> As the signature of this function is different from the existing trace
> syscall, create as dedicated one.
> 
> For simplicity reasons, the maximum string length that can be passed
> down to the kernel is limited to 255 characters (+1 for termination).
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> ---
> 
>  include/cobalt/trace.h        |    5 +++++
>  include/cobalt/uapi/syscall.h |    1 +
>  kernel/cobalt/posix/syscall.c |   15 +++++++++++++++
>  lib/cobalt/trace.c            |   29 +++++++++++++++++++++++++++++
>  4 files changed, 50 insertions(+)
> 
> diff --git a/include/cobalt/trace.h b/include/cobalt/trace.h
> index 968eafa..172c0dc 100644
> --- a/include/cobalt/trace.h
> +++ b/include/cobalt/trace.h
> @@ -22,6 +22,8 @@
>  extern "C" {
>  #endif
>  
> +#include <stdarg.h>
> +
>  int xntrace_max_begin(unsigned long v);
>  
>  int xntrace_max_end(unsigned long v);
> @@ -38,6 +40,9 @@ int xntrace_special(unsigned char id, unsigned long v);
>  
>  int xntrace_special_u64(unsigned char id, unsigned long long v);
>  
> +int xnftrace_vprintf(const char *format, va_list args);
> +int xnftrace_printf(const char *format, ...);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
> index 9c2ead1..cd7e820 100644
> --- a/include/cobalt/uapi/syscall.h
> +++ b/include/cobalt/uapi/syscall.h
> @@ -117,6 +117,7 @@
>  #define sc_cobalt_backtrace			94
>  #define sc_cobalt_serialdbg			95
>  #define sc_cobalt_extend			96
> +#define sc_cobalt_ftrace_puts			97
>  
>  #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>  
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
> index 0f905bf..1654cb9 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -180,6 +180,21 @@ static COBALT_SYSCALL(trace, current,
>  	return ret;
>  }
>  
> +static COBALT_SYSCALL(ftrace_puts, current,
> +		      (const char __user *str))
> +{
> +	char buf[256];
> +	unsigned len;
> +
> +	len = cobalt_strncpy_from_user(buf, str, sizeof(buf));
> +	if (len < 0)
> +		return -EFAULT;
> +
> +	trace_puts(buf);
> +
> +	return 0;
> +}
> +
>  static COBALT_SYSCALL(archcall, current,
>  		      (unsigned long a1, unsigned long a2,
>  		       unsigned long a3, unsigned long a4,
> diff --git a/lib/cobalt/trace.c b/lib/cobalt/trace.c
> index 48114aa..42e139f 100644
> --- a/lib/cobalt/trace.c
> +++ b/lib/cobalt/trace.c
> @@ -15,6 +15,9 @@
>   * License along with this library; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
>   */
> +
> +#include <errno.h>
> +#include <stdio.h>
>  #include <cobalt/uapi/kernel/trace.h>
>  #include <cobalt/trace.h>
>  #include <asm/xenomai/syscall.h>
> @@ -61,3 +64,29 @@ int xntrace_special_u64(unsigned char id, unsigned long long v)
>  				(unsigned long)(v >> 32),
>  				(unsigned long)(v & 0xFFFFFFFF));
>  }
> +
> +int xnftrace_vprintf(const char *format, va_list args)
> +{
> +	char buf[256];
> +	int ret;
> +
> +	ret = vsnprintf(buf, sizeof(buf), format, args);
> +	if (ret < 0)
> +		return ret;
> +	if (ret >= sizeof(buf))
> +		return -EOVERFLOW;
> +
> +	return XENOMAI_SYSCALL1(sc_cobalt_ftrace_puts, buf);
> +}
> +
> +int xnftrace_printf(const char *format, ...)
> +{
> +	va_list args;
> +	int ret;
> +
> +	va_start(args, format);
> +	ret = xnftrace_vprintf(format, args);
> +	va_end(args);
> +
> +	return ret;
> +}
> 

Any remarks on this approach? Does it take a reasonable direction?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

