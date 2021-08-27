Subject: Re: [PATCH] y2038: testsuite/smokey/y2038: Run tests on y2038 safe
 kernels only
References: <20210827100243.22612-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77ebef55-ad96-c5ba-0abc-9f497dd2bd64@siemens.com>
Date: Fri, 27 Aug 2021 14:57:53 +0200
MIME-Version: 1.0
In-Reply-To: <20210827100243.22612-1-florian.bezdeka@siemens.com>
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

On 27.08.21 12:02, Florian Bezdeka wrote:
> Especially 4.19 is not 2038 safe and 32 bit kernels do not have
> CONFIG_64BIT_TIME set, which ends up in __kernel_timespec being defined
> in a non y2038 safe way.
> 
> cobalt_get_timespec64 will copy the upper bytes of the sec field into
> the nsec field, which is always zero.
> 
> Testing y2038 syscalls on a non y2038 safe kernel doesn't make sense,
> hence limiting the test runs to kernels with 2038 support.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index 8afedd7d1..c23a54f5d 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -11,6 +11,7 @@
>   */
>  #include <asm/xenomai/syscall.h>
>  #include <smokey/smokey.h>
> +#include <sys/utsname.h>
>  #include <mqueue.h>
>  
>  smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
> @@ -989,10 +990,36 @@ static int test_sc_cobalt_event_wait64(void)
>  	return 0;
>  }
>  
> +static int check_kernel_version(void)
> +{
> +	int ret, major, minor;
> +	struct utsname uts;
> +
> +	ret = smokey_check_errno(uname(&uts));
> +	if (ret)
> +		return ret;
> +
> +	ret = sscanf(uts.release, "%d.%d", &major, &minor);
> +	if (!smokey_assert(ret == 2))
> +		return -EINVAL;
> +
> +	/* We need a kernel with y2038 support, 5.4 onwards */
> +	if (!(major > 5 || (major == 5 && minor >= 4))) {
> +		smokey_note("y2038: skipped. (no y2038 safe kernel)");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
>  {
>  	int ret;
>  
> +	ret = check_kernel_version();
> +	if (ret)
> +		return (ret < 0) ? ret : 0; /* skip if no y2038 safe kernel */
> +
>  	ret = test_sc_cobalt_sem_timedwait64();
>  	if (ret)
>  		return ret;
> 

OK, will apply. But I'm also expected a patch that makes the test case
fail in cases of early shots. We only noticed this issue because you
read the logs of successful runs.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

