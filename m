Subject: Re: [PATCH RFC 1/2] cobalt/registry: Add a new virtual /proc file for
 dumping registry
References: <20210816161214.62995-1-florian.bezdeka@siemens.com>
 <20210816161214.62995-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9f51d511-c6d7-a091-6fca-cee84e4e09c5@siemens.com>
Date: Tue, 17 Aug 2021 08:09:04 +0200
MIME-Version: 1.0
In-Reply-To: <20210816161214.62995-2-florian.bezdeka@siemens.com>
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

On 16.08.21 18:12, Florian Bezdeka wrote:
> Introducing /proc/xenomai/registry/dump which could be accessed by
> something like "cat" to dump the current registry. Like the "usage"
> file it is available when CONFIG_XENO_OPT_VFILE is enabled.
> 
> The main purpose of this file is providing some additional help when
> trying to find resource leaks triggered by Xenomai based applications.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/registry.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
> index 816102f7a..8befa795c 100644
> --- a/kernel/cobalt/registry.c
> +++ b/kernel/cobalt/registry.c
> @@ -80,6 +80,23 @@ static int usage_vfile_show(struct xnvfile_regular_iterator *it, void *data)
>  	return 0;
>  }
>  
> +static int dump_vfile_show(struct xnvfile_regular_iterator *it, void *data)
> +{
> +	struct xnobject *elem;
> +	struct hlist_node *next;
> +	int n;
> +
> +	xnvfile_printf(it, "nr_object_entries: %d\n", nr_object_entries);
> +	xnvfile_printf(it, "obj_idx[0]: \treserved\n");
> +
> +	for (n = 0; n < nr_object_entries; n++)
> +		hlist_for_each_entry_safe(elem, next, &object_index[n], hlink)
> +			xnvfile_printf(it, "obj_idx[%d]:\tobj=%p, key=%s\n", n,
> +				       elem->objaddr, elem->key ?: "(anon)");
> +
> +	return 0;
> +}
> +
>  static struct xnvfile_regular_ops usage_vfile_ops = {
>  	.show = usage_vfile_show,
>  };
> @@ -88,6 +105,14 @@ static struct xnvfile_regular usage_vfile = {
>  	.ops = &usage_vfile_ops,
>  };
>  
> +static struct xnvfile_regular_ops dump_vfile_ops = {
> +	.show = dump_vfile_show,
> +};
> +
> +static struct xnvfile_regular dump_vfile = {
> +	.ops = &dump_vfile_ops,
> +};
> +
>  #endif /* CONFIG_XENO_OPT_VFILE */
>  
>  unsigned xnregistry_hash_size(void)
> @@ -124,8 +149,16 @@ int xnregistry_init(void)
>  		return ret;
>  	}
>  
> +	ret = xnvfile_init_regular("dump", &dump_vfile, &registry_vfroot);
> +	if (ret) {
> +		xnvfile_destroy_regular(&usage_vfile);
> +		xnvfile_destroy_dir(&registry_vfroot);
> +		return ret;
> +	}
> +
>  	proc_virq = pipeline_create_inband_sirq(registry_proc_schedule);
>  	if (proc_virq < 0) {
> +		xnvfile_destroy_regular(&dump_vfile);
>  		xnvfile_destroy_regular(&usage_vfile);
>  		xnvfile_destroy_dir(&registry_vfroot);
>  		return proc_virq;
> @@ -149,6 +182,7 @@ int xnregistry_init(void)
>  
>  	if (object_index == NULL) {
>  #ifdef CONFIG_XENO_OPT_VFILE
> +		xnvfile_destroy_regular(&dump_vfile);
>  		xnvfile_destroy_regular(&usage_vfile);
>  		xnvfile_destroy_dir(&registry_vfroot);
>  		pipeline_delete_inband_sirq(proc_virq);
> @@ -199,6 +233,7 @@ void xnregistry_cleanup(void)
>  #ifdef CONFIG_XENO_OPT_VFILE
>  	pipeline_delete_inband_sirq(proc_virq);
>  	flush_scheduled_work();
> +	xnvfile_destroy_regular(&dump_vfile);
>  	xnvfile_destroy_regular(&usage_vfile);
>  	xnvfile_destroy_dir(&registry_vfroot);
>  #endif /* CONFIG_XENO_OPT_VFILE */
> 

We need something like this, I'm just wondering if we shouldn't make the
missing information available in a similar way like the already
published one (drivers/ipc), also to avoid duplicating things this way.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

