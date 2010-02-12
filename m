Message-ID: <4B7523E6.1080008@domain.hid>
Date: Fri, 12 Feb 2010 10:48:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <201001292104.42395.lux-integ@domain.hid>	<4B657977.6050906@domain.hid>	<1264944150.16492.72.camel@domain.hid>	<4B6584DA.2010707@domain.hid>	<1264944906.16492.74.camel@domain.hid>	<4B6588AC.4070105@domain.hid>	<1265280370.2348.130.camel@domain.hid>
	<4B743B4E.3060703@domain.hid>
In-Reply-To: <4B743B4E.3060703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help with xenomai-2.5.0 on pure64bit linux x86_64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Mauerer wrote:
> Philippe Gerum wrote:
>> On Sun, 2010-01-31 at 14:42 +0100, Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> On Sun, 2010-01-31 at 14:25 +0100, Jan Kiszka wrote:
>>>>> Philippe Gerum wrote:
>>>>>> On Sun, 2010-01-31 at 13:37 +0100, Jan Kiszka wrote:
>>>>>>> lux-integ wrote:
>>>>>>>> Greetings
>>>>>>>>
>>>>>>>>  I am new to xenomai and I am attempting to   install    a RT-kernel on a pure 
>>>>>>>> 64-bit  (not multilib) amd64 linux setup.  The machine has a Sempron CPU and 
>>>>>>>> 2 GBytes of RAM.  The distribution is cross-lfs  compiled from sources.  This 
>>>>>>>> is what I have done:-
>>>>>>>>
>>>>>>>> a) I   fetched fresh kernel2.6.32.2  source-code   and placed it 
>>>>>>>> in /usr/src/linux like so:-
>>>>>>>> `linux' -> `linux-2.6.32.2'
>>>>>>>>
>>>>>>>> b) ..I then  applied  the  xenomai patch as such:-
>>>>>>>> $SOURCES/xenomai-2.5.0/scripts/prepare-kernel.sh --linux=/usr/src/linux  --adeos=$SOURCES/xenomai-2.5.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.32.2-x86-2.5-00.patch  --arch=x86_64
>> <snip>
>>
>>>>>> This is likely our old friend CONFIG_SPARSE_IRQ which is at work. Just
>>>>>> disable this, until we have introduced the required changes to support
>>>>>> more than 1024 IRQs.
>>>>> If that is true, then please include a simple "depends on !CONFIG_IPIPE"
>>>>> in the x86 patch for the meantime.
>>>>>
>>>> No. Work to lift this limitation is in progress here.
>>> That's even nicer (if 'lift' means removing any limitation of
>>> CONFIG_NR_CPUS).
>>>
>>> Jan
>>>
>> Could someone gives this patch a go, with CONFIG_SPARSE_IRQ on (or some
>> unreasonable number of CPUs in 64bit mode, whichever comes first)?
>>
>> http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.32.7-x86-2.6-00.patch
> 
> boots (and seems to work fine after a rather short test) w/o Xenomai and
> the attached .config (SPARSE_IRQ, NR_CPUS=512). With Xenomai is compiled
> in, it reboots right after registering the Xenomai domain with ipipe -
> see the attached console logs. Did not dig any deeper so far.
> The test was done on qemu 0.10.50  (-cpu core2duo, KVM)

Try to disable CONFIG_KPROBES_SANITY_TEST. I guess one problem is that
Kprobes aren't prepared for use over I-pipe.

I still have to stable 2.6.32 here over qemu (w/ or w/o kvm). Some
setups even fail under -smp 1. :( Will try Wolfgang's config now.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

