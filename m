Subject: Re: [PATCH] cobalt/posix/sem: Pull xnregistry_remove out of nklock
References: <33aedba3-088f-db8d-66e4-36515cf644f7@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3446dbf8-69b3-cee3-3fd3-fa03bd2bee4d@siemens.com>
Date: Wed, 25 Aug 2021 14:29:53 +0200
MIME-Version: 1.0
In-Reply-To: <33aedba3-088f-db8d-66e4-36515cf644f7@siemens.com>
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
To: Xenomai <xenomai@xenomai.org>

On 25.08.21 14:06, Jan Kiszka via Xenomai wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Neither needed nor correct for named semaphores where xnregistry_remove
> will trigger a flush_work when running over the secondary domain.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/posix/sem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
> index b6709e6927..6fb4dc2c2a 100644
> --- a/kernel/cobalt/posix/sem.c
> +++ b/kernel/cobalt/posix/sem.c
> @@ -94,7 +94,6 @@ int __cobalt_sem_destroy(xnhandle_t handle)
>  	}
>  
>  	cobalt_mark_deleted(sem);
> -	xnregistry_remove(sem->resnode.handle);
>  	if (!sem->pathname)
>  		cobalt_del_resource(&sem->resnode);
>  	if (xnsynch_destroy(&sem->synchbase) == XNSYNCH_RESCHED) {
> @@ -104,6 +103,7 @@ int __cobalt_sem_destroy(xnhandle_t handle)
>  
>  	xnlock_put_irqrestore(&nklock, s);
>  
> +	xnregistry_remove(sem->resnode.handle);
>  	if (sem->pathname)
>  		putname(sem->pathname);
>  
> 

Will go in before Florian's registry patches as those surface this
hidden issue. Previously, sems had no entry in proc, thus couldn't
trigger this problem.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

