Message-ID: <4FF04C54.5040904@xenomai.org>
Date: Sun, 01 Jul 2012 15:10:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <009c01cd539e$e9f81420$bde83c60$@com>	<4FE9BDA9.3000209@xenomai.org>	<013901cd547a$50179b00$f046d100$@com>
	<4FEB32B2.6080700@xenomai.org>
In-Reply-To: <4FEB32B2.6080700@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM, exception #0 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <GPontis@z9.com>
Cc: xenomai@xenomai.org

On 06/27/2012 06:20 PM, Gilles Chanteperdrix wrote:
> On 06/27/2012 05:34 PM, George Pontis wrote:
>>
>>> On 06/26/2012 03:23 PM, George Pontis wrote:
>>>> Running Xenomai 2.6.0 on an ARM at91sam9g45. I recently updated
>>>> from
>>> Adeos
>>>> patch adeos-ipipe-3.0.13-arm-1.18-05 to
>>>> adeos-ipipe-3.0.13-arm-1.18-
>>> 09. Then
>>>> built a new kernel and gave it to the application developers for
>>>> a
>>> test.
>>>> There were other changes in the root FS and a few tweaks in the
>>> kernel, but
>>>> none that looked (to me) like they would affect Xenomai. They
>>>> report
>>> this
>>>> new error:
>>>>
>>>>> Xenomai: Switching ADC Task to secondary mode after exception
>>>>> #0
>>> from
>>>>> user-space at 0xffff0fbc (pid 723)
>>>>
>>>> And then nothing about the app works any more. What does this
>>>> mean ?
>>>
>>> It means there is a fault, when the PC is around 0xffff0fbc, that
>>> is in the tsc emulation kernel helper. Could you try reverting this
>>> commit ?
>>>
>>
>> I tried reverting to adeos-ipipe-3.0.13-arm-1.18-05 without any other
>> changes, and this error still occurs. The address of the exception is
>> exactly the same. So I did some experiments to try to narrow this
>> down. First thing, it does not happen with any Xenomai user app. I
>> wrote a different app some time ago that runs without error on all
>> the Xenomai-enabled kernels.
>>
>> I also went back to a previous kernel where this app runs without
>> causing the error. That kernel was the same 3.0.13 with
>> adeos-ipipe-3.0.13-arm-1.18-05.patch and the same Xenomai 2.6.0. The
>> root FS was identical. Everything was built with the same GCC 4.5.3.
>> What was different about it were some other features that were
>> enabled or disabled in the kernel. Possibly it is one or more of
>> these changes that is aggravating the problem with this one app:
>>
>> 1) Turned off JFFS2, IDE 2) Turned on ext4 support 3) Enabled Atmel
>> FB and SPI-based touchscreen controller 4) Disabled shmem 5) Disabled
>> UID16 and "sysctl syscall"
>>
>> Do any of these seem like they could be a factor ? I should emphasize
>> that we are still pretty new to Xenomai. It is more likely that we
>> have made a mistake in the app than that there is a Xenomai bug that
>> nobody else has caught yet. Any suggestions where to go next to get
>> to the bottom of this ?
> 
> Try enabling CONFIG_DEBUG_USER, and adding user_debug=29 to the boot
> arguments. This way, you will get a kernel trace when the fault happens
> giving you more details (registers values and binary code). It would
> also help if you could send me your vmlinux.
> 

Contrarily to what I said, 0xffff0fbc is not the tsc emulation code. On 
the kernel I run, it is a nop in the middle of the 
__kuser_memory_barrier helper.

In order to verify what is there, you can try debugging a test program, 
and typing in gdb:

disass 0xffff0fa0,+0x20

I get:
   0xffff0fa0:  mov     pc, lr
   0xffff0fa4:  nop                     ; (mov r0, r0)
   0xffff0fa8:  nop                     ; (mov r0, r0)
   0xffff0fac:  nop                     ; (mov r0, r0)
   0xffff0fb0:  nop                     ; (mov r0, r0)
   0xffff0fb4:  nop                     ; (mov r0, r0)
   0xffff0fb8:  nop                     ; (mov r0, r0)
   0xffff0fbc:  nop                     ; (mov r0, r0)

I ran the following example, compiled to use xenomai posix skin:

#include <sched.h>
#include <pthread.h>
#include <sys/mman.h>

int main(void)
{
	struct sched_param sp;

	mlockall(MCL_CURRENT | MCL_FUTURE);

	sp.sched_priority = 1;
	pthread_setschedparam(pthread_self(), SCHED_FIFO, &sp);

	*(unsigned *)0 = 0;
}

On a kernel with the user_debug=29 parameter, you should see the 
following messages on the kernel console:

# test_fault                                                                     
Xenomai: Switching test_fault to secondary mode after exception #0 from user-space at 0x8794 (pid 922)                                                            
fcse pid: 89, 0xb2000000                                                         
pgd = c3a68000                                                                   
[00000000] *pgd=23ad5831, *pte=00000000, *ppte=00000000                          
                                                                                 
Pid: 922, comm:           test_fault                                             
CPU: 0    Not tainted  (3.2.21 #2)                                               
PC is at 0x8798                                                                  
LR is at 0x5008                                                                  
pc : [<00008798>]    lr : [<00005008>]    psr: 60000010                          
sp : 01e2ed38  ip : 00000000  fp : 00000000                                      
r10: 00b11b60  r9 : 00000000  r8 : 00000000                                      
r7 : 00000000  r6 : 00000000  r5 : 00000001  r4 : 01e2ed3c                       
r3 : 00000000  r2 : 00000001  r1 : 00832000  r0 : 00000000                       
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user               
Control: 0005317f  Table: 23a68000  DAC: 00000015                                
Backtrace:                                                                       
[<c000ca54>] (dump_backtrace+0x0/0x114) from [<c0285058>] (dump_stack+0x18/0x1c) 
 r6:0000000b r5:00000000 r4:c3ad7fb0 r3:60000013                                 
[<c0285040>] (dump_stack+0x0/0x1c) from [<c000acb4>] (show_regs+0x44/0x50)       
[<c000ac70>] (show_regs+0x0/0x50) from [<c0010130>] (__do_user_fault+0x60/0xb8)  
 r4:c3825340 r3:60000013                                                         
[<c00100d0>] (__do_user_fault+0x0/0xb8) from [<c001042c>] (do_page_fault+0x218/0x
24c)                                                                             
 r8:c3a39600 r7:00000000 r6:00010000 r5:c3825340 r4:c3ad7fb0                     
[<c0010214>] (do_page_fault+0x0/0x24c) from [<c0008718>] (do_DataAbort+0x4c/0xf8)
[<c00086cc>] (do_DataAbort+0x0/0xf8) from [<c00092e0>] (__dabt_usr+0x40/0x60)    
Exception stack(0xc3ad7fb0 to 0xc3ad7ff8)                                        
7fa0:                                     00000000 00832000 00000001 00000000    
7fc0: 01e2ed3c 00000001 00000000 00000000 00000000 00000000 00b11b60 00000000    
7fe0: 00000000 01e2ed38 00005008 00008798 60000010 ffffffff                      
 r8:00000000 r7:00000000 r6:ffffffff r5:60000010 r4:00008798                     
mappings:                                                                        
0x00008000-0x00009000 r-xp 0x00000000 /usr/bin/test_fault <- PC                  
0x00010000-0x00011000 rwxp 0x00000000 /usr/bin/test_fault                        
0x00011000-0x00032000 rwxp 0x00011000 [heap]                                     
0x00832000-0x00833000 rwxp 0x00832000                                            
0x0085e000-0x00864000 r-xp 0x00000000 /usr/lib/libxenomai.so.0.0.0               
0x00864000-0x0086b000 ---p 0x00006000 /usr/lib/libxenomai.so.0.0.0               
0x0086b000-0x0086c000 rwxp 0x00005000 /usr/lib/libxenomai.so.0.0.0               
0x0086c000-0x00877000 r-xp 0x00000000 /lib/libgcc_s.so.1                         
0x00877000-0x0087f000 ---p 0x0000b000 /lib/libgcc_s.so.1                         
0x0087f000-0x00880000 rwxp 0x0000b000 /lib/libgcc_s.so.1                         
0x00893000-0x00894000 ---p 0x00893000                                            
0x00894000-0x0089b000 rwxp 0x00894000                                            
0x008a4000-0x008a5000 rwxp 0x008a4000                                            
0x008ba000-0x008bb000 rwxp 0x008ba000                                            
0x008c6000-0x008e4000 r-xp 0x00000000 /lib/ld-linux.so.3                         
0x008eb000-0x008ec000 r-xp 0x0001d000 /lib/ld-linux.so.3                         
0x008ec000-0x008ed000 rwxp 0x0001e000 /lib/ld-linux.so.3                         
0x008ed000-0x00902000 r-xp 0x00000000 /lib/libpthread.so.0                       
0x00902000-0x00909000 ---p 0x00015000 /lib/libpthread.so.0                       
0x00909000-0x0090a000 r-xp 0x00014000 /lib/libpthread.so.0                       
0x0090a000-0x0090b000 rwxp 0x00015000 /lib/libpthread.so.0                       
0x0090b000-0x0090d000 rwxp 0x0090b000                                            
0x0096e000-0x0096f000 r-xs 0xc4808000 /dev/rtheap                                
0x009a4000-0x009ab000 r-xp 0x00000000 /lib/librt.so.1                            
0x009ab000-0x009b2000 ---p 0x00007000 /lib/librt.so.1                            
0x009b2000-0x009b3000 r-xp 0x00006000 /lib/librt.so.1                            
0x009b3000-0x009b4000 rwxp 0x00007000 /lib/librt.so.1                            
0x009b7000-0x009c1000 r-xp 0x00000000 /usr/lib/libpthread_rt.so.1.0.0            
0x009c1000-0x009c8000 ---p 0x0000a000 /usr/lib/libpthread_rt.so.1.0.0            
0x009c8000-0x009c9000 rwxp 0x00009000 /usr/lib/libpthread_rt.so.1.0.0            
0x009c9000-0x00b07000 r-xp 0x00000000 /lib/libc.so.6                             
0x00b07000-0x00b0e000 ---p 0x0013e000 /lib/libc.so.6                             
0x00b0e000-0x00b10000 r-xp 0x0013d000 /lib/libc.so.6                             
0x00b10000-0x00b11000 rwxp 0x0013f000 /lib/libc.so.6                             
0x00b11000-0x00b14000 rwxp 0x00b11000                                            
0x00b14000-0x00b15000 r-xs 0xfff7c000 /dev/mem                                   
0x00b31000-0x00b34000 rwxs 0xc4865000 /dev/rtheap                                
0x00b35000-0x00b38000 rwxs 0xc4804000 /dev/rtheap                                
0x01e0d000-0x01e2f000 rw-p 0x01fde000 [stack] <- SP                              
0xffff0000-0xffff1000 r-xp 0xffff0000 [vectors]                                  
Segmentation fault                                                               

You will get the line starting with "fcse" only if you have
CONFIG_ARM_FCSE enabled.
And the lines describing the memory mappings only if you have
CONFIG_ARM_FCSE_MESSAGES.

-- 
                                                                Gilles.

