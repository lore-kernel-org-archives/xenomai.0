Subject: Re: [PATCH 6/6] testsuite/smokey/leaks: Add export checks for mqueues
 and named semaphores
References: <20210823150031.78791-1-florian.bezdeka@siemens.com>
 <20210823150031.78791-7-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d8bfbb92-b5c3-eb45-c65e-1fbda7a84855@siemens.com>
Date: Tue, 24 Aug 2021 07:48:34 +0200
MIME-Version: 1.0
In-Reply-To: <20210823150031.78791-7-florian.bezdeka@siemens.com>
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

On 23.08.21 17:00, Florian Bezdeka wrote:
> Make sure mqueues and named semaphores are exported to the procfs if
> the kernel has procfs support activated.
> 
> While at it: The exit code of the child process was never correctly
> reported to the parent process. Hence, the status code check was wrong
> at all. The variable previously named subprocess_status was not shared
> between both processes.

The second part should better be separate.

Jan

> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/leaks/leaks.c | 68 ++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 23 deletions(-)
> 
> diff --git a/testsuite/smokey/leaks/leaks.c b/testsuite/smokey/leaks/leaks.c
> index d5577d85e..433dfcc17 100644
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
> @@ -91,9 +110,7 @@ static void *empty(void *cookie)
>  	return cookie;
>  }
>  
> -static int subprocess_status;
> -
> -static inline void subprocess_leak(void)
> +static inline int subprocess_leak(void)
>  {
>  	struct sigevent sevt;
>  	pthread_mutex_t mutex;
> @@ -105,36 +122,44 @@ static inline void subprocess_leak(void)
>  
>  	ret = smokey_check_status(pthread_create(&thread, NULL, empty, NULL));
>  	if (ret)
> -		goto fail;
> +		return ret;
>  	
>  	ret = smokey_check_status(pthread_mutex_init(&mutex, NULL));
>  	if (ret)
> -		goto fail;
> +		return ret;
>  	
>  	ret = smokey_check_status(pthread_cond_init(&cond, NULL));
>  	if (ret)
> -		goto fail;
> +		return ret;
>  
>  	ret = smokey_check_errno(sem_init(&sem, 0, 0));
>  	if (ret)
> -		goto fail;
> +		return ret;
>  
>  	ret = smokey_check_errno(-!(sem_open(SEM_NAME, O_CREAT, 0644, 1)));
>  	if (ret)
> -		goto fail;
> +		return ret;
> +
> +	ret = procfs_exists("sem", SEM_NAME);
> +	if (ret)
> +		return ret;
>  
>  	sevt.sigev_notify = SIGEV_THREAD_ID;
>  	sevt.sigev_signo = SIGALRM;
>  	sevt.sigev_notify_thread_id = syscall(__NR_gettid);
>  	ret = smokey_check_errno(timer_create(CLOCK_MONOTONIC, &sevt, &tm));
>  	if (ret)
> -		goto fail;
> -	
> +		return ret;
> +
>  	ret = smokey_check_errno(mq_open(MQ_NAME, O_RDWR | O_CREAT, 0644, NULL));
> -	if (ret >= 0)
> -		return;
> -fail:
> -	subprocess_status = ret;
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = procfs_exists("mqueue", MQ_NAME);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
>  }
>  
>  static int run_leaks(struct smokey_test *t, int argc, char *const argv[])
> @@ -143,7 +168,7 @@ static int run_leaks(struct smokey_test *t, int argc, char *const argv[])
>  	struct sigevent sevt;
>  	pthread_mutex_t mutex;
>  	pthread_cond_t cond;
> -	int fd, failed = 0, i, ret;
> +	int fd, failed = 0, i, ret, child_ret;
>  	pthread_t thread;
>  	sem_t sem, *psem;
>  	timer_t tm;
> @@ -235,11 +260,9 @@ static int run_leaks(struct smokey_test *t, int argc, char *const argv[])
>  	child = smokey_check_errno(fork());
>  	if (child < 0)
>  		return child;
> -	if (!child) {
> -		subprocess_leak();
> -		exit(EXIT_SUCCESS);
> -	}
> -	while (waitpid(child, NULL, 0) == -1 && errno == EINTR);
> +	if (!child)
> +		exit(subprocess_leak());
> +	while (waitpid(child, &child_ret, 0) == -1 && errno == EINTR);
>  	sleep(1);
>  
>  	ret = smokey_check_errno(sem_unlink(SEM_NAME));
> @@ -248,9 +271,8 @@ static int run_leaks(struct smokey_test *t, int argc, char *const argv[])
>  	ret = smokey_check_errno(mq_unlink(MQ_NAME));
>  	if (ret)
>  		return ret;
> -	if (subprocess_status)
> -		return subprocess_status;
> -		
> +	if (WIFEXITED(child_ret) && WEXITSTATUS(child_ret))
> +		return -WEXITSTATUS(child_ret);
>  	check_used("fork", before, failed);
>  #endif
>  
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

