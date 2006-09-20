Message-ID: <4511A253.9010009@domain.hid>
Date: Wed, 20 Sep 2006 15:19:31 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai v2.2.3
References: <1158564530.5020.5.camel@domain.hid>
	<450F1686.3010304@domain.hid>		<451068AD.6080000@domain.hid>
	<1158744278.5544.42.camel@domain.hid>		<451153D5.2080200@domain.hid>
	<1158768864.5043.31.camel@domain.hid>		<45118754.3000001@domain.hid>
	<1158777216.5043.46.camel@domain.hid> <45119E68.9050608@domain.hid>
In-Reply-To: <45119E68.9050608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jeff Webb wrote:
> Philippe Gerum wrote:
>>
>> cd /usr/xenomai/testsuite/latency
>> gdb latency
>> r
>> ...(SIGSEGV)...
>> bt
> 
> If I try to run gdb on it, it just hangs when I type the "r" command:
> 
> [root@domain.hid webb-ja]# cd /usr/xenomai/testsuite/latency/
> [root@domain.hid latency]# /sbin/modprobe xeno_native
> [root@domain.hid latency]# gdb latency
> GNU gdb Red Hat Linux (5.3.90-0.20030710.41rh)
> Copyright 2003 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you 
> are
> welcome to change it and/or distribute copies of it under certain 
> conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "i386-redhat-linux-gnu"...
> (no debugging symbols found)...Using host libthread_db library 
> "/lib/tls/libthread_db.so.1".
> (gdb) r
> Starting program: /usr/xenomai-2.2.3/testsuite/latency/latency
> (no debugging symbols found)...[Thread debugging using libthread_db 
> enabled]
> Error while reading shared library symbols:
> Cannot find new threads: generic error
> (no debugging symbols found)...
> (no debugging symbols found)...(no debugging symbols found)...

With one of my working xenomai kernels, the above steps seem to work, so maybe the above symptom is part of the bug.  My results for a working kernel are shown below:

-Jeff


[root@domain.hid webb-ja]# cd /usr/xenomai/testsuite/latency/
[root@domain.hid latency]# gdb latency
GNU gdb Red Hat Linux (5.3.90-0.20030710.41rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...
(no debugging symbols found)...Using host libthread_db library "/lib/libthread_db.so.1".

(gdb) r
Starting program: /usr/xenomai-2.2.3/testsuite/latency/latency
(no debugging symbols found)...[Thread debugging using libthread_db enabled]
[New Thread 16384 (LWP 5239)]
(no debugging symbols found)...
(no debugging symbols found)...(no debugging symbols found)...== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
[New Thread 32769 (LWP 5240)]
[New Thread 16386 (LWP 5241)]
warming up...
[New Thread 32771 (LWP 5242)]
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      -1.782|      -1.154|       4.307|       0|      -1.782|       4.307
RTD|      -1.933|      -1.158|       4.157|       0|      -1.933|       4.307
RTD|      -1.924|      -1.223|       4.497|       0|      -1.933|       4.497
RTD|      -2.014|      -1.206|       4.438|       0|      -2.014|       4.497

Program received signal SIGINT, Interrupt.
[Switching to Thread 32771 (LWP 5242)]
0x0804b555 in rt_task_wait_period ()
(gdb) bt
#0  0x0804b555 in rt_task_wait_period ()
#1  0x08049f7c in latency ()
#2  0x0804b233 in rt_task_trampoline ()
#3  0x48a3bdb2 in pthread_start_thread () from /lib/i686/libpthread.so.0
#4  0x48a3bf45 in pthread_start_thread_event () from /lib/i686/libpthread.so.0
#5  0x488a97fa in clone () from /lib/i686/libc.so.6
(gdb)



