Message-ID: <43BFC392.1000700@domain.hid>
Date: Sat, 07 Jan 2006 14:35:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] latency tracer update
References: <43BC4FFB.8040709@domain.hid>
	<43BCF891.1080402@domain.hid>	<43BCFFBB.1080303@domain.hid>
	<43BE4091.4020806@domain.hid> <43BEC786.8050504@domain.hid>
In-Reply-To: <43BEC786.8050504@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>Jan Kiszka wrote:
>>
>>
>>>...
>>>Meanwhile I found a solution for the described unterminated trace (put
>>>an explicite trace_end at the end of __ipipe_unstall_iret_root),
>>>included the irq number in the begin/end report, and stumbled over some
>>>other remaining unterminated trace on a different machine. So, no need
>>>to hurry with the merge (not the review! ;) ), I will publish a second
>>>revision first.
>>>
>>
>>
>>And here comes this revision finally. Should apply (almost) cleanly
>>against latest ipipe versions. Additionally to the changes of the first
>>revision this one addresses the following topics:
>>
>> o fix trace overrun handling
>> o report IRQ number to tracer on IRQ entry/exit
>> o fix virtually leaking IRQs-off in __ipipe_unstall_iret_root()
>> o fix another potential NMI race
>> o really trace the maximum IRQs-off time, not the maximum time of
>>   consecutive IRQs-off times (that scenario will soon be addressed
>>   instead  in the latency benchmark tool => reset&freeze the maximum
>>   latency from the user's point of view)
> 
> 
> ...and it turned out that the existing functions were no sufficient for
> this. So here comes an add-on patch to update3:
> 
>  o allow ipipe_trace_{frozen|max}_reset from every context
>    (well, at least give it a try and just fail on locked traces)
>  o mark border between valid and invalid trace points
>  o show invalid points border
> 
> Apply order:
> 
> ipipe_tracer.update3
> ipipe_tracer.update3-1
> 

Merged in 1.1-03, with the appropriate tracer patch. Thanks.

> The front-end to the first change, a modified latency+timerbench will
> get committed to Xenomai soon. It already works nicely, automatically
> creating a freeze of the maximum latency turn the benchmark perceives.
> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.14.3/kernel/ipipe/tracer.c.orig	2006-01-06 11:13:41.000000000 +0100
> +++ linux-2.6.14.3/kernel/ipipe/tracer.c	2006-01-06 20:11:10.000000000 +0100
> @@ -134,10 +134,14 @@ __ipipe_migrate_pre_trace(struct ipipe_t
>  	int i;
>  
>  	new_tp->trace_pos = pre_trace+1;
> +
>  	for (i = new_tp->trace_pos; i > 0; i--)
>  		memcpy(&new_tp->point[WRAP_POINT_NO(new_tp->trace_pos-i)],
>  		       &old_tp->point[WRAP_POINT_NO(old_pos-i)],
>  		       sizeof(struct ipipe_trace_point));
> +
> +	/* mark the end (i.e. the point before point[0]) invalid */
> +	new_tp->point[IPIPE_TRACE_POINTS-1].eip = 0;
>  }
>  
>  static notrace struct ipipe_trace_path *
> @@ -436,21 +440,23 @@ void notrace ipipe_trace_special(unsigne
>  }
>  EXPORT_SYMBOL(ipipe_trace_special);
>  
> -void ipipe_trace_max_reset(void)
> +int ipipe_trace_max_reset(void)
>  {
>  	int cpu_id;
>  	unsigned long flags;
>  	struct ipipe_trace_path *path;
> +	int ret = 0;
>  
> -	/* only allowed from root domain (we sync with /proc routines) */
> -	if (ipipe_current_domain != ipipe_root_domain)
> -		return;
> -
> -	down(&out_mutex);
>  	flags = __ipipe_global_path_lock();
>  
>  	for_each_cpu(cpu_id) {
>  		path = &trace_paths[cpu_id][max_path[cpu_id]];
> +
> +		if (path->dump_lock) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
>  		path->begin     = -1;
>  		path->end       = -1;
>  		path->trace_pos = 0;
> @@ -458,25 +464,28 @@ void ipipe_trace_max_reset(void)
>  	}
>  
>  	__ipipe_global_path_unlock(flags);
> -	up(&out_mutex);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(ipipe_trace_max_reset);
>  
> -void ipipe_trace_frozen_reset(void)
> +int ipipe_trace_frozen_reset(void)
>  {
>  	int cpu_id;
>  	unsigned long flags;
>  	struct ipipe_trace_path *path;
> +	int ret = 0;
>  
> -	/* only allowed from root domain (we sync with /proc routines) */
> -	if (ipipe_current_domain != ipipe_root_domain)
> -		return;
> -
> -	down(&out_mutex);
>  	flags = __ipipe_global_path_lock();
>  
>  	for_each_cpu(cpu_id) {
>  		path = &trace_paths[cpu_id][frozen_path[cpu_id]];
> +
> +		if (path->dump_lock) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
>  		path->begin = -1;
>  		path->end = -1;
>  		path->trace_pos = 0;
> @@ -484,7 +493,8 @@ void ipipe_trace_frozen_reset(void)
>  	}
>  
>  	__ipipe_global_path_unlock(flags);
> -	up(&out_mutex);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(ipipe_trace_frozen_reset);
>  
> @@ -684,8 +694,10 @@ static int __ipipe_prtrace_show(struct s
>  	unsigned long long abs_delta;
>  	struct ipipe_trace_point *point = p;
>  
> -	if (!point->eip)
> +	if (!point->eip) {
> +		seq_puts(m, "-<invalid>-\n");
>  		return 0;
> +	}
>  
>  	/* ipipe_tsc2us works on unsigned => handle sign separately */
>  	delta = point->timestamp -
> @@ -749,7 +761,10 @@ static ssize_t
>  __ipipe_max_reset(struct file *file, const char __user *pbuffer,
>                    size_t count, loff_t *data)
>  {
> +	down(&out_mutex);
>  	ipipe_trace_max_reset();
> +	up(&out_mutex);
> +
>  	return count;
>  }
>  
> @@ -841,7 +856,10 @@ static ssize_t
>  __ipipe_frozen_reset(struct file *file, const char __user *pbuffer,
>                       size_t count, loff_t *data)
>  {
> +	down(&out_mutex);
>  	ipipe_trace_frozen_reset();
> +	up(&out_mutex);
> +
>  	return count;
>  }
>  
> --- linux-2.6.14.3/include/linux/ipipe_trace.h.orig	2006-01-06 11:13:41.000000000 +0100
> +++ linux-2.6.14.3/include/linux/ipipe_trace.h	2006-01-06 12:37:19.000000000 +0100
> @@ -28,7 +28,7 @@ void ipipe_trace_end(unsigned long v);
>  void ipipe_trace_freeze(unsigned long v);
>  void ipipe_trace_special(unsigned char special_id, unsigned long v);
>  
> -void ipipe_trace_max_reset(void);
> -void ipipe_trace_frozen_reset(void);
> +int ipipe_trace_max_reset(void);
> +int ipipe_trace_frozen_reset(void);
>  
>  #endif	/* !__LINUX_IPIPE_H */


-- 

Philippe.

