Message-ID: <47DA887C.1020109@domain.hid>
Date: Fri, 14 Mar 2008 15:15:24 +0100
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <47DA7CCD.40901@domain.hid> <47DA842E.3070305@domain.hid>
In-Reply-To: <47DA842E.3070305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Moving from 2.6.14(ppc) to 2.6.20(powerpc):
 illicit calls detected by ipipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Johan Borkhuis wrote:
>   
>> Hello,
>>
>> I am trying to move from 2.6.14(ppc) to 2.6.20(powerpc). On ppc I am 
>> using Xenomai 2.4.1 and I-Pipe version 1.5-03, on powerpc I am using 
>> Xenomai 2.4.1, I-Pipe version 1.7-12.
>> Most of the system is working, but I am having some problems with one 
>> device driver. This is a "standard" Linux driver, that I converted into 
>> a Xenomai driver. This driver does a very limited initialization, the 
>> main init is done when the device is opened and after some IOCTL calls.
>>
>> The problem is that I am getting "Detected illicit call from domain 
>> 'Xenomai' into a service reserved for domain 'Linux' and below." 
>> messages from Adeos, which I did not get when using 2.6.14. The code I 
>> use is identical, except for some small areas where the API kernel 
>> changed between 2.6.14 and 2.6.20. Has there been a change between the 
>> versions of Adeos or Xenomai which could cause this change in behavior?
>> (BTW: this message is generated when the option IPIPE_DEBUG_CONTEXT is 
>> on, when this option is off I get a kernel Oops in kernel/ipipe/core.c:210.
>>
>> The affected calls are calls like kmalloc and kfree, but also calls like 
>> check_mem_region, which uses kmem_cache_zalloc inside the function. 
>> Normally these should not be used inside a RT application, but this is 
>> the startup phase of the application and there are no RT restraints at 
>> this point.
>>
>>     
>
> 2.6.14 did not provide any invalid call context detection, so the fact that you
> start getting those with 2.6.20 is just the sign that your driver had a problem
> since 2.6.14, but they went unnoticed so far.
>   

They were unnoticed in 2.6.14, but do they cause any trouble? As far as 
I can see the driver did work correctly in 2.6.14.
Can I just ignore this error in 2.6.20, and have the driver continue, or 
does this situation generate an error, so that my application cannot 
continue?

> You may want to send the stack backtrace dumped by the detector, so that we
> could clearly identify what the calling context is.
>   

Below is the call-trace:

I-pipe: Detected illicit call from domain 'Xenomai'
        into a service reserved for domain 'Linux' and below.
Call Trace:
[97A479E0] [8000817C] show_stack+0x7c/0x1a4 (unreliable)
[97A47A10] [8005C2A4] ipipe_check_context+0xb8/0xc0
[97A47A30] [800D88F0] kmem_cache_zalloc+0xe4/0xf4
[97A47A50] [80033520] __request_region+0x48/0xd4
[97A47A70] [800335E0] __check_region+0x34/0x6c
[97A47A80] [A1216F94] men_OSS_AssignResources+0xec/0x1dc [men_oss]
[97A47AB0] [A12309BC] A201_Init+0x618/0x708 [men_bb_a201]
[97A47B10] [A12319F0] InitWrapper+0x38/0x50 [men_bb_a201]
[97A47B20] [A122C5E4] OpenDevice+0x4a8/0x634 [men_bbis_kernel]
[97A47C20] [A122CF9C] bbis_open+0x130/0x220 [men_bbis_kernel]
[97A47C60] [A126B450] mk_ioctl_core+0x548/0xcec [men_mdis_kernel]
[97A47DB0] [A126FA6C] mdisctl_ioctl_rt+0x84/0x1b40 [men_mdis_kernel]
[97A47DE0] [800A5D04] __rt_dev_ioctl+0xb0/0x1bc
[97A47E90] [800A8A3C] sys_rtdm_ioctl+0x3c/0x54
[97A47EA0] [80074338] losyscall_event+0xe4/0x208
[97A47ED0] [8005D88C] __ipipe_dispatch_event+0x1ec/0x2a4
[97A47F30] [80012268] __ipipe_syscall_root+0x5c/0x13c
[97A47F40] [80010A5C] DoSyscall+0x24/0x60

And another one (I replaced the kfree with rtdm_free, and the associated 
kalloc with rtdm_alloc, after that this message disappeared and the 
message above appeared):
I-pipe: Detected illicit call from domain 'Xenomai'
        into a service reserved for domain 'Linux' and below.
Call Trace:
[9758BBD0] [8000732C] show_stack+0x50/0x188 (unreliable)
[9758BC00] [8004ED48] ipipe_check_context+0x88/0x8c
[9758BC10] [800B6224] kfree+0x24/0xec
[9758BC30] [A10A99AC] bbis_open+0x11c/0x550 [men_bbis_kernel]
[9758BC60] [A10EB13C] mk_ioctl_core+0x52c/0xcd0 [men_mdis_kernel]
[9758BDB0] [A10EF384] mdisctl_ioctl_rt+0x6c/0x17c0 [men_mdis_kernel]
[9758BDE0] [8008B360] __rt_dev_ioctl+0x98/0x198
[9758BE90] [8008D808] sys_rtdm_ioctl+0x20/0x30
[9758BEA0] [80061230] losyscall_event+0xc8/0x1e4
[9758BED0] [8004FDDC] __ipipe_dispatch_event+0x10c/0x1e4
[9758BF30] [8000FAE4] __ipipe_syscall_root+0x40/0xe8
[9758BF40] [8000E610] DoSyscall+0x24/0x60


>   
>> Kind regards,
>>     Johan Borkhuis
>>
>>     
>
>
>   


-- 
Johan Borkhuis                                  Dutch Space BV
email:        j.borkhuis@domain.hid          Newtonweg 1
phone:        071-5245788                       Leiden
fax:          071-5245499                       The Netherlands


