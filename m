Message-ID: <4ADDE138.8060000@domain.hid>
Date: Tue, 20 Oct 2009 18:11:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000AE71.4ADDA6F7@domain.hid>
In-Reply-To: <0000AE71.4ADDA6F7@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] :: rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "oliver.schlenker@domain.hid" <oliver.schlenker@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

oliver.schlenker@domain.hid wrote:
> 
> 
> 
> 
> -------- Original Message --------
> Subject: Re: :: rt_printf with daemonized task (20-Okt-2009 11:33)
> From:    Jan Kiszka <jan.kiszka@domain.hid>
> To:      oliver.schlenker@domain.hid
> 
>> See http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/6571 for
>> an example of a patch that may (but need not) be generated via git. What
>> counts is the format: proper title, a few lines of description, signed-off.
>>
>> HTH,
>> Jan
>>
> 
> ok, here is my next trial for a proper patch
> 

That format looks good.

Thanks,
Jan

> 
> Oliver
> 
> 
> ----------------------------------------------------------------------------------------------
> 
> Subject : Fork-save use of rt_print
> 
> Fork save initialisation of rt_print library, necessary child initialisation are
> done via pthread_atfork() when child process is started.
> 
> Signed-off-by: Oliver Schlenker <oliver.schlenker <at> sm motion control.de>
> ---
> 
> --- rt_print.c.original	2008-09-10 10:36:27.000000000 +0200
> +++ rt_print.c.forkonly	2009-10-16 16:19:25.949289800 +0200
>                     
>  	}
>  }
>  
> -void __rt_print_init(void)
> +static void spawn_printer_thread(void)
>  {
>  	pthread_attr_t thattr;
> +
> +	pthread_attr_init(&thattr);
> +	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
> +	pthread_create(&__printer_thread, &thattr, printer_loop, NULL);
> +}
> +
> +static void forked_child_init(void)
> +{
> +	struct print_buffer *my_buffer = pthread_getspecific(__buffer_key);
> +	struct print_buffer **pbuffer = &__first_buffer;
> +
> +	/* re-init to avoid finding it locked by some parent thread */
> +	pthread_mutex_init(&__buffer_lock, NULL);
> +
> +	while (*pbuffer) {
> +		if (*pbuffer == my_buffer)
> +			pbuffer = &(*pbuffer)->next;
> +		else
> +			cleanup_buffer(*pbuffer);
> +	}
> +
> +	spawn_printer_thread();
> +}
> +
> +void __rt_print_init(void)
> +{
>  	const char *value_str;
>  	unsigned long long period;
>  
>                    
>  	pthread_mutex_init(&__buffer_lock, NULL);
>  	pthread_key_create(&__buffer_key, (void (*)(void*))cleanup_buffer);
>  
> -	pthread_attr_init(&thattr);
> -	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
> -	pthread_create(&__printer_thread, &thattr, printer_loop, NULL);
> +	spawn_printer_thread();
> +	pthread_atfork(NULL, NULL, forked_child_init);
>  } 
> 
> 
> 
> 
> To: jan.kiszka@domain.hid
> Cc: gilles.chanteperdrix@xenomai.org
>     xenomai@xenomai.org


-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

