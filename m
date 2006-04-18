Message-ID: <4444E199.4080201@domain.hid>
Date: Tue, 18 Apr 2006 14:54:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] CONFIG_PREEMPT doesn't work with ADEOS
References: <20060418131428.31f735e9@domain.hid>	<4444D12B.6040901@domain.hid>	<4444D277.4040306@domain.hid>
	<4444D5F6.2010006@domain.hid> <4444D8B6.3020004@domain.hid>
In-Reply-To: <4444D8B6.3020004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Philippe Gerum wrote:
>>
>>> Philippe Gerum wrote:
>>>
>>>> Bernhard Walle wrote:
>>>>
>>>>
>>>>> Hello,
>>>>>
>>>>> I have a kernel 2.6.15.6 with
>>>>> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.15-i386-1.2-03.patch 
>>>>>
>>>>>
>>>>> patch. In this configuration, CONFIG_PREEMPT doesn't work any more,
>>>>> i.e. the kernel is not preempted.
>>>>>
>>>>
>>>> How do you check this?
>>>>
>>>
>>> Forget about this question. I'm going to give a look at your testcase
>>> when time allows. Thanks.
>>>
>>
>>
>> I did, and I can confirm this (2.6.16, original ipipe-1.2-03 applied,
>> ipipe on vs. off). Maybe something related to the TASK_ATOMICSWITCH 
>> changes?
>>
> 
> Don't know yet, I'm rebuilding an instrumented kernel, but considering 
> that we don't even have local echo of keystrokes, I'd rather think of 
> IRQs lagging in the pipeline log. More news later.
> 

Er, the softlockup detector triggers while the module holds the CPU, so 
the timer top-half must be running properly. Something is possibly fishy 
in the IRQ return path for x86 from resume_kernel and beyond.

>>
>>>>> With the kernel without ADEOS patch, it works fine. A test program is
>>>>> at http://www.bwalle.de/temp/kern-preempt.tar.bz2.
>>>>>
>>>>> Do you know what's wrong?
>>>>>
>>>>>
>>>>> Regards,
>>>>>  Bernhard
>>>>
>>>>
>>>>
>>>>
>>
>> Jan
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Adeos-main mailing list
>> Adeos-main@domain.hid
>> https://mail.gna.org/listinfo/adeos-main
> 
> 
> 


-- 

Philippe.

