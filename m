Message-ID: <4ACF417F.2020907@domain.hid>
Date: Fri, 09 Oct 2009 15:58:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0000AD00.4ACF580B@192.168.2.103>
In-Reply-To: <0000AD00.4ACF580B@192.168.2.103>
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

Hi Oliver,

oliver.schlenker@domain.hid wrote:
> I have done several changes in rt_print.c and rtdk.h to extend
> the functionality of rt-print lib as follows :
> - Fork save initialisation of the library by using pthread_atfork()
>   There are now two hooks integrated :
>     1. A prepare hook which is called to prepare the fork. This
>         hook clears all open print buffers
>     2. A child hook which is called after the fork on the child side.
>        This hook clears also all open print buffers (just ot be on the save side)
>        and is spawning another printer thread.
> 
> - Adding two addition functions
>     1. rt_syslog( int priority, char *format, ...)
>         which reports all messages to the syslog, using the print buffers of rtprint
>     2. rt_vsyslog( int priority, char *format, va_list args )
>         same as above for va_list arguments.
> 
> Both changes do run in my application as expected. It's now possible to use
> rt_print-lib in a daemonized process and rt_print output can be directed
> to syslog via rt_syslog/rt_vsyslog.

Thanks for the patch. I just have a few comments, see below.

> 
> 
> Oliver
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
                 ^^^
Stray whitespace.

> +void rt_vsyslog(int priority, char *format, va_list args);
> +
>  
>  int rt_print_init(size_t buffer_size, const char *name);
>  void rt_print_cleanup(void); 
> 
> 
> --- rt_print.c.original	2008-09-10 10:36:27.000000000 +0200
> +++ rt_print.c	2009-10-09 11:47:16.014443900 +0200
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
> +#define RT_PRINT_SYSLOG_STREAM	((FILE *)-9999)

Better use NULL here.

> +
>  struct entry_head {
>  	FILE *dest;
>  	uint32_t seq_no;
> +	int priority;
>  	char text[1];
>  } __attribute__((packed));
>  
>                    
>  
>  static void cleanup_buffer(struct print_buffer *buffer);
>  static void print_buffers(void);
> +static void rt_print_reinit_atfork_prepare(void);
> +static void rt_print_reinit_atfork_child(void);
>  
>  /* *** rt_print API *** */
>  
> -int rt_vfprintf(FILE *stream, const char *format, va_list args)
> +static int rt_print_to_buffer(FILE *stream, int priority, const char *format, va_list args)

Line with >80 characters.

>  {
>  	struct print_buffer *buffer = pthread_getspecific(__buffer_key);
>  	off_t write_pos, read_pos;
>                    
>  			/* Write out empty entry */
>  			head = buffer->ring + write_pos;
>  			head->seq_no = __seq_no;
> +			head->priority = 0;
>  			head->text[0] = 0;
>  
>  			/* Forward to the ring buffer start */
>                    
>  	/* If we were able to write some text, finalise the entry */
>  	if (len > 0) {
>  		head->seq_no = ++__seq_no;
> +		head->priority = priority;
>  		head->dest = stream;
>  
>  		/* Move forward by text and head length */
>                    
>  		/* An empty entry marks the wrap-around */
>  		head = buffer->ring + write_pos;
>  		head->seq_no = __seq_no;
> +		head->priority = priority;
>  		head->text[0] = 0;
>  
>  		write_pos = 0;
>                     
>  	return res;
>  }
>  
> +int rt_vfprintf(FILE *stream, const char *format, va_list args)
> +{
> +	return rt_print_to_buffer( stream, 0, format, args);

Stray whitespace.

> +}
> +
>  int rt_vprintf(const char *format, va_list args)
>  {
>  	return rt_vfprintf(stdout, format, args);
>                     
>  	return n;
>  }
>  
> +void rt_syslog(int priority, char *format, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, format);
> +	rt_print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
> +	va_end(args);
> +
> +	return;
> +}
> +
> +void rt_vsyslog(int priority, char *format, va_list args )

Whitespace.

> +{
> +
> +	rt_print_to_buffer(RT_PRINT_SYSLOG_STREAM, priority, format, args);
> +
> +	return;
> +}
> +
>  static void set_buffer_name(struct print_buffer *buffer, const char *name)
>  {
>  	int n;
>                     
>  
>  		if (len) {
>  			/* Print out non-empty entry and proceed */
> -			fprintf(head->dest, "%s", head->text);
> +			/* Check if output goes to syslog */
> +			if (head->dest == RT_PRINT_SYSLOG_STREAM) {
> +			   	syslog( head->priority, "%s", head->text );

Stray whitespaces. And one /may/ argue that we do not need braces here,
but that's a grey area.

> +			} else {
> +				/* Output goes to specified stream */
> +				fprintf(head->dest, "%s", head->text);
> +			}
> +
>  			read_pos += sizeof(*head) + len;
>  		} else {
>  			/* Emptry entries mark the wrap-around */
>                     
>  	}
>  }
>  
> +static void rt_print_reinit_atfork_child(void)
> +{
> +	pthread_attr_t thattr;
> +	struct print_buffer *buffer,*next_b;
> +
> +	/* Clean parent process buffer list -
> +	   Shouldn't be necessary because also done at atfork_parent
> +	*/
> +	buffer = __first_buffer;
> +	while (buffer) {
> +		next_b = buffer->next;
> +		cleanup_buffer(buffer);
> +		buffer = next_b;
> +	}
> +
> +	/* Throw new thread with printer loop in child process */
> +	pthread_attr_init(&thattr);
> +	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
> +	pthread_create(&__printer_thread, &thattr, printer_loop, NULL);
> +	pthread_atfork(rt_print_reinit_atfork_prepare,NULL,rt_print_reinit_atfork_child);
> +}

Here is my version:

static void spawn_printer_thread(void)
{
	pthread_attr_t thattr;

	pthread_attr_init(&thattr);
	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
}

static void forked_child_init(void)
{
	struct print_buffer *my_buffer = pthread_getspecific(buffer_key);
	struct print_buffer **pbuffer = &first_buffer;

	/* re-init to avoid finding it locked by some parent thread */
	pthread_mutex_init(&buffer_lock, NULL);

	while (*pbuffer) {
		if (*pbuffer == my_buffer)
			pbuffer = &(*pbuffer)->next;
		else
			cleanup_buffer(*pbuffer);
	}

	spawn_printer_thread();
}

The major differences are:
 - my code is totally untested :)
 - we have to play safe and re-init the mutex
 - we should not purge a potentially existing buffer of the main thread
 - I don't think we have to re-install the fork hook for the child (the
   parent's installation should survive the fork)

and...

> +
> +static void rt_print_reinit_atfork_prepare(void)
> +{
> +	struct print_buffer *buffer,*next_b;
> +
> +	/* Clean parent process buffer list */
> +	buffer = __first_buffer;
> +	while (buffer) {
> +		next_b = buffer->next;
> +		cleanup_buffer(buffer);
> +		buffer = next_b;
> +	}
> +}
> +

 - we must not destroy the father's environment

>  void __rt_print_init(void)
>  {
>  	pthread_attr_t thattr;
>                    
>  	pthread_attr_init(&thattr);
>  	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
>  	pthread_create(&__printer_thread, &thattr, printer_loop, NULL);
> +	pthread_atfork(rt_print_reinit_atfork_prepare,NULL,rt_print_reinit_atfork_child);
>  } 
> 

Besides that, nice patch!

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

