Message-ID: <4ADC7116.4050008@domain.hid>
Date: Mon, 19 Oct 2009 16:00:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000AE44.4ADC8261@domain.hid>
In-Reply-To: <0000AE44.4ADC8261@domain.hid>
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
> 
> 
> 
> 
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
> ... and the next patch for a syslog enabled rt_print.
> 
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
> 
> 
> --- rtdk.h.original	2007-12-09 11:46:36.000000000 +0100
> +++ rtdk.h	2009-10-09 11:46:52.767271100 +0200
>                  
>  int rt_vprintf(const char *format, va_list args);
>  int rt_fprintf(FILE *stream, const char *format, ...);
>  int rt_printf(const char *format, ...);
> +void rt_syslog( int priority, char *format, ...);

Stray space.

> +void rt_vsyslog(int priority, char *format, va_list args);
> +
>  
>  int rt_print_init(size_t buffer_size, const char *name);
>  void rt_print_cleanup(void); 
> 
> 
> 
> --- rt_print.c.forkonly	2009-10-16 16:19:25.949289800 +0200
> +++ rt_print.c.wsyslog	2009-10-16 16:31:01.952464300 +0200
>                  
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <syslog.h>
>  
>  #include <rtdk.h>
>  #include <asm/xenomai/system.h>
>                   
>  
>  #define RT_PRINT_LINE_BREAK		256
>  
> +#define RT_PRINT_SYSLOG_STREAM	NULL
> +
>  struct entry_head {
>  	FILE *dest;
>  	uint32_t seq_no;
> +	int priority;
>  	char text[1];
>  } __attribute__((packed));
>  
>                     
>  static pthread_key_t __buffer_key;
>  static pthread_t __printer_thread;
>  
> +static int print_to_buffer(FILE *stream, int priority,
> +                           const char *format,va_list args);

If you move the definition of print_to_buffer right below this prototype
block, you would avoid having to add this prototype and you would have
likely generated a more reviewable patch. The large code movement below
is very hard to check regarding correctness as I do not see the actually
modified lines.

>  static void cleanup_buffer(struct print_buffer *buffer);
>  static void print_buffers(void);
> +static void forked_child_init(void);

Stray prototype.

>  
>  /* *** rt_print API *** */
>  
>  int rt_vfprintf(FILE *stream, const char *format, va_list args)
>  {
> -	struct print_buffer *buffer = pthread_getspecific(__buffer_key);
> -	off_t write_pos, read_pos;
> -	struct entry_head *head;
> -	int len;
> -	int res;
> -
> -	if (!buffer) {
> -		res = 0;
> -		if (__auto_init)
> -			res = rt_print_init(0, NULL);
> -		else
> -			res = EIO;
> -
> -		if (res) {
> -			errno = res;
> -			return -1;
> -		}
> -		buffer = pthread_getspecific(__buffer_key);
> -	}
> -
> -	/* Take a snapshot of the ring buffer state */
> -	write_pos = buffer->write_pos;
> -	read_pos = buffer->read_pos;
> -	xnarch_read_memory_barrier();
> -
> -	/* Is our write limit the end of the ring buffer? */
> -	if (write_pos >= read_pos) {
> -		/* Keep a savety margin to the end for at least an empty entry */
> -		len = buffer->size - write_pos - sizeof(struct entry_head);
> -
> -		/* Special case: We were stuck at the end of the ring buffer
> -		   with space left there only for one empty entry. Now
> -		   read_pos was moved forward and we can wrap around. */
> -		if (len == 0 && read_pos > sizeof(struct entry_head)) {
> -			/* Write out empty entry */
> -			head = buffer->ring + write_pos;
> -			head->seq_no = __seq_no;
> -			head->text[0] = 0;
> -
> -			/* Forward to the ring buffer start */
> -			write_pos = 0;
> -			len = read_pos - 1;
> -		}
> -	} else {
> -		/* Our limit is the read_pos ahead of our write_pos. One byte
> -		   margin is required to detect a full ring. */
> -		len = read_pos - write_pos - 1;
> -	}
> -
> -	/* Account for head length */
> -	len -= sizeof(struct entry_head);
> -	if (len < 0)
> -		len = 0;
> -
> -	head = buffer->ring + write_pos;
> -
> -	res = vsnprintf(head->text, len, format, args);
> -
> -	if (res < len) {
> -		/* Text was written completely, res contains its length */
> -		len = res;
> -	} else {
> -		/* Text was truncated, remove closing \0 that entry_head
> -		   already includes */
> -		len--;
> -	}
> -
> -	/* If we were able to write some text, finalise the entry */
> -	if (len > 0) {
> -		head->seq_no = ++__seq_no;
> -		head->dest = stream;
> -
> -		/* Move forward by text and head length */
> -		write_pos += len + sizeof(struct entry_head);
> -	}
> -
> -	/* Wrap around early if there is more space on the other side */
> -	if (write_pos >= buffer->size - RT_PRINT_LINE_BREAK &&
> -	    read_pos <= write_pos && read_pos > buffer->size - write_pos) {
> -		/* An empty entry marks the wrap-around */
> -		head = buffer->ring + write_pos;
> -		head->seq_no = __seq_no;
> -		head->text[0] = 0;
> -
> -		write_pos = 0;
> -	}
> -
> -	/* All entry data must be written before we can update write_pos */
> -	xnarch_write_memory_barrier();
> -
> -	buffer->write_pos = write_pos;
> -
> -	return res;
> +	return print_to_buffer(stream, 0, format, args);
>  }
>  
>  int rt_vprintf(const char *format, va_list args)
>                     
>  	return n;
>  }
>  
> +void rt_syslog(int priority, char *format, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, format);
> +	print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
> +	va_end(args);
> +
> +	return;

Unneeded return.

> +}
> +
> +void rt_vsyslog(int priority, char *format, va_list args )
> +{
> +	print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
> +
> +	return;

Here too.

> +}
> +
>  static void set_buffer_name(struct print_buffer *buffer, const char *name)
>  {
>  	int n;
>                      
>  
>  /* *** Deferred Output Management *** */
>  
> +static int print_to_buffer(FILE *stream, int priority,
> +							const char *format,va_list args)

When moving this function, please also indent this properly and take
care for a space after the ','.

> +{
> +	struct print_buffer *buffer = pthread_getspecific(__buffer_key);
> +	off_t write_pos, read_pos;
> +	struct entry_head *head;
> +	int len;
> +	int res;
> +
> +	if (!buffer) {
> +		res = 0;
> +		if (__auto_init)
> +			res = rt_print_init(0, NULL);
> +		else
> +			res = EIO;
> +
> +		if (res) {
> +			errno = res;
> +			return -1;
> +		}
> +		buffer = pthread_getspecific(__buffer_key);
> +	}
> +
> +	/* Take a snapshot of the ring buffer state */
> +	write_pos = buffer->write_pos;
> +	read_pos = buffer->read_pos;
> +	xnarch_read_memory_barrier();
> +
> +	/* Is our write limit the end of the ring buffer? */
> +	if (write_pos >= read_pos) {
> +		/* Keep a savety margin to the end for at least an empty entry */
> +		len = buffer->size - write_pos - sizeof(struct entry_head);
> +
> +		/* Special case: We were stuck at the end of the ring buffer
> +		   with space left there only for one empty entry. Now
> +		   read_pos was moved forward and we can wrap around. */
> +		if (len == 0 && read_pos > sizeof(struct entry_head)) {
> +			/* Write out empty entry */
> +			head = buffer->ring + write_pos;
> +			head->seq_no = __seq_no;
> +			head->priority = 0;
> +			head->text[0] = 0;
> +
> +			/* Forward to the ring buffer start */
> +			write_pos = 0;
> +			len = read_pos - 1;
> +		}
> +	} else {
> +		/* Our limit is the read_pos ahead of our write_pos. One byte
> +		   margin is required to detect a full ring. */
> +		len = read_pos - write_pos - 1;
> +	}
> +
> +	/* Account for head length */
> +	len -= sizeof(struct entry_head);
> +	if (len < 0)
> +		len = 0;
> +
> +	head = buffer->ring + write_pos;
> +
> +	res = vsnprintf(head->text, len, format, args);
> +
> +	if (res < len) {
> +		/* Text was written completely, res contains its length */
> +		len = res;
> +	} else {
> +		/* Text was truncated, remove closing \0 that entry_head
> +		   already includes */
> +		len--;
> +	}
> +
> +	/* If we were able to write some text, finalise the entry */
> +	if (len > 0) {
> +		head->seq_no = ++__seq_no;
> +		head->priority = priority;
> +		head->dest = stream;
> +
> +		/* Move forward by text and head length */
> +		write_pos += len + sizeof(struct entry_head);
> +	}
> +
> +	/* Wrap around early if there is more space on the other side */
> +	if (write_pos >= buffer->size - RT_PRINT_LINE_BREAK &&
> +	    read_pos <= write_pos && read_pos > buffer->size - write_pos) {
> +		/* An empty entry marks the wrap-around */
> +		head = buffer->ring + write_pos;
> +		head->seq_no = __seq_no;
> +		head->priority = priority;
> +		head->text[0] = 0;
> +
> +		write_pos = 0;
> +	}
> +
> +	/* All entry data must be written before we can update write_pos */
> +	xnarch_write_memory_barrier();
> +
> +	buffer->write_pos = write_pos;
> +
> +	return res;
> +}
> +
>  static void cleanup_buffer(struct print_buffer *buffer)
>  {
>  	struct print_buffer *prev, *next;
>                     
>  
>  		if (len) {
>  			/* Print out non-empty entry and proceed */
> -			fprintf(head->dest, "%s", head->text);
> +			/* Check if output goes to syslog */
> +			if (head->dest == RT_PRINT_SYSLOG_STREAM) {
> +			   	syslog( head->priority, "%s", head->text );
> +			} else {
> +				/* Output goes to specified stream */
> +				fprintf(head->dest, "%s", head->text);
> +			}
> +
>  			read_pos += sizeof(*head) + len;
>  		} else {
>  			/* Emptry entries mark the wrap-around */ 
> 
> 
> 

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

