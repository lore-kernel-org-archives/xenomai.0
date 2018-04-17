References: <7be9b9c7-7393-eca0-6a86-bcf3d0302271@siemens.com>
 <667bd118-b8eb-4fbf-cb24-4f4f30114370@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3c4fc185-19af-4285-07a2-148b2a039fec@xenomai.org>
Date: Tue, 17 Apr 2018 09:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <667bd118-b8eb-4fbf-cb24-4f4f30114370@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] copperplate: Drop PI from registry locks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 04/13/2018 07:51 PM, Jan Kiszka wrote:
> None of the callers that run into the locks have RT requirements.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> As noted before, I think we should even be fine with STD locks, but that
> may require more changes.
> 
>  lib/copperplate/registry.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/lib/copperplate/registry.c b/lib/copperplate/registry.c
> index daefa6c97..1bf0ebfea 100644
> --- a/lib/copperplate/registry.c
> +++ b/lib/copperplate/registry.c
> @@ -175,7 +175,6 @@ int registry_init_file(struct fsobj *fsobj,
>  
>  	pthread_mutexattr_init(&mattr);
>  	pthread_mutexattr_settype(&mattr, mutex_type_attribute);
> -	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
>  	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_PRIVATE);
>  	ret = __bt(-__RT(pthread_mutex_init(&fsobj->lock, &mattr)));
>  	pthread_mutexattr_destroy(&mattr);
> @@ -758,7 +757,6 @@ int __registry_pkg_init(const char *arg0, char *mountpt, int flags)
>  
>  	pthread_mutexattr_init(&mattr);
>  	pthread_mutexattr_settype(&mattr, mutex_type_attribute);
> -	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
>  	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_PRIVATE);
>  	ret = __bt(-__RT(pthread_mutex_init(&p->lock, &mattr)));
>  	pthread_mutexattr_destroy(&mattr);
> 

This one raises an interesting issue: since commit #8e606e681,
registry_{add, destroy}_file() use plain malloc(), therefore are subject
to mode switches, dropping the real-time guarantee from object
creation/deletion routines such as rt_*_{create, delete}() calls from
the Alchemy API.

Previously to such change, some of these routines did not provide such
guarantee anyway, e.g. rt_task_create(), but others did like
rt_mutex_create(), rt_cond_create().

I'm now questioning those specific changes in registry_{add,
destroy}_file(), because they might break applications assuming that rt
mode is not lost when calling them, which is still true if the registry
is disabled, leading to a fairly confusing inconsistency.

Merging your patch would enforce this change in behavior even more,
carving in stone that all object creation and deletion routines which
interface with the registry won't be rt-capable anymore.

Would that be generally acceptable?

PS: btw, the memory allocation mess is much worse than I suspected, and
it is globally bad: this is not only a matter of properly sizing the
private memory heap, but a general performance issues with all
allocators, on different aspects and usage patterns. I'll follow up on
this later this week with details.

-- 
Philippe.

