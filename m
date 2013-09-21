Message-ID: <523D594F.1050605@xenomai.org>
Date: Sat, 21 Sep 2013 10:31:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1VN5el-0002Ct-8K@xenomai.org>
In-Reply-To: <E1VN5el-0002Ct-8K@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/posix/sem: Fix
 locking imbalances in cobalt_sem_open
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>

On 09/20/2013 08:42 PM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 8775720ae828d1e1be076f91b93a3eeac1b7ed90
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=8775720ae828d1e1be076f91b93a3eeac1b7ed90
>
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri Sep 20 20:39:18 2013 +0200
>
> cobalt/posix/sem: Fix locking imbalances in cobalt_sem_open
>
> We hold cobalt_assoc_lock, not nklock.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>

This fix should be backported to 2.6.

> ---
>
>   kernel/cobalt/posix/sem.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
> index 076f2d2..60906fd 100644
> --- a/kernel/cobalt/posix/sem.c
> +++ b/kernel/cobalt/posix/sem.c
> @@ -916,7 +916,7 @@ int cobalt_sem_open(unsigned long __user *u_addr,
>   	if (assoc) {
>   		usm = container_of(assoc, struct cobalt_usem, assoc);
>   		++usm->refcnt;
> -		xnlock_put_irqrestore(&nklock, s);
> +		xnlock_put_irqrestore(&cobalt_assoc_lock, s);
>   		goto got_usm;
>   	}
>
> @@ -936,7 +936,7 @@ int cobalt_sem_open(unsigned long __user *u_addr,
>   	assoc = cobalt_assoc_lookup(&cc->usems, (u_long)sm->sem);
>   	if (assoc) {
>   		container_of(assoc, struct cobalt_usem, assoc)->refcnt++;
> -		xnlock_put_irqrestore(&nklock, s);
> +		xnlock_put_irqrestore(&cobalt_assoc_lock, s);
>   		xnfree(usm);
>   		usm = container_of(assoc, struct cobalt_usem, assoc);
>   		goto got_usm;
>
>
> _______________________________________________
> Xenomai-git mailing list
> Xenomai-git@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai-git
>


-- 
Philippe.

