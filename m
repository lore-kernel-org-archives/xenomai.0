Message-ID: <4AE08982.8050501@domain.hid>
Date: Thu, 22 Oct 2009 18:34:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000AEB3.4ADF1568@domain.hid>
In-Reply-To: <0000AEB3.4ADF1568@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re-2: :: rt_printf with daemonized task
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
> Subject: Re: :: rt_printf with daemonized task (19-Okt-2009 16:00)
> From:    Jan Kiszka <jan.kiszka@domain.hid>
> To:      oliver.schlenker@domain.hid
> 
>> If you move the definition of print_to_buffer right below this prototype
>> block, you would avoid having to add this prototype and you would have
>> likely generated a more reviewable patch. The large code movement below
>> is very hard to check regarding correctness as I do not see the actually
>> modified lines.
> 
> Ok, moved back definition of print_to_buffer to avoid large code movement
> 
>>>  static void cleanup_buffer(struct print_buffer *buffer);
>>>  static void print_buffers(void);
>>> +static void forked_child_init(void);
>> Stray prototype.
> 
> deleted
> 
>>>  
>>> +void rt_syslog(int priority, char *format, ...)
>>> +{
>>> +	va_list args;
>>> +
>>> +	va_start(args, format);
>>> +	print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
>>> +	va_end(args);
>>> +
>>> +	return;
>> Unneeded return.
> 
> Deleted
> 
>>> +}
>>> +
>>> +void rt_vsyslog(int priority, char *format, va_list args )
>>> +{
>>> +	print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
>>> +
>>> +	return;
>> Here too.
> 
> Also deleted
> 
>>> +}
>>> +
>>>  static void set_buffer_name(struct print_buffer *buffer, const char *name)
>>>  {
>>>  	int n;
>>>                      
>>>  
>>>  /* *** Deferred Output Management *** */
>>>  
>>> +static int print_to_buffer(FILE *stream, int priority,
>>> +							const char *format,va_list args)
>> When moving this function, please also indent this properly and take
>> care for a space after the ','.
> 
> should be correct now.
> 
>> Jan
>>
>> -- 
>> Siemens AG, Corporate Technology, CT SE 2
>> Corporate Competence Center Embedded Linux
> 
> 
> when patches are acked by you, should I do something with the patches
> like sending to a special mailing list or is it ok to have them posted in
> this list ?

I was about to apply them to my tree and send out a git pull request to
Philippe. Unfortunately I missed so far that your mail client or gateway
damaged the patch format seriously (the '@@' markers are all missing).
So if you have a clean "diff -up" of your changes, please sent them in a
tarball to me or via a proper mail client / account that keeps emails
intact. Otherwise I would have to reconstruct all changes by hand...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

