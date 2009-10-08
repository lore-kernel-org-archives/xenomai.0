Message-ID: <4ACDEA32.70502@domain.hid>
Date: Thu, 08 Oct 2009 15:33:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0000ACDD.4ACE037F@192.168.2.103>
In-Reply-To: <0000ACDD.4ACE037F@192.168.2.103>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Re : rt_printf with daemonized task
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
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

oliver.schlenker@domain.hid wrote:
> Did change my test code in the meantime to :
> 
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
> daemon(0,1);
> 
> __rt_print_init();
> 
> rt_print_auto_init(1);
> 
> rt_printf("--------------- TEST RT-PRINTF ------------\n");
> 
> sleep(10);
> 
> return(0);
> }
> 
> 
> and everything works fine at first glance.
> 
> There is at least an output to syslog of the rt_printf message. I have
> no idea if this creates an internal memory leak. For my application
> it might be not a real problem, because the fork is done only once.
> For application with several fork calls or a recursional fork calls it might be
> not ok.

Calling fork inside an application which has several running threads is
already insane. Think about it: if the running threads had a mutex
locked, the mutex will still appear as locked in the child process and
can not be unlocked. The threads will not exist in the child process,
but their stacks and allocated tsd will still exists. posix proposes
pthread_atfork to solve these issues, but not forking in a process with
threads is more sane (the exception being to call fork+exec or
vfork+exec, since in that case the virtual memory space will be wiped
out by exec, so we do not care about the leaks anyway).

-- 
                                          Gilles


