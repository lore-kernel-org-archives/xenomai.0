Message-ID: <4DA4544F.7020300@domain.hid>
Date: Tue, 12 Apr 2011 15:31:59 +0200
From: Jesper Christensen <jbc@domain.hid>
MIME-Version: 1.0
References: <4D9F0679.7080109@domain.hid>	<1302268379.2101.35.camel@domain.hid>		<4DA30C80.3010107@domain.hid>	<1302531493.2054.355.camel@domain.hid>		<4DA30E14.6070401@domain.hid>	<1302532049.2054.357.camel@domain.hid>		<4DA31108.9080000@domain.hid>	<1302532753.2054
	<4DA314F1.3070504@domain.hid> <4DA31EB6.4040909@domain.hid>
In-Reply-To: <4DA31EB6.4040909@domain.hid>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

 

I have managed to print the stack of a faulting thread:

Xenomai: suspending kernel thread b911f518 ('rtnet-rtpc') at
nip=0xb911f940, lr=0xb911f940, r1=0xaf2c4580 after exception #1792

Xenomai: dumping stack at af2c4600
Xenomai: 0xaf2c45ec - 0xaf2c45fc:       00000000 af2c4600 8009a334
00000000 00000000
Xenomai: 0xaf2c45d8 - 0xaf2c45e8:       00000000  0 00000000 00000000
00000000
Xenomai: 0xaf2c45c4 - 0xaf2c45d4:       b911f518  0 00000000 af2c45f0
8009a364
Xenomai: 0xaf2c45b0 - 0xaf2c45c0:       00000000  0 00000000 00000000
00000000
Xenomai: 0xaf2c459c - 0xaf2c45ac:       00000000  0 00000000 b911f518
8009a334
Xenomai: 0xaf2c4588 - 0xaf2c4598:       00000000 b911f4e0 af2c45d0
b911649c 00000000
Xenomai: 0xaf2c4574 - 0xaf2c4584:       805e3988 8000000 805a89f0
00000001 b911f940
Xenomai: 0xaf2c4560 - 0xaf2c4570:       b911f940 20000000 22000022
b911ebb8 00000700
Xenomai: 0xaf2c454c - 0xaf2c455c:       805a89f0 b911f940 00029000
ffffffff 8009b2e4
Xenomai: 0xaf2c4538 - 0xaf2c4548:       00000000 b911ebb8 805e50c4
805e3988 805a89f0
Xenomai: 0xaf2c4524 - 0xaf2c4534:       00100100 ffffffff 00000000
af2c4580 8000bf48
Xenomai: 0xaf2c4510 - 0xaf2c4520:       00000000  0 00000000 00000000
00200200
Xenomai: 0xaf2c44fc - 0xaf2c450c:       805e3988 22000022 00000000
00000000 00000000

Manually decoded link register words:
---------------------------------------------------------------------------------------------------------
8009a334:
$ powerpc-linux-gnu-addr2line -e vmlinux 0x8009a334
linux-2.6.29.6/arch/powerpc/include/asm/xenomai/bits/pod.h:168

8009a364:
$ powerpc-linux-gnu-addr2line -e vmlinux 0x8009a364
linux-2.6.29.6/arch/powerpc/include/asm/xenomai/bits/pod.h:172

b911649c:
$ powerpc-linux-gnu-addr2line -e
../3rd_party/XM-Linux/rtnet_build/stack/rtnet.ko 0x249c
rtnet_build/stack/rtnet_rtpc.c:201

8000bf48:
$ powerpc-linux-gnu-addr2line -e vmlinux 0x8000bf48
linux-2.6.29.6/arch/powerpc/kernel/ipipe.c:429  
(ipipe_trigger_irq(unsigned irq) at local_irq_restore_hw(flags);)

---------------------------------------------------------------------------------------------------------

Notice the "r1" register in the first line i assume should point to a
back chain word, but the value is 00000001 and the "link register" word
immediately after is b911f940 which points to:
# grep b911f940 /proc/kallsyms
b911f940 b pending_calls_lock   [rtnet]


I'm not sure of the significance of the stack frame after that one.




/Jesper


On 2011-04-11 17:31, Jesper Christensen wrote:
> hmm...
>
> Xenomai: suspending kernel thread b911f518 ('rtnet-rtpc') at
> nip=0x1088860, lr=0x1088862 after exception #1025
>
> LR points to nowhere...Maybe i should do a hexdump of the stack and
> manually decode it.
>
> /Jesper
>
>
> On 2011-04-11 16:49, Jesper Christensen wrote:
>   
>> I'll just give them a run and see, thanks!
>>
>> /Jesper
>>
>>
>> On 2011-04-11 16:39, Philippe Gerum wrote:
>>   
>>     
>>> On Mon, 2011-04-11 at 16:32 +0200, Jesper Christensen wrote:
>>>   
>>>     
>>>       
>>>> How do i see that?
>>>>
>>>>     
>>>>       
>>>>         
>>> diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
>>> index 5cc4a23..8dbc537 100644
>>> --- a/include/asm-powerpc/system.h
>>> +++ b/include/asm-powerpc/system.h
>>> @@ -104,7 +104,7 @@ typedef struct xnarch_fltinfo {
>>>  #define xnarch_fault_trap(fi)   ((unsigned int)(fi)->regs->trap)
>>>  #define xnarch_fault_code(fi)   ((fi)->regs->dar)
>>>  #define xnarch_fault_pc(fi)     ((fi)->regs->nip)
>>> -#define xnarch_fault_pc(fi)     ((fi)->regs->nip)
>>> +#define xnarch_fault_lr(fi)     ((fi)->regs->link)
>>>  /* FIXME: FPU faults ignored by the nanokernel on PPC. */
>>>  #define xnarch_fault_fpu_p(fi)  (0)
>>>  /* The following predicates are only usable over a regular Linux stack
>>> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
>>> index b5ddbaa..c1722e7 100644
>>> --- a/ksrc/nucleus/pod.c
>>> +++ b/ksrc/nucleus/pod.c
>>> @@ -2591,8 +2591,8 @@ int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)
>>>  
>>>  	if (!xnpod_userspace_p()) {
>>>  		xnprintf
>>> -		    ("suspending kernel thread %p ('%s') at 0x%lx after exception #%u\n",
>>> -		     thread, thread->name, xnarch_fault_pc(fltinfo),
>>> +		    ("suspending kernel thread %p ('%s') at nip=0x%lx, lr=0x%lx after exception #%u\n",
>>> +		     thread, thread->name, xnarch_fault_pc(fltinfo), xnarch_fault_lr(fltinfo),
>>>  		     xnarch_fault_trap(fltinfo));
>>>  
>>>  		xnpod_suspend_thread(thread, XNSUSP, XN_INFINITE, XN_RELATIVE, NULL);
>>>   
>>>     
>>>       
>>>> /Jesper
>>>>
>>>>
>>>> On 2011-04-11 16:27, Philippe Gerum wrote:
>>>>     
>>>>       
>>>>         
>>>>> On Mon, 2011-04-11 at 16:20 +0200, Jesper Christensen wrote:
>>>>>   
>>>>>       
>>>>>         
>>>>>           
>>>>>> Problem is the NIP in question is the address of the thread structure as
>>>>>> seen in the error message.
>>>>>>     
>>>>>>         
>>>>>>           
>>>>>>             
>>>>> LR?
>>>>>
>>>>>   
>>>>>       
>>>>>         
>>>>>           
>>>>>> /Jesper
>>>>>>
>>>>>>
>>>>>> On 2011-04-11 16:18, Philippe Gerum wrote:
>>>>>>     
>>>>>>         
>>>>>>           
>>>>>>             
>>>>>>> On Mon, 2011-04-11 at 16:13 +0200, Jesper Christensen wrote:
>>>>>>>   
>>>>>>>       
>>>>>>>           
>>>>>>>             
>>>>>>>               
>>>>>>>> I have updated to xenomai 2.5.6, but i'm still seeing exceptions
>>>>>>>> (considerably less often though):
>>>>>>>>
>>>>>>>> Xenomai: suspending kernel thread b92a39d0 ('tt_upgw_0') at 0xb92a39d0
>>>>>>>> after exception #1792
>>>>>>>>     
>>>>>>>>         
>>>>>>>>             
>>>>>>>>               
>>>>>>>>                 
>>>>>>> You should build your code statically into the kernel, not as a module,
>>>>>>> and find out which code raises the MCE.
>>>>>>>
>>>>>>> CONFIG_DEBUG_INFO=y, then objdump -dl vmlinux, looking for the NIP
>>>>>>> mentioned.
>>>>>>>
>>>>>>>   
>>>>>>>       
>>>>>>>           
>>>>>>>             
>>>>>>>               
>>>>>>>> /Jesper
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2011-04-08 15:12, Philippe Gerum wrote:
>>>>>>>>     
>>>>>>>>         
>>>>>>>>             
>>>>>>>>               
>>>>>>>>                 
>>>>>>>>> On Fri, 2011-04-08 at 14:58 +0200, Jesper Christensen wrote:
>>>>>>>>>   
>>>>>>>>>       
>>>>>>>>>           
>>>>>>>>>               
>>>>>>>>>                 
>>>>>>>>>                   
>>>>>>>>>> Hi
>>>>>>>>>>
>>>>>>>>>> I'm trying to implement some gateway functionality in the kernel on a
>>>>>>>>>> emerson CPCI6200 board, but have run into some strange errors. The
>>>>>>>>>> kernel module is made up of two threads that run every 1 ms. I have also
>>>>>>>>>> made use of the rtpc dispatcher in rtnet to dispatch control messages
>>>>>>>>>> from a netlink socket to the RT part of my kernel module.
>>>>>>>>>>
>>>>>>>>>> The problem is that when loaded the threads get suspended due to exceptions:
>>>>>>>>>>
>>>>>>>>>> Xenomai: suspending kernel thread b929cbc0 ('tt_upgw_0') at 0xb929cbc0
>>>>>>>>>> after exception #1792
>>>>>>>>>>
>>>>>>>>>> or
>>>>>>>>>>
>>>>>>>>>> Xenomai: suspending kernel thread b929cbc0 ('tt_upgw_0') at 0x0 after
>>>>>>>>>> exception #1025
>>>>>>>>>>
>>>>>>>>>> or
>>>>>>>>>>
>>>>>>>>>> Xenomai: suspending kernel thread b911f518 ('rtnet-rtpc') at 0xb911f940
>>>>>>>>>> after exception #1792
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I have ported the "gianfar" driver from linux to rtnet.
>>>>>>>>>>
>>>>>>>>>> The versions and hardware are listed below. The errors are most likely
>>>>>>>>>> due to faulty software on my part, but i would like to ask if there are
>>>>>>>>>> any known issues with the versions or hardware i'm using. I would also
>>>>>>>>>> like to ask if there are any ways of further debugging the errors as i
>>>>>>>>>> am not getting very far with the above messages.
>>>>>>>>>>     
>>>>>>>>>>         
>>>>>>>>>>             
>>>>>>>>>>                 
>>>>>>>>>>                   
>>>>>>>>>>                     
>>>>>>>>> A severe bug at kthread init was fixed in the 2.5.5.2 - 2.5.6 timeframe,
>>>>>>>>> which would cause exactly the kind of weird behavior you are seeing
>>>>>>>>> right now. The bug triggered random code execution due to stack memory
>>>>>>>>> pollution at init on powerpc for Xenomai kthreads:
>>>>>>>>> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=90699565cbce41f2cec193d57857bb5817efc19a
>>>>>>>>> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=da20c20d4b4d892d40c657ad1d32ddb6d0ceb47c
>>>>>>>>> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=a5886b354dc18f054b187b58cfbacfb60bccaf47
>>>>>>>>>
>>>>>>>>> You need at the very least those three patches (from the top of my
>>>>>>>>> head), but it would be much better to upgrade to 2.5.6.
>>>>>>>>>
>>>>>>>>>   
>>>>>>>>>       
>>>>>>>>>           
>>>>>>>>>               
>>>>>>>>>                 
>>>>>>>>>                   
>>>>>>>>>> System info:
>>>>>>>>>>
>>>>>>>>>> Linux kernel: 2.6.29.6
>>>>>>>>>> i-pipe version: 2.7-04
>>>>>>>>>> processor: powerpc mpc8572
>>>>>>>>>> xenomai version: 2.5.3
>>>>>>>>>> rtnet version: 0.9.12
>>>>>>>>>>
>>>>>>>>>>     
>>>>>>>>>>         
>>>>>>>>>>             
>>>>>>>>>>                 
>>>>>>>>>>                   
>>>>>>>>>>                     
>>>>>>>>>   
>>>>>>>>>       
>>>>>>>>>           
>>>>>>>>>               
>>>>>>>>>                 
>>>>>>>>>                   
>>>>>>>> _______________________________________________
>>>>>>>> Xenomai-core mailing list
>>>>>>>> Xenomai-core@domain.hid
>>>>>>>> https://mail.gna.org/listinfo/xenomai-core
>>>>>>>>     
>>>>>>>>         
>>>>>>>>             
>>>>>>>>               
>>>>>>>>                 
>>>>>>>   
>>>>>>>       
>>>>>>>           
>>>>>>>             
>>>>>>>               
>>>>>>     
>>>>>>         
>>>>>>           
>>>>>>             
>>>>>   
>>>>>       
>>>>>         
>>>>>           
>>>>     
>>>>       
>>>>         
>>>   
>>>     
>>>       
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>>
>>   
>>     
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>   


