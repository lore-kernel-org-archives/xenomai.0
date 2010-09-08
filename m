Message-ID: <4C8713A2.9010705@domain.hid>
Date: Tue, 07 Sep 2010 21:40:02 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C8605E6.4000400@domain.hid> <4C862A3B.2050300@domain.hid>
In-Reply-To: <4C862A3B.2050300@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How do I force a core dump on a page fault event?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

  Comments inline...

On 9/7/2010 5:04 AM, Gilles Chanteperdrix wrote:
> Bob Feretich wrote:
>>    I am seeing various Oops reports referencing my rt user task, but they
>> don't provide any useful information regarding my program's state at the
>> time of the Oops.
>>
>> The most common Oops is...
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
>> ... snipped...
> This tells us that a bug happens in kernel-space for some reason, while
> trying to handle a user-space fault.
>
> Do you have a simple piece of code which I can run to reproduce this issue?
>
No. This problem started occurring when I integrated the whole system 
together. I'm going to have to work on it a bit to reduce it to a 
suitable code segment .
The Xenomai content of the loop is:
while (!end) {
     ...
     rc = rt_event_wait(&event1,..);
     ...
     rc = rt_event_clear(&event1,..);
     ...
     rc = rt_event_wait(&event2,..);
     ...
     rc = rt_event_clear(&event2,..);
     ...
     rc = rt_event_wait(&event3, TM_NONBLOC, ...);
     if (rc==0) end = 1;
}

I changed the way my system of programs worked and replaced the first 
two rt_event_wait()s with ioctls, which execute rtdm_event_wait()s.  
This fix seemed to work around the problem. Initial testing show no Oopses.

>> Another is...
>> Unable to handle kernel paging request at virtual address 70000049
>> pgd = cf034000
>> [70000049] *pgd=00000000
>> Internal error: Oops: 805 [#1]
>> last sysfs file: /sys/devices/virtual/gpio/gpio7/value
>> Modules linked in: rtservo_driver rtasuspidvr
>> CPU: 0    Not tainted  (2.6.33 #10)
>> PC is at 0x40038998
>> LR is at 0x40038984
>> pc : [<40038998>]    lr : [<40038984>]    psr: 60000113
>> sp : cf0f3ff8  ip : 00000000  fp : 00000001
>> r10: 40242c3c  r9 : 00000000  r8 : 40242c40
>> r7 : 000f0042  r6 : 40242c40  r5 : 402434b0  r4 : 00000000
>> r3 : 00000a64  r2 : 70000049  r1 : ffffffab  r0 : 00000000
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> Control: 10c5387d  Table: 8f034019  DAC: 00000015
>> Process navigator (pid: 646, stack limit = 0xcf0f22e8)
>> Stack: (0xcf0f3ff8 to 0xcf0f4000)
>> 3fe0:                                                       00000000
>> 00000000
>> Code: 0affffe9 e3500000 059d3014 059d2008 (05823000)
>> ---[ end trace 6d46aff735536a73 ]---
> This is the real user-space fault. Happening at pc 0x40038998 which
> corresponds to an address in your process. However, the stack pointer is
> invalid here. So, the most probablie reason for such fault is that you
> overwrote some piece of stack, which caused the return from a function
> to try and use cf0f3ff8 as a stack address, causing the fault.
0x40038998 is somewhere in /usr/xenomai/lib/native.so.3.0.0. A load map 
that I captured from one small iteration after the above Oops showed the 
executable section of native.so starting at 0x40035000.

I have a deadline in a few days, then some travel, so I can't dig 
further into the rt_event Oopses for two weeks.

Regards,
Bob Feretich

