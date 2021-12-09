Subject: Re: [RFC PATCH] plugin/sched_event: add cobalt_switch_context event
 and corresponding action
References: <20211209060309.16802-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d954a0dc-e9b5-5f6d-cbb3-b3753d3b6973@siemens.com>
Date: Thu, 9 Dec 2021 10:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <20211209060309.16802-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="utf-8"
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 09.12.21 07:03, Hongzhan Chen wrote:
> this patch is for kernelshark to fix issue "visualize task switches correctly 
> in Kernelshark (color in CPU bar is not updating on cobalt_switch_context)"
> described in https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/33
> 
> For Xenomai cobalt enabled system, cobalt_switch_context means that there
> is context switch in companion core , which we may need to do special
> treatment and take correct action as main kenrel sched_switch.
> 
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/src/plugins/sched_events.c b/src/plugins/sched_events.c
> index 198ed49..41b3537 100644
> --- a/src/plugins/sched_events.c
> +++ b/src/plugins/sched_events.c
> @@ -110,6 +110,21 @@ static bool plugin_sched_init_context(struct kshark_data_stream *stream,
>  	plugin_ctx->sched_switch_prev_state_field =
>  		tep_find_field(event, "prev_state");
>  
> +	event = tep_find_event_by_name(plugin_ctx->tep,
> +					"cobalt_core", "cobalt_switch_context");
> +
> +	if (!event)
> +		return false;
> +
> +	plugin_ctx->cobalt_switch_event = event;
> +	plugin_ctx->cobalt_switch_next_field =
> +		tep_find_any_field(event, "next_pid");
> +
> +	plugin_ctx->cobalt_switch_prev_state_field =
> +		tep_find_field(event, "prev_state");
> +
> +
> +
>  	wakeup_found = define_wakeup_event(plugin_ctx->tep,
>  					   &plugin_ctx->sched_waking_event);
>  
> @@ -159,6 +174,26 @@ static void plugin_sched_swith_action(struct kshark_data_stream *stream,
>  	}
>  }
>  
> +static void plugin_cobalt_swith_action(struct kshark_data_stream *stream,

typo: switch

> +				      void *rec, struct kshark_entry *entry)
> +{
> +	struct tep_record *record = (struct tep_record *) rec;
> +	struct plugin_sched_context *plugin_ctx;
> +	unsigned long long next_pid, prev_state;
> +	ks_num_field_t ks_field;
> +	int ret;
> +
> +	plugin_ctx = __get_context(stream->stream_id);
> +	if (!plugin_ctx)
> +		return;
> +
> +	ret = tep_read_number_field(plugin_ctx->cobalt_switch_next_field,
> +				    record->data, &next_pid);
> +
> +	if (ret == 0 && next_pid >= 0)
> +		entry->pid = next_pid;
> +}
> +
>  static void plugin_sched_wakeup_action(struct kshark_data_stream *stream,
>  				       void *rec, struct kshark_entry *entry)
>  {
> @@ -193,6 +228,10 @@ int KSHARK_PLOT_PLUGIN_INITIALIZER(struct kshark_data_stream *stream)
>  				      plugin_ctx->sched_switch_event->id,
>  				      plugin_sched_swith_action);
>  
> +	kshark_register_event_handler(stream,
> +				      plugin_ctx->cobalt_switch_event->id,
> +				      plugin_cobalt_swith_action);
> +
>  	if (plugin_ctx->sched_waking_event) {
>  		kshark_register_event_handler(stream,
>  					      plugin_ctx->sched_waking_event->id,
> diff --git a/src/plugins/sched_events.h b/src/plugins/sched_events.h
> index 2c540fd..067487e 100644
> --- a/src/plugins/sched_events.h
> +++ b/src/plugins/sched_events.h
> @@ -37,6 +37,15 @@ struct plugin_sched_context {
>  	/** Pointer to the sched_switch_prev_state_field format descriptor. */
>  	struct tep_format_field	*sched_switch_prev_state_field;
>  
> +	/** Pointer to the cobalt_switch_event object. */
> +	struct tep_event	*cobalt_switch_event;
> +
> +	 /** Pointer to the cobalt_switch_next_field format descriptor. */
> +	struct tep_format_field *cobalt_switch_next_field;
> +
> +	/** Pointer to the cobalt_switch_prev_state_field format descriptor. */
> +	struct tep_format_field *cobalt_switch_prev_state_field;
> +
>  	/** Pointer to the sched_waking_event object. */
>  	struct tep_event        *sched_waking_event;
>  
> 

Yep, that goes the same way as I used to go in the past with kernelshark
1.x. Just recalled that I published it:
https://git.kiszka.org/?p=trace-cmd.git;a=commitdiff;h=92b0aaf7eaf7fa4bbc8edde1ffe8206a35214565

However: This is likely not maintainable. We need a real plugin that
does not affect the main code and can be handled out-of-tree, or we need
to sell such an extension to upstream.

We should sync on that topic again with the kernelshark community and
specifically Steven Rostedt. I was discussing our needs a long time ago
with him, but I unfortunately forgot the details of the outcome.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

