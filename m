Message-ID: <7eed4fdc-0e29-57c1-2c1a-545e3c490c1a@siemens.com>
Date: Tue, 8 Feb 2022 08:04:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] cobalt/thread: add missing EXPORT_SYMBOL_GPL for
 xnthread_host_pid
Content-Language: en-US
References: <20220208050609.5007-1-david.oberhollenzer@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220208050609.5007-1-david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>, xenomai@xenomai.org

On 08.02.22 06:06, David Oberhollenzer via Xenomai wrote:
> xnthread_host_pid was previously exposed as an inline function, and
> as such was externally available in releases up to 3.0.7.
> 
> Commit 2ac704fa8 moved it into thread.c, but did not export it.
> This patch adds a missing EXPORT_SYMBOL_GPL.
> 
> Fixes: 2ac704fa8 ("cobalt: Never crash on reading host task pid")
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> ---
>  kernel/cobalt/thread.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index dfaef7564..6cddf3f9f 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -388,6 +388,7 @@ pid_t xnthread_host_pid(struct xnthread *thread)
> 
>  	return task_pid_nr(xnthread_host_task(thread));
>  }
> +EXPORT_SYMBOL_GPL(xnthread_host_pid);
> 
>  int xnthread_set_clock(struct xnthread *thread, struct xnclock *newclock)
>  {
> --
> 2.34.1
> 
> 
> 

No general concern - but can you help me where this is used by a module?
In-tree or out-of-tree?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

