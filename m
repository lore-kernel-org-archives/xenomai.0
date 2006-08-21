Message-ID: <44E9663C.2030904@domain.hid>
Date: Mon, 21 Aug 2006 01:52:28 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: xeno-load: line 182: 2794 Floating
	point	exception$suflag $* $cmdargs
References: <44E91231.8070403@domain.hid> <44E955E0.40009@domain.hid>
	<1156143410.4723.4.camel@domain.hid>
In-Reply-To: <1156143410.4723.4.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

got a backtrace

Philippe Gerum wrote:
> On Mon, 2006-08-21 at 00:42 -0600, Jim Cromie wrote:
>   
>> Jim Cromie wrote:
>>     
>>> *
>>> == Sampling period: 10 us
>>> == Do not interrupt this program
>>> /usr/xenomai/bin/xeno-load: line 182:  2868 Floating point 
>>> exception$suflag $* $cmdargs
>>>
>>>       
>> soekris:/usr/xenomai/bin# gdb ../testsuite/switchbench/switchbench
>> I tried stuffing -g into all *_CFLAGS in src/testsuite/Makefile,
>> but I couldnt get it to show up in the compilation.
>>
>>     
>
> Try passing --enable-debug to the "configure" script.
>
>   
#0  0x0804ae57 in __divdi3 ()
#1  0x08049ac2 in worker (cookie=0x0) at switchbench.c:133
#2  0x0804a18f in rt_task_trampoline (cookie=0x0) at task.c:89
#3  0xb7f8107d in start_thread () from /lib/tls/libpthread.so.0
#4  0xb7f158fe in clone () from /lib/tls/libc.so.6
(gdb)


Ill look deeper later, if its not obvious to the experts

