References: <E1daPZD-0000KU-Bk@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <279c3ea8-3396-161c-254a-aca7e2f6a445@xenomai.org>
Date: Wed, 26 Jul 2017 18:59:40 +0200
MIME-Version: 1.0
In-Reply-To: <E1daPZD-0000KU-Bk@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt: Fix conditional
 build of lock_vfile registration
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, xenomai-git@xenomai.org

On 07/26/2017 06:53 PM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 634a95c9c023dda40607e5e5c1dd43761f59e541
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=634a95c9c023dda40607e5e5c1dd43761f59e541
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Wed Jul 26 18:50:43 2017 +0200
> 
> cobalt: Fix conditional build of lock_vfile registration
> 
> There is and there was never a CONFIG_XENO_DEBUG_LOCKING.
> Fixes de66d324a93d.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> ---
> 
>  kernel/cobalt/procfs.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cobalt/procfs.c b/kernel/cobalt/procfs.c
> index 9d193af..85aea0c 100644
> --- a/kernel/cobalt/procfs.c
> +++ b/kernel/cobalt/procfs.c
> @@ -216,7 +216,7 @@ static struct xnvfile_regular apc_vfile = {
>  void xnprocfs_cleanup_tree(void)
>  {
>  #ifdef CONFIG_XENO_OPT_DEBUG
> -#ifdef CONFIG_XENO_DEBUG_LOCKING

This would reintroduce another bug [1]. Better check for the proper
symbol instead, i.e. CONFIG_XENO_OPT_DEBUG_LOCKING.

[1]  http://xenomai.org/pipermail/xenomai/2017-February/037136.html

-- 
Philippe.

