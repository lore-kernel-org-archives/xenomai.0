Message-ID: <4ADC7116.9060101@domain.hid>
Date: Mon, 19 Oct 2009 16:00:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000AE42.4ADC81E9@domain.hid>
In-Reply-To: <0000AE42.4ADC81E9@domain.hid>
Content-Type: text/plain; charset=utf-8
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
> -------- Original Message --------
> Subject: Re: :: rt_printf with daemonized task (09-Okt-2009 16:59)
> From:    Jan Kiszka <jan.kiszka@domain.hid>
> To:      oliver.schlenker@domain.hid
> 
>> Yes (to the former), avoiding code duplication was the motivation for
>> this functions.
>>
>> Another wish: Please split up your changes into two patches: first the
>> atfork fix, on top of it the syslog extension. That allows us, e.g., to
>> apply the fix also to 2.4.
> 
> Here we go, first patch for a fork save rt_print .....
> 

Thanks for the patches, but I still have remarks. :)

First of all, both patches need proper titles, a few lines of
description (see git history to get a feeling), and a signed-off-by to
express that you are the copyright holder and are allowed to contribute
this to Xenomai.

> 
>> Jan
>>
>> -- 
>> Siemens AG, Corporate Technology, CT SE 2
>> Corporate Competence Center Embedded Linux
> 
> 
> Oliver
> 
> 
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
> +	pthread_atfork(NULL,NULL,forked_child_init);

Please add a space after each ','.

>  } 
> 

When the formal things are resolved:

Acked-by: Jan Kiszka <jan.kiszka@domain.hid>

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

