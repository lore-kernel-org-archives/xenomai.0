Subject: Re: Strange switching [threadname] to secondary mode after exception
 #0 in kernel-space at 0x80272444
References: <1175-5f86ba00-b9-25a5a500@198941922>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f64b59e3-b141-4309-7779-a8a99e16eb98@siemens.com>
Date: Wed, 14 Oct 2020 11:37:13 +0200
MIME-Version: 1.0
In-Reply-To: <1175-5f86ba00-b9-25a5a500@198941922>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org, Greg Gallagher <greg@embeddedgreg.com>, Philippe Gerum <rpm@xenomai.org>

On 14.10.20 10:43, François Legal via Xenomai wrote:
> Anybody can help on this ?
> 

I'm unfortunately not familiar with the armv7 details of copy-from-user,
not too speak of how spectre contributed to it. Greg, Philippe, did you
come across this already?

Jan

> François
> 
> Le Mercredi, Septembre 30, 2020 17:14 CEST, François Legal via Xenomai <xenomai@xenomai.org> a écrit: 
>  
>> So the problem here lies in the calls to rtnet_get_arg(fd, &_msg, msg, sizeof(*msg)); in af_packet.c sendmasg/recvmsg
>>
>> The only explanation I could find was that, for my architecture (32bit ARMv7), syscall use the COBALT_SYSCALL32emu variants for sendmsg/recvmsg calls, which in turn allocate a struct user_msghdr on the SVC stack, then calls rt_packet_sendmsg/rt_packet_recvmsg with the address of that struct.
>>
>> Then, rtnet_get_arg would invoke arm_copy_from_user, which, with SPECTRE mitigation turned on (you normally can't disable this by configuration), would check that the source pointer is in the userland memory area, and hence fail in my case.
>>
>> Going from there, except disabling SPECTRE mitigation, I'm not sure how I can fix this.
>>
>> François
>>
>> Le Mercredi, Septembre 30, 2020 10:48 CEST, François Legal via Xenomai <xenomai@xenomai.org> a écrit: 
>>  
>>> I might have found what is causing this problem : CONFIG_CPU_SPECTRE
>>>
>>> It was the noticeable difference between my last (4.4.189) kernel release not showing this problem, and the next I tried (4.4.227).
>>> If I modify the Kconfig to disable CPU_SPECTRE, the problem does not show up anymore.
>>>
>>> I'll dig a little deeper into that now.
>>>
>>> François
>>>
>>> Le Mercredi, Septembre 30, 2020 08:42 CEST, François Legal <francois.legal@thom.fr.eu.org> a écrit: 
>>>  
>>>> So I decided to dig a little deeper in this problem, and found out that it is not xenomai3.1 specific.
>>>> I tried with xenomai-3.0.9 and linux 4.4.227 -> same problem.
>>>> I thought it might be a matter of ipipe patch not quite fit to 4.4.227, so I decided to try with latest ipipe-4.4.y-cip from git and xenomai 3.0.9, but the same problem happens.
>>>>
>>>> François
>>>>
>>>> Le Vendredi, Septembre 25, 2020 18:11 CEST, François Legal via Xenomai <xenomai@xenomai.org> a écrit: 
>>>>  
>>>>> Sorry to come back so late on that topic.
>>>>> I took some time to write a simple test program, which is attached.> > 
>>>>> Config is as follows :
>>>>> xenomai-3.1
>>>>> linux-4.4.227
>>>>>
>>>>> François
>>>>>
>>>>> Le Vendredi, Août 21, 2020 20:04 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>>>>>  
>>>>>> On 20.08.20 15:46, François Legal via Xenomai wrote:
>>>>>>> Using RTNet with multiple interfaces, xenomai 3.1 with linux 4.4
>>>>>>> Whenever a posix RT thread calls recvmsg (), I get this error.
>>>>>>>
>>>>>>> I could track this down to line 422 in udp.c :     msg = rtnet_get_arg(fd, &_msg, u_msg, sizeof(_msg));
>>>>>>>
>>>>>>> If I disassemble the kernel, the failing instruction (at 0x80272444) is a nop in arm_copy_from_user
>>>>>>> Am I doing anything wrong ?
>>>>>>
>>>>>> Maybe you are passing an invalid pointer to recvmsg, directly or in its
>>>>>> message structures. That would cause an exception which is fixed up but
>>>>>> also reported. Do you get an error in return?
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>> -- 
>>>>>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>>>>>> Corporate Competence Center Embedded Linux
>>>>> -------------- next part --------------
>>>>> A non-text attachment was scrubbed...
>>>>> Name: test-net.c
>>>>> Type: application/octet-stream
>>>>> Size: 6141 bytes
>>>>> Desc: not available
>>>>> URL: <http://xenomai.org/pipermail/xenomai/attachments/20200925/f745e32f/attachment.obj>
>>>>

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

