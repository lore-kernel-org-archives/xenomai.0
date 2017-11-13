References: <E1e2arC-0007kc-Al@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1fcfc877-67e5-13d3-2e4f-9c014f33ddb8@siemens.com>
Date: Mon, 13 Nov 2017 17:34:22 +0100
MIME-Version: 1.0
In-Reply-To: <E1e2arC-0007kc-Al@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Jan Kiszka : cobalt/debug: Fix locking
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

On 2017-10-12 12:36, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 02424d69f933bea30904b6ef53168c3a3aca8459
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=02424d69f933bea30904b6ef53168c3a3aca8459
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Thu Oct 12 09:46:41 2017 +0200
> 
> cobalt/debug: Fix locking
> 
> None of these functions are called over interrupt context. Leaving the
> critical sections interruptible can cause premature/double-unlock
> scenarios and bug reports such as
> 
> [Xenomai] lock ffffffff81c56000 already unlocked on CPU #1
>           last owner = kernel/xenomai/debug.c:74 (hash_symbol(), CPU #1)
>  000000000000002f ffff88007dc8bb10 ffffffff8118ae8f ffffffff00000001
>  0000000000000021 ffff88007f897fde ffff88007dc8bb50 ffffffff8118b266
>  00000000000000f1 ffff88007dc8bd68 0000000000000006 ffff88007dc8bd40
> Call Trace:
>  [<ffffffff8118ae8f>] xnlock_dbg_release+0xdf/0xf0
>  [<ffffffff8118b266>] hash_symbol+0x236/0x2d0
>  [<ffffffff8118b668>] xndebug_trace_relax+0x118/0x450
>  [<ffffffff811b8d50>] ? CoBaLt32emu_mmap+0xf0/0xf0
>  [<ffffffff811b8dd7>] CoBaLt32emu_backtrace+0x87/0xb0
>  [<ffffffff8100def6>] ? fpu__clear+0xd6/0x160
>  [<ffffffff817b3691>] ? _raw_spin_unlock_irq+0x11/0x30
>  [<ffffffff811ab1cc>] ipipe_syscall_hook+0x11c/0x3a0
>  [<ffffffff8113d9bf>] __ipipe_notify_syscall+0xbf/0x180
>  [<ffffffff810cd019>] ? __set_current_blocked+0x49/0x50
>  [<ffffffff8113daab>] ipipe_handle_syscall+0x2b/0xb0
>  [<ffffffff81001c9d>] do_fast_syscall_32+0xbd/0x220
>  [<ffffffff817b64e2>] sysenter_flags_fixed+0x8/0x12
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> ---
> 
>  kernel/cobalt/debug.c |   28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
> index 159b3c7..e5f4ab9 100644
> --- a/kernel/cobalt/debug.c
> +++ b/kernel/cobalt/debug.c
> @@ -64,14 +64,15 @@ DEFINE_PRIVATE_XNLOCK(symbol_lock);
>  static const char *hash_symbol(const char *symbol)
>  {
>  	struct hashed_symbol *p, **h;
> -	const char *s;
> +	const char *str;
>  	size_t len;
>  	u32 hash;
> +	spl_t s;
>  
>  	len = strlen(symbol);
>  	hash = jhash(symbol, len, 0);
>  
> -	xnlock_get(&symbol_lock);
> +	xnlock_get_irqsave(&symbol_lock, s);
>  
>  	h = &symbol_jhash[hash & (SYMBOL_HSLOTS - 1)];
>  	p = *h;
> @@ -85,7 +86,7 @@ static const char *hash_symbol(const char *symbol)
>  
>  	p = xnheap_alloc(&memory_pool, sizeof(*p) + len + 1);
>  	if (p == NULL) {
> -		s = NULL;
> +		str = NULL;
>  		goto out;
>  	}
>  
> @@ -93,11 +94,11 @@ static const char *hash_symbol(const char *symbol)
>  	p->next = *h;
>  	*h = p;
>  done:
> -	s = p->symbol;
> +	str = p->symbol;
>  out:
> -	xnlock_put(&symbol_lock);
> +	xnlock_put_irqrestore(&symbol_lock, s);
>  
> -	return s;
> +	return str;
>  }
>  
>  /*
> @@ -214,6 +215,7 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
>  	int n, depth;
>  	char *tmp;
>  	u32 hash;
> +	spl_t s;
>  
>  	thread = xnthread_current();
>  	if (thread == NULL)
> @@ -285,7 +287,7 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
>  	strcpy(spot.thread, thread->name);
>  	hash = jhash2((u32 *)&spot, sizeof(spot) / sizeof(u32), 0);
>  
> -	xnlock_get(&relax_lock);
> +	xnlock_get_irqsave(&relax_lock, s);
>  
>  	h = &relax_jhash[hash & (RELAX_HSLOTS - 1)];
>  	p = *h;
> @@ -326,7 +328,7 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
>  out:
>  	relax_overall++;
>  
> -	xnlock_put(&relax_lock);
> +	xnlock_put_irqrestore(&relax_lock, s);
>  }
>  
>  static DEFINE_VFILE_HOSTLOCK(relax_mutex);
> @@ -343,6 +345,7 @@ static void *relax_vfile_begin(struct xnvfile_regular_iterator *it)
>  {
>  	struct relax_vfile_priv *priv = xnvfile_iterator_priv(it);
>  	struct relax_record *p;
> +	spl_t s;
>  	int n;
>  
>  	/*
> @@ -352,7 +355,7 @@ static void *relax_vfile_begin(struct xnvfile_regular_iterator *it)
>  	 * holds the relax_mutex lock for us, so that we can't race
>  	 * with ->store().
>  	 */
> -	xnlock_get(&relax_lock);
> +	xnlock_get_irqsave(&relax_lock, s);
>  
>  	if (relax_queued == 0 || it->pos > relax_queued) {
>  		xnlock_put(&relax_lock);
> @@ -362,7 +365,7 @@ static void *relax_vfile_begin(struct xnvfile_regular_iterator *it)
>  	priv->queued = relax_queued;
>  	priv->head = relax_record_list;
>  
> -	xnlock_put(&relax_lock);
> +	xnlock_put_irqrestore(&relax_lock, s);
>  
>  	if (it->pos == 0) {
>  		priv->curr = NULL;
> @@ -447,19 +450,20 @@ static int relax_vfile_show(struct xnvfile_regular_iterator *it, void *data)
>  static ssize_t relax_vfile_store(struct xnvfile_input *input)
>  {
>  	struct relax_record *p, *np;
> +	spl_t s;
>  
>  	/*
>  	 * Flush out all records. Races with ->show() are prevented
>  	 * using the relax_mutex lock. The vfile layer takes care of
>  	 * this internally.
>  	 */
> -	xnlock_get(&relax_lock);
> +	xnlock_get_irqsave(&relax_lock, s);
>  	p = relax_record_list;
>  	relax_record_list = NULL;
>  	relax_overall = 0;
>  	relax_queued = 0;
>  	memset(relax_jhash, 0, sizeof(relax_jhash));
> -	xnlock_put(&relax_lock);
> +	xnlock_put_irqrestore(&relax_lock, s);
>  
>  	while (p) {
>  		np = p->r_next;
> 

Please review/merge. It's also stable material.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

