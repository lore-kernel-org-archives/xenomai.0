Message-ID: <453FCC87.80409@domain.hid>
Date: Wed, 25 Oct 2006 15:43:51 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
References: <450B2BE1.1050105@domain.hid>	
	<20060916042719.M57867@domain.hid>	<450F0451.8070102@domain.hid>
	<1158614598.5009.71.camel@domain.hid>
	<453FC279.8040608@domain.hid> <453FC819.9020900@domain.hid>
In-Reply-To: <453FC819.9020900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Jan Kiszka wrote:
> Jeff Webb wrote:
>> If I run the attached program, I get the following result:
>>
>>  [root]# ./mqtest2
>>  CPU time limit exceeded
>>
>> The kernel log contains:
>>
>>  Oct 25 14:13:03 kernel: invalid use of FPU in Xenomai context at 0x80492f6
> 
> Can you do a backtrace in gdb?
> 

# gdb ./mqtest2
GNU gdb Red Hat Linux (6.3.0.0-1.122rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host libthread_db library "/lib/libthread_db.so.1".

(gdb) r
Starting program: mqtest2
Reading symbols from shared object read from target memory...done.
Loaded system supplied DSO at 0xffffe000
[Thread debugging using libthread_db enabled]
[New Thread -1208785216 (LWP 3484)]
[New Thread -1208788064 (LWP 3487)]
received message: count: 1 0.000000

Program received signal SIGXCPU, CPU time limit exceeded.
[Switching to Thread -1208788064 (LWP 3487)]
rt_loop (arg=0x0) at mqtest2.c:74
74              f = f + 0.1*count;
(gdb) bt
#0  rt_loop (arg=0x0) at mqtest2.c:74
#1  0xb7f53545 in __pthread_trampoline ()
   from /usr/xenomai/lib/libpthread_rt.so.0
#2  0x0092940b in start_thread () from /lib/libpthread.so.0
#3  0x00757b7e in clone () from /lib/libc.so.6
(gdb)


