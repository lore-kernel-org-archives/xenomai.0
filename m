Message-ID: <4EF37DF8.1060807@domain.hid>
Date: Thu, 22 Dec 2011 13:59:04 -0500
From: Andrew Tannenbaum <trb@domain.hid>
MIME-Version: 1.0
References: <4EF27CD5.4060603@domain.hid>	<4EF2FCD9.5010105@domain.hid>
	<CAKvQZ_323WScmgq748=rfnVwq534Ln56VMgb9hDt=R4O19=TLQ@mail.gmail.com>
	<4EF34E86.2020606@domain.hid>
In-Reply-To: <4EF34E86.2020606@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] hang in rtcansend
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles,

The virtual driver gives me the same hang problem.  It loaded fine:

Dec 22 12:04:18 atom1 kernel: [ 2457.833703] rtcan: registered rtcan2
Dec 22 12:04:18 atom1 kernel: [ 2457.833721] rtcan2: VIRT driver loaded
Dec 22 12:04:18 atom1 kernel: [ 2457.833775] rtcan: registered rtcan3
Dec 22 12:04:18 atom1 kernel: [ 2457.833789] rtcan3: VIRT driver loaded

All notes below operate on the virtual device rtcan2.

I get:

$ rtcansend rtcan2 -v -i 0x0 0x82 0x1
interface rtcan2
s=0, ifr_name=rtcan2
<0x000> [2] 82 01
Cleaning up...
^CSignal 2 received
Cleaning up...
$

So it's the same behavior - it hangs, I hit ^C, and it exits.

Here's what I get with gdb:

first on /usr/bin/rtcansend with no breakpoints:

$ gdb rtcansend
GNU gdb (GDB) 7.1-ubuntu
...
Reading symbols from /usr/bin/rtcansend...(no debugging symbols
found)...done.
(gdb) run rtcan2 -v -i 0x0 0x82 0x1
Starting program: /usr/bin/rtcansend rtcan2 -v -i 0x0 0x82 0x1
[Thread debugging using libthread_db enabled]
[New Thread 0xb7fdfb70 (LWP 1850)]
interface rtcan2
s=0, ifr_name=rtcan2
<0x000> [2] 82 01
Cleaning up...

And it hangs here and I can't ^C, though a kill -9 killed it.


Here's gdb with breakpoints on the suspect functions (here I cd into
src/utils/can/.libs):

(gdb) b rt_dev_close
Breakpoint 1 at 0x8048900
(gdb) b rt_task_delete
Breakpoint 2 at 0x8048960
(gdb) run rtcan2  -v -i 0x0 0x82 0x1
Starting program:
/home/imt/src/xenomai-2.5.5.2/src/utils/can/.libs/rtcansend rtcan2  -v
-i 0x0 0x82 0x1
[Thread debugging using libthread_db enabled]
[New Thread 0xb7fdfb70 (LWP 2326)]
interface rtcan2
s=0, ifr_name=rtcan2
<0x000> [2] 82 01
Cleaning up...

Breakpoint 1, 0xb7fc46f0 in rt_dev_close () from /usr/lib/librtdm.so.1
(gdb) c
Continuing.

Breakpoint 2, 0xb7fcbeb5 in rt_task_delete () from /usr/lib/libnative.so.3
(gdb) bt
#0  0xb7fcbeb5 in rt_task_delete () from /usr/lib/libnative.so.3
#1  0x08048d36 in cleanup () at rtcansend.c:65
#2  0x08049268 in main (argc=7, argv=0xbffff754) at rtcansend.c:303
(gdb) info threads
  2 Thread 0xb7fdfb70 (LWP 2326)  0xb7fe2424 in __kernel_vsyscall ()
* 1 Thread 0xb7e3e6d0 (LWP 2323)  0xb7fcbeb5 in rt_task_delete ()
   from /usr/lib/libnative.so.3
(gdb) thread 2
[Switching to thread 2 (Thread 0xb7fdfb70 (LWP 2326))]#0  0xb7fe2424 in
__kernel_vsyscall ()
(gdb) bt
#0  0xb7fe2424 in __kernel_vsyscall ()
#1  0xb7fb0736 in nanosleep () from /lib/tls/i686/cmov/libpthread.so.0
#2  0xb7fbe8de in ?? () from /usr/lib/libxenomai.so.0
#3  0xb7fa896e in start_thread () from /lib/tls/i686/cmov/libpthread.so.0
#4  0xb7f16a4e in clone () from /lib/tls/i686/cmov/libc.so.6
(gdb) c
Continuing.

And it hangs (before I kill -9).  I don't know the gdb commands to
investigate more deeply.  The rtcansend is a zombie at this point.

$ ps -ef (edited)
imt       2321  1227  0 13:51 pts/1    00:00:00 gdb rtcansend
imt       2323  2321  0 13:51 pts/1    00:00:00 [rtcansend-2323] <defunct>


Re "narrowing down" the problem, note in the
strace outputs in my post at the beginning
of the thread that I think it's hanging in
cleanup(), and the straces show that 2.5.5.2
calls exit_group(0) (and closes correctly)
where 2.6.0 calls _exit(0) (and hangs). I assume
that exit_group() is cleaning up threads where
_exit() is probably doing less cleanup work,
or none.  I'm curious about why one has
exit_group() and the other has _exit().


-Andy


On 12/22/2011 10:36 AM, Gilles Chanteperdrix wrote:
> On 12/22/2011 02:33 PM, Willy Lambert wrote:
>> 2011/12/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>> On 12/22/2011 01:41 AM, Andrew Tannenbaum wrote:
>>>> If I just run rtcansend with no args (so it prints a help message), it
>>>> exits ok on 2.6.0 with no hang.  But if I run rtcansend or rtcanrecv
>>>> with any CAN i/o, they hang in the cleanup function, though they do
>>>> their processing before then correctly.
>>>>
>>>> Any idea why rtcansend/recv would hang for me here on 2.6.0?
>>>
>>> Is this behaviour reproducible with the virtual rtcan driver?
>>>
>>>
>>
>> For your information, I have a similar behavior with the same Linux
>> 2.5.38.8 and Xenomai 2.6.0 config. As I did not used the CAN before I
>> didn't reported it.
> 
> Have you tried attaching gdb when rtcansend is locked to see where the
> bug happens?
> 


