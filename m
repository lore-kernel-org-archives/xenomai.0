Message-ID: <4ACCB60C.2040007@domain.hid>
Date: Wed, 07 Oct 2009 17:38:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DIIE.000001A50000AC82@domain.hid>
In-Reply-To: <DIIE.000001A50000AC82@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re-8:  rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: oliver.schlenker@domain.hid
Cc: xenomai@xenomai.org

oliver.schlenker@domain.hid wrote:
> 
> 
> As you expected, changing the syslog call from
>     syslog( LOG_ERR | LOG_LOCAL4, head->text ); 
> to
>     syslog( LOG_ERR | LOG_LOCAL4, "%s", head->text ); 
> 
> did not change anything.
> 
> To track down the problem further, I have made a small test application :
> 
> #include <stdlib.h>
> #include <stdio.h>
> 
> #include <native/task.h>
> #include <native/timer.h>
> #include <rtdk.h>
> 
> 
> int main( int arc, char *argv[] )
> {
> int i;
> 
> rt_print_auto_init(1);
> 
> rt_printf("--------------- TEST RT-PRINTF  1 ------------\n");
> 
> 	sleep(1);
> 
> daemon(0,0);
> 
> 	rt_print_auto_init(1);
> 
> 	rt_printf("--------------- TEST RT-PRINTF  2 ------------\n");
> 
> 	sleep(10);
> 
> return(0);
> }
> 
> 
> 
> This application gives the following results :
> - If the daemon() function is not called, all rt_printf() do work well
>   and output is shown in syslog
> - If daemon() function is called, and first call to sleep(1) is omitted,
>   there is no output in the syslog whatsoever.
> - If daemon() function is called, and first call to sleep(1) is executed,
>   there is output of the first rt_printf in the syslog but not of the second
>   one.
> 
> I do not have any idea why daemonizing of the process is not giving
> any output to the syslog.

As you are already looking at rt_printf.c: __rt_print_init spawns a
pthread that polls the internal queues and issues the output to stdout
or whatever. On fork (or daemonize), this thread is not replicated. So
the child process simply has no printing thread.

I think this should be fixable with a pthread_atfork hook, patches
always welcome.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

