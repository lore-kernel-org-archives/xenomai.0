Subject: Re: [PATCH v2 7/7] testsuite/smokey/leaks: Adding checks for procfs
 exports
References: <20210825103230.27274-1-florian.bezdeka@siemens.com>
 <20210825103230.27274-8-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a9920045-bdac-2be6-7f23-8ce003ae0d2e@siemens.com>
Date: Wed, 25 Aug 2021 17:09:03 +0200
MIME-Version: 1.0
In-Reply-To: <20210825103230.27274-8-florian.bezdeka@siemens.com>
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

On 25.08.21 12:32, Florian Bezdeka wrote:
> Make sure that named semaphores as well as mqueues are exported to the
> procfs.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/leaks/leaks.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/testsuite/smokey/leaks/leaks.c b/testsuite/smokey/leaks/leaks.c
> index bbe5fc3ad..b867bc727 100644
> --- a/testsuite/smokey/leaks/leaks.c
> +++ b/testsuite/smokey/leaks/leaks.c
> @@ -28,6 +28,7 @@
>  #include <pthread.h>
>  #include <fcntl.h>
>  #include <sys/mman.h>
> +#include <sys/stat.h>
>  #include <semaphore.h>
>  #include <mqueue.h>
>  #include <signal.h>
> @@ -71,6 +72,24 @@ const char *memdev[] = {
>  
>  static int memdevfd[3];
>  
> +static int procfs_exists(const char *type, const char *name)
> +{
> +	struct stat s;
> +	char path[128];
> +	int ret;
> +
> +	/* Ignore if the kernel seems to be compiled without procfs support */
> +	if (stat("/proc/xenomai", &s) || !S_ISDIR(s.st_mode))
> +		return 0;
> +
> +	ret = snprintf(path, 128, "%s/%s/%s", "/proc/xenomai/registry/posix",
> +		       type, &name[1]);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	return smokey_check_errno(stat(path, &s));
> +}
> +
>  static unsigned long long get_used(void)
>  {
>  	struct cobalt_memdev_stat statbuf;
> @@ -121,6 +140,10 @@ static inline int subprocess_leak(void)
>  	if (ret)
>  		return ret;
>  
> +	ret = procfs_exists("sem", SEM_NAME);
> +	if (ret)
> +		return ret;
> +

This comes too fast for the registry, see failing tests in CI, e.g.
https://source.denx.de/Xenomai/xenomai-images/-/jobs/313503. The
registration with /proc seems to happen asynchronously. If I add a
usleep(100000) to procfs_exists(), the tests seem to pass.

Jan

>  	sevt.sigev_notify = SIGEV_THREAD_ID;
>  	sevt.sigev_signo = SIGALRM;
>  	sevt.sigev_notify_thread_id = syscall(__NR_gettid);
> @@ -132,6 +155,10 @@ static inline int subprocess_leak(void)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = procfs_exists("mqueue", MQ_NAME);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

