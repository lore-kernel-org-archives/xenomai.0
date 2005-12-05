Message-ID: <4393F4A7.9020402@domain.hid>
Date: Mon, 05 Dec 2005 09:04:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem building MVM simulator in cross-compilation
	system
References: <8DF1258D5F0FC94EBF5810BF2C7BF2FB4003AA@ILEX5.IL.NDS.COM>
In-Reply-To: <8DF1258D5F0FC94EBF5810BF2C7BF2FB4003AA@ILEX5.IL.NDS.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: "Ashri, Sarit" <Sashri@domain.hid>
Cc: xenomai@xenomai.org

Ashri, Sarit wrote:
> Hi Philippe,
> 
> If I understood the MVM concept correctly, it is a real time control
> layer 
> beneath the Xenomai layer that allows the user to write and test Xenomai
> code
> ( without actual timing but with the actual thread priorities and
> scheduling).
> The code runs on the actual Xenomai version in the same manner in which
> it will
> Run on the target system (same minus the exact timing and performance).

Yes. Additionally, you get a Xenomai-aware graphical debugger, and since 
the simulator is event-driven and clocked by a virtual time source, a 
test scenarii can be replayed exactely the same way an infinite number 
of times (one would say ad nauseam when searching a bug).

> If this is correct, I will have to use the actual Xenomai v2.1 code.
> As far as I understood the Xenomai 2.1 code includes major changes from
> the
> Previous version, so my question is basically if it is stable enough for
> a 
> beginner like me to start working with?
> 

v2.1 is mainly a matter of:

1) Changing the build system so that Xenomai kernel support is hosted by 
the vanilla Linux build infrastructure, which also has the desirable 
side effect of strongly decoupling both kernel and user-space Xenomai 
supports.
2) Adding two new architecture ports, namely Blackfin and ARM.

Of course, a number of bug fixes will take place, but AFAICT, they are 
currently targeting portions of code that do not run over the simulator 
(e.g. shadow thread management, message pipe support).

IOW, using v2.0.x or v2.1 makes no difference for starting a development 
over the simulator.

> Thanks again for all you help!
> Sarit.
> 
> 
> 
> 
>>Ashri, Sarit wrote:
>>
>>>Hi Philippe,
>>>Do you think I should wait for the v2.1 to be released or 
>>
>>is it stable 
>>
>>>enough To start playing with it now?
>>>
>>
>>If we are still talking about the simulator, this is a rather 
>>mature piece of code since 2000 or so. Actually, it has been 
>>adapted from an old RTOS simulator project I recently moved to GNA: 
>>www.gna.org/projects/carbonkernel.
>>
>>
>>>Thanks a lot for all your help!
>>>Sarit.
>>>
>>>
>>>
>>>>- Configure and cross-compile Xenomai for ppc without simulation 
>>>>support for installing to /opt/nfsroot
>>>>- Configure and compile Xenomai natively for x86 with simulation 
>>>>support for installing to, e.g. /opt/local
>>>>
>>>>This way at least, you won't need to build the simulator apart, it 
>>>>will be built as part of the second step. Most of the native x86 
>>>>support won't be used (aside of the simulator, of course), but at 
>>>>least, this will work. On the host, you will need to set 
>>
>>your PATH and 
>>
>>>>LD_LIBRARY_PATH to /opt/local/bin, and /opt/local/lib 
>>
>>respectively, so 
>>
>>>>that the simulation libs and tools are found.
>>>>
>>>>The #warning won't go away though; only v2.1 gets rid of this by 
>>>>avoiding any kernel header inclusion in user-space. Debian systems 
>>>>would not bother you with this (at least sarge doesn't), but RH 
>>>>actually do.
>>>>
>>>>--
>>>>
>>>>Philippe.
>>>>
>>>
>>-- 
>>
>>Philippe.
>>
> 
> 


-- 

Philippe.

