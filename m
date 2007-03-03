Message-ID: <45E994FB.6000004@domain.hid>
Date: Sat, 03 Mar 2007 07:32:11 -0800
From: Jeff Koftinoff <jeffk@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] MPC8641D and CONFIG_PPC_MERGE
References: <45E8D44F.7070200@domain.hid>
	<45E90B60.6060406@domain.hid> <45E92BDF.60909@domain.hid>
In-Reply-To: <45E92BDF.60909@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Thank you for your responses, Wolfgang.

I still have some confusion; I was able to build and run a xenomai 2.2.0 
patched linux 2.6.14 kernel on a Apple EMac, which has a 7447A processor 
in it - with no changes, and was able to get good latency results in my 
tests.

I am currently playing with a 8641D dual core power pc, it is basically 
two 7448 processors in one package which is almost identical to the 
7447A, along with peripherals (ethernet/serial/pcie).  Yet I can't seem 
to get xenomai compiled for it, even in non-smp mode.
The 8641D needs a newer kernel than 2.6.14 ( 2.6.19 is okay ). 

What should I do?

Regards,
Jeff Koftinoff

Wolfgang Grandegger wrote:
> Heikki Lindholm wrote:
>> Jeff Koftinoff kirjoitti:
>>> Hi Everyone. I would really like to get Xenomai working on the new 
>>> Freescale 8641D dual core G4.
>>>
>>> I see that for linux 2.6.19, Xenomai does not support 
>>> CONFIG_PPC_MERGE or architectures=powerpc instead of 'ppc'.
>>
>> Weren't there some experimental powerpc ports already posted some 
>> time ago (by Wolfgang, I think)? See the list archive.
>
> I started porting to the powerpc tree some time ago but realized that 
> it was not straight-forward. My quick hack didn't boot and then I 
> stopped because of lack of free time.
>
>>> Please forgive my ignorance; What exactly is the difference between 
>>> arch=ppc and arch=powerpc?
>
> Mainly the use of the generic IRQ layer and time of day. It requires an
> in-depth review and design of the corresponding Adeos/I-pipe 
> implementation. Well, the general design is already there for x86 
> implemented by Philippe but needs to be adapted. Nevertheless, the 
> port is planned for the near future. Funding would help, of course.
>
>>> What is involved in changing adeos to work under arch=powerpc on the 
>>> 8641D in single core mode?
>>>
>>> How much more work is involved in changing adeos to support SMP on 
>>> powerpc?
>>
>> The 64-bit powerpc target is under powerpc and supports SMP. The work 
>> required somewhat depends on the specific architecture implementation 
>> of SMP, but shouldn't be too difficult.
>
> That's also my impression, and a system for porting and testing is 
> also required.
>
> Wolfgang.
>


