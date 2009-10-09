Message-ID: <4ACF4FE6.90309@domain.hid>
Date: Fri, 09 Oct 2009 16:59:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000AD04.4ACF6958@domain.hid>
In-Reply-To: <0000AD04.4ACF6958@domain.hid>
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
> Hi Jan,
> 
> thank you for the hints and advices. I'm going to integrate the
> changes, as described below,  test it and send new patch.
> 
> -------- Original Message --------
> Subject: Re: :: rt_printf with daemonized task (09-Okt-2009 15:58)
> From:    Jan Kiszka <jan.kiszka@domain.hid>
> To:      oliver.schlenker@domain.hid
> 
>> Hi Oliver,
>>
>>> +++ rtdk.h	2009-10-09 11:46:52.767271100 +0200
>>>                  
>>>  int rt_vprintf(const char *format, va_list args);
>>>  int rt_fprintf(FILE *stream, const char *format, ...);
>>>  int rt_printf(const char *format, ...);
>>> +void rt_syslog( int priority, char *format, ...);
>>                  ^^^
>> Stray whitespace.
> 
> ok, removed.
> 
>>>  
>>>  #define RT_PRINT_LINE_BREAK		256
>>>  
>>> +#define RT_PRINT_SYSLOG_STREAM	((FILE *)-9999)
>> Better use NULL here.
> 
> ok, changed to NULL.
> 
>>> format, va_list args)
>> Line with >80 characters.
> 
> Is there any reason why a line should not exceed 80 chars ?

Xenomai follows Linux kernel coding style. And Linux (like many other
projects) argue that limited line length helps readability and enforces
the developer to think about different code structuring before
introducing the 10th indention level.

> I did change it anyway.
> 
> 
>>>  
>>> +int rt_vfprintf(FILE *stream, const char *format, va_list args)
>>> +{
>>> +	return rt_print_to_buffer( stream, 0, format, args);
>> Stray whitespace.
> 
> ok, removed.
> 
>>> +void rt_vsyslog(int priority, char *format, va_list args )
>> Whitespace.
> 
> also removed.
> 
>>> +{
>>> +
>>> +	rt_print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
>>> +
>>> +	return;
>>> +}
>>> +
>>>  static void set_buffer_name(struct print_buffer *buffer, const char *name)
>>>  {
>>>  	int n;
>>>                     
>>>  
>>>  		if (len) {
>>>  			/* Print out non-empty entry and proceed */
>>> -			fprintf(head->dest, "%s", head->text);
>>> +			/* Check if output goes to syslog */
>>> +			if (head->dest == RT_PRINT_SYSLOG_STREAM) {
>>> +			   	syslog( head->priority, "%s", head->text );
>> Stray whitespaces. And one /may/ argue that we do not need braces here,
>> but that's a grey area.
> 
> whitespace removed, braces are left (I feel more convienent with braces).
> 
>> Here is my version:
>>
>> static void spawn_printer_thread(void)
>> {
>> 	pthread_attr_t thattr;
>>
>> 	pthread_attr_init(&thattr);
>> 	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
>> 	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
>> }
>>
>> static void forked_child_init(void)
>> {
>> 	struct print_buffer *my_buffer = pthread_getspecific(buffer_key);
>> 	struct print_buffer **pbuffer = &first_buffer;
>>
>> 	/* re-init to avoid finding it locked by some parent thread */
>> 	pthread_mutex_init(&buffer_lock, NULL);
>>
>> 	while (*pbuffer) {
>> 		if (*pbuffer == my_buffer)
>> 			pbuffer = &(*pbuffer)->next;
>> 		else
>> 			cleanup_buffer(*pbuffer);
>> 	}
>>
>> 	spawn_printer_thread();
>> }
>>
>> The major differences are:
>>  - my code is totally untested :)
>>  - we have to play safe and re-init the mutex
>>  - we should not purge a potentially existing buffer of the main thread
>>  - I don't think we have to re-install the fork hook for the child (the
>>    parent's installation should survive the fork)
>>
>> and...
> 
> ok, I got the points. I'm going to integrate your version.
> Should I use spawn_printer_thread() also in __rt_print_init() or leave
> the 4 lines of code ?
> 

Yes (to the former), avoiding code duplication was the motivation for
this functions.

Another wish: Please split up your changes into two patches: first the
atfork fix, on top of it the syslog extension. That allows us, e.g., to
apply the fix also to 2.4.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

